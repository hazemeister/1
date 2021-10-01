--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:8513559771092f3a8880b1724a518984:c7be78b6f42f98db629a1989b6ced62c:79a7d449c1e774c836646549e5b6049d$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1stone
            x=0,
            y=0,
            width=125,
            height=115,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 135,
            sourceHeight = 135
        },
        {
            -- 2stone
            x=0,
            y=115,
            width=123,
            height=130,

        },
        {
            -- 3stone
            x=0,
            y=245,
            width=123,
            height=130,

        },
        {
            -- beam
            x=0,
            y=375,
            width=126,
            height=121,

        },
        {
            -- ship
            x=0,
            y=496,
            width=128,
            height=128,

        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 624
}

SheetInfo.frameIndex =
{

    ["1stone"] = 1,
    ["2stone"] = 2,
    ["3stone"] = 3,
    ["beam"] = 4,
    ["ship"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
