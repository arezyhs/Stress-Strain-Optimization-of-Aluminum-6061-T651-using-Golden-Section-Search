# Stress-Strain Optimization of Aluminum 6061-T651
This project applies numerical optimization techniques to analyze the mechanical behavior of Aluminum 6061-T651 using real-world experimental data. It was developed as a final project for the *Computational Science* course.

## 🔧 Features
- 📊 **Polynomial Regression** (4th-degree) to model stress-strain relationship.
- 🔍 **Golden Section Search (GSS)** for locating the maximum stress point (ultimate stress).
- ⚖️ **Error Metrics**: Calculates RMSE and MAE for model evaluation.
- 🔁 **Comparison with `fminbnd`**: Built-in Octave optimization used for validation.
- 📈 **Visualization**: Graphical output showing original data, fitted model, and maximum point.

## 📁 Dataset
Dataset used: `T_300_F_1_171_133_31.csv`  
Source: [Mendeley Data](https://doi.org/10.17632/rd6jm9tyb6.2)  
Material: Aluminum 6061-T651 under uniaxial tension at 300K.

## 🧪 Tools
- GNU Octave
- MATLAB-compatible syntax
- CSV data handling

## 🧠 Method Overview
1. Load strain-stress data from CSV.
2. Fit a 4th-degree polynomial using `polyfit`.
3. Use Golden Section Search to find the strain value where stress is maximized.
4. Compare result with Octave's built-in `fminbnd` function.
5. Plot original data, fitted curve, and highlight the maximum point.

## 📉 Result Highlights
- **Maximum stress found**: ~85.23 MPa at strain ≈ 0.0185
- **RMSE**: 10.24 MPa
- **MAE**: 6.61 MPa

## 📚 References
- Shields, M., et al. (2019). *Stress-strain data for aluminum 6061-T651...*. [DOI: 10.17632/rd6jm9tyb6.2](https://doi.org/10.17632/rd6jm9tyb6.2)
- Aakash, B. S., et al. (2019). *Variability in the thermo-mechanical behavior...*
