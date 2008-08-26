From: Frans Pop <elendil@planet.nl>
Subject: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Tue, 26 Aug 2008 11:24:38 +0200
Message-ID: <200808261124.39282.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Xv8sIQZMg6niQrb"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml06.kpnxchange.com ([213.75.38.155]:9798 "EHLO
	cpsmtpo-eml06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752200AbYHZJYl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 05:24:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

--Boundary-00=_Xv8sIQZMg6niQrb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Resend with correct address for linux-arm list; with apologies.)

Starting with kernel 2.6.26 I've noticed that the harddisk (HDD) led on my 
QNAP TS-109 (which has a Marvel SATA controller as platform device) no 
longer flashes when there is disk activity. Instead it will just 
stay "on" all the time. The led worked fine with 2.6.25.

I have bisected this to the following series of commits, which are all 
libata or sata_mv changes:
9363c3825ea9ad7..094e50b2f74146d8ee
Further bisection is not possible because between those commits the 
harddisk is not recognized at all.

Lennert Buytenhek suggested to try disabling NCQ, and that does indeed 
make a difference.

After booting the system I did 'echo 1 >/sys/block/sdX/device/queue_depth' 
and after that the HDD led showed disk activity again.

After enabling NCQ again ('echo 31 >/sys/...'), the led again becomes 
unresponsive and just stays on.

Attached a diff between sata_mv hardware registers between 2.6.25 and 
2.6.26 obtained using a patch provided by Mark Lord. (For some reason
"Host" and "ATA Shadow" regs were not available on 2.6.25.)

Cheers,
FJP


--Boundary-00=_Xv8sIQZMg6niQrb
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="qnap_mv0.regs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="qnap_mv0.regs.diff"

--- qnap_mv0_2.6.25.regs	2008-08-11 20:13:14.000000000 +0200
+++ qnap_mv0.regs	2008-08-11 19:08:18.000000000 +0200
@@ -1,102 +1,106 @@
 CRPBs:
-  0: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=52630
-  1: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=54883
-  2: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=57132
-  3: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=59382
-  4: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=61878
-  5: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=64515
-  6: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=1121
-  7: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=3279
-  8: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=5368
-  9: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=7277
- 10: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=9196
- 11: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=11005
- 12: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=12797
- 13: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=14946
- 14: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=16923
- 15: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=18722
- 16: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=20525
- 17: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=30791
- 18: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=11866
- 19: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=56565
- 20: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=64129
- 21: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=4382
- 22: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=52366
- 23: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=28236
-=24: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=30786
- 25: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=33358
- 26: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=35931
- 27: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=38729
- 28: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=41622
- 29: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=44619
- 30: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=47195
- 31: tag=0  ioid=0  estat=0x00 dstat=0x50 tstmp=49739
+  0: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=54641
+  1: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=55675
+  2: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=62732
+  3: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=3073
+  4: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=8681
+  5: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=9721
+  6: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=10762
+  7: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=17302
+  8: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=23001
+  9: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=52336
+ 10: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=53359
+ 11: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=56477
+ 12: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=37642
+ 13: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=38704
+ 14: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=39764
+ 15: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=46417
+ 16: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=52200
+ 17: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=32877
+ 18: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=62100
+ 19: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=1606
+ 20: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=34537
+ 21: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=35359
+ 22: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=36419
+ 23: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=51224
+ 24: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=58938
+=25: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=10808
+ 26: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=11848
+ 27: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=12877
+ 28: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=22037
+ 29: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=28404
+ 30: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=26248
+ 31: tag=0  ioid=0  estat=0x00 dstat=0x40 tstmp=53609
 
 CRQBs:
-  0: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  1: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  2: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  3: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  4: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  5: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  6: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  7: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  8: 07d47000 00000000 00000000 00000000 00ca0000 ..
-  9: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 10: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 11: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 12: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 13: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 14: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 15: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 16: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 17: 07d47000 00000000 00000001 00000000 00c80000 ..
- 18: 07d47000 00000000 00000001 00000000 00c80000 ..
- 19: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 20: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 21: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 22: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 23: 07d47000 00000000 00000001 00000000 00c80000 ..
- 24: 07d47000 00000000 00000001 00000000 00c80000 ..
-=25: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 26: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 27: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 28: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 29: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 30: 07d47000 00000000 00000000 00000000 00ca0000 ..
- 31: 07d47000 00000000 00000000 00000000 00ca0000 ..
+  0: 07d59000 00000000 00020002 00000000 08610000 ..
+  1: 07d04000 00000000 00040004 00000000 08610000 ..
+  2: 07d58000 00000000 00000000 00000000 18610000 ..
+  3: 07d58000 00000000 00000000 00000000 08610000 ..
+  4: 07d58000 00000000 00000000 00000000 08610000 ..
+  5: 07d59000 00000000 00020002 00000000 08610000 ..
+  6: 07d04000 00000000 00040004 00000000 08610000 ..
+  7: 07d58000 00000000 00000000 00000000 10610000 ..
+  8: 07d58000 00000000 00000000 00000000 08610000 ..
+  9: 07d58000 00000000 00000000 00000000 10610000 ..
+ 10: 07d59000 00000000 00020002 00000000 08610000 ..
+ 11: 07d58000 00000000 00000000 00000000 08610000 ..
+ 12: 07d58000 00000000 00000000 00000000 08610000 ..
+ 13: 07d59000 00000000 00020002 00000000 08610000 ..
+ 14: 07d04000 00000000 00040004 00000000 08610000 ..
+ 15: 07d58000 00000000 00000000 00000000 10610000 ..
+ 16: 07d58000 00000000 00000000 00000000 08610000 ..
+ 17: 07d58000 00000000 00000000 00000000 08610000 ..
+ 18: 07d58000 00000000 00000001 00000000 08600000 ..
+ 19: 07d58000 00000000 00000001 00000000 08600000 ..
+ 20: 07d58000 00000000 00000001 00000000 08600000 ..
+ 21: 07d58000 00000000 00000000 00000000 08610000 ..
+ 22: 07d59000 00000000 00020002 00000000 08610000 ..
+ 23: 07d58000 00000000 00000000 00000000 10610000 ..
+ 24: 07d58000 00000000 00000000 00000000 08610000 ..
+=25: 07d58000 00000000 00000000 00000000 08610000 ..
+ 26: 07d59000 00000000 00020002 00000000 08610000 ..
+ 27: 07d04000 00000000 00040004 00000000 08610000 ..
+ 28: 07d58000 00000000 00000000 00000000 18610000 ..
+ 29: 07d58000 00000000 00000000 00000000 08610000 ..
+ 30: 07d58000 00000000 00000001 00000000 08600000 ..
+ 31: 07d58000 00000000 00000000 00000000 08610000 ..
 
 EDMA regs:
-000:   Config: 0000001f Qlen=32 BSz=128 WBlen=256
-004:    Timer: 3824da8b
+000:   Config: 0000003f NCQ Qlen=32 BSz=128 WBlen=256
+004:    Timer: d9ac2965
 008:  IErrCau: 00000000
 00c:  IErrMsk: fc1e9fff pDAT pPRD DevErr DevDis DevCon SerrInt bit6 SelfDis TrInt pCQRB pCRPB pInt IORdy cRx2 dRx0 dRx1 dRx2 dRx3 dTx0 dTx1 dTx2 dTx3 dTx4 Proto
 010: RqBaseHi: 00000000
-014:  RqInPtr: 07c91320 Index=25 Base=0x7c91
+014:  RqInPtr: 07d56320 Index=25 Base=0x7d56
 018: RqOutPtr: 00000320 Index=25 Base=0x0
 01c: RsBaseHi: 00000000
 020:  RsInPtr: 000000c8 Index=25 Base=0x0
-024: RsOutPtr: 07d460c8 Index=25 Base=0x7d460
+024: RsOutPtr: 07d570c8 Index=25 Base=0x7d570
 028:  Command: 00000001 Active
 02c: TestCtrl: 00000000
-030:   Status: 000000e0 Tag=0 D2M cEmpty Idle State=0x0 IOID=0
+030:   Status: 000000c0 Tag=0 M2D cEmpty Idle State=0x0 IOID=0
 034:  IORdyTO: 000000bc
 038:  Arbiter: 00032190
 040: DelayThr: 00000000
 060: HaltCond: fc1e0e1f
-064: IErrCau2: 00000000
+064: IErrCau2: 00000004
 068: IErrMsk2: 00000000
 06c: Reserved: ff000000
 080:  FsmDctl: 0000ffff
 084: FsmDstat: 00000000
 088: BusyStat: 00000000
 08c:  TcqStat: 00000000
-090: RxFISprs: 00504034
+090: RxFISprs: 015040a1
 094: Ncq0Done: 00000000
 098: Ncq1Done: 00000000
 09c: Ncq2Done: 00000000
 0a0: Ncq3Done: 00000000
-0a8: DsMemory: 10100001
+0a8: DsMemory: 10100000
+
+HOST regs:
+1d60: MainCaus: 00000000
+1d64: MainMask: 00000000
 
 SATA regs:
 300:  SStatus: 00000113 DET=Dev+Phy SPD=0x1 IPM=0x1
@@ -104,26 +108,37 @@
 340:  SErrMsk: 019c0000 W B D S T
 308: SControl: 00000300 DET=Off IPM=0x3
 30c:   LTMode: 010300b0
-310:  PhyMod3: aaaac02a
+310:  PhyMod3: aaaac022
 314:  PhyMod4: 00010005
 32c:  PhyMod1: 40555aa0
 330:  PhyMod2: 3cf5944f
 334:  BistCtl: 00800000
 338:  BistDW1: 00000000
 33c:  BistDW2: 00000000
-050:    IFCfg: 009b7095 RefClk=25Mhz RefClkDiv=2 FeedDiv=1 Gen2iEn bits_12-23=0x9b7
+050:    IFCfg: 009b1095 RefClk=25Mhz RefClkDiv=2 FeedDiv=1 Gen2iEn bits_12-23=0x9b1
 344:    IFCtl: 00000000 PmPortTx=0
 348: IFTstCtl: 00000000
-34c: IFStatus: 00404034 FIStypeRx=0x34 PMportRx=0 MBistRdy DevPres LinkRdy
+34c: IFStatus: 004040a1 FIStypeRx=0xa1 PMportRx=0 MBistRdy DevPres LinkRdy
 35c:  VUnique: 00000000
 360:   FISCfg: 00000000
 364: FISiCaus: 00008000
 368: FISiMask: 00000a00
-370: RxFISDW0: 00504034
-374: RxFISDW1: e6bc2800
-378: RxFISDW2: 00000006
+370: RxFISDW0: 005040a1
+374: RxFISDW1: 00000001
+378: RxFISDW2: 00000000
 37c: RxFISDW3: 00000000
 380: RxFISDW4: 00000000
-384: RxFISDW5: 00000000
+384: RxFISDW5: 00001000
 388: RxFISDW6: 00000000
 
+ATA Shadow regs:
+100:     Data: 16a516a5
+104:    Error: 00000000
+108:    NSect: 08080808
+10c:     LbaL: c8c8c8c8
+110:     LbaM: 3e3e3e3e
+114:     LbaH: 2a2a2a2a
+118:      Dev: 40404040
+11c:     Stat: 50505050
+120:  AltStat: 50505050
+

--Boundary-00=_Xv8sIQZMg6niQrb--
