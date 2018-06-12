cps{1}.p = [10/3,10/3,10/3];
cps{1}.eta = [0.9, 0, 0.99];
cps{1}.w = 10;

disp(cps);
cps = energyflow_set(cps);
disp(cps);