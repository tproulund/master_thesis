%% Initial guesses
x_k_mark = [0 0]';
P_k_mark = eye(2);
x_k_1_save = [];
Kk_save = [];
for i = 1:lg
   z = [cent(i,1) v(i)]';
   %% Correct
   Kk = P_k_mark*H' / (H*P_k_mark*H'+Vd);
   Kk_save(i) = Kk(2,1);
   x_k=x_k_mark+Kk*(z-H*x_k_mark);
   P_k = (eye(2)-Kk*H)*P_k_mark;
   
   %% Predict
   x_k_1 = F*x_k;
   x_k_1_save = [x_k_1_save; x_k_1'];
   P_k_1 = F*P_k*F'+Vn;
   
   x_k_mark = x_k_1;
   P_k_mark = P_k_1;
    
    
end

figure
plot(x_k_1_save(:,1));
hold on
plot(cent(:,1));
hold off

figure
plot(x_k_1_save(:,2));
hold on
plot(v);
hold off