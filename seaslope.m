function tanbeta0 = seaslope(SeaState)
  
%% Define slope from Sea State
switch SeaState
  case 0, tanbeta0 = 0.05;
  case 1, tanbeta0 = 0.12;
  case 2, tanbeta0 = 0.14;
  case 3, tanbeta0 = 0.15;
  case 4, tanbeta0 = 0.16;
  case 5, tanbeta0 = 0.18;
  case 6, tanbeta0 = 0.22;
  case 7, tanbeta0 = 0.25;
  otherwise, error("unknown Sea State %d", SeaState)
end
  
end % function
