function outframe = extracttimeframe(u,t, n, m)
framevector = u(t,:);
outtransposed = reshape(framevector, [n,m]);
outframe = transpose(outtransposed);
end

