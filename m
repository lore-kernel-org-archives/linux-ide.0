From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: Driver for Promise PDC42819 SATA/SAS controller
Date: Fri, 15 Aug 2008 11:46:33 +1000
Message-ID: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:6764 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYHOBqf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 21:46:35 -0400
Received: by qb-out-0506.google.com with SMTP id a16so870103qbd.17
        for <linux-ide@vger.kernel.org>; Thu, 14 Aug 2008 18:46:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi All,

I recently bought an MSI K9A2 Platinum motherboard and it has a Promise
PDC42819 SATA/SAS controller onboard. I haven't been able to get the
controller to work with any of the libata sata drivers in mainline
(although I did only try sata_promise, sata_sx4 or ahci; last two I was
doubtful about but I figured it was worth a try).

Has anyone played with this controller under Linux before and can it be
made to work with any of the open source drivers - I would realy like
to use the eSATA and internal SATA ports attached to this controller
(and I don't want to trust my data to the promise binary blob)? Maybe
it's as simple as adding the right PCI ID to sata_promise, but I wasn't
sure what kind of board it should be: 2037x, 2057x, 20319, 40518, 20619,
or maybe some new one...

I'm not sure how important this is but I gathered the following info
about the controller:

References to the controller in the motherboard manual and the
motherboard manufacturer's website: Promise T3 [1]

Written on the actual chip on the motherboard: Promise PDC42819 [2]

This chip is also used on Promise's own FastTrak TX2650 & TX4650
adapters [3] which have "partial open source" drivers [4], [5]. This
driver looks like an open source wrapper around a binary blob (some
fasttrak library for software fake raid, I think).

Having a quick look through the source of Promise's driver, it looks
like the driver has been hacked up out of a driver that was originally
used for fakeraid on ATI and intel southbridges as well as Promise's
SX4 adapter (and some Promise adapter called the OCTOPUSII).

Promise has an open source commitment written on its werbsite [6] but
it just relates to their SuperTrak products (not their FastTrak ones)
and the stex driver.

The following is the hunk of lspci output that refers to the controller:

02:00.0 RAID bus controller [0104]: Promise Technology, Inc. Unknown
device [105a:3f20]
	Subsystem: Micro-Star International Co., Ltd. Unknown device [1462:3716]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c800 [size=128]
	Region 2: I/O ports at c400 [size=256]
	Region 3: Memory at fbeff000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fbec0000 (32-bit, non-prefetchable) [size=128K]
	Region 5: Memory at fbefc000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0
<64ns, L1 <1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
	Capabilities: [94] SATA HBA <?>
	Capabilities: [100] Advanced Error Reporting <?>
	Capabilities: [140] Virtual Channel <?>
	Capabilities: [160] Device Serial Number 01-00-00-00-02-00-00-00
	Capabilities: [170] Power Budgeting <?>


Many thanks!

Mark


[1] http://global.msi.com.tw/index.php?func=proddesc&prod_no=1332
[2] http://www.3dnews.ru/_imgdata/img/2008/01/25/72299.jpg
[3] http://www.promise.com/product/product_detail.asp?product_id=191#
[4] http://www.promise.com/support/download/download2_eng.asp?productID=191&category=all&os=100
[5] http://www.promise.com/upload/Support/Driver/FT%20TX4650-2650%20Linux%20Kernl%202.6%20PSC%20v1.1.0.12.tgz
[6] http://www.promise.com/product/linux/linux_eng.asp
