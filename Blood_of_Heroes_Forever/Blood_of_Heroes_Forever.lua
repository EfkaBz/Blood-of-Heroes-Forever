-- Blood of Heroes Forever - affiche sur la carte du monde les points de spawn
-- de l'objet "Blood of Heroes" (Peaux-de-la-Peste Est/Ouest).
-- Autonome : ne depend ni de WeakAuras ni de TomTom.

local ADDON_NAME = ...

local BoH = CreateFrame("Frame")

-- Textes : francais sur un client frFR, anglais partout ailleurs.
local L = {
  NO_MAPID = "no mapID",
  NO_CANVAS = "no canvas found",
  BAD_CANVAS = "invalid canvas size (%s x %s)",
  SHOW_PINS = "Show spawn points on the map",
  PIN_SIZE = "Map pin size",
  SIZE_SET = "pin size = %d",
  DEBUG_ON = "enabled. Open the map on the Plaguelands.",
  DEBUG_OFF = "disabled.",
  PINS_ON = "pins enabled.",
  PINS_OFF = "pins disabled.",
}
if GetLocale() == "frFR" then
  L = {
    NO_MAPID = "pas de mapID",
    NO_CANVAS = "pas de canvas trouve",
    BAD_CANVAS = "canvas taille invalide (%s x %s)",
    SHOW_PINS = "Afficher les points sur la carte",
    PIN_SIZE = "Taille des points sur la carte",
    SIZE_SET = "taille des points = %d",
    DEBUG_ON = "active. Ouvre la carte sur Maleterres.",
    DEBUG_OFF = "desactive.",
    PINS_ON = "pins actives.",
    PINS_OFF = "pins desactivees.",
  }
end

-- 1422 = Peaux-de-la-Peste Ouest, 1423 = Peaux-de-la-Peste Est (mapID cote client Forever)
BoH.locations = {
  {zoneID = 1422, x = 35.9, y = 57.4},
  {zoneID = 1422, x = 36.4, y = 53.6},
  {zoneID = 1422, x = 38.3, y = 56.4},
  {zoneID = 1422, x = 39.7, y = 69.4},
  {zoneID = 1422, x = 39.7, y = 69.6},
  {zoneID = 1422, x = 40.6, y = 73.1},
  {zoneID = 1422, x = 40.7, y = 57.4},
  {zoneID = 1422, x = 40.7, y = 57.6},
  {zoneID = 1422, x = 41.4, y = 62.1},
  {zoneID = 1422, x = 41.5, y = 62.1},
  {zoneID = 1422, x = 42.2, y = 54.8},
  {zoneID = 1422, x = 42.8, y = 64.2},
  {zoneID = 1422, x = 43.3, y = 68.3},
  {zoneID = 1422, x = 43.6, y = 70.4},
  {zoneID = 1422, x = 43.7, y = 70.5},
  {zoneID = 1422, x = 44.2, y = 65.0},
  {zoneID = 1422, x = 44.4, y = 71.6},
  {zoneID = 1422, x = 44.5, y = 53.3},
  {zoneID = 1422, x = 44.5, y = 71.7},
  {zoneID = 1422, x = 44.6, y = 53.5},
  {zoneID = 1422, x = 45.8, y = 51.0},
  {zoneID = 1422, x = 45.8, y = 71.5},
  {zoneID = 1422, x = 45.9, y = 71.4},
  {zoneID = 1422, x = 46.7, y = 34.4},
  {zoneID = 1422, x = 46.8, y = 34.5},
  {zoneID = 1422, x = 46.9, y = 67.2},
  {zoneID = 1422, x = 47.0, y = 59.9},
  {zoneID = 1422, x = 47.6, y = 70.0},
  {zoneID = 1422, x = 47.9, y = 53.1},
  {zoneID = 1422, x = 49.4, y = 68.1},
  {zoneID = 1422, x = 49.8, y = 33.3},
  {zoneID = 1422, x = 52.2, y = 66.5},
  {zoneID = 1422, x = 52.3, y = 66.3},
  {zoneID = 1422, x = 52.4, y = 55.0},
  {zoneID = 1422, x = 53.0, y = 64.2},
  {zoneID = 1422, x = 53.3, y = 65.1},
  {zoneID = 1422, x = 53.3, y = 66.2},
  {zoneID = 1422, x = 53.4, y = 63.4},
  {zoneID = 1422, x = 53.5, y = 63.4},
  {zoneID = 1422, x = 53.5, y = 63.5},
  {zoneID = 1422, x = 54.9, y = 27.1},
  {zoneID = 1422, x = 55.3, y = 69.6},
  {zoneID = 1422, x = 56.7, y = 34.7},
  {zoneID = 1422, x = 57.8, y = 66.4},
  {zoneID = 1422, x = 62.0, y = 58.3},
  {zoneID = 1422, x = 62.0, y = 58.5},
  {zoneID = 1422, x = 62.9, y = 57.2},
  {zoneID = 1422, x = 62.9, y = 57.9},
  {zoneID = 1422, x = 63.3, y = 59.2},
  {zoneID = 1422, x = 63.6, y = 75.4},
  {zoneID = 1422, x = 63.6, y = 75.5},
  {zoneID = 1422, x = 64.0, y = 48.7},
  {zoneID = 1422, x = 64.1, y = 57.9},
  {zoneID = 1422, x = 64.9, y = 74.5},
  {zoneID = 1422, x = 65.0, y = 74.4},
  {zoneID = 1422, x = 65.8, y = 76.8},
  {zoneID = 1422, x = 66.5, y = 42.2},
  {zoneID = 1422, x = 67.0, y = 53.8},
  {zoneID = 1422, x = 67.8, y = 84.6},
  {zoneID = 1422, x = 68.0, y = 44.7},
  {zoneID = 1422, x = 68.3, y = 81.4},
  {zoneID = 1422, x = 68.3, y = 81.6},
  {zoneID = 1422, x = 68.4, y = 77.1},
  {zoneID = 1422, x = 68.5, y = 77.1},
  {zoneID = 1422, x = 68.7, y = 49.2},
  {zoneID = 1422, x = 68.7, y = 79.2},
  {zoneID = 1422, x = 68.9, y = 73.8},
  {zoneID = 1422, x = 69.5, y = 78.6},
  {zoneID = 1423, x = 7.1, y = 50.7},
  {zoneID = 1423, x = 8.0, y = 54.5},
  {zoneID = 1423, x = 8.1, y = 54.4},
  {zoneID = 1423, x = 14.2, y = 64.7},
  {zoneID = 1423, x = 20.0, y = 60.9},
  {zoneID = 1423, x = 20.5, y = 66.9},
  {zoneID = 1423, x = 21.5, y = 73.9},
  {zoneID = 1423, x = 22.1, y = 85.0},
  {zoneID = 1423, x = 24.3, y = 88.2},
  {zoneID = 1423, x = 26.0, y = 74.7},
  {zoneID = 1423, x = 26.3, y = 70.4},
  {zoneID = 1423, x = 26.3, y = 70.5},
  {zoneID = 1423, x = 26.7, y = 69.4},
  {zoneID = 1423, x = 26.7, y = 69.5},
  {zoneID = 1423, x = 27.0, y = 75.4},
  {zoneID = 1423, x = 27.1, y = 75.5},
  {zoneID = 1423, x = 27.3, y = 64.0},
  {zoneID = 1423, x = 28.8, y = 85.9},
  {zoneID = 1423, x = 29.2, y = 78.8},
  {zoneID = 1423, x = 30.9, y = 65.5},
  {zoneID = 1423, x = 32.0, y = 71.0},
  {zoneID = 1423, x = 33.6, y = 32.6},
  {zoneID = 1423, x = 34.0, y = 80.2},
  {zoneID = 1423, x = 34.3, y = 67.8},
  {zoneID = 1423, x = 34.4, y = 25.9},
  {zoneID = 1423, x = 34.5, y = 25.8},
  {zoneID = 1423, x = 34.5, y = 76.9},
  {zoneID = 1423, x = 35.6, y = 73.3},
  {zoneID = 1423, x = 35.9, y = 75.8},
  {zoneID = 1423, x = 36.7, y = 38.1},
  {zoneID = 1423, x = 36.9, y = 70.6},
  {zoneID = 1423, x = 37.1, y = 65.7},
  {zoneID = 1423, x = 37.6, y = 68.4},
  {zoneID = 1423, x = 38.4, y = 31.1},
  {zoneID = 1423, x = 38.5, y = 31.1},
  {zoneID = 1423, x = 38.5, y = 54.0},
  {zoneID = 1423, x = 38.8, y = 26.7},
  {zoneID = 1423, x = 38.9, y = 36.1},
  {zoneID = 1423, x = 40.0, y = 49.7},
  {zoneID = 1423, x = 41.4, y = 65.7},
  {zoneID = 1423, x = 41.4, y = 79.7},
  {zoneID = 1423, x = 41.5, y = 79.7},
  {zoneID = 1423, x = 42.3, y = 75.7},
  {zoneID = 1423, x = 44.9, y = 32.9},
  {zoneID = 1423, x = 46.2, y = 70.8},
  {zoneID = 1423, x = 46.3, y = 64.0},
  {zoneID = 1423, x = 46.5, y = 74.8},
  {zoneID = 1423, x = 47.5, y = 40.8},
  {zoneID = 1423, x = 47.9, y = 80.0},
  {zoneID = 1423, x = 48.9, y = 67.2},
  {zoneID = 1423, x = 49.1, y = 35.2},
  {zoneID = 1423, x = 50.2, y = 45.5},
  {zoneID = 1423, x = 50.3, y = 45.4},
  {zoneID = 1423, x = 50.4, y = 77.4},
  {zoneID = 1423, x = 50.5, y = 77.3},
  {zoneID = 1423, x = 51.8, y = 70.3},
  {zoneID = 1423, x = 53.4, y = 50.6},
  {zoneID = 1423, x = 53.5, y = 50.8},
  {zoneID = 1423, x = 55.3, y = 58.7},
  {zoneID = 1423, x = 55.5, y = 58.7},
  {zoneID = 1423, x = 56.2, y = 63.8},
  {zoneID = 1423, x = 56.5, y = 76.1},
  {zoneID = 1423, x = 57.0, y = 82.0},
  {zoneID = 1423, x = 57.4, y = 71.9},
  {zoneID = 1423, x = 57.5, y = 72.0},
  {zoneID = 1423, x = 57.8, y = 76.2},
  {zoneID = 1423, x = 58.1, y = 79.6},
  {zoneID = 1423, x = 58.4, y = 64.8},
  {zoneID = 1423, x = 58.5, y = 79.4},
  {zoneID = 1423, x = 58.6, y = 79.6},
  {zoneID = 1423, x = 59.2, y = 80.8},
  {zoneID = 1423, x = 59.3, y = 62.2},
  {zoneID = 1423, x = 59.3, y = 76.0},
  {zoneID = 1423, x = 59.5, y = 76.0},
  {zoneID = 1423, x = 59.9, y = 67.4},
  {zoneID = 1423, x = 59.9, y = 67.5},
  {zoneID = 1423, x = 61.8, y = 70.2},
  {zoneID = 1423, x = 63.6, y = 67.7},
  {zoneID = 1423, x = 64.7, y = 65.4},
  {zoneID = 1423, x = 64.7, y = 81.0},
  {zoneID = 1423, x = 66.1, y = 53.1},
  {zoneID = 1423, x = 67.6, y = 66.8},
  {zoneID = 1423, x = 68.2, y = 70.4},
  {zoneID = 1423, x = 68.2, y = 70.6},
  {zoneID = 1423, x = 68.2, y = 74.4},
  {zoneID = 1423, x = 68.3, y = 74.6},
  {zoneID = 1423, x = 68.6, y = 78.4},
  {zoneID = 1423, x = 68.8, y = 80.6},
  {zoneID = 1423, x = 68.9, y = 83.3},
  {zoneID = 1423, x = 69.0, y = 71.4},
  {zoneID = 1423, x = 69.0, y = 71.5},
  {zoneID = 1423, x = 70.7, y = 69.4},
  {zoneID = 1423, x = 70.7, y = 69.5},
  {zoneID = 1423, x = 70.7, y = 80.8},
  {zoneID = 1423, x = 71.1, y = 75.3},
  {zoneID = 1423, x = 72.2, y = 78.4},
  {zoneID = 1423, x = 72.3, y = 78.5},
  {zoneID = 1423, x = 73.3, y = 70.1},
  {zoneID = 1423, x = 73.3, y = 77.2},
  {zoneID = 1423, x = 73.4, y = 82.1},
  {zoneID = 1423, x = 73.6, y = 76.8},
  {zoneID = 1423, x = 73.8, y = 51.1},
  {zoneID = 1423, x = 74.1, y = 83.8},
  {zoneID = 1423, x = 74.7, y = 58.7},
  {zoneID = 1423, x = 75.6, y = 55.3},
  {zoneID = 1423, x = 75.8, y = 83.3},
  {zoneID = 1423, x = 75.8, y = 83.5},
  {zoneID = 1423, x = 76.1, y = 78.2},
  {zoneID = 1423, x = 76.2, y = 50.4},
  {zoneID = 1423, x = 76.2, y = 50.7},
  {zoneID = 1423, x = 76.6, y = 72.5},
  {zoneID = 1423, x = 78.4, y = 57.4},
  {zoneID = 1423, x = 78.4, y = 57.5},
  {zoneID = 1423, x = 78.5, y = 57.4},
  {zoneID = 1423, x = 78.5, y = 57.5},
  {zoneID = 1423, x = 78.7, y = 67.4},
  {zoneID = 1423, x = 78.9, y = 63.4},
  {zoneID = 1423, x = 79.0, y = 63.5},
  {zoneID = 1423, x = 80.4, y = 59.7},
  {zoneID = 1423, x = 80.5, y = 59.6},
}

local DEFAULT_PIN_SIZE = 10
local MIN_PIN_SIZE = 4
local MAX_PIN_SIZE = 24

local function GetPinSize()
  local size = tonumber(BloodOfHeroesForeverPinSize)
  if not size then
    return DEFAULT_PIN_SIZE
  end
  if size < MIN_PIN_SIZE then return MIN_PIN_SIZE end
  if size > MAX_PIN_SIZE then return MAX_PIN_SIZE end
  return size
end

local pinPool = {}
local activePins = {}

local function ReleaseAllPins()
  for _, pin in ipairs(activePins) do
    pin:Hide()
    pin:ClearAllPoints()
  end
  wipe(activePins)
end

local function AcquirePin(parent)
  local pin = tremove(pinPool)
  if not pin then
    pin = CreateFrame("Frame", nil, parent)
    -- Sans ca, la pin est un frame enfant du canvas comme les couches de
    -- terrain de la carte : elle heritait d'un niveau/strata par defaut qui
    -- la faisait passer SOUS le rendu de la carte. TOOLTIP + niveau eleve la
    -- force au-dessus de tout ce qui est dessine sur la carte.
    pin:SetFrameStrata("TOOLTIP")
    pin:SetFrameLevel(100)
    -- Icone de l'addon (Media\icon.png) affichee sur la carte.
    pin.icon = pin:CreateTexture(nil, "ARTWORK")
    pin.icon:SetAllPoints()
    pin.icon:SetTexture("Interface\\AddOns\\Blood_of_Heroes_Forever\\Media\\icon.png")

    pin:EnableMouse(true)
    pin:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText("Blood of Heroes", 1, 1, 1)
      GameTooltip:Show()
    end)
    pin:SetScript("OnLeave", function() GameTooltip:Hide() end)
  end
  pin:SetParent(parent)
  local size = GetPinSize()
  pin:SetSize(size, size)
  activePins[#activePins + 1] = pin
  return pin
end

local function GetCanvasFrame()
  if WorldMapFrame.GetCanvas then
    local ok, canvas = pcall(WorldMapFrame.GetCanvas, WorldMapFrame)
    if ok and canvas then
      return canvas
    end
  end
  if WorldMapFrame.ScrollContainer then
    return WorldMapFrame.ScrollContainer.Child or WorldMapFrame.ScrollContainer
  end
  return nil
end

-- Etat du dernier affichage reussi, pour eviter de tout recreer/rafraichir
-- pour rien : c'est ce reset+recreation repete (par le ticker de secours)
-- qui causait le clignotement, surtout entre pins qui se chevauchent.
local lastMapID, lastCanvas, lastWidth, lastHeight, lastSize, lastEnabled

local function RefreshPins(force)
  if not BloodOfHeroesForeverEnabled then
    if lastEnabled ~= false then
      ReleaseAllPins()
    end
    lastEnabled, lastMapID = false, nil
    return
  end
  if not WorldMapFrame or not WorldMapFrame:IsShown() then
    return
  end

  local mapID = WorldMapFrame:GetMapID()
  if not mapID then
    if BoH.debug then print("|cffff8800BoH debug:|r " .. L.NO_MAPID) end
    return
  end

  -- Il faut parenter les pins au vrai canvas zoomable (ScrollContainer.Child
  -- via WorldMapFrame:GetCanvas()), pas au ScrollContainer lui-meme qui garde
  -- une taille fixe (le viewport). C'est ce canvas qui recoit le SetScale()
  -- lors d'un zoom ; les pins positionnes dans son repere local suivent donc
  -- zoom/pan automatiquement.
  local canvas = GetCanvasFrame()
  if not canvas then
    if BoH.debug then print("|cffff8800BoH debug:|r " .. L.NO_CANVAS) end
    return
  end
  local width, height = canvas:GetSize()
  if not width or not height or width == 0 or height == 0 then
    if BoH.debug then print(("|cffff8800BoH debug:|r " .. L.BAD_CANVAS):format(tostring(width), tostring(height))) end
    return
  end

  local size = GetPinSize()

  -- Rien n'a change depuis le dernier affichage reussi : on ne touche a
  -- rien. C'est ce qui empeche les pins de clignoter en continu.
  if not force and mapID == lastMapID and canvas == lastCanvas
     and width == lastWidth and height == lastHeight
     and size == lastSize and lastEnabled ~= false then
    return
  end

  for _, pin in ipairs(activePins) do
    tinsert(pinPool, pin)
  end
  ReleaseAllPins()

  local shown = 0
  for _, loc in ipairs(BoH.locations) do
    if loc.zoneID == mapID then
      shown = shown + 1
      local pin = AcquirePin(canvas)
      -- Niveau unique et stable par emplacement (pas par frame physique
      -- reutilisee) : deux pins qui se chevauchent gardent toujours le
      -- meme ordre d'affichage au lieu de se disputer le dessus.
      pin:SetFrameLevel(100 + shown)
      local x = (loc.x / 100) * width
      local y = -(loc.y / 100) * height
      pin:ClearAllPoints()
      pin:SetPoint("CENTER", canvas, "TOPLEFT", x, y)
      pin:Show()
    end
  end

  lastMapID, lastCanvas, lastWidth, lastHeight, lastSize, lastEnabled =
    mapID, canvas, width, height, size, true

  if BoH.debug then
    print(("|cff00ff88BoH debug:|r mapID=%d canvas=%dx%d pins=%d"):format(mapID, width, height, shown))
  end
end

local function DelayedRefresh()
  C_Timer.After(0.3, RefreshPins)
end

BoH:RegisterEvent("ADDON_LOADED")
BoH:RegisterEvent("PLAYER_ENTERING_WORLD")
BoH:RegisterEvent("ZONE_CHANGED_NEW_AREA")
BoH:RegisterEvent("ZONE_CHANGED")
BoH:RegisterEvent("ZONE_CHANGED_INDOORS")
BoH:SetScript("OnEvent", function(self, event, name)
  if event == "ADDON_LOADED" then
    if name ~= ADDON_NAME then
      return
    end
    if BloodOfHeroesForeverEnabled == nil then
      BloodOfHeroesForeverEnabled = true
    end
    if BloodOfHeroesForeverPinSize == nil then
      BloodOfHeroesForeverPinSize = DEFAULT_PIN_SIZE
    end
    return
  end
  DelayedRefresh()
end)

-- Ticker de secours pendant que la carte est ouverte : si le canvas n'est pas
-- encore pret au premier essai (course de timing au chargement de la carte),
-- ca se corrige tout seul au lieu de rester bloque sans aucune pin affichee.
local refreshTicker
if WorldMapFrame then
  WorldMapFrame:HookScript("OnShow", function()
    RefreshPins()
    if not refreshTicker then
      refreshTicker = C_Timer.NewTicker(0.5, RefreshPins)
    end
  end)
  WorldMapFrame:HookScript("OnHide", function()
    if refreshTicker then
      refreshTicker:Cancel()
      refreshTicker = nil
    end
  end)
  hooksecurefunc(WorldMapFrame, "SetMapID", DelayedRefresh)
end

-- Panneau d'options (Options de jeu > AddOns > Blood of Heroes) avec un
-- curseur pour la taille des points sur la carte.
local function CreateOptionsPanel()
  if not Settings or not Settings.RegisterCanvasLayoutCategory then
    return
  end

  local panel = CreateFrame("Frame")
  panel.name = "Blood of Heroes"

  local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  title:SetPoint("TOPLEFT", 16, -16)
  title:SetText("Blood of Heroes")

  local enableCheckbox = CreateFrame("CheckButton", "BloodOfHeroesForeverEnableCheckbox", panel, "UICheckButtonTemplate")
  enableCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
  if enableCheckbox.Text then
    enableCheckbox.Text:SetText(L.SHOW_PINS)
  end
  enableCheckbox:SetScript("OnClick", function(self)
    BloodOfHeroesForeverEnabled = self:GetChecked() and true or false
    RefreshPins()
  end)

  local slider = CreateFrame("Slider", "BloodOfHeroesForeverSizeSlider", panel, "OptionsSliderTemplate")
  slider:SetPoint("TOPLEFT", enableCheckbox, "BOTTOMLEFT", 8, -28)
  slider:SetWidth(220)
  slider:SetMinMaxValues(MIN_PIN_SIZE, MAX_PIN_SIZE)
  slider:SetValueStep(1)
  slider:SetObeyStepOnDrag(true)

  if slider.Low then slider.Low:SetText(MIN_PIN_SIZE) end
  if slider.High then slider.High:SetText(MAX_PIN_SIZE) end
  if slider.Text then slider.Text:SetText(L.PIN_SIZE) end

  slider:SetScript("OnValueChanged", function(self, value)
    value = math.floor(value + 0.5)
    BloodOfHeroesForeverPinSize = value
    if self.valueText then
      self.valueText:SetText(value)
    end
    RefreshPins()
  end)

  local valueText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  valueText:SetPoint("LEFT", slider, "RIGHT", 12, 0)
  slider.valueText = valueText

  panel:SetScript("OnShow", function()
    enableCheckbox:SetChecked(BloodOfHeroesForeverEnabled and true or false)
    local size = GetPinSize()
    slider:SetValue(size)
    valueText:SetText(size)
  end)

  local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
  Settings.RegisterAddOnCategory(category)
end
CreateOptionsPanel()

SLASH_BLOODOFHEROESFOREVER1 = "/boh"
SlashCmdList["BLOODOFHEROESFOREVER"] = function(msg)
  msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
  local sizeArg = msg:match("^size%s+(%d+)$")
  if sizeArg then
    BloodOfHeroesForeverPinSize = tonumber(sizeArg)
    local size = GetPinSize()
    BloodOfHeroesForeverPinSize = size
    print(("|cff00ff88Blood of Heroes:|r " .. L.SIZE_SET):format(size))
    RefreshPins()
    return
  elseif msg == "debug" then
    BoH.debug = not BoH.debug
    print("|cff00ff88BoH debug:|r " .. (BoH.debug and L.DEBUG_ON or L.DEBUG_OFF))
    RefreshPins(true) -- force : sinon rien ne s'affiche si l'etat n'a pas change
    return
  elseif msg == "on" or msg == "show" then
    BloodOfHeroesForeverEnabled = true
  elseif msg == "off" or msg == "hide" then
    BloodOfHeroesForeverEnabled = false
  else
    BloodOfHeroesForeverEnabled = not BloodOfHeroesForeverEnabled
  end
  if BloodOfHeroesForeverEnabled then
    print("|cff00ff00Blood of Heroes:|r " .. L.PINS_ON)
  else
    print("|cffff0000Blood of Heroes:|r " .. L.PINS_OFF)
  end
  RefreshPins()
end
