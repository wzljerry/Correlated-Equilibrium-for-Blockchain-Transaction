clear
clc
format short g
N_set=(500:50:2000);
social_wol=N_set.*0;

for pk=1:length(N_set)     
    dataS=randi(3,N_set(pk),1).*100;
    dataT=randi(3,N_set(pk),1).*10;
    
    times=N_set(pk);    
    index1=floor(times*0.4);
    index2=floor(times*0.6);
    

    if mod(index1,2)==0
        num2_groupS=dataS(1:index1);
        num2_groupT=dataT(1:index1);
    else
        num2_groupS=dataS(1:index1+1);
        num2_groupT=dataT(1:index1+1);
    end
    

    TdataT=fliplr(dataT);
    TdataS=fliplr(dataS);

    if mod(index2,3)==0
        num3_groupS=TdataS(1:index2); 
        num3_groupT=TdataT(1:index2); 
    elseif mod(index2,3)==1
        num3_groupT=TdataT(1:index2+2); 
        num3_groupS=TdataS(1:index2+2); 
    else
        num3_groupT=TdataT(1:index2+1); 
        num3_groupS=TdataS(1:index2+1);
    end
    
    max_valu2=zeros(length(num2_groupS)/2,1);
    max_valu3=zeros(length(num3_groupT)/3,1);
    
    num2_groupMS=reshape(num2_groupS,length(num2_groupS)/2,2);
    num2_groupMT=reshape(num2_groupT,length(num2_groupS)/2,2);
    
    num3_groupMS=reshape(num3_groupS,length(num3_groupT)/3,3);
    num3_groupMT=reshape(num3_groupT,length(num3_groupT)/3,3);
    
    for i=1:length(num2_groupS)/2
         s =num2_groupMS(i,:)./100; 
         st =num2_groupMT(i,:);
         Max_p2=two_p_sum(s,st);
         max_valu2(i)=Max_p2;   
    end
   for i=1:length(num3_groupT)/3
         T=num3_groupMT(i,:);
         TS=num3_groupMS(i,:)./100;
         Max_p3=three_p_sum(TS,T);
         max_valu3(i)=Max_p3;
    end 
    social_wol(pk)= sum(max_valu2).*0.4+sum(max_valu3).*0.6;
end
figure(1)
plot(N_set,social_wol,'r-*');
xlabel('n');
ylabel('Maxpin');
