From: kelk1@comcast.net (Quel Qun)
Subject: Re: Boot fails on Intel SATA controller
Date: Wed, 01 Aug 2007 14:18:45 +0000
Message-ID: <080120071418.11784.46B09645000B42BF00002E082200735834CE05040A05@comcast.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:37315 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbXHAOSq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:18:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: linux-ide@vger.kernel.org


 -------------- Original message ----------------------
From: Tejun Heo <htejun@gmail.com>
> Hello,
> 
> Luiz Fernando N. Capitulino wrote:
> >  Hi there,
> > 
> >  A Mandriva user is reporting that his machine hangs while booting
> > kernels 2.6.22.1 and 2.6.23-rc1.
> > 
> >  But boots fine with 2.6.21.
> > 
> > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > ata1.00: qc timeout (cmd 0x27)
> > ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)
> > ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133
> > ata1.00: 781422768 sectors, multi 8: LBA48
> > ata1.00: failed to set xfermode (err_mask=0x40)
> > ata1: failed to recover some devices, retrying in 5 secs
> 
> What happens after this?
> 
It basically retries a few times, then fails to boot. Here is a more complete log with 2.6.23-rc1:

ata1: SATA max UDMA/133 cmd 0xf881ad00 ctl 0x00000000 bmdma 0x00000000 irq 18^M
ata2: SATA max UDMA/133 cmd 0xf881ad80 ctl 0x00000000 bmdma 0x00000000 irq 18^M
ata3: SATA max UDMA/133 cmd 0xf881ae00 ctl 0x00000000 bmdma 0x00000000 irq 18^M
ata4: SATA max UDMA/133 cmd 0xf881ae80 ctl 0x00000000 bmdma 0x00000000 irq 18^M
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)^M
ata1.00: qc timeout (cmd 0x27)^M
ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)^M
ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133^M
ata1.00: 781422768 sectors, multi 8: LBA48 ^M
ata1.00: failed to set xfermode (err_mask=0x40)^M
ata1: failed to recover some devices, retrying in 5 secs^M
ata1: port is slow to respond, please be patient (Status 0x80)^M
ata1: COMRESET failed (errno=-16)^M
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)^M
ata1.00: qc timeout (cmd 0x27)^M
ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)^M
ata1.00: configured for UDMA/133^M
ata1: EH pending after completion, repeating EH (cnt=4)^M
ata1: soft resetting port^M
ata1: failed to reset engine (errno=-95)<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)^M
ata1.00: qc timeout (cmd 0xec)^M
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)^M
ata1.00: revalidation failed (errno=-5)^M
ata1: failed to recover some devices, retrying in 5 secs^M
ata1: hard resetting port^M
ata1: port is slow to respond, please be patient (Status 0x80)^M
ata1: COMRESET failed (errno=-16)^M
ata1: hard resetting port^M
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)^M
ata1.00: qc timeout (cmd 0x27)^M
ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)^M
ata1.00: failed to set xfermode (err_mask=0x40)^M
ata1: limiting SATA link speed to 1.5 Gbps^M
ata1.00: limiting speed to UDMA/133:PIO3^M
ata1: failed to recover some devices, retrying in 5 secs^M
ata1: hard resetting port^M
ata1: port is slow to respond, please be patient (Status 0x80)^M
ata1: COMRESET failed (errno=-16)^M
ata1: hard resetting port^M
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)^M
ata1.00: qc timeout (cmd 0x27)^M
ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)^M
ata1.00: failed to set xfermode (err_mask=0x40)^M
ata1.00: disabled^M
ata1: EH pending after completion, repeating EH (cnt=3)^M
ata1: soft resetting port^M
ata1: failed to reset engine (errno=-95)<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)^M
ata1: EH complete^M
ata2: SATA link down (SStatus 0 SControl 300)^M
ata3: SATA link down (SStatus 0 SControl 300)^M
ata4: SATA link down (SStatus 0 SControl 300)^M
Loading ata_piixACPI: PCI Interrupt 0000:00:1f.1[A] -> .ko module^M
GSI 16 (level, low) -> IRQ 16^M
scsi4 : ata_piix^M
scsi5 : ata_piix^M
ata5: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14^M
ata6: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15^M
ata5.00: ATAPI: GCR-8483B, 1.09, max UDMA/33^M
ata5.01: ATAPI: PHILIPS DVD+/-RW DVD8631, GD30, max UDMA/33^M
ata5.00: configured for UDMA/33^M
ata5.01: configured for UDMA/33^M
scsi 4:0:0:0: CD-ROM            HL-DT-ST CD-ROM GCR-8483B 1.09 PQ: 0 ANSI: 5^M
scsi 4:0:1:0: CD-ROM            PHILIPS  DVD+-RW DVD8631  GD30 PQ: 0 ANSI: 5^M
Loading sd_mod.ko module^M
Loading jbd.ko module^MKernel panic - not syncing: Attempted to kill init!^M

Loading ext3.ko module^M
Mounting /proc filesystem^M
Mounting sys

