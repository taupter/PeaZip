unit externalprograms;

{$MODE OBJFPC}{$H+}

interface

const
  APPLICATION_PEA = 'Pea 1.26 (LGPLv3, Giorgio Tani)';

  {$IFDEF MSWINDOWS}
  EXEEXT        = '.exe';
  UNRARNAME     = 'unrar';
  APPLICATION_7Z = '7z 25.01 (LGPL, Igor Pavlov), and Tino Reichardt sfx modules and codecs 24.09-v1.5.7-R1 (LGPL)';
  {$IFDEF WIN64}
  APPLICATION_ZPAQ = 'PAQ8F/JD/L/O, LPAQ1/5/8, Zpaqfranz 62.5 [Matt Mahoney et al. (GPL), Franco Corbelli (Mit)]';
  {$ELSE}
  APPLICATION_ZPAQ = 'PAQ8F/JD/L/O, LPAQ1/5/8, Zpaq 7.15 [Matt Mahoney et al. (GPL)]';
  {$ENDIF}
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils), UPX 3.95 (GPL, Markus F.X.J. Oberhumer, Laszlo Molnar and John F. Reiser)';
  APPLICATION_QUAD    = 'QUAD 1.12 (LGPL) / BALZ 1.15 (Public Domain), BCM 1.0 (Public Domain) (Ilia Muraviev)';
  APPLICATION_UNACE   = 'UNACEV2.DLL 2.6.0.0 (royalty-free UNACEV2.DLL license, ACE Compression Software)';
  APPLICATION_FREEARC = 'FreeArc 0.67 alpha (GPL, Bulat Ziganshin)';
  APPLICATION_UNRAR   = 'UNRAR 5.21 (freeware, royalty-free, source available with unrar restriction, Alexander Roshal)';
  APPLICATION_BROTLI  = 'Brotli 1.1.0 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  APPLICATION_ZSTD    = 'Zstd 1.5.7 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$ENDIF}

  {$IFDEF LINUX}
  EXEEXT        = '';
  UNRARNAME     = 'unrar-nonfree';
  APPLICATION_7Z   = 'Linux 7z 25.01 (LGPL, Igor Pavlov), cielavenir/p7zip 24.09.1 (LGPL, T. Yamada)';
  APPLICATION_ZSTD = 'Zstd 1.5.7 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$IFDEF CPUAARCH64}
  APPLICATION_ZPAQ    = '';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils)';
  APPLICATION_QUAD    = '';
  APPLICATION_UNACE   = '';
  APPLICATION_FREEARC = '';
  APPLICATION_UNRAR   = '';
  APPLICATION_BROTLI  = 'Brotli 1.1.0 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  {$ELSE}
  APPLICATION_ZPAQ    = 'PAQ8F/JD/L/O, LPAQ1/5/8, Zpaqfranz 59.8 [Matt Mahoney et al. (GPL), Franco Corbelli (Mit)]';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils), UPX 3.96 (GPL, Markus F.X.J. Oberhumer, Laszlo Molnar and John F. Reiser)';
  APPLICATION_QUAD    = 'QUAD 1.12 (LGPL) / BALZ 1.15(Public Domain), BCM 1.0 (Public Domain) (Ilia Muraviev)';
  APPLICATION_UNACE   = 'UNACE (royalty-free UNACE for Linux license, Marcel Lemke, ACE Compression Software)';
  APPLICATION_FREEARC = 'FreeArc 0.60 (GPL, Bulat Ziganshin)';
  APPLICATION_UNRAR   = 'UNRAR 5.21 beta 2 (freeware, royalty-free, source available with unrar restriction, Alexander Roshal, Petr Cech)';
  APPLICATION_BROTLI  = 'Brotli 1.0.7 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  {$ENDIF}
  {$ENDIF}

  {$IFDEF FREEBSD}
  EXEEXT        = '';
  UNRARNAME     = '';
  APPLICATION_7Z      = 'BSD 7z 21.07 (LGPL, Igor Pavlov)';
  APPLICATION_ZPAQ    = '';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils)';
  APPLICATION_QUAD    = '';
  APPLICATION_UNACE   = '';
  APPLICATION_FREEARC = '';
  APPLICATION_UNRAR   = '';
  APPLICATION_BROTLI  = 'Brotli 1.0.9 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  APPLICATION_ZSTD    = 'Zstd 1.4.8 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$ENDIF}

  {$IFDEF NETBSD}
  EXEEXT        = '';
  UNRARNAME     = '';
  APPLICATION_7Z      = 'BSD 7z 21.07 (LGPL, Igor Pavlov)';
  APPLICATION_ZPAQ    = '';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils)';
  APPLICATION_QUAD    = '';
  APPLICATION_UNACE   = '';
  APPLICATION_FREEARC = '';
  APPLICATION_UNRAR   = '';
  APPLICATION_BROTLI  = 'Brotli 1.0.9 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  APPLICATION_ZSTD    = 'Zstd 1.4.8 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$ENDIF}

  {$IFDEF OPENBSD}
  EXEEXT        = '';
  UNRARNAME     = '';
  APPLICATION_7Z      = 'BSD 7z 21.07 (LGPL, Igor Pavlov)';
  APPLICATION_ZPAQ    = '';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils)';
  APPLICATION_QUAD    = '';
  APPLICATION_UNACE   = '';
  APPLICATION_FREEARC = '';
  APPLICATION_UNRAR   = '';
  APPLICATION_BROTLI  = 'Brotli 1.0.9 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  APPLICATION_ZSTD    = 'Zstd 1.4.8 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$ENDIF}

  {$IFDEF DARWIN}
  EXEEXT        = '';
  UNRARNAME     = '';
  APPLICATION_7Z      = 'macOS 7z 25.01 (LGPL, Igor Pavlov), cielavenir/p7zip 24.09.1 (LGPL, T. Yamada)';
  APPLICATION_ZPAQ    = 'Zpaqfranz 61.2 [Matt Mahoney et al. (GPL), Franco Corbelli (Mit)]]';
  APPLICATION_STRIP   = 'Strip (GPL, GNU binutils)';
  APPLICATION_QUAD    = '';
  APPLICATION_UNACE   = '';
  APPLICATION_FREEARC = '';
  APPLICATION_UNRAR   = '';
  APPLICATION_BROTLI  = 'Brotli 1.1.0 (MIT License, Jyrki Alakuijala, Eugene Kliuchnikov, Robert Obryk, Zoltán Szabadka, Lode Vandevenne)';
  APPLICATION_ZSTD    = 'Zstd 1.5.2 (Dual license BSD / GPLv2, Yann Collet, Przemysław Skibiński)';
  {$ENDIF}

implementation

end.
