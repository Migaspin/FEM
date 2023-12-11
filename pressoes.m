addpath(genpath("libraries"))

Parede1 = [153 125 94; 125 124 43; 124 123 51; 123 122 30; 122 121 1; 121 120 4; 120 119 3; 119 118 256; 118 117 145; 117 116 139; 116 115 142; 115 114 141; 114 113 178; 113 156 213]
Parede2 = [154 126 75; 126 127 64; 127 128 65; 128 129 103; 129 130 107; 130 131 108; 131 132 113; 132 133 111; 133 134 219; 134 135 216; 135 136 174; 136 137 173; 137 138 186; 138 157 194;]

Parede3 = [107 106 252; 106 105 249; 105 104 36; 104 155 97; 155 112 18; 112 111 22; 111 110 16; 110 109 15; 109 108 237; 108 107 250]
Parede4 = [143 142 226; 142 141 233; 141 140 26; 140 139 24; 139 158 121; 158 147 223; 147 146 224; 146 145 222; 145 144 158; 144 143 163;]

l1 = length(Parede1)
l2 = length(Parede2)
l3 = length(Parede3)
l4 = length(Parede4)

F1 = zeros(l1, 1);
F2 = zeros(l2, 1);
F3 = zeros(l3, 1);
F4 = zeros(l4, 1);
f1 = zeros(l1, 2);
f2 = zeros(l2, 2);
f3 = zeros(l3, 2);
f4 = zeros(l4, 2);

for i = 1:l1
    [f, fx, fy] = CalcularForca(x, y, Parede1(i, 1), Parede1(i, 2), p(Parede1(i, 3)));
    F1(i) = f
    f1(i, 1) = fx
    f1(i, 2) = fy
end

for i = 1:l2
    [f, fx, fy] = CalcularForca(x, y, Parede2(i, 1), Parede2(i, 2), p(Parede2(i, 3)));
    F2(i) = f
    f2(i, 1) = fx
    f2(i, 2) = fy
end

for i = 1:l3
    [f, fx, fy] = CalcularForca(x, y, Parede3(i, 1), Parede3(i, 2), p(Parede3(i, 3)));
    F3(i) = f
    f3(i, 1) = fx
    f3(i, 2) = fy
end

for i = 1:l4
    [f, fx, fy] = CalcularForca(x, y, Parede4(i, 1), Parede4(i, 2), p(Parede4(i, 3)));
    F4(i) = f
    f4(i, 1) = fx
    f4(i, 2) = fy
end

Fxy1 = sum(F1)
fx1 = sum(f1(:,1));
fy1 = sum(f1(:,2));

Fxy2 = sum(F2)
fx2 = sum(f2(:,1));
fy2 = sum(f2(:,2));

Fxy3 = sum(F3)
fx3 = sum(f3(:,1));
fy3 = sum(f3(:,2));

Fxy4 = sum(F4)
fx4 = sum(f4(:,1));
fy4 = sum(f4(:,2));