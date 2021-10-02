--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:71a5b58ca831e677ece6fdb6c36a3381:19f41e56b26d8816a0531c23cdd8024a:79a7d449c1e774c836646549e5b6049d$
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
            width=99,
            height=135,

            sourceX = 18,
            sourceY = 0,
            sourceWidth = 135,
            sourceHeight = 135
        },
        {
            -- 2stone
            x=0,
            y=135,
            width=123,
            height=130,

        },
        {
            -- 3stone
            x=0,
            y=265,
            width=123,
            height=130,

        },
        {
            -- beam
            x=0,
            y=395,
            width=126,
            height=121,

        },
        {
            -- ship
            x=0,
            y=516,
            width=128,
            height=128,

        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 644
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
