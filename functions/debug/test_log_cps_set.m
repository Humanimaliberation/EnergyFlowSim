% Initialisation
cps = {};
log_cps = {};


for t = [1:4]
  % define cps values
  for i = [1:3]
    cps{i}.p = i*[10,10,10]+[t,t,t]/3;  
    cps{i}.w = 30*i*t;
    cps{i}.prio = i;
    
    % log data works
    log_cps.psum(t,i) = sum(cps{i}.p);
    log_cps.w(t,i) = cps{i}.w;
    log_cps.prio(t,i) = cps{i}.prio;
 
    %% log data broken
    %log_cps = log_cps_set(cps,t,log_cps)

  endfor
endfor

disp(log_cps);

      log_cps.psum(t,i) = sum(cps{i}.p);
      log_cps.w(t,i) = cps{i}.w;
      log_cps.prio(t,i) = cps{i}.prio;