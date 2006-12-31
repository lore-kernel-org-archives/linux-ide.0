From: Dave Maurer <dcmaurer1@cox.net>
Subject: Re: AHCI NCQ on ESB2 (8086:2681)
Date: Sun, 31 Dec 2006 12:14:47 -0700
Message-ID: <200612311214.47931.dcmaurer1@cox.net>
References: <4597B34C.1090606@omega71.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40637 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030440AbWLaTX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Dec 2006 14:23:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231191448.EGJR9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>
          for <linux-ide@vger.kernel.org>; Sun, 31 Dec 2006 14:14:48 -0500
In-Reply-To: <4597B34C.1090606@omega71.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sunday 31 December 2006 05:55, Bryan Boatright wrote:
> I hope this is an appropriate place to ask this question.  Googling for
> answers turned up nothing.
>
> I am using kernel 2.6.19.1 and am trying to get NCQ support working.  My
> Intel chipset (ESB2, see details below) should support NCQ, but it is
> not returning the NCQ capabilities bit in the HBA Capabilities
> register.  Here's the relevant dmesg output:
>
>
> <5>SCSI subsystem initialized
> <7>libata version 2.00 loaded.
> <7>ahci 0000:00:1f.2: version 2.0
> <7>IOAPIC[0]: Set PCI routing entry (2-19 -> 0x71 -> IRQ 19 Mode:1
> Active:1) <6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) ->
> IRQ 19 <7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
> <6>ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports ? Gbps 0x3f impl
> SATA mode cap: 0x8a021f05
> <6>ahci 0000:00:1f.2: flags: 64bit stag led pmp
> <6>ata1: SATA max UDMA/133 cmd 0xFFFFC2000001ED00 ctl 0x0 bmdma 0x0 irq 19
> <6>ata2: SATA max UDMA/133 cmd 0xFFFFC2000001ED80 ctl 0x0 bmdma 0x0 irq 19
> <6>ata3: SATA max UDMA/133 cmd 0xFFFFC2000001EE00 ctl 0x0 bmdma 0x0 irq 19
> <6>ata4: SATA max UDMA/133 cmd 0xFFFFC2000001EE80 ctl 0x0 bmdma 0x0 irq 19
> <6>ata5: SATA max UDMA/133 cmd 0xFFFFC2000001EF00 ctl 0x0 bmdma 0x0 irq 19
> <6>ata6: SATA max UDMA/133 cmd 0xFFFFC2000001EF80 ctl 0x0 bmdma 0x0 irq 19
> <6>scsi0 : ahci
> <6>ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> <6>ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
> <6>ata1.00: ata1: dev 0 multi count 16
> <6>ata1.00: configured for UDMA/133
> <6>scsi1 : ahci
> <6>ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> <6>ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
> <6>ata2.00: ata2: dev 0 multi count 16
> <6>ata2.00: configured for UDMA/133
>
> Note the "flags" line does not include "ncq" but the "AHCI" line clearly
> reports 32 slots (I added the "cap: 0x8a021f05" to the pintk to see the
> entire contents of the register).  Also note that the register is
> returning a value of 0 in the Interface Speed Support field, which also
> seems to be wrong (and that's why the ? appears).
>
> I cannot locate a detailed spec for programming the ESB2, but is it
> possible that this is a case of the BIOS telling the ESB2 not to report
> this capability?  The mobo vendor (Supermicro) has been unhelpful.
>
> Any thoughts on what to look at next?  Does anyone have NCQ support
> working on a platform with an ESB2?
>
> Here's the lspci stuff:
>
> 00:1f.2 Class 0106: 8086:2681 (rev 09) (prog-if 01)
>         Subsystem: 15d9:8180
>
> 00:1f.2 SATA controller: Intel Corporation Enterprise Southbridge SATA
> AHCI (rev 09) (prog-if 01 [AHCI 1.0])
>         Subsystem: Super Micro Computer Inc Unknown device 8180
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 19
>         Region 0: I/O ports at 2000 [size=8]
>         Region 1: I/O ports at 18d4 [size=4]
>         Region 2: I/O ports at 18d8 [size=8]
>         Region 3: I/O ports at 18d0 [size=4]
>         Region 4: I/O ports at 18e0 [size=32]
>         Region 5: Memory at dd500c00 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [a8] #12 [0010]
>
>
>
> Thanks,
> Bryan

Yes, I have a Mac Pro with the 5000X chipset.  The AHCI controller in the ESB2 
chip on this board does report it's NCQ capable:

PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl IDE mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000046500 ctl 0x0 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0xFFFFC20000046580 ctl 0x0 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0xFFFFC20000046600 ctl 0x0 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0xFFFFC20000046680 ctl 0x0 bmdma 0x0 irq 21
ata5: SATA max UDMA/133 cmd 0xFFFFC20000046700 ctl 0x0 bmdma 0x0 irq 21
ata6: SATA max UDMA/133 cmd 0xFFFFC20000046780 ctl 0x0 bmdma 0x0 irq 21
scsi0 : ahci

ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci

I'm running kernel 2.6.19, and the NCQ depth for my drives is set to (31/32).  
I do have the ESB2 datasheet, and there's no mention of how to enable NCQ in 
the controller.  It refers to the AHCI spec for any AHCI specific commands to 
use.  Based on this, I would assume then that NCQ is enabled in the 
controller by the BIOS.  I'm surprised SuperMicro cannot provide some info on 
NCQ support then.

It's also possible that the ESB2 is not able to enable NCQ with your hard 
drives.  Some drives are not totally compliant with NCQ or are known to have 
issues with NCQ.  I'm using a Seagate 7200.9 and a Maxtor MaxLine III SATA 
drive.

Dave


