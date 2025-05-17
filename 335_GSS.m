clc; clear all;

% ================================
% Kode Octave: Golden Section Search dan fminbnd
% ================================

% Membaca Data
data = csvread('T_300_F_1_171_133_31.csv', 1, 0);
strain = data(:, 1);  % Kolom pertama: Strain
stress = data(:, 2);  % Kolom kedua: Stress

% Membuat Model Polinomial
p = polyfit(strain, stress, 4); % Regresi polinomial derajat 4
polynomial_function = @(x) polyval(p, x); % Fungsi polinomial

% Menampilkan Persamaan Polinomial
fprintf('Persamaan Polinomial:\n');
fprintf('f(x) = ');
for i = 1:length(p)
    fprintf('%.4e*x^%d ', p(i), length(p) - i);
    if i < length(p)
        fprintf('+ ');
    end
end
fprintf('\n');

% ================================
% Fungsi Golden Section Search
% ================================
function [x_opt, f_opt, iterasi] = golden_section_search(func, a, b, tol)
  phi = (1 + sqrt(5)) / 2;  % Rasio emas
  c = b - (b - a) / phi;
  d = a + (b - a) / phi;
  iterasi = 0;

  while abs(c - d) > tol
    iterasi = iterasi + 1;
    if func(c) > func(d)
      b = d;
    else
      a = c;
    end
    c = b - (b - a) / phi;
    d = a + (b - a) / phi;
  end

  x_opt = (b + a) / 2; % Titik optimum
  f_opt = func(x_opt); % Nilai fungsi di titik optimum
end

% ================================
% Pencarian Titik Maksimum
% ================================
a = min(strain); % Batas bawah
b = max(strain); % Batas atas
tol = 1e-6;      % Toleransi

% Menggunakan Golden Section Search
[max_strain_gss, max_stress_gss, iterasi_gss] = golden_section_search(polynomial_function, a, b, tol);

% Menggunakan fminbnd
options = optimset('TolX', tol);
[max_strain_fminbnd, max_stress_fminbnd] = fminbnd(@(x) -polynomial_function(x), a, b, options);
max_stress_fminbnd = -max_stress_fminbnd;

% ================================
% Menampilkan Hasil di Konsol
% ================================
fprintf('\nHasil Pencarian Titik Maksimum:\n');
fprintf('Golden Section Search: Strain = %.6f, Stress = %.6f, Iterasi = %d\n', max_strain_gss, max_stress_gss, iterasi_gss);
fprintf('fminbnd: Strain = %.6f, Stress = %.6f\n', max_strain_fminbnd, max_stress_fminbnd);

% ================================
% Membuat Grafik Data dan Hasil
% ================================
x_fit = linspace(min(strain), max(strain), 500); % Data untuk grafik
y_fit = polyval(p, x_fit); % Nilai berdasarkan fungsi polinomial

figure;
plot(strain, stress, 'bo', 'MarkerSize', 4, 'DisplayName', 'Data Asli'); % Data asli
hold on;
plot(x_fit, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Model Polinomial'); % Kurva model
plot(max_strain_gss, max_stress_gss, 'go', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Titik Maks GSS');
text(max_strain_gss, max_stress_gss, sprintf('  Maks (%.4f, %.2f)', max_strain_gss, max_stress_gss), 'Color', 'blue');
legend('show');
title('Hubungan Stress-Strain dengan Titik Maksimum');
xlabel('Strain');
ylabel('Stress (MPa)');
grid on;
