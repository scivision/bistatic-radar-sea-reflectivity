function ShadowFactor = shadow_factor(P)

if strcmpi(P.Shadowing,'Y')
  vR = eqn20a(P.gammaR, P.tanbeta0);
  vT = eqn20a(P.gammaT, P.tanbeta0);
  
  LambdaR = eqn20b(vR);
  LambdaT = eqn20b(vT);
%% Eqn 19
  ShadowFactor = (1 + erf(vR)) * (1 + erf(vT)) ./ ...
                  (4 .* (1 + LambdaR + LambdaT));
else
  ShadowFactor = 1;  
end

end % function


function v = eqn20a(gamma, tanbeta0)
  v = abs(tan(gamma)) ./ (sqrt(2)*tanbeta0);
end


function Lambda = eqn20b(v)
  % multiplied top and bottom by (1/v)
  Lambda = (exp(-v.^2) ./ v - sqrt(pi) * erfc(v)) ./ ...
            (2 * sqrt(pi));
  
end