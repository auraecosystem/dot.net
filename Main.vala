using Web4.ICU;

public static int main(string[] args) {
    try {
        // Convert UTF-8 string to ICU String
        string original = "héllo 🌍";
        String icuStr = String.from_utf8(original);
        stdout.printf("Original: %s\n", original);

        // Convert back to UTF-8
        string roundtrip = icuStr.to_utf8();
        stdout.printf("Roundtrip: %s\n", roundtrip);

        // IDNA example: convert domain name to ASCII (punycode)
        ErrorCode status = ErrorCode.ZERO_ERROR;
        IDNA idna = IDNA.openUTS46(IDNAOptions.DEFAULT, ref status);
        char[] dest = new char[256];
        IDNAInfo info;
        idna.nameToASCII_UTF8("bücher.de", "bücher.de".length, dest, out info, ref status);

        string asciiDomain = (string) dest;
        stdout.printf("ASCII domain: %s\n", asciiDomain);

    } catch (GLib.ConvertError e) {
        stderr.printf("Conversion failed: %s\n", e.message);
        return 1;
    }
    return 0;
}
