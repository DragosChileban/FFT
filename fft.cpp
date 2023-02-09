#include <iostream>
using namespace std;

void fft(int re[], int im[]) {
    int temp_real=0, temp_imag = 0;
    int temp_real2=0, temp_imag2 = 0;
    //stage 1
    for(int i = 0; i < 4; i++) {
        temp_real = re[i] + re[i+4];
        temp_imag = im[i] + im[i+4];
        temp_real2 = re[i] - re[i+4];
        temp_imag2= im[i] - im[i+4];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+4] = temp_real2;
        im[i+4] = temp_imag2;
    }
    int idx[] = {0, 4, 2, 6, 1, 5, 3, 7};
    cout << "Stage1:\n";
    for(int i = 0; i < 8; i++) {
        cout << re[i] << " + i * " << im[i] << '\n';
    }
    cout << "\n\n";

    //stage 2
    for(int i = 0; i < 2; i++) {
        temp_real = re[i] + re[i+2];
        temp_imag = im[i] + im[i+2];
        temp_real2 = re[i] - re[i+2];
        temp_imag2 = im[i] - im[i+2];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+2] = temp_real2;
        im[i+2] = temp_imag2;
    }

    for(int i = 4; i < 6; i++) {
        temp_real = re[i] + im[i+2];
        temp_imag = im[i] - re[i+2];
        temp_real2 = re[i] - im[i+2];
        temp_imag2 = im[i] + re[i+2];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+2] = temp_real2;
        im[i+2] = temp_imag2;
    }

    cout << "Stage2:\n";
    for(int i = 0; i < 8; i++) {
        cout << re[i] << " + i * " << im[i] << '\n';
    }
    cout << "\n\n";

    //Stage 3
    temp_real = re[0] + re[1];
    temp_imag = im[0] + im[1];
    temp_real2 = re[0] - re[1];
    temp_imag2 = im[0] - im[1];
    re[0] = temp_real;
    im[0] = temp_imag;
    re[1] = temp_real2;
    im[1] = temp_imag2;

    temp_real = re[2] + im[3];
    temp_imag = im[2] - re[3];
    temp_real2 = re[2] - im[3];
    temp_imag2 = im[2] + re[3];
    re[2] = temp_real;
    im[2] = temp_imag;
    re[3] = temp_real2;
    im[3] = temp_imag2;

    temp_real = re[4] + 0.707*re[5] + 0.707*im[5];
    temp_imag = im[4] + 0.707*im[5] - 0.707*re[5];
    temp_real2 = re[4] - 0.707*re[5] - 0.707*im[5];
    temp_imag2 = im[4] - 0.707*im[5] + 0.707*re[5];
    re[4] = temp_real;
    im[4] = temp_imag;
    re[5] = temp_real2;
    im[5] = temp_imag2;

    temp_real = re[6] - 0.707*re[7] + 0.707*im[7];
    temp_imag = im[6] - 0.707*im[7] - 0.707*re[7];
    temp_real2 = re[6] + 0.707*re[7] - 0.707*im[7];
    temp_imag2 = im[6] + 0.707*im[7] + 0.707*re[7];
    re[6] = temp_real;
    im[6] = temp_imag;
    re[7] = temp_real2;
    im[7] = temp_imag2;

    cout << "Stage3:\n";
    for(int i = 0; i < 8; i++) {
        cout << re[i] << " + i * " << im[i] << '\n';
    }
    cout << "\n\n";

    for(int i = 0; i < 8; i++) {
        cout << re[idx[i]] << " + i * " << im[idx[i]] << '\n';
    }
    cout << "\n\n";
}

int main() {
    int re[] = {23, 14, 16, 19, 18, 12, 11, 10};
    int im[] = {0, 0, 0, 0, 0, 0, 0, 0};
    fft(re, im);
}