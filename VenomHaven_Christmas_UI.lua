--[[
VENOM HAVEN UNIVERSAL - Christmas UI starter
Place this LocalScript in StarterPlayer > StarterPlayerScripts
for an experience you own in Roblox Studio.

This is a client-side interface prototype. It does NOT include an executor,
third-party game injection, exploit functions, fake key verification, or
client-authoritative moderation. Secure keys and owner commands must be
validated by server-side scripts and a trusted backend.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local COLORS = {
    background = Color3.fromRGB(13, 19, 16),
    panel = Color3.fromRGB(22, 33, 27),
    panel2 = Color3.fromRGB(29, 47, 36),
    green = Color3.fromRGB(35, 112, 67),
    greenLight = Color3.fromRGB(72, 164, 102),
    red = Color3.fromRGB(174, 43, 49),
    gold = Color3.fromRGB(226, 190, 105),
    white = Color3.fromRGB(240, 246, 241),
    muted = Color3.fromRGB(164, 181, 169),
    line = Color3.fromRGB(55, 78, 62),
}

local function make(className, props, parent)
    local object = Instance.new(className)
    for key, value in pairs(props or {}) do
        object[key] = value
    end
    object.Parent = parent
    return object
end

local function round(parent, radius)
    make("UICorner", {CornerRadius = UDim.new(0, radius or 10)}, parent)
end

local function stroke(parent, color, thickness)
    make("UIStroke", {
        Color = color or COLORS.line,
        Thickness = thickness or 1,
        Transparency = 0.15,
    }, parent)
end

local function tween(object, duration, properties)
    TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    ):Play()
end

local old = playerGui:FindFirstChild("VenomHavenChristmas")
if old then old:Destroy() end

local gui = make("ScreenGui", {
    Name = "VenomHavenChristmas",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local root = make("Frame", {
    Name = "Root",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(760, 485),
    BackgroundColor3 = COLORS.background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)
round(root, 16)
stroke(root, COLORS.gold, 1.4)

local scale = make("UIScale", {Scale = 1}, root)
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.clamp(math.min(viewport.X / 850, viewport.Y / 570), 0.62, 1)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 66),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
}, root)

local title = make("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(20, 8),
    Size = UDim2.new(1, -130, 0, 29),
    Font = Enum.Font.GothamBlack,
    Text = "🎄  VENOM HAVEN",
    TextColor3 = COLORS.white,
    TextSize = 23,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local subtitle = make("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(22, 37),
    Size = UDim2.new(1, -140, 0, 17),
    Font = Enum.Font.Gotham,
    Text = "UNIVERSAL  •  CHRISTMAS EDITION",
    TextColor3 = COLORS.gold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local collapseButton = make("TextButton", {
    Name = "TreeToggle",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -16, 0.5, 0),
    Size = UDim2.fromOffset(42, 40),
    BackgroundColor3 = COLORS.green,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "🎄",
    TextSize = 20,
    TextColor3 = COLORS.white,
    AutoButtonColor = true,
}, header)
round(collapseButton, 10)

local body = make("Frame", {
    Name = "Body",
    Position = UDim2.fromOffset(0, 66),
    Size = UDim2.new(1, 0, 1, -66),
    BackgroundTransparency = 1,
}, root)

local sidebar = make("Frame", {
    Name = "Sidebar",
    Size = UDim2.fromOffset(174, 419),
    BackgroundColor3 = COLORS.panel,
    BorderSizePixel = 0,
}, body)

local sidePadding = make("UIPadding", {
    PaddingTop = UDim.new(0, 14),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
}, sidebar)

local sideList = make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)

local content = make("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(174, 0),
    Size = UDim2.new(1, -174, 1, 0),
    BackgroundTransparency = 1,
}, body)

local pageTitle = make("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(22, 16),
    Size = UDim2.new(1, -44, 0, 32),
    Font = Enum.Font.GothamBold,
    Text = "Início",
    TextColor3 = COLORS.white,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageSubtitle = make("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(22, 49),
    Size = UDim2.new(1, -44, 0, 28),
    Font = Enum.Font.Gotham,
    Text = "Escolha uma seção na barra lateral.",
    TextColor3 = COLORS.muted,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageArea = make("ScrollingFrame", {
    Name = "PageArea",
    Position = UDim2.fromOffset(22, 88),
    Size = UDim2.new(1, -44, 1, -106),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = COLORS.greenLight,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)
make("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, pageArea)

local function clearPage()
    for _, child in ipairs(pageArea:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function addCard(heading, description, buttonText, callback)
    local card = make("Frame", {
        Size = UDim2.new(1, -6, 0, buttonText and 94 or 76),
        BackgroundColor3 = COLORS.panel,
        BorderSizePixel = 0,
    }, pageArea)
    round(card, 11)
    stroke(card)

    make("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 10),
        Size = UDim2.new(1, -28, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = heading,
        TextColor3 = COLORS.white,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)

    make("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 34),
        Size = UDim2.new(1, -28, 0, 30),
        Font = Enum.Font.Gotham,
        Text = description,
        TextColor3 = COLORS.muted,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    }, card)

    if buttonText then
        local button = make("TextButton", {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -12, 1, -9),
            Size = UDim2.fromOffset(116, 27),
            BackgroundColor3 = COLORS.green,
            BorderSizePixel = 0,
            Font = Enum.Font.GothamBold,
            Text = buttonText,
            TextColor3 = COLORS.white,
            TextSize = 10,
        }, card)
        round(button, 7)
        button.MouseButton1Click:Connect(callback or function() end)
    end
    return card
end

local function addNotice(text)
    addCard("Informação", text)
end

local function showHome()
    pageTitle.Text = "Bem-vindo ao Venom Haven"
    pageSubtitle.Text = "Hub universal • edição natalina"
    clearPage()
    addCard("🎮 Seleção de jogos", "Brookhaven RP é o primeiro módulo planejado. Os demais jogos podem receber módulos próprios quando estiverem prontos.")
    addCard("🔑 Acesso", "A interface está em modo de demonstração. A validação real de uma key de 24 horas precisa acontecer no servidor/backend.")
    addCard("🎄 Tema de Natal", "Interface em verde, vermelho e dourado, com detalhes natalinos.")
    addCard("📌 Status", "Protótipo da interface carregado. Nenhuma ação administrativa ou de jogo é executada por este menu.")
end

local function showPlayer()
    pageTitle.Text = "Player"
    pageSubtitle.Text = "Ferramentas de perfil e informações."
    clearPage()
    addCard("Meu perfil", "Jogador: " .. localPlayer.Name .. "  •  Display: " .. localPlayer.DisplayName)
    addCard("Jogadores", "Lista de jogadores desta experiência. Atualize a lista para consultar quem está conectado.", "Atualizar", function()
        pageSubtitle.Text = "Jogadores conectados: " .. tostring(#Players:GetPlayers())
    end)
    addCard("Lista atual", "A lista atual é exibida abaixo.")
    for _, player in ipairs(Players:GetPlayers()) do
        addCard(player.DisplayName .. "  (@" .. player.Name .. ")", "ID: " .. tostring(player.UserId))
    end
end

local espEnabled = false
local highlights = {}

local function clearHighlights()
    for player, highlight in pairs(highlights) do
        if highlight then highlight:Destroy() end
        highlights[player] = nil
    end
end

local function applyHighlights()
    clearHighlights()
    if not espEnabled then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local h = Instance.new("Highlight")
            h.Name = "VenomHavenHighlight"
            h.FillColor = COLORS.greenLight
            h.OutlineColor = COLORS.gold
            h.FillTransparency = 0.72
            h.OutlineTransparency = 0.1
            h.DepthMode = Enum.HighlightDepthMode.Occluded
            h.Adornee = player.Character
            h.Parent = player.Character
            highlights[player] = h
        end
    end
end

local function showESP()
    pageTitle.Text = "ESP"
    pageSubtitle.Text = "Destaque visual local, sem atravessar paredes."
    clearPage()
    addCard("Destaque de jogadores", "Mostra um contorno discreto em personagens nesta experiência. O destaque respeita a oclusão.", espEnabled and "Desativar" or "Ativar", function()
        espEnabled = not espEnabled
        applyHighlights()
        showESP()
    end)
    addCard("Cor do destaque", "A cor atual é verde natalino com contorno dourado. Personalização de cor pode ser adicionada depois.")
end

local function showWorld()
    pageTitle.Text = "Mundo"
    pageSubtitle.Text = "Opções informativas e de interface."
    clearPage()
    addCard("Informações do servidor", "Jogadores conectados: " .. tostring(#Players:GetPlayers()))
    addCard("Reentrar / trocar servidor", "Essas ações precisam ser implementadas com os serviços oficiais e regras da experiência.")
    addCard("Ambiente", "Efeitos locais de interface podem ser adicionados sem alterar a experiência de outros jogadores.")
end

local function showMisc()
    pageTitle.Text = "Misc"
    pageSubtitle.Text = "Utilidades gerais."
    clearPage()
    addCard("Anti-idle", "Para uma experiência própria, configure sistemas de sessão e inatividade no servidor, em vez de simular entradas.")
    addCard("FPS e Ping", "Um monitor de desempenho pode ser adicionado como componente separado.")
    addCard("Favoritos", "Espaço reservado para atalhos das seções que você mais usa.")
end

local function showConfig()
    pageTitle.Text = "Configurações"
    pageSubtitle.Text = "Preferências da interface."
    clearPage()
    addCard("Tema", "Tema atual: Natal • verde, vermelho e dourado.")
    addCard("Tamanho da interface", "A interface se ajusta automaticamente ao tamanho da tela.")
    addCard("Animações", "Transições suaves estão ativadas.")
    addCard("Restaurar interface", "Reabre o painel caso ele seja minimizado.", "Restaurar", function()
        root.Visible = true
        body.Visible = true
    end)
end

local function showMorph()
    pageTitle.Text = "Morph Avatar"
    pageSubtitle.Text = "Personalização visual para a experiência."
    clearPage()
    addCard("Outfits", "Área reservada para salvar, listar, equipar e excluir outfits usando os recursos permitidos da experiência.")
    addCard("Acessórios e aparência", "Aplique apenas itens e aparências que a experiência permita.")
end

local function showRGB()
    pageTitle.Text = "RGB"
    pageSubtitle.Text = "Personalização visual da interface."
    clearPage()
    addCard("Cores natalinas", "Paleta: verde, vermelho e dourado.")
    addCard("Velocidade de transição", "Controle de animação de cores poderá ser adicionado aqui.")
    addCard("Efeitos", "Efeitos visuais locais da interface, sem alterar itens de outros jogadores.")
end

local function showOwner()
    pageTitle.Text = "Owner Panel"
    pageSubtitle.Text = "Área administrativa demonstrativa."
    clearPage()
    addCard("Acesso do proprietário", "Este protótipo não concede privilégios. O servidor deve verificar UserId e permissões.")
    addCard("Moderação segura", "Freeze, jail, kick e outras ações precisam de RemoteEvents validados no servidor, com registro e permissões.")
    addCard("Usuários do Hub", "Uma lista confiável deve vir do servidor da experiência, não de uma lista controlada pelo cliente.")
end

local pages = {
    {name = "Início", icon = "⌂", render = showHome},
    {name = "Player", icon = "👤", render = showPlayer},
    {name = "ESP", icon = "◎", render = showESP},
    {name = "Mundo", icon = "🌍", render = showWorld},
    {name = "Misc", icon = "✦", render = showMisc},
    {name = "Morph Avatar", icon = "🧍", render = showMorph},
    {name = "RGB", icon = "🌈", render = showRGB},
    {name = "Owner Panel", icon = "👑", render = showOwner},
    {name = "Config", icon = "⚙", render = showConfig},
}

for index, page in ipairs(pages) do
    local button = make("TextButton", {
        Name = page.name:gsub("%s+", "") .. "Button",
        Size = UDim2.new(1, 0, 0, 39),
        BackgroundColor3 = index == 1 and COLORS.green or COLORS.panel2,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamSemibold,
        Text = page.icon .. "   " .. page.name,
        TextColor3 = COLORS.white,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = true,
        LayoutOrder = index,
    }, sidebar)
    round(button, 8)
    make("UIPadding", {PaddingLeft = UDim.new(0, 11)}, button)

    button.MouseButton1Click:Connect(function()
        for _, child in ipairs(sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                tween(child, 0.12, {BackgroundColor3 = COLORS.panel2})
            end
        end
        tween(button, 0.12, {BackgroundColor3 = COLORS.green})
        page.render()
    end)
end

local footer = make("TextLabel", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 12, 1, -8),
    Size = UDim2.new(1, -24, 0, 16),
    Font = Enum.Font.Gotham,
    Text = "VENOM HAVEN • CHRISTMAS",
    TextColor3 = COLORS.gold,
    TextSize = 8,
}, sidebar)

local collapsed = false
collapseButton.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    if collapsed then
        tween(root, 0.2, {Size = UDim2.fromOffset(210, 66)})
        body.Visible = false
        title.Text = "🎄  VENOM"
        subtitle.Text = "TOQUE NA ÁRVORE PARA ABRIR"
    else
        title.Text = "🎄  VENOM HAVEN"
        subtitle.Text = "UNIVERSAL  •  CHRISTMAS EDITION"
        body.Visible = true
        tween(root, 0.2, {Size = UDim2.fromOffset(760, 485)})
    end
end)

-- Drag the panel using its header.
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = root.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        root.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

Players.PlayerAdded:Connect(function()
    if espEnabled then task.defer(applyHighlights) end
end)
Players.PlayerRemoving:Connect(function(player)
    if highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end
end)

showHome()
