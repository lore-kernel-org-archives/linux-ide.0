From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: HSM violations from ATA PACKET cmd ABRT errors in initial comms
 with   LG GH22 SATA DVDRW
Date: Tue, 29 Dec 2009 10:06:44 +0100
Message-ID: <4B39C6A4.1040205@gmail.com>
References: <4B37C58D.2090200@gmail.com>	<4B37D50F.4010804@gmail.com> <19257.17141.825766.63548@pilspetsen.it.uu.se>
Reply-To: thomas.schorpp@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:57407 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZL2JG7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Dec 2009 04:06:59 -0500
Received: by fxm25 with SMTP id 25so5094412fxm.21
        for <linux-ide@vger.kernel.org>; Tue, 29 Dec 2009 01:06:57 -0800 (PST)
In-Reply-To: <19257.17141.825766.63548@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Robert Hancock writes:
>  > On 12/27/2009 02:37 PM, thomas schorpp wrote:
>  > > LG GH22NS40 NL01 (possibly Renesas chipset)
>  > > VIA8237 SATA (produces basically same errors), Promise SATA II 150 20579
>  > > HBAs.
>  > >
>  > > Linux 2.6.32.2
>  > > hal polling
>  > > devkit polling
>  > > wodim
>  > > growisofs
>  > >
>  > > port_status 0x20280000 (Data Transfer Overrun Error & Target Device Fault)?
>  > >
>  > > Looks like a hardware combination incompatibility.
>  > > Most applicable ATA_HORKAGES in sourcecode already tried.
>  > >
>  > > Not found the sense code yet since FEATURE specific according to
>  > > T13/1410D revision 3b.
>  > >
>  > > Comments?
>  > >
>  > > y
>  > > tom
>  > >
>  > > dmesg |grep -A 10 ata
>  > >
>  > > sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
>  > > scsi5 : sata_promise
>  > > scsi6 : sata_promise
>  > > scsi7 : sata_promise
>  > > ata6: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe200 irq 17
>  > > ata7: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe280 irq 17
>  > > ata8: PATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe300 irq 17
>  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  > > ata6.00: ATAPI: HL-DT-ST DVDRAM GH22NS40, NL01, max UDMA/100
>  > > ata6.00: configured for UDMA/100
>  > > scsi 5:0:0:0: CD-ROM HL-DT-ST DVDRAM GH22NS40 NL01 PQ: 0 ANSI: 5
>  > > sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
>  > > sr 5:0:0:0: Attached scsi CD-ROM sr0
>  > > sr 5:0:0:0: Attached scsi generic sg2 type 5
>  > > ata7: SATA link down (SStatus 0 SControl 300)
>  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  > > ata6.00: port_status 0x20280000
>  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 40 00
>  > > ata6.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 131072 in
>  > > res 51/54:03:00:00:fc/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  > > ata6.00: status: { DRDY ERR }
>  > > ata6: hard resetting link
>  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  > > ata6.00: configured for UDMA/100
>  > > ata6: EH complete
>  > > ...
>  > > <period, ~10 times in series>
>  > > ...
>  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  > > ata6.00: port_status 0x20280000
>  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  > > ata6.00: status: { DRDY ERR }
>  > > ata6: hard resetting link
>  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  > > ata6.00: configured for UDMA/100
>  > > ata6: EH complete
>  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  > > ata6.00: port_status 0x20280000
>  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  > > ata6.00: status: { DRDY ERR }
>  > > ata6: hard resetting link
>  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  > > ata6.00: configured for UDMA/100
>  > > ata6: EH complete
>  > > ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>  > > ata6.00: port_status 0x20280000
>  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  > > ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
>  > > res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>  > > ata6.00: status: { DRDY ERR }
>  > > ata6: hard resetting link
>  > > ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  > > ata6.00: configured for UDMA/100
>  > > sr 5:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
>  > > sr 5:0:0:0: [sr0] Sense Key : 0x5 [current] Info fld=0x0
>  > > sr 5:0:0:0: [sr0] ASC=0x21 ASCQ=0x0
>  > > sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
>  > 
>  > Well, it's a READ command, and the response is "LOGICAL BLOCK ADDRESS 
>  > OUT OF RANGE". Seems reasonable if it's a blank disc in the drive (is it?)
>  > 
>  > According to the code comments in sata_promise, "overrun error" means 
>  > the S/G byte count was larger than the drive requires. Which I suppose 
>  > would happen here, because the drive didn't actually transfer any data. 
>  > sata_promise raises an HSM error on that though which triggers resets 
>  > and such. Seems like an overreaction, for ATAPI commands anyway, as that 
>  > can happen normally. CCing Mikael.
> 
> Thanks for the report. I'll try to come up with a patch to reduce
> the severity of overruns to something less than HSM.
> 
>  > What were the errors you were seeing on the VIA controller?
> 
> I'd like to see that too.

Many thanks for the fast service ;-) , but all VIA HBA SATA ports are in use now by 2 hdd's,
I will connect the LG GH22 this evening (> 1800 UTC) and report.

If of any worth for You here is a dmesg from kernel version 2.6.29.3 using the 

(00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South])
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80):

dmesg |grep ata6 (Sorry, forgot -A, didn't noticed not all messages are printk'd with 'ata' in the line)
ata6: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe200 irq 17
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATAPI: HL-DT-ST DVDRAM GH22NS40, NL01, max UDMA/100
ata6.00: configured for UDMA/100
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata6: hotplug_status 0x10
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6: limiting SATA link speed to 1.5 Gbps
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t3
ata6: hotplug_status 0x10
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/100
ata6.00: limiting speed to UDMA/66:PIO4
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t2
ata6: hotplug_status 0x11
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/66
ata6.00: limiting speed to UDMA/33:PIO4
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t1
ata6: hotplug_status 0x11
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6: EH pending after 5 tries, giving up
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
ata6.00: cmd a0/01:00:00:00:08/00:00:00:00:00/a0 tag 0 dma 2048 in
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
ata6.00: cmd a0/01:00:00:00:08/00:00:00:00:00/a0 tag 0 dma 2048 in
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for UDMA/33
ata6.00: limiting speed to PIO4
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
ata6: hotplug_status 0x11
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for PIO4
ata6.00: limiting speed to PIO3
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t3
ata6: hotplug_status 0x11
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for PIO3
ata6.00: limiting speed to PIO0
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t2
ata6: hotplug_status 0x11
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for PIO0
ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t1
ata6: hotplug_status 0x10
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata6.00: configured for PIO0
ata6: EH pending after 5 tries, giving up
ata6: EH complete
ata6.00: disabled
