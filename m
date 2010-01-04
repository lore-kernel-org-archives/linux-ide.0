From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: HSM violations from ATA PACKET cmd ABRT errors in initial comms
 with   LG GH22 SATA DVDRW
Date: Mon, 04 Jan 2010 03:00:47 +0100
Message-ID: <4B414BCF.1020607@gmail.com>
References: <4B37C58D.2090200@gmail.com>	<4B37D50F.4010804@gmail.com>	<19257.17141.825766.63548@pilspetsen.it.uu.se> <19265.3552.13209.914969@pilspetsen.it.uu.se>
Reply-To: thomas.schorpp@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:59474 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0ADCAx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2010 21:00:53 -0500
Received: by fxm25 with SMTP id 25so8368203fxm.21
        for <linux-ide@vger.kernel.org>; Sun, 03 Jan 2010 18:00:51 -0800 (PST)
In-Reply-To: <19265.3552.13209.914969@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Mikael Pettersson writes:
>  > Robert Hancock writes:
>  >  > On 12/27/2009 02:37 PM, thomas schorpp wrote:
>  >  > > LG GH22NS40 NL01 (possibly Renesas chipset)
>  >  > > VIA8237 SATA (produces basically same errors), Promise SATA II 150 20579
>  >  > > HBAs.
>  >  > >
>  >  > > Linux 2.6.32.2
>  >  > > hal polling
>  >  > > devkit polling
>  >  > > wodim
>  >  > > growisofs
>  >  > >
>  >  > > port_status 0x20280000 (Data Transfer Overrun Error & Target Device Fault)?
>  >  > >
>  >  > > Looks like a hardware combination incompatibility.
>  >  > > Most applicable ATA_HORKAGES in sourcecode already tried.
>  >  > >
>  >  > > Not found the sense code yet since FEATURE specific according to
>  >  > > T13/1410D revision 3b.
>  >  > >
>  >  > > Comments?
>  >  > >
>  >  > > y
>  >  > > tom
>  >  > >
>  >  > > dmesg |grep -A 10 ata
>  >  > >
>  >  > > sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
>  >  > > scsi5 : sata_promise
>  >  > > scsi6 : sata_promise
>  >  > > scsi7 : sata_promise
>  >  > > ata6: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe200 irq 17
>  >  > > ata7: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe280 irq 17
>  >  > > ata8: PATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe300 irq 17
>  >  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  >  > > ata6.00: ATAPI: HL-DT-ST DVDRAM GH22NS40, NL01, max UDMA/100
>  >  > > ata6.00: configured for UDMA/100
>  >  > > scsi 5:0:0:0: CD-ROM HL-DT-ST DVDRAM GH22NS40 NL01 PQ: 0 ANSI: 5
>  >  > > sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
>  >  > > sr 5:0:0:0: Attached scsi CD-ROM sr0
>  >  > > sr 5:0:0:0: Attached scsi generic sg2 type 5
>  >  > > ata7: SATA link down (SStatus 0 SControl 300)
>  >  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  >  > > ata6.00: port_status 0x20280000
>  >  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 40 00
>  >  > > ata6.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 131072 in
>  >  > > res 51/54:03:00:00:fc/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  >  > > ata6.00: status: { DRDY ERR }
>  >  > > ata6: hard resetting link
>  >  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  >  > > ata6.00: configured for UDMA/100
>  >  > > ata6: EH complete
>  >  > > ...
>  >  > > <period, ~10 times in series>
>  >  > > ...
>  >  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  >  > > ata6.00: port_status 0x20280000
>  >  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  >  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  >  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  >  > > ata6.00: status: { DRDY ERR }
>  >  > > ata6: hard resetting link
>  >  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  >  > > ata6.00: configured for UDMA/100
>  >  > > ata6: EH complete
>  >  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  >  > > ata6.00: port_status 0x20280000
>  >  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  >  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  >  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  >  > > ata6.00: status: { DRDY ERR }
>  >  > > ata6: hard resetting link
>  >  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  >  > > ata6.00: configured for UDMA/100
>  >  > > ata6: EH complete
>  >  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  >  > > ata6.00: port_status 0x20280000
>  >  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  >  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  >  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  >  > > ata6.00: status: { DRDY ERR }
>  >  > > ata6: hard resetting link
>  >  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  >  > > ata6.00: configured for UDMA/100
>  >  > > sr 5:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
>  >  > > sr 5:0:0:0: [sr0] Sense Key : 0x5 [current] Info fld=0x0
>  >  > > sr 5:0:0:0: [sr0] ASC=0x21 ASCQ=0x0
>  >  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  >  > 
>  >  > Well, it's a READ command, and the response is "LOGICAL BLOCK ADDRESS 
>  >  > OUT OF RANGE". Seems reasonable if it's a blank disc in the drive (is it?)
>  >  > 
>  >  > According to the code comments in sata_promise, "overrun error" means 
>  >  > the S/G byte count was larger than the drive requires. Which I suppose 
>  >  > would happen here, because the drive didn't actually transfer any data. 
>  >  > sata_promise raises an HSM error on that though which triggers resets 
>  >  > and such. Seems like an overreaction, for ATAPI commands anyway, as that 
>  >  > can happen normally. CCing Mikael.
>  > 
>  > Thanks for the report. I'll try to come up with a patch to reduce
>  > the severity of overruns to something less than HSM.
> 
> I've looked at the available AC_ERR_ values and how they're treated by
> libata-eh, and to avoid resets but allow for retries it seems that one
> should use AC_ERR_OTHER, or possibly AC_ERR_DEV, or possibly no AC_ERR_
> at all (i.e., zero). So please first try the patch below. If it doesn't
> eliminate the reset loop, change the AC_ERR_OTHER to AC_ERR_DEV and try
> again. And if that one still causes reset loops, try a plain 0.
> 
> /Mikael
> 
> --- linux-2.6.32/drivers/ata/sata_promise.c.~1~	2009-12-03 12:38:32.000000000 +0100
> +++ linux-2.6.32/drivers/ata/sata_promise.c	2010-01-03 22:08:08.000000000 +0100
> @@ -862,7 +862,7 @@ static void pdc_error_intr(struct ata_po
>  	if (port_status & PDC_DRIVE_ERR)
>  		ac_err_mask |= AC_ERR_DEV;
>  	if (port_status & (PDC_OVERRUN_ERR | PDC_UNDERRUN_ERR))
> -		ac_err_mask |= AC_ERR_HSM;
> +		ac_err_mask |= AC_ERR_OTHER; /* or AC_ERR_DEV, or zero */
>  	if (port_status & (PDC2_ATA_HBA_ERR | PDC2_ATA_DMA_CNT_ERR))
>  		ac_err_mask |= AC_ERR_ATA_BUS;
>  	if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC2_HTO_ERR
> 

FIXED with AC_ERR_OTHER.
TESTED Drive reads and writes media fine.

Many Thanks :-)

y
tom
