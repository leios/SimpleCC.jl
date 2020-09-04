module SimpleCC
using DelimitedFiles

export convert_to_md, convert_to_srt

function find_url_time(timestamp)
    hours = parse(Int,timestamp[1:2])
    mins = parse(Int,timestamp[4:5])
    secs = parse(Int,timestamp[7:8])
    return string(hours)*"h"*
           string(mins)*"m"*
           string(secs)*"s"
end

function convert_to_md(input_file, output_file, url)
    lines = readlines(input_file)
    for i = 1:length(lines)
        if occursin("-->", lines[i])
            lines[i] = "["*lines[i]*"]("*url*"#t="*find_url_time(lines[i][1:12])*")"
        end
        println(lines[i])
    end

    writedlm(output_file, lines)
end

function convert_to_srt(input_file, output_file, url)
    lines = readlines(input_file)
    for i = 1:length(lines)
        if occursin("-->", lines[i])
            lines[i] = lines[i][2:30]
        end
        println(lines[i])
    end

    writedlm(output_file, lines)

end

end # module
