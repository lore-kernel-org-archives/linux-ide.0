From: arnaud atoch <arnaud.atoch@gmail.com>
Subject: Re: Marvell support in ahci
Date: Sat, 2 Apr 2011 22:09:56 +0200
Message-ID: <BANLkTimQ_0D540RoaAF7j-UgnJuyK87VGw@mail.gmail.com>
References: <BANLkTinXaLRBHhrYgetzgv=u8kBg=SQRpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33733 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab1DBUJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Apr 2011 16:09:57 -0400
Received: by ywj3 with SMTP id 3so1797450ywj.19
        for <linux-ide@vger.kernel.org>; Sat, 02 Apr 2011 13:09:56 -0700 (PDT)
In-Reply-To: <BANLkTinXaLRBHhrYgetzgv=u8kBg=SQRpQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

2011/4/2 arnaud atoch <arnaud.atoch@gmail.com>
>
> Bonjour,
>
> Thank you for your time devoted to maintaining the AHCI sata part of =
the Linux kernel.
> I'd like to to ask you to add the Marvell sata device found on variou=
s ASUS motherboard like mine : P5WDG2WS Pro.
>
> This sata device is listed as :
> 02:00.0 0106: 11ab:6141 (rev 01)
> 02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA =
II PCI-E controller (rev 01) (prog-if 81)
> =A0=A0=A0 Subsystem: ASUSTeK Computer Inc. Device 81d6
> =A0=A0=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-
> =A0=A0=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> =A0=A0=A0 Latency: 0 (2000ns min), Cache Line Size: 16 bytes
> =A0=A0=A0 Interrupt: pin A routed to IRQ 10
> =A0=A0=A0 Region 0: I/O ports at bc00 [size=3D8]
> =A0=A0=A0 Region 1: I/O ports at b880 [size=3D4]
> =A0=A0=A0 Region 2: I/O ports at b800 [size=3D64]
> =A0=A0=A0 Region 4: I/O ports at b480 [size=3D32]
> =A0=A0=A0 Region 5: Memory at ebdffc00 (32-bit, non-prefetchable) [si=
ze=3D1K]
> =A0=A0=A0 Expansion ROM at ebd80000 [disabled] [size=3D256K]
> =A0=A0=A0 Capabilities: [48] Power Management version 2
> =A0=A0=A0 =A0=A0=A0 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(=
D0+,D1+,D2-,D3hot+,D3cold-)
> =A0=A0=A0 =A0=A0=A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=
=3D1 PME+
> =A0=A0=A0 Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit=
-
> =A0=A0=A0 =A0=A0=A0 Address: 00000000=A0 Data: 0000
> =A0=A0=A0 Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
> =A0=A0=A0 =A0=A0=A0 DevCap:=A0=A0=A0 MaxPayload 128 bytes, PhantFunc =
0, Latency L0s unlimited, L1 unlimited
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtTag- AttnBtn- AttnInd- PwrInd- RBE- =
=46LReset-
> =A0=A0=A0 =A0=A0=A0 DevCtl:=A0=A0=A0 Report errors: Correctable- Non-=
=46atal- Fatal- Unsupported-
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoS=
noop-
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 MaxPayload 128 bytes, MaxReadReq 128 by=
tes
> =A0=A0=A0 =A0=A0=A0 DevSta:=A0=A0=A0 CorrErr- UncorrErr- FatalErr- Un=
suppReq+ AuxPwr- TransPend-
> =A0=A0=A0 =A0=A0=A0 LnkCap:=A0=A0=A0 Port #0, Speed 2.5GT/s, Width x1=
, ASPM L0s, Latency L0 <256ns, L1 unlimited
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ClockPM- Surprise- LLActRep- BwNot-
> =A0=A0=A0 =A0=A0=A0 LnkCtl:=A0=A0=A0 ASPM Disabled; RCB 64 bytes Disa=
bled- Retrain- CommClk+
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ExtSynch- ClockPM- AutWidDis- BWInt- Au=
tBWInt-
> =A0=A0=A0 =A0=A0=A0 LnkSta:=A0=A0=A0 Speed 2.5GT/s, Width x1, TrErr- =
Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> =A0=A0=A0 Capabilities: [100 v1] Advanced Error Reporting
> =A0=A0=A0 =A0=A0=A0 UESta:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- Cmp=
ltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> =A0=A0=A0 =A0=A0=A0 UEMsk:=A0=A0=A0 DLP- SDES- TLP- FCP- CmpltTO- Cmp=
ltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> =A0=A0=A0 =A0=A0=A0 UESvrt:=A0=A0=A0 DLP+ SDES- TLP- FCP+ CmpltTO- Cm=
pltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
> =A0=A0=A0 =A0=A0=A0 CESta:=A0=A0=A0 RxErr+ BadTLP- BadDLLP- Rollover-=
 Timeout- NonFatalErr-
> =A0=A0=A0 =A0=A0=A0 CEMsk:=A0=A0=A0 RxErr- BadTLP- BadDLLP- Rollover-=
 Timeout- NonFatalErr-
> =A0=A0=A0 =A0=A0=A0 AERCap:=A0=A0=A0 First Error Pointer: 1f, GenCap-=
 CGenEn- ChkCap- ChkEn-
>
>
> There is a modified kernel source (2.6.12.3) n the ASUS site but acco=
rding to Alan Cox changes are limited to the addition of the device PCI=
 id.
> Could you please add this device to the list of managed devices in ah=
ci.c ?
>
> Thanks in advance.
>
> Arnaud Atoch
>
