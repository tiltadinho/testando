-- Mensagem de licença
local a="This file is licensed with Luarmor. You must use the actual loadstring to execute this script. Do not run this file directly. Always use the loadstring."

-- Hash do script
local b="6eadf37a595d57529a91a20244b4bf5c"

-- Verifica se o script está sendo carregado pelo Luarmor
if lrm_load_script then
    lrm_load_script(b)
    while wait(1) do end
end

-- URL do arquivo do script
local c="https://api.luarmor.net/files/v3/l/"..b..".lua"
is_from_loader={Mode="fastload"}

-- Função de carregamento rápido
local d=0.03
l_fastload_enabled=function(e)
    if e=="flush" then
        wait(d)
        d=d+2
        local f,g
        local h,i=pcall(function()
            g=game:HttpGet(c)
            pcall(writefile,b.."-cache.lua","-- "..a.."\n\n if not is_from_loader then warn('Use the loadstring, do not run this directly') return end;\n "..g)
            wait(0.1)
            f=loadstring(g)
        end)
        if not h or not f then
            pcall(writefile,"lrm-err-loader-log-httpresp.txt",tostring(g))
            warn("Error while executing loader. Err:"..tostring(i).." See lrm-err-loader-log-httpresp.txt in your workspace.")
            return
        end
        f(is_from_loader)
    end
    if e=="rl" then
        pcall(writefile,b.."-cache.lua","recache required")
        wait(0.2)
        pcall(delfile,b.."-cache.lua")
    end
end

local j
local k,l=pcall(function()
    j=readfile(b.."-cache.lua")
    if (not j) or (#j < 5) then
        j=nil
        return
    end
    j=loadstring(j)
end)
if not k or not j then
    l_fastload_enabled("flush")
    return
end
j(is_from_loader)

-- Função para desenhar caixas de ESP ao redor dos itens
local function drawESP(item)
    local function drawBox(part)
        local box = Instance.new("BillboardGui")
        box.Size = UDim2.new(0, 100, 0, 100)
        box.Adornee = part
        box.AlwaysOnTop = true
        box.Parent = part

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
        frame.Parent = box
    end

    if item:IsA("BasePart") then
        drawBox(item)
    end
end

-- Função principal de atualização para adicionar ESP aos itens
local function updateESP()
    while true do
        for _, item in pairs(workspace:FindPartsInRegion3(workspace.CurrentCamera.CFrame:toWorldSpace(workspace.CurrentCamera.CFrame).p, workspace.CurrentCamera.CFrame.p + Vector3.new(50,50,50))) do
            drawESP(item)
        end
        wait(1) -- Ajuste o intervalo conforme necessário
    end
end

-- Chama a função de atualização do ESP
updateESP()