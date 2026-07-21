using Web4.ICU;

public static string normalize_username(string input) {
    ErrorCode status = ErrorCode.ZERO_ERROR;
    PrepProfile profile = PrepProfile.openByType(PrepType.RFC3491_NAMEPREP, ref status);
    if (status.is_failure()) {
        throw new GLib.ConvertError.FAILED(status.errorName());
    }

    String src = String.from_utf8(input);
    String dest = String.alloc(src.len() * 2);
    ParseError parse_error;
    profile.prepare(src, src.len(), dest, dest.len(), PrepOptions.DEFAULT, out parse_error, ref status);

    if (status.is_failure()) {
        throw new GLib.ConvertError.FAILED(status.errorName());
    }
    return dest.to_utf8();
}
