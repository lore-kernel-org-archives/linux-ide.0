From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: ahci fails with SATA DVD drive, IDE mode works
Date: Sat, 21 Feb 2009 18:17:05 -0500
Message-ID: <20090221181705.0b5f9ed3@dhcp-100-2-144.bos.redhat.com>
References: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
	<499D2202.7070503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:57389 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbZBUXRS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Feb 2009 18:17:18 -0500
In-Reply-To: <499D2202.7070503@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Thu, 19 Feb 2009 18:10:26 +0900
Tejun Heo <tj@kernel.org> wrote:

> > ata2: link is slow to respond, please be patient (ready=0)
> > ata2: COMRESET failed (errno=-16)
> 
> Can you please attach log of successful boot using ata_piix and the
> output of "hdparm -I" on the drive?  Also, if you put a different
> harddisk and more preferably a different ATAPI device there, does it
> work in ahci mode?

I don't have another drive like this one, but maybe can borrow one on
Monday (it's a SATA notebook drive.) I did get the other information
though.

Here's the boot log:

ata_piix 0000:00:1f.2: version 2.12
  alloc irq_desc for 19 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x21b0 ctl 0x21a0 bmdma 0x2170 irq 19
ata2: SATA max UDMA/133 cmd 0x2190 ctl 0x2180 bmdma 0x2178 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: Hitachi HTS722016K9SA00, DCDOC54P, max UDMA/133
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
isa bounce pool size: 16 pages
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72201 DCDO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors: (160 GB/149 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: TSSTcorp CDDVDW TS-L633A, UO00, max MWDMA2
ata2.00: applying bridge limits
ata2.00: configured for MWDMA2
scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633A  UO00 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
  alloc irq_desc for 21 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ata_piix 0000:00:1f.5: PCI INT A -> GSI 21 (level, low) -> IRQ 21
ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.5: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x2150 ctl 0x2140 bmdma 0x2110 irq 21
ata4: SATA max UDMA/133 cmd 0x2130 ctl 0x2120 bmdma 0x2118 irq 21
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)


I ran hdparm -i first:

 Model=TSSTcorp CDDVDW TS-L633A                , FwRev=UO00    , SerialNo=                    
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4.
 DMA modes:  mdma0 mdma1 *mdma2.
 AdvancedPM=no


And then hdparm -I, which took a while and eventually printed:

/dev/sr0:

ATA device, with non-removable media
Standards:
	Likely used: 1
Configuration:
	Logical		max	current
	cylinders	0	0
	heads		0	0
	sectors/track	0	0
	--
	device size with M = 1024*1024:           0 MBytes
	device size with M = 1000*1000:           0 MBytes 
	cache/buffer size  = unknown
Capabilities:
	IORDY not likely
	Cannot perform double-word IO
	R/W multiple sector transfer: not supported
	DMA: not supported
	PIO: pio0 


Looking in the kernel log, I saw this after running hdparm -I:

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata2.00: cmd a0/01:00:00:00:02/00:00:00:00:00/a0 tag 0 dma 512 in
         cdb a1 08 2e 00 00 00 00 00  40 ec 00 00 00 00 00 00
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for MWDMA2
ata2: EH complete


And after that the drive was inaccessible, filling the log with these messages:

end_request: I/O error, dev sr0, sector 153612
sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sr 1:0:0:0: [sr0] Sense Key : Illegal Request [current].
sr 1:0:0:0: [sr0] Add. Sense: Logical block address out of range
