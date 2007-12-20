From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: Questions about SATA hotplug in linux 2.6
Date: Thu, 20 Dec 2007 17:05:08 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E5008813C@sshaexmb1.amd.com>
References: <20071025.011445.80152909.davem@davemloft.net>
 <472052C1.2050302@garzik.org>
 <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
 <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com>
 <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
 <47679074.9000400@gmail.com>
 <B90463BC30D2E446BA423D888DC85E50087A77@sshaexmb1.amd.com>
 <476A0970.9090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:2724 "EHLO
	outbound6-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755148AbXLTJIx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2007 04:08:53 -0500
Content-class: urn:content-classes:message
In-Reply-To: <476A0970.9090804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Tejun:


> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com]
> >
> > But when I set "OnChip SATA type" into "AHCI" mode(SATA device ID
4391),
> > the hotplug can work, and the device name will be changed from
"scd0" to
> > "scd1"
> > during the hotplug. The log messages are attached at the end of this
> > mail.
> 
> That's strange.  I guess we're forgetting something when forcing the
> controller into AHCI mode.  

Yes, it's strange. This issue also exists on RedHat RHEL5.1 and RHEL4.6


> What happens if you manually issue re-scan
> by doing "echo - - - > /sys/class/scsi_host/hostN/scan" where hostN is
> the SCSI host for the ATA port you moved the drive?

"echo" helps nothing in this issue, the /dev/scd1 still can not appear,
Here is the log message when do "echo", ata2 is the new SATA port
connected
to SATA HDD after hotplug under native IDE mode:
================================================
Dec 21 00:38:00 linux-d8vg kernel: ata2: soft resetting link
Dec 21 00:38:00 linux-d8vg kernel: ata2: SATA link down (SStatus 0
SControl 300)
Dec 21 00:38:00 linux-d8vg kernel: ata2: EH complete


> Also, after driver is loaded, can you please post the results of
"lspci
> -nnvvvxxx" with BIOS mode set to IDE and AHCI?

There are too much messages, I only keep the SATA controller as below:
========= Native IDE mode =======
00:11.0 SATA controller [Class 0106]: ATI Technologies Inc SB700 SATA
Controller [IDE mode] [1002:4390] (prog-if 01 [AHCI 1.0])
	Subsystem: ATI Technologies Inc SB700 SATA Controller [IDE mode]
[1002:4390]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at a000 [size=4]
	Region 4: I/O ports at 9000 [size=16]
	Region 5: Memory at fe8ff800 (32-bit, non-prefetchable)
[size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #12 [0010]
00: 02 10 90 43 07 01 30 02 00 01 06 01 10 40 00 00
10: 01 d0 00 00 01 c0 00 00 01 b0 00 00 01 a0 00 00
20: 01 90 00 00 00 f8 8f fe 00 00 00 00 02 10 90 43
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 10 00 3a 20 01 00 10 00 00 00 00 01 00 00 00 00
50: 05 70 84 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 50 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 12 00 10 00 0f 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 06 00 00 2c 16 80 b4 01 16 80 b4 01
90: 16 80 b4 01 16 80 b4 01 16 80 b4 01 16 80 b4 01
a0: 7a a0 7a a0 7a a0 7a a0 7a a0 7a a0 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 20 00 00
e0: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

========= AHCI mode =======
00:11.0 SATA controller [Class 0106]: ATI Technologies Inc SB700 SATA
Controller [AHCI mode] [1002:4391] (prog-if 01 [AHCI 1.0])
	Subsystem: ATI Technologies Inc SB700 SATA Controller [AHCI
mode] [1002:4391]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at a000 [size=4]
	Region 4: I/O ports at 9000 [size=16]
	Region 5: Memory at fe8ff800 (32-bit, non-prefetchable)
[size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/2 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #12 [0010]
00: 02 10 91 43 07 01 30 02 00 01 06 01 10 40 00 00
10: 01 d0 00 00 01 c0 00 00 01 b0 00 00 01 a0 00 00
20: 01 90 00 00 00 f8 8f fe 00 00 00 00 02 10 91 43
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 10 00 00 20 01 00 10 00 00 00 00 01 00 00 00 00
50: 05 70 84 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 50 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 12 00 10 00 0f 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 06 00 00 2c 16 80 b4 01 16 80 b4 01
90: 16 80 b4 01 16 80 b4 01 16 80 b4 01 16 80 b4 01
a0: 7a a0 7a a0 7a a0 7a a0 7a a0 7a a0 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 20 00 00
e0: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Thanks
Shane



