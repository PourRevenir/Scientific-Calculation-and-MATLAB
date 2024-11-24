function [w,x] = GaussLegendreCoef(n)
%GaussLegendreCoef Calculate Gauss-Legendre quadrature coefficients and Gaussian points.
%
%   [w,x] = GaussLegendreCoef(n)
%
%   Input
%       n - number of Gaussian points
%   Output
%       w - Gauss-Legendre quadrature coefficients
%       x - Gaussian points
%
    polyPrevious = 1;
    polyCurrent = [1 0];
    for i = 1:n
        polyForward = [polyCurrent*(2*i+1)/(i+1) 0];
        polyForward = polyForward - [0 0 polyPrevious*i/(i+1)];
        polyPrevious = polyCurrent;
        polyCurrent = polyForward;
    end

    x = roots(polyPrevious);
    w = 2*(1-x.^2)./((n+1)*polyval(polyCurrent,x)).^2;
end