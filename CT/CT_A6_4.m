t = linspace(1,100,100);
err = (0.1-(209715/2097152))*3600*t;
err(1)
err(100)
disp(['The Patriot Missile missed the Scud missile by the distance ',num2str(err(100)*274),' m'])
figure;
plot(err,t)
