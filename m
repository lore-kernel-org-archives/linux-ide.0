From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: HSM violations from ATA PACKET cmd ABRT errors in initial comms
 with   LG GH22 SATA DVDRW
Date: Tue, 29 Dec 2009 00:44:53 +0100
Message-ID: <19257.17141.825766.63548@pilspetsen.it.uu.se>
References: <4B37C58D.2090200@gmail.com>
	<4B37D50F.4010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:50164 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbZL1Xo6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Dec 2009 18:44:58 -0500
In-Reply-To: <4B37D50F.4010804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: thomas.schorpp@gmail.com, thomas schorpp <thomas.schorpp@googlemail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Robert Hancock writes:
 > On 12/27/2009 02:37 PM, thomas schorpp wrote:
 > > LG GH22NS40 NL01 (possibly Renesas chipset)
 > > VIA8237 SATA (produces basically same errors), Promise SATA II 150 20579
 > > HBAs.
 > >
 > > Linux 2.6.32.2
 > > hal polling
 > > devkit polling
 > > wodim
 > > growisofs
 > >
 > > port_status 0x20280000 (Data Transfer Overrun Error & Target Device Fault)?
 > >
 > > Looks like a hardware combination incompatibility.
 > > Most applicable ATA_HORKAGES in sourcecode already tried.
 > >
 > > Not found the sense code yet since FEATURE specific according to
 > > T13/1410D revision 3b.
 > >
 > > Comments?
 > >
 > > y
 > > tom
 > >
 > > dmesg |grep -A 10 ata
 > >
 > > sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
 > > scsi5 : sata_promise
 > > scsi6 : sata_promise
 > > scsi7 : sata_promise
 > > ata6: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe200 irq 17
 > > ata7: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe280 irq 17
 > > ata8: PATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe300 irq 17
 > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > > ata6.00: ATAPI: HL-DT-ST DVDRAM GH22NS40, NL01, max UDMA/100
 > > ata6.00: configured for UDMA/100
 > > scsi 5:0:0:0: CD-ROM HL-DT-ST DVDRAM GH22NS40 NL01 PQ: 0 ANSI: 5
 > > sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
 > > sr 5:0:0:0: Attached scsi CD-ROM sr0
 > > sr 5:0:0:0: Attached scsi generic sg2 type 5
 > > ata7: SATA link down (SStatus 0 SControl 300)
 > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
 > > ata6.00: port_status 0x20280000
 > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 40 00
 > > ata6.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 131072 in
 > > res 51/54:03:00:00:fc/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
 > > ata6.00: status: { DRDY ERR }
 > > ata6: hard resetting link
 > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > > ata6.00: configured for UDMA/100
 > > ata6: EH complete
 > > ...
 > > <period, ~10 times in series>
 > > ...
 > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
 > > ata6.00: port_status 0x20280000
 > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
 > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
 > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
 > > ata6.00: status: { DRDY ERR }
 > > ata6: hard resetting link
 > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > > ata6.00: configured for UDMA/100
 > > ata6: EH complete
 > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
 > > ata6.00: port_status 0x20280000
 > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
 > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
 > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
 > > ata6.00: status: { DRDY ERR }
 > > ata6: hard resetting link
 > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > > ata6.00: configured for UDMA/100
 > > ata6: EH complete
 > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
 > > ata6.00: port_status 0x20280000
 > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
 > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
 > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
 > > ata6.00: status: { DRDY ERR }
 > > ata6: hard resetting link
 > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 > > ata6.00: configured for UDMA/100
 > > sr 5:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
 > > sr 5:0:0:0: [sr0] Sense Key : 0x5 [current] Info fld=0x0
 > > sr 5:0:0:0: [sr0] ASC=0x21 ASCQ=0x0
 > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
 > 
 > Well, it's a READ command, and the response is "LOGICAL BLOCK ADDRESS 
 > OUT OF RANGE". Seems reasonable if it's a blank disc in the drive (is it?)
 > 
 > According to the code comments in sata_promise, "overrun error" means 
 > the S/G byte count was larger than the drive requires. Which I suppose 
 > would happen here, because the drive didn't actually transfer any data. 
 > sata_promise raises an HSM error on that though which triggers resets 
 > and such. Seems like an overreaction, for ATAPI commands anyway, as that 
 > can happen normally. CCing Mikael.

Thanks for the report. I'll try to come up with a patch to reduce
the severity of overruns to something less than HSM.

 > What were the errors you were seeing on the VIA controller?

I'd like to see that too.

/Mikael
