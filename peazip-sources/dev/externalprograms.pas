unit externalprograms;

{
 DESCRIPTION     :  Unit defining external binaries used in PeaZip project and
                    collecting calls to external routines

 REQUIREMENTS    :  FPC

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODE    :  ---

 REFERENCES      :  ---

 REMARK          :  ---

 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 0.10     20250819  Suve        Initial version on GitHub
 0.11     20250820  G.Tani      Expanded with hash checking values
 0.12     20251015  G.Tani      Expanded moving here some of the calls to external routines

(C) Copyright 2006 Giorgio Tani giorgio.tani.software@gmail.com
The program is released under GNU LGPL http://www.gnu.org/licenses/lgpl.txt

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 3 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
}

{$MODE OBJFPC}{$H+}
{$INLINE ON}

interface

uses
Classes, SysUtils,
{$IFDEF MSWINDOWS}
Windows, activex, ShlObj, ComObj, shellapi, windirs,
{$ENDIF}
list_utils;

const
  APPLICATION_PEA = 'Pea 1.27 (LGPLv3, Giorgio Tani)';

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

  // Known hash values

  //Pea 1.27
  HPEA_BSD_X_GTK2     = '08A04EEF35A5F438AD62B9E4C4705E37E0E2FDAAF71A69DCD60C2D0F7E0AAAAF'; //BSD x86_64 GTK2
  HPEA_LIN_A_GTK2     = '95500D1754C14AC324D1CBCCCE8CB88C73363C4ADF3127E8FAC6E495DF9998DC'; //lin aarch64 GTK2
  HPEA_LIN_X_GTK2     = 'DE92A6D9A7E040D97FA4DFCA876D4CE4BA5BFA0FB2C4D2EBD26DE5ED024D2BC8'; //lin x86_64 GTK2
  HPEA_LIN_X_GTK3     = '105494EF4563AD66FEDD0CE71CABF44403BB9701127B15DA220BA56899FAB92F'; //lin x86_64 GTK3
  HPEA_LIN_X_QT6      = '1EBACA0A5D02FF6CFD790C632CFCC649454BC791819D46F1F88EFFB764DF8A83'; //lin x86_64 Qt6
  HPEA_MACOS_A        = '530B528B1D370F0653A06AB9B6CBCAE0FD54C2B6B764E9E6435A909ADA81687F'; //macos aarch64
  HPEA_MACOS_X        = '3C65EE1021929E2C2C3E626A312EDAF681012C1C2FBED336257F6F7EE794BDA7'; //macos Intel x86_64
  HPEA_WIN32_X        = '4C0EC55F80376F310F86E3F98EBD93E1030BAFF785AC9B330221813C95FEB119'; //win32
  HPEA_WIN64_X        = 'FC1C53367BF962EF819F467D54B939E515055B2EA84A3A253FE9D6D16D11BD42'; //win64

  //7z sfx (Tino Reichardt's modules)
  H7ZSFX1             = '353A3F6D7CBD06C6F25589DF00B40F363E9F597C4EDC4AD782F6D6B21F297F09'; //7z\7z.sfx
  H7ZSFX2             = '5F5A7F958C8A9CDBF43A8135670A8E389050B5AEB0C0325300F6C08E640AA24B'; //7z\7zCon.sfx
  H7ZSFX3             = 'C29701887677ADC82AAF3F2C55432007B3228F5D05EC3B932E08BFC3ED1A7159'; //7z\7zCon.linux.sfx

  //freearc sfx
  HARCSFX1            = '4F00384CFC55BBE91C3E2EA9A2A94F63DE5CCBB8360141DF0E4C4AEF30FBD383'; //arc\arc-tiny.linux.sfx freeze
  HARCSFX2            = '1229A21E326612DE63CB6F7B5B871DA2913B9C3E52475763AF5FEE7AC785022A'; //arc\arc-tiny.sfx freeze
  HARCSFX3            = 'DF9EF81163FF5C9390F2680AFF22148E623AF6AC8713612625ED3D2168D2F56B'; //arc\freearc.sfx freeze
  HARCSFX4            = '2143076C94FC6838E2C705E4AC8CFA7F1B9E8B30C247A3AB44707744D2E3209B'; //arc\freearc-installer.sfx freeze
  HARCSFX5            = '38B6FB72A5BC35B62D89CA835D0A9A719734FBD9F79683C8773156A4A43FE34B'; //arc\freearc-tiny.sfx freeze

  //win helpers
  HWINCONFIGURE       = '9361847CC76AC58B53D0321ABA4607E4D93F6D8C5E11B1FC054B7236C2C87BCA'; //Configure PeaZip 32 and 64 bit 10.3+
  HDDDLL_WIN64_X      = 'E4ACD142D36A3A16532C85C9A7CCD50F9ABC25721FA35706B16F6CEEC565B44C'; //dragdropfilesdll.dll 64 bit 10.6+
  HDDDLL_WIN32_X      = '29CABD1CD01C09A29C48FA45F347F7673D27DDC61741279669CAB5BC56038B12'; //dragdropfilesdll.dll 32 bit 10.6+

  //win64 base package
  H7Z_WIN64_X         = '4CD7D776C686427226A151789D2D61F0B2ED2C392148CC4E69C0238362FAFECF'; //7z 25.01 64 bit
  H7ZDLL_WIN64_X      = '5BD20FB38499D95C39594F41D4781B6181B3304B7F1F4D06B0182F514E7EAA74'; //7z\7z.dll
  H7ZBROTLI_WIN64_X   = 'EFF4866A407D876F722068B2BBF77DFA271AD828B090BC7EC735237AB6BB33F4'; //7z\Codecs\brotli.dll
  H7ZFLZMA2_WIN64_X   = '41B3042C2AD45A6645E34B1EA587E024A0B8721980676EC5FB7CB4763E25004D'; //7z\Codecs\flzma2.dll
  H7ZLIZARD_WIN64_X   = '22365EB170AF99EE72881D099EFF996F2DFAAA5FA6642AEA58C5094CC7CD8E97'; //7z\Codecs\lizard.dll
  H7ZLZ4_WIN64_X      = 'F23791027EAAB2B6DAAAB1F4A3F31E8A5AFD2340FAC0311D1517699BE1EAC1B2'; //7z\Codecs\lz4.dll
  H7ZLZ5_WIN64_X      = '3CD81FFE67E4C61FFD7861166841A35FBF8481415319F439E8B2EB09E1339144'; //7z\Codecs\lz5.dll
  H7ZZSTD_WIN64_X     = '818E8EA81319B719DAA09E373132EEF287B7C8730500C07FCA9D1D3C9E92F9ED'; //7z\Codecs\zstd.dll
  HBROTLI_WIN64_X     = 'B7A78E7B814B08CE0E3B6FF6ECEEAC13E6F02E0EFC5994E53AD000D9B99A3DCE'; //brotli 64 bit
  HZPAQ_WIN64_X       = '17DBEAA8C773B672DBCC60332CBED5A98E94B8156026B2001B108AFFFE30D602'; //zpaqfranz 62.5 64 bit
  HZSTD_WIN64_X       = 'E86912B9DBCD3385D6E52F744A36DBDE5BD0A5E94851E39EB87023506FBA1521'; //zstd 1.5.7 64 bit
  HARC_WIN64_X        = 'B36B1BE0A3C329675AF4EECE3193F08CF343EDE57A6933033BF6004A50AB2A65'; //arc 0.67 freeze
  HARCDLL1_WIN64_X    = '17A9FFDF381F7A9F6CDFC85B157FC6CF80CD4B45ED8AD43EDAC73008923501A0'; //arc\facompress.dll freeze
  HARCDLL2_WIN64_X    = '7EEB2C50920E30544E2F180B0C39488501372A8F8BD8393BCB095353E9114CDE'; //arc\facompress_mt.dll freeze
  HBCM_WIN64_X        = '586CAD02BDEC4E7278A8C797FEC0A6275499086497CA12461DC85CAAF83BD15A'; //bcm 1.0 64 bit freeze

  //Win32 base package
  H7Z_WIN32_X         = 'B1E06A424F2E7E3B9A5BF676665BD14BC39785FBC48CFDCC54AB63C574DE0B01'; //7z 25.01 32 bit
  H7ZDLL_WIN32_X      = '51075AF59F6696D5DC5446BA39FABFD0022628CDCFA41C80E7CB66E3BF4EE55D'; //7z\7z.dll
  HZPAQ_WIN32_X       = 'A0F127A70943B0262060498C1723C795A8E2980F1ACF0C42EE8C1DAE72AE54B5'; //zpaq 7.15 freeze

  //additional formats
  HBALZ               = 'F31FCF56B866DAA87B746DB5352AA6A557CBB60C590A27676AF66256BCC2E2EA'; //balz 1.15 freeze
  HLPAQ1              = 'FE32FC0FCE51ED295A367B8829B7B29F0E755F52C1C5AD23681A97A673CCBDD7'; //lpaq1 freeze
  HLPAQ5              = '6374D2FA4AB190A39AA6459B54BC6C4FCB0381E5822628988C17B28C8BE7554D'; //lpaq5 freeze
  HLPAQ8              = '52674DE2E06ECC07AE9C4101DE73203BB04A916B42EF2A4B71F403294441B227'; //lpaq8 freeze
  HPAQ8F              = '14500A21A2AF760A648D100D93A109E28D82713851149490D9D32CB45005C112'; //paq8f freeze
  HPAQ8JD             = '254C4714B672C51F0FDC2121AC17DAAA13A4A57DD680BB3126492A3CE96BF9BE'; //paq8jd freeze
  HPAQ8L              = '9A1C9C11FE5EE5DA84671E1A3E798293A44A817F25DFB907A8F78CC7FF227EB1'; //paq8l freeze
  HPAQ8O              = 'C6CBCF5CF508FF8010313A1A251350E31A6BFADF217F0420D1CC32A394844B32'; //paq8o freeze
  HQUAD               = '087401A585B096411272CCBEC9CEE1C40FCD22A7D16A8832023700D288BE0D24'; //quad 1.12 freeze
  HSTRIP              = 'B4EBE301E77A5B6A40E71776B921EFDB639BDC9011D2EF5A137DE9FA6F57E51E'; //strip freeze
  HUPX_WIN32_X        = 'D634CDE09D1AA1320A1D4C589D35D306F8350129FAF225B2BCA394128C2C4442'; //upx 3.95 32 bit freeze
  HUPX_WIN64_X        = '24624A9D3786D7BA93575383EDF694505453AF59B39B0463260A75C6344D0AE7'; //upx 3.95 64 bit freeze
  HUNACE              = '8ABB49B815A2F57E22F21967B9059DD3D4A22D75C8460AE893FF7FC5D30CFEC5'; //unace freeze
  HUNACEDLL           = 'C9D28800E740A1569AEC8FE27DF10EF186D883F94CEC15A5C228826B45A24F9D'; //unace\UNACEV2.DLL freeze
  HUNRAR              = 'E13A75A2936DB0E8BE3C5B72D19E0E9C6AB27BC37933490E2D847E189DBCA5EF'; //unrar 5.21 freeze

  //Darwin/macOS Apple Silicon aarch64
  H7Z_MACOS           = '5C2FD36F00A66F7787DCF1BADD977D44A02B50063FE5678E1F19FF64797432ED'; //7z 25.01 universal binary
  H7ZALT_MACOS        = '632E0E22ECA9DF186EA3C8F101CB49E09B09920707ED181507B0D83D38888C65'; //cielavenir/p7zip 24.09.1
  HBROTLI_MACOS_A     = '32C38FD7A0D6B1294781705942F6A7839111FE352E2BF4EBF1A25934ABDF0B7D'; //brotli aarch64
  HZPAQ_MACOS_A       = 'AE4389AC290F38B42CB02D744924DECC6215F6B546B8B257FFA2920C3ABA0C3F'; //zpaqfranz 61.2 aarch64
  HZSTD_MACOS_A       = '3796CE883E03B33B00F54F229992A768E302B9C7B231B230EAC2A6F70B99EE03'; //zstd aarch64
  //Intel x86_64
  HBROTLI_MACOS_X     = '9A4524554B9A966EAA5A13B7127B02A635C94CDEB101F30A1BA54BC99C977B28'; //brotli x86_64
  HZPAQ_MACOS_X       = '9171E728276D517CF22F687092F4201A4437A917C0CBFFA9078E3F26A029B007'; //zpaqfranz 61.2 x86_64
  HZSTD_MACOS_X       = '44B6A7E6988D5AB1F3829428FA8D5A61E54FAC46D86D6DAAFA84058449498321'; //zstd x86_64
  HZSTDLIB_MACOS_X    = '40B68816D275792058BDC1CD42D794690E51F8047405CE8B17746EAC4CC61E1A'; //lib/libzstd.1.dylib

  //BSD
  H7Z_BSD_X           = 'C1108D01249D960BE54AC517AD2267D2D8C8662ABC6101A48C75AEC4FCE1174B'; //7z 21.07
  HBROTLI_BSD_X       = '90A625C12427C4C2F27AB05A353978B24FF943CA0DC247CD5A2F8038260E29FB'; //brotli x86_64
  HZSTD_BSD_X         = '989DFF2DC096C4D5A88B6850120038FFE095D18CFF3206D15F82FD63FE8D1B8C'; //zstd x86_64

  //Linux x86_64
  H7Z_LIN_X           = '5EF56FBEF44A9B618036A90039D4A709A18E0950D7939112114F5C43674C5422'; //7z 25.01
  H7ZALT_LIN_X        = 'E132237815C07A2D006DCC60FF57EE65528EBB696C3C06C866991D6BF3AF31AF'; //cielavenir/p7zip 24.09.1
  HBCM_LIN_X          = '4B69F1EAA187CA2A9733CEF266FE84052EA9DB2DCBC177A2D442466D9AD28CC2'; //bcm
  HBROTLI_LIN_X       = '4DE1C1A73B5467D2AAC4950BA4EF33C07C3DB46460F25BE2C4302EEB2CC3C21D'; //brotli
  HUPX_LIN_X          = 'B97D182D9718FD7FD608FA2CE3375A15F479C73415B51999DCB5FEA72646F53C'; //upx
  HZPAQ_LIN_X         = '1D53F25BFA66AC6333661C6772D9EB9F0FB582D4267001539810876C5A203550'; //zpaqfranz 59.8
  HZSTD_LIN_X         = '82A75EA32C8B3B66083BB8C6CAED927656978C7B38E9420C13757C0BA56DFB8C'; //zstd 1.5.7
  H7ZRARSO_LIN_X      = '1C4BAADFA986CF8186731C54E892F315C9D4582496C3A075324BA345619F4C36'; //7z/codecs/Rar.so
  //x86
  HARC_LIN_X          = '2BA0605AD4569BAA83F050ADED9C9EE52F02D9A0BDDAC37B1AEADFFD4D960F76'; //arc (x86)
  HLPAQ8_LIN_X        = '3FC1609793097868951CF1FD3179826301F7C7CE0204BD82159E0892B4786765'; //lpaq8 (x86)
  HPAQ8O_LIN_X        = '7206FA4EB8C0110EC845CE2BA6FB42FEA1BA755CC6E3FA0DD7620050D6F5A8DF'; //paq8o (x86)
  //aarch64
  H7Z_LIN_A           = '17595CA8613132898C870558C018C4AB4B89F1BDA5E23D227EE7925062D5728E'; //7z aarch64 25.01
  HBROTLI_LIN_A       = '32AA36A75D2151B6A6489E4ED735B5F133AA9DEE5D1F9332966627570D0C7A8E'; //brotli aarch64
  HZSTD_LIN_A         = 'A7FA062F4AF7B56717758972D4CCE140EDA199CAC6A7A8A091D0FECD05950DA9'; //zstd 1.5.7 aarch64

{$IFDEF MSWINDOWS}
type //used for file properties
   TSHMultiFileProperties = function(pDataObj: IDataObject; Flag: DWORD): HRESULT;
   stdcall;
{$ENDIF}

{$IFDEF MSWINDOWS}
var
  //used for file properties
  hUser32prop: HMODULE;
  SHMultiFileProperties: TSHMultiFileProperties;
{$ENDIF}

{$IFDEF MSWINDOWS}
//get file properties
procedure ShowFileProperties(Files: TStrings; aWnd: HWND);
//wrappers for ShFileOperationW
function fileop_fromnamelist(fnames: array of ansistring; fto:ansistring; fileopfun:integer; fileopflags:integer):integer;
function fileop_fromnamelist_single(fname, fto:ansistring; fileopfun:integer; fileopflags:integer):integer;
{$ENDIF}

implementation

{$IFDEF MSWINDOWS}
function callSHMultiFileProperties(pDataObj: IDataObject; Flag: DWORD): HRESULT;
begin
      try
         hUser32prop := GetModuleHandle(PChar('shell32.dll'));
         if hUser32prop <> 0 then
            begin
            pointer(SHMultiFileProperties) := GetProcAddress(hUser32prop, 'SHMultiFileProperties');
            if @SHMultiFileProperties <> nil then
               SHMultiFileProperties(pDataObj,Flag);
            end;
      except
      end;
end;

function GetFileListDataObject(Files: TStrings): IDataObject;
type
   PArrayOfPItemIDList = ^TArrayOfPItemIDList;
   TArrayOfPItemIDList = array[0..0] of PItemIDList;
var
   Malloc: IMalloc;
   Root: IShellFolder;
   p: PArrayOfPItemIDList;
   chEaten, dwAttributes: ULONG;
   i, FileCount: Integer;
begin
   Result := nil;
   FileCount := Files.Count;
   if FileCount = 0 then Exit;

   OleCheck(SHGetMalloc(Malloc));
   OleCheck(SHGetDesktopFolder(Root));
   p := AllocMem(SizeOf(PItemIDList) * FileCount);
   try
     for i := 0 to FileCount - 1 do
       try
         //if not (checkdirexists(Files[i]) or FileExists(Files[i])) then Continue;
         OleCheck(Root.ParseDisplayName(GetActiveWindow,
           nil,
           PWideChar(WideString(Files[i])),
           chEaten,
           p^[i],
           dwAttributes));
       except
       end;
     OleCheck(Root.GetUIObjectOf(GetActiveWindow,
       FileCount,
       p^[0],
       IDataObject,
       nil,
       Pointer(Result)));
   finally
     for i := 0 to FileCount - 1 do
     begin
       if p^[i] <> nil then Malloc.Free(p^[i]);
     end;
     FreeMem(p);
   end;
end;

procedure ShowFileProperties(Files: TStrings; aWnd: HWND);
type
   PArrayOfPItemIDList = ^TArrayOfPItemIDList;
   TArrayOfPItemIDList = array[0..0] of PItemIDList;
var
   Data: IDataObject;
begin
   if Files.Count = 0 then Exit;
   Data := GetFileListDataObject(Files);
   callSHMultiFileProperties(Data, 0);
end;

function fileop_fromnamelist(fnames: array of ansistring; fto:ansistring; fileopfun:integer; fileopflags:integer):integer;
var
   FStruct: TSHFILEOPSTRUCTW;
   tmpfnames: widestring;
   tmpfto: widestring;
   i:integer;
begin
if fto<>'' then
   if not(checkdirexists(fto)) then ForceDirectories(fto);
//file already checked when the function is called
tmpfnames:='';
for i:=0 to (length(fnames)-1) do tmpfnames:=tmpfnames+WideString(expandfilename(fnames[i]))+#0;
if fto<>'' then tmpfto:=WideString(expandfilename(fto));
FStruct.wnd:=0;
case fileopfun of
   0: FStruct.wFunc:=FO_DELETE;
   1: FStruct.wFunc:=FO_MOVE;
   2: FStruct.wFunc:=FO_COPY;
   end;
FStruct.pFrom:=PWChar((tmpfnames)+#0);
if fto<>'' then FStruct.pTo:=PWChar((tmpfto)+#0#0)
else FStruct.pTo:=nil;
case fileopflags of
   0: FStruct.fFlags:= FOF_ALLOWUNDO;
   1: FStruct.fFlags:= FOF_ALLOWUNDO or FOF_RENAMEONCOLLISION;
   2: FStruct.fFlags:= FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
   3: FStruct.fFlags:= FOF_NOCONFIRMATION;
   end;
FStruct.fAnyOperationsAborted := false;
FStruct.hNameMappings := nil;
Result:=ShFileOperationW(@FStruct);
end;

function fileop_fromnamelist_single(fname, fto:ansistring; fileopfun:integer; fileopflags:integer):integer;
var
   FStruct: TSHFILEOPSTRUCTW;
   tmpfname: widestring;
   tmpfto: widestring;
   i:integer;
begin
//file already checked when the function is called
tmpfname:='';
tmpfname:=WideString(expandfilename(fname))+#0;
if fto<>'' then tmpfto:=WideString(expandfilename(fto));
FStruct.wnd:=0;
case fileopfun of
   0: FStruct.wFunc:=FO_DELETE;
   1: FStruct.wFunc:=FO_MOVE;
   2: FStruct.wFunc:=FO_COPY;
   end;
FStruct.pFrom:=PWChar((tmpfname)+#0);
if fto<>'' then FStruct.pTo:=PWChar((tmpfto)+#0#0)
else FStruct.pTo:=nil;
case fileopflags of
   0: FStruct.fFlags:= FOF_ALLOWUNDO;
   1: FStruct.fFlags:= FOF_ALLOWUNDO or FOF_RENAMEONCOLLISION;
   2: FStruct.fFlags:= FOF_ALLOWUNDO or FOF_NOCONFIRMATION;
   3: FStruct.fFlags:= FOF_NOCONFIRMATION;
   end;
FStruct.fAnyOperationsAborted := false;
FStruct.hNameMappings := nil;
Result:=ShFileOperationW(@FStruct);
end;
{$ENDIF}

end.
