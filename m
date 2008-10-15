From: Damazy <damazy@gmail.com>
Subject: Re: sata_sil for 3512A chip on kernel 2.6.26.3
Date: Wed, 15 Oct 2008 08:37:50 +0200
Message-ID: <48F58FBE.909@gmail.com>
References: <48E48BF2.1010403@gmail.com> <48E71DBC.5090301@kernel.org> <48F47924.9040504@gmail.com> <48F54E4C.1020704@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090603010901030108040806"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:46262 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbYJOGhh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 02:37:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2519951fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 23:37:35 -0700 (PDT)
In-Reply-To: <48F54E4C.1020704@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090603010901030108040806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> 
> The commands are either being timed out or aborted by the device.  Can
> you post the result of "smartctl -a" of the drive?
> 

This is output of smartctl -a /dev/sda1

smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG HD502IJ
Serial Number:    S13TJ90Q641644
Firmware Version: 1AA01112
User Capacity:    500,106,780,160 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   8
ATA Standard is:  ATA-8-ACS revision 3b
Local Time is:    Wed Oct 15 08:32:29 2008 CEST

==> WARNING: May need -F samsung or -F samsung2 enabled; see manual for 
details.

SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                         was never started.
                                         Auto Offline Data Collection: 
Disabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                         without error or no self-test 
has ever
                                         been run.
Total time to complete Offline
data collection:                 (7461) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                         Auto Offline data collection 
on/off support.
                                         Suspend Offline collection upon new
                                         command.
                                         Offline surface scan supported.
                                         Self-test supported.
                                         Conveyance Self-test supported.
                                         Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                         power-saving mode.
                                         Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                         General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 125) minutes.
Conveyance self-test routine
recommended polling time:        (  14) minutes.
SCT capabilities:              (0x003f) SCT Status supported.
                                         SCT Feature Control supported.
                                         SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE 
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000f   100   100   051    Pre-fail 
Always       -       0
   3 Spin_Up_Time            0x0007   087   087   011    Pre-fail 
Always       -       4870
   4 Start_Stop_Count        0x0032   100   100   000    Old_age 
Always       -       47
   5 Reallocated_Sector_Ct   0x0033   100   100   010    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000f   253   253   051    Pre-fail 
Always       -       0
   8 Seek_Time_Performance   0x0025   100   100   015    Pre-fail 
Offline      -       9770
   9 Power_On_Hours          0x0032   100   100   000    Old_age 
Always       -       1178
  10 Spin_Retry_Count        0x0033   100   100   051    Pre-fail 
Always       -       0
  11 Calibration_Retry_Count 0x0012   100   100   000    Old_age 
Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age 
Always       -       46
  13 Read_Soft_Error_Rate    0x000e   100   100   000    Old_age 
Always       -       0
183 Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
       -       0
184 Unknown_Attribute       0x0033   100   100   099    Pre-fail  Always 
       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always 
       -       0
188 Unknown_Attribute       0x0032   100   100   000    Old_age   Always 
       -       0
190 Airflow_Temperature_Cel 0x0022   063   060   000    Old_age   Always 
       -       37 (Lifetime Min/Max 35/40)
194 Temperature_Celsius     0x0022   063   059   000    Old_age   Always 
       -       37 (Lifetime Min/Max 35/41)
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always 
       -       115423
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age 
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   099   099   000    Old_age   Always 
       -       311
200 Multi_Zone_Error_Rate   0x000a   100   100   000    Old_age   Always 
       -       0
201 Soft_Read_Error_Rate    0x000a   253   253   000    Old_age   Always 
       -       0

SMART Error Log Version: 1
ATA Error Count: 190 (device log contains only the most recent five errors)
         CR = Command Register [HEX]
         FR = Features Register [HEX]
         SC = Sector Count Register [HEX]
         SN = Sector Number Register [HEX]
         CL = Cylinder Low Register [HEX]
         CH = Cylinder High Register [HEX]
         DH = Device/Head Register [HEX]
         DC = Device Command Register [HEX]
         ER = Error register [HEX]
         ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 190 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 3f 00 ee 1d e0  Error: ICRC, ABRT 63 sectors at LBA = 
0x001dee00 = 1961472

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 00 3f ed 1d e0 00      00:50:52.250  READ DMA
   c8 00 00 3f ec 1d e0 00      00:50:52.250  READ DMA
   c8 00 00 3f eb 1d e0 00      00:50:52.250  READ DMA
   c8 00 00 3f ea 1d e0 00      00:50:52.250  READ DMA
   c8 00 00 3f e9 1d e0 00      00:50:52.250  READ DMA

Error 189 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 9f 58 db 1c e0  Error: ICRC, ABRT 159 sectors at LBA = 
0x001cdb58 = 1891160

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 00 f7 da 1c e0 00      00:50:45.810  READ DMA
   c8 00 00 f7 d9 1c e0 00      00:50:45.810  READ DMA
   c8 00 00 f7 d8 1c e0 00      00:50:45.810  READ DMA
   c8 00 00 f7 d7 1c e0 00      00:50:45.810  READ DMA
   c8 00 00 f7 d6 1c e0 00      00:50:45.800  READ DMA

Error 188 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   00 d0 00 00 00 00 a0   at LBA = 0x00000000 = 0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 00 3f c5 1a e0 00      00:50:38.500  READ DMA
   c8 00 00 3f c4 1a e0 00      00:50:38.490  READ DMA
   ca 00 08 df d1 e9 ea 00      00:50:38.480  WRITE DMA
   ca 00 08 d7 b1 e9 ea 00      00:50:38.480  WRITE DMA
   ca 00 08 cf 91 e9 ea 00      00:50:38.480  WRITE DMA

Error 187 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 4f d0 35 1a e0  Error: ICRC, ABRT 79 sectors at LBA = 
0x001a35d0 = 1717712

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 00 1f 35 1a e0 00      00:50:32.800  READ DMA
   c8 00 80 9f 34 1a e0 00      00:50:32.790  READ DMA
   c8 00 88 17 34 1a e0 00      00:50:32.790  READ DMA
   c8 00 00 17 33 1a e0 00      00:50:32.790  READ DMA
   c8 00 00 17 32 1a e0 00      00:50:32.790  READ DMA

Error 186 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 1f d0 66 16 e0  Error: ICRC, ABRT 31 sectors at LBA = 
0x001666d0 = 1468112

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 00 00 ef 65 16 e0 00      00:50:28.720  READ DMA
   c8 00 00 ef 64 16 e0 00      00:50:28.720  READ DMA
   c8 00 00 ef 63 16 e0 00      00:50:28.720  READ DMA
   c8 00 80 6f 63 16 e0 00      00:50:28.720  READ DMA
   c8 00 88 e7 62 16 e0 00      00:50:28.710  READ DMA

SMART Self-test log structure revision number 0
Warning: ATA Specification requires self-test log structure revision 
number = 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%       529 
      -
# 2  Short offline       Aborted by host               00%       458 
      -

SMART Selective Self-Test Log Data Structure Revision Number (0) should be 1
SMART Selective self-test log data structure revision number 0
Warning: ATA Specification requires selective self-test log data 
structure revision number = 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


Kind regards.

--------------ms090603010901030108040806
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILyzCC
Ao0wggF1oAMCAQICAwEAITANBgkqhkiG9w0BAQUFADA+MQswCQYDVQQGEwJQTDEbMBkGA1UE
ChMSVW5pemV0byBTcC4geiBvLm8uMRIwEAYDVQQDEwlDZXJ0dW0gQ0EwHhcNMDIwNzEyMTYz
MTUzWhcNMTIwNzEyMTYzMTUzWjBDMQswCQYDVQQGEwJQTDEbMBkGA1UEChMSVW5pemV0byBT
cC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwgSTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEApe96WfQxXJ+0MtKgWSvkqNfHGr+3a1KyfEomDpQw1bJLfNfniHC/+BXpU0ho
7gDr2HZpvhxmBvffETwdImfgJOu71xSed+70VjnLumjIzbgMLvATnXOXkoAdGPF+PtyzmH7o
LWmWvJqxEPB4rdMixPVAXFPSfuD5pFRnnJmfI2UCAwEAAaMTMBEwDwYDVR0TAQH/BAUwAwEB
/zANBgkqhkiG9w0BAQUFAAOCAQEAJQ0uGk5oCtGIJlL7f98zextv2a7QQQrTjZVLwuvXO05i
yVifONstgB+68jV15HLJ+qdGQU60ydrQNsv49j1yXl6wpCv6gCSKTNJeLtDE+3p2OWpGrHbh
6djVzD/bw5YDMu3pVNrN55Dk+/YH4eV7bQvuQ/8eCQzYtQzAAPYZNegyuM1pg1X45Ij/xt3x
J3bSYDQ0LMqp2kNxN25Y7939SiU42VL7QNjJejD9oRUYYGT7MboVvEF4nUGDYrmtYe11FIj4
hESwy1mZn2OncRqx140k8d7IRzWkDNKpA7PYEulCvLliTdm39mAZ7xps8tCEL8ecAwh+4fAH
WgQ+g4CBtTCCBJkwggQCoAMCAQICAwRFUjANBgkqhkiG9w0BAQUFADBDMQswCQYDVQQGEwJQ
TDEbMBkGA1UEChMSVW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwg
STAeFw0wODA3MzEyMDA2MDdaFw0wODEwMjkyMDA2MDdaMG4xCzAJBgNVBAYTAlBMMRwwGgYD
VQQKExNQcml2YXRlIENlcnRpZmljYXRlMSAwHgYDVQQDExdNYXRldXN6IERhbWF6eSBIb3Jv
d3NraTEfMB0GCSqGSIb3DQEJARYQZGFtYXp5QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAPZvBpH21zlkJtf5zQjscR4xIxTzijGozZxGKvTkEBvX3MQSarVg
E9kFB3xxhrzjJSFlALL06Keett8Kk8yCD/zw9dLgA06st7gizjPPF6Q92rKCbiC6SIq7DXa6
G95qL5Z5kta5vpkuOkWVL8Ao9YvNUG/OSQkd6RvOPv16DS0ltrqRq3AAWi6hG66cIUhCXwpq
3dONWdmXUd+rlxhmTcA3ZR6bnhffdaWSnnXntEsEHIkBOxBt/KUSVXckmmpCjKyPS+j0d80/
JDz83+YJiagZ2VcfWpub23+MVYUXHUKhOwf8RREELgwbnWm6rwmGfUjnnyezsMaL84PmQg9J
nX8CAwEAAaOCAeowggHmMBsGA1UdEQQUMBKBEGRhbWF6eUBnbWFpbC5jb20wCQYDVR0TBAIw
ADALBgNVHQ8EBAMCBPAwEQYJYIZIAYb4QgEBBAQDAgWgMDAGA1UdHwQpMCcwJaAjoCGGH2h0
dHA6Ly9jcmwuY2VydHVtLnBsL2NsYXNzMS5jcmwwMQYIKwYBBQUHAQEEJTAjMCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jZXJ0dW0ucGwwggE1BgNVHSAEggEsMIIBKDCCASQGCiqEaAGG
9ncCAgEwggEUMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwgesGCCsG
AQUFBwICMIHeMBkWElVuaXpldG8gU3AuIHogby5vLjADAgEBGoHAVXNhZ2Ugb2YgdGhpcyBj
ZXJ0aWZpY2F0ZSBpcyBzdHJpY3RseSBzdWJqZWN0ZWQgdG8gdGhlIENFUlRVTSBDZXJ0aWZp
Y2F0aW9uClByYWN0aWNlIFN0YXRlbWVudCAoQ1BTKSBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJl
bmNlIGhlcmVpbiBhbmQgaW4gdGhlIHJlcG9zaXRvcnkKYXQgaHR0cHM6Ly93d3cuY2VydHVt
LnBsL3JlcG9zaXRvcnkuMA0GCSqGSIb3DQEBBQUAA4GBAI05m1hYt5fBfrjl9meJXJJMmyjl
LtneiRX/C3yrIprGacR24MXVULxQf3YnGRi5dQ4bV9/DdV2R1Kac3Xwk3OOMydSxmwdC0RrS
8VN8+9n9/vdHWtiZATgFMWlOZAvLvezCXHfwfk9jtAYJJewQu6sJn7fN1CBlQ9Eo28wOczRM
MIIEmTCCBAKgAwIBAgIDBEVSMA0GCSqGSIb3DQEBBQUAMEMxCzAJBgNVBAYTAlBMMRswGQYD
VQQKExJVbml6ZXRvIFNwLiB6IG8uby4xFzAVBgNVBAMTDkNlcnR1bSBMZXZlbCBJMB4XDTA4
MDczMTIwMDYwN1oXDTA4MTAyOTIwMDYwN1owbjELMAkGA1UEBhMCUEwxHDAaBgNVBAoTE1By
aXZhdGUgQ2VydGlmaWNhdGUxIDAeBgNVBAMTF01hdGV1c3ogRGFtYXp5IEhvcm93c2tpMR8w
HQYJKoZIhvcNAQkBFhBkYW1henlAZ21haWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA9m8GkfbXOWQm1/nNCOxxHjEjFPOKMajNnEYq9OQQG9fcxBJqtWAT2QUHfHGG
vOMlIWUAsvTop5623wqTzIIP/PD10uADTqy3uCLOM88XpD3asoJuILpIirsNdrob3movlnmS
1rm+mS46RZUvwCj1i81Qb85JCR3pG84+/XoNLSW2upGrcABaLqEbrpwhSEJfCmrd041Z2ZdR
36uXGGZNwDdlHpueF991pZKedee0SwQciQE7EG38pRJVdySaakKMrI9L6PR3zT8kPPzf5gmJ
qBnZVx9am5vbf4xVhRcdQqE7B/xFEQQuDBudabqvCYZ9SOefJ7Owxovzg+ZCD0mdfwIDAQAB
o4IB6jCCAeYwGwYDVR0RBBQwEoEQZGFtYXp5QGdtYWlsLmNvbTAJBgNVHRMEAjAAMAsGA1Ud
DwQEAwIE8DARBglghkgBhvhCAQEEBAMCBaAwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL2Ny
bC5jZXJ0dW0ucGwvY2xhc3MxLmNybDAxBggrBgEFBQcBAQQlMCMwIQYIKwYBBQUHMAGGFWh0
dHA6Ly9vY3NwLmNlcnR1bS5wbDCCATUGA1UdIASCASwwggEoMIIBJAYKKoRoAYb2dwICATCC
ARQwJAYIKwYBBQUHAgEWGGh0dHA6Ly93d3cuY2VydHVtLnBsL0NQUzCB6wYIKwYBBQUHAgIw
gd4wGRYSVW5pemV0byBTcC4geiBvLm8uMAMCAQEagcBVc2FnZSBvZiB0aGlzIGNlcnRpZmlj
YXRlIGlzIHN0cmljdGx5IHN1YmplY3RlZCB0byB0aGUgQ0VSVFVNIENlcnRpZmljYXRpb24K
UHJhY3RpY2UgU3RhdGVtZW50IChDUFMpIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UgaGVy
ZWluIGFuZCBpbiB0aGUgcmVwb3NpdG9yeQphdCBodHRwczovL3d3dy5jZXJ0dW0ucGwvcmVw
b3NpdG9yeS4wDQYJKoZIhvcNAQEFBQADgYEAjTmbWFi3l8F+uOX2Z4lckkybKOUu2d6JFf8L
fKsimsZpxHbgxdVQvFB/dicZGLl1DhtX38N1XZHUppzdfCTc44zJ1LGbB0LRGtLxU3z72f3+
90da2JkBOAUxaU5kC8u97MJcd/B+T2O0Bgkl7BC7qwmft83UIGVD0SjbzA5zNEwxggLrMIIC
5wIBATBKMEMxCzAJBgNVBAYTAlBMMRswGQYDVQQKExJVbml6ZXRvIFNwLiB6IG8uby4xFzAV
BgNVBAMTDkNlcnR1bSBMZXZlbCBJAgMERVIwCQYFKw4DAhoFAKCCAXYwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDgxMDE1MDYzNzUwWjAjBgkqhkiG9w0B
CQQxFgQUhvtb5cqAHDat1YpQiRYiZCwcU1kwWQYJKwYBBAGCNxAEMUwwSjBDMQswCQYDVQQG
EwJQTDEbMBkGA1UEChMSVW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2
ZWwgSQIDBEVSMFsGCyqGSIb3DQEJEAILMUygSjBDMQswCQYDVQQGEwJQTDEbMBkGA1UEChMS
VW5pemV0byBTcC4geiBvLm8uMRcwFQYDVQQDEw5DZXJ0dW0gTGV2ZWwgSQIDBEVSMF8GCSqG
SIb3DQEJDzFSMFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASC
AQAlLpJacWDY1IdwcLsSgLTjwSfoN52sY58jF10IiPPG7Ju/sJvI9BdkzE7sTZUcKnLfHJPa
UnRTGzb1DbcuEzKxDoTvUUXFZJ3T3/D2ZYAseP/0ZJF6MTSYknUNDZwKdj1oSZDyi/ost+05
1KCY6OwOWeMGC1V3gGLT7+XMpykyCIuNi69+kFm0S8woQLptcHMP8p9m0AqqvNJMnclkRtaV
sS/Evqx8QNWlGARMOcP2lEGYpvEkQloP7CpHcg7EqZvU9sShkHW1kvelIt5QOIKZNvrC6D/b
FK8X8cJTrWzZUwY/vCxC5EjPoIPluHFBRtHhnnsJt2hLnH8gNC/dZHygAAAAAAAA
--------------ms090603010901030108040806--
