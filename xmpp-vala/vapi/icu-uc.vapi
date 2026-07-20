namespace Web4.ICU {

    // Basic Unicode character type
    [CCode (cname = "UChar")]
    [IntegerType (rank = 5, min = 0, max = 65535)]
    struct Char {}

    // Unicode string wrapper
    [CCode (cname = "UChar*", destroy_function="g_free", has_type_id = false, cheader_filename = "unicode/ustring.h")]
    [SimpleType]
    struct String {
        public static String alloc(int length) {
            return (String) (Char*) new Char[length];
        }

        public static String from_utf8(string src) throws GLib.ConvertError {
            ErrorCode status = ErrorCode.ZERO_ERROR;
            int dest_capacity = src.length * 2 + 1;
            String dest = alloc(dest_capacity);
            int dest_length;
            strFromUTF8(dest, dest_capacity, out dest_length, src, src.length, ref status);
            if (status.is_failure()) {
                throw new GLib.ConvertError.FAILED(status.errorName());
            }
            return dest;
        }

        public string to_utf8() throws GLib.ConvertError {
            ErrorCode status = ErrorCode.ZERO_ERROR;
            char[] dest = new char[len() * 4 + 1];
            int dest_length;
            strToUTF8(dest, out dest_length, this, -1, ref status);
            if (status.is_failure()) {
                throw new GLib.ConvertError.FAILED(status.errorName());
            }
            dest[dest_length] = 0;
            return (string) dest;
        }

        [CCode (cname = "u_strlen")]
        public int len();

        [CCode (cname="u_strFromUTF8")]
        private static void strFromUTF8(String dest, int dest_capacity, out int dest_length, string src, int src_length, ref ErrorCode status);

        [CCode (cname="u_strToUTF8")]
        private static void strToUTF8(char[] dest, out int dest_length, String src, int src_length, ref ErrorCode status);
    }

    // Error codes
    [CCode (cname = "UErrorCode", cprefix = "U_", cheader_filename = "unicode/utypes.h")]
    enum ErrorCode {
        ZERO_ERROR,
        INVALID_CHAR_FOUND,
        INDEX_OUTOFBOUNDS_ERROR,
        BUFFER_OVERFLOW_ERROR,
        STRINGPREP_PROHIBITED_ERROR,
        UNASSIGNED_CODE_POINT_FOUND,
        IDNA_STD3_ASCII_RULES_ERROR;

        [CCode (cname = "u_errorName")]
        public unowned string errorName();
        [CCode (cname = "U_SUCCESS")]
        public bool is_success();
        [CCode (cname = "U_FAILURE")]
        public bool is_failure();
    }

    // Parse error struct
    [CCode (cname = "UParseError", cprefix = "U_", cheader_filename = "unicode/parseerr.h")]
    struct ParseError {}

    // StringPrep profiles
    [CCode (cname = "UStringPrepProfile", cprefix = "usprep_", free_function = "usprep_close", cheader_filename = "unicode/usprep.h")]
    [Compact]
    class PrepProfile {
        public static PrepProfile open(string path, string file_name, ref ErrorCode status);
        public static PrepProfile openByType(PrepType type, ref ErrorCode status);
        public int prepare(String src, int src_length, String dest, int dest_capacity, PrepOptions options, out ParseError parse_error, ref ErrorCode status);
    }

    [CCode (cname = "UStringPrepProfileType", cprefix = "USPREP_")]
    enum PrepType {
        RFC3491_NAMEPREP,
        RFC3920_NODEPREP,
        RFC3920_RESOURCEPREP
    }

    [CCode (cname = "int32_t", cprefix = "USPREP_")]
    enum PrepOptions {
        DEFAULT,
        ALLOW_UNASSIGNED
    }

    // IDNA (Internationalized Domain Names)
    [CCode (cname = "UIDNA", cprefix = "uidna_", free_function = "uidna_close", cheader_filename = "unicode/uidna.h")]
    [Compact]
    class IDNA {
        public static IDNA openUTS46(IDNAOptions options, ref ErrorCode status);
        public static int IDNToUnicode(Char* src, int src_length, Char* dest, int dest_capacity, IDNAOptions options, out ParseError parse_error, ref ErrorCode status);
        public static int IDNToASCII(Char* src, int src_length, Char* dest, int dest_capacity, IDNAOptions options, out ParseError parse_error, ref ErrorCode status);
        public int nameToUnicode(Char* src, int src_length, Char* dest, int dest_capacity, out IDNAInfo info, ref ErrorCode status);
        public int nameToASCII(Char* src, int src_length, Char* dest, int dest_capacity, out IDNAInfo info, ref ErrorCode status);
        public int nameToASCII_UTF8(string name, int name_length, char[] dest, out IDNAInfo info, ref ErrorCode status);
        public int nameToUnicodeUTF8(string name, int name_length, char[] dest, out IDNAInfo info, ref ErrorCode status);
    }

    [CCode (cname = "UIDNAInfo", default_value = "UIDNA_INFO_INITIALIZER", has_type_id = false, cheader_filename = "unicode/uidna.h")]
    struct IDNAInfo {
        public static IDNAInfo INITIAL;
        public uint errors;
        public bool isTransitionalDifferent;
    }

    [CCode (cname = "uint32_t", cprefix = "UIDNA_")]
    enum IDNAOptions {
        DEFAULT,
        ALLOW_UNASSIGNED,
        USE_STD3_RULES
    }
}
