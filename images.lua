function Para(el)
    if #el.content == 1 and el.content[1].t == "Image" then
        local img = el.content[1]

        if not img.attributes["width"] then
            img.attributes["width"] = "65%"
        end
        if not img.attributes["height"] then
            img.attributes["height"] = "0.50\\textheight"
        end

        return {
            pandoc.RawBlock("latex", "\\begin{center}"),
            pandoc.Para({img}),
            pandoc.RawBlock("latex", "\\end{center}")
        }
    end
end

function Image(img)
    if not img.attributes["width"] then
        img.attributes["width"] = "65%"
    end
    if not img.attributes["height"] then
        img.attributes["height"] = "0.50\\textheight"
    end
    return img
end
