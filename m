From: Bryan Boatright <yahoo-groups@omega71.com>
Subject: AHCI NCQ on ESB2 (8086:2681)
Date: Sun, 31 Dec 2006 06:55:40 -0600
Message-ID: <4597B34C.1090606@omega71.com>
Reply-To: yahoo-groups@omega71.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:42596 "HELO
	smtp106.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933164AbWLaMzo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Dec 2006 07:55:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by beta.omega71.com (Postfix) with ESMTP id 705187B30
	for <linux-ide@vger.kernel.org>; Sun, 31 Dec 2006 06:55:42 -0600 (CST)
Received: from beta.omega71.com ([127.0.0.1])
 by localhost (beta.omega71.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19907-08 for <linux-ide@vger.kernel.org>;
 Sun, 31 Dec 2006 06:55:40 -0600 (CST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by beta.omega71.com (Postfix) with ESMTP id 9A4F11AF7
	for <linux-ide@vger.kernel.org>; Sun, 31 Dec 2006 06:55:40 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I hope this is an appropriate place to ask this question.  Googling for 
answers turned up nothing.

I am using kernel 2.6.19.1 and am trying to get NCQ support working.  My 
Intel chipset (ESB2, see details below) should support NCQ, but it is 
not returning the NCQ capabilities bit in the HBA Capabilities 
register.  Here's the relevant dmesg output:


<5>SCSI subsystem initialized
<7>libata version 2.00 loaded.
<7>ahci 0000:00:1f.2: version 2.0
<7>IOAPIC[0]: Set PCI routing entry (2-19 -> 0x71 -> IRQ 19 Mode:1 Active:1)
<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports ? Gbps 0x3f impl 
SATA mode cap: 0x8a021f05
<6>ahci 0000:00:1f.2: flags: 64bit stag led pmp
<6>ata1: SATA max UDMA/133 cmd 0xFFFFC2000001ED00 ctl 0x0 bmdma 0x0 irq 19
<6>ata2: SATA max UDMA/133 cmd 0xFFFFC2000001ED80 ctl 0x0 bmdma 0x0 irq 19
<6>ata3: SATA max UDMA/133 cmd 0xFFFFC2000001EE00 ctl 0x0 bmdma 0x0 irq 19
<6>ata4: SATA max UDMA/133 cmd 0xFFFFC2000001EE80 ctl 0x0 bmdma 0x0 irq 19
<6>ata5: SATA max UDMA/133 cmd 0xFFFFC2000001EF00 ctl 0x0 bmdma 0x0 irq 19
<6>ata6: SATA max UDMA/133 cmd 0xFFFFC2000001EF80 ctl 0x0 bmdma 0x0 irq 19
<6>scsi0 : ahci
<6>ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
<6>ata1.00: ata1: dev 0 multi count 16
<6>ata1.00: configured for UDMA/133
<6>scsi1 : ahci
<6>ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
<6>ata2.00: ata2: dev 0 multi count 16
<6>ata2.00: configured for UDMA/133

Note the "flags" line does not include "ncq" but the "AHCI" line clearly 
reports 32 slots (I added the "cap: 0x8a021f05" to the pintk to see the 
entire contents of the register).  Also note that the register is 
returning a value of 0 in the Interface Speed Support field, which also 
seems to be wrong (and that's why the ? appears).

I cannot locate a detailed spec for programming the ESB2, but is it 
possible that this is a case of the BIOS telling the ESB2 not to report 
this capability?  The mobo vendor (Supermicro) has been unhelpful.

Any thoughts on what to look at next?  Does anyone have NCQ support 
working on a platform with an ESB2?

Here's the lspci stuff:

00:1f.2 Class 0106: 8086:2681 (rev 09) (prog-if 01)
        Subsystem: 15d9:8180

00:1f.2 SATA controller: Intel Corporation Enterprise Southbridge SATA 
AHCI (rev 09) (prog-if 01 [AHCI 1.0])
        Subsystem: Super Micro Computer Inc Unknown device 8180
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 2000 [size=8]
        Region 1: I/O ports at 18d4 [size=4]
        Region 2: I/O ports at 18d8 [size=8]
        Region 3: I/O ports at 18d0 [size=4]
        Region 4: I/O ports at 18e0 [size=32]
        Region 5: Memory at dd500c00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] #12 [0010]



Thanks,
Bryan
