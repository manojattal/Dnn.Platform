$fileName=$args[0]+"/Web/EditorControl.cs"
"Patching: "+$fileName
(Get-Content $fileName) | 
    Foreach-Object {
        # trying to match the following string: _settings["scayt_sLang"] = currentCulture.Name.ToLowerInvariant();
        if ($_.Trim() -like "*_settings*scayt_sLang*currentCulture.Name.ToLowerInvariant*") 
        {
            # replace the line with another block of code
            "                        // 'en-us' is not a language code that is supported, the correct is 'en_US'"
            "                        // https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR_config.html#cfg-scayt_sLang"
            '                        _settings["scayt_sLang"] = currentCulture.Name.Replace("-", "_");'
        } else {
            $_ # send the current line to output
        }
    } | Set-Content $fileName
"Patched successfully"
