From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: 2.6.22-rc5 libata/ata_piix failure with older CDROM
Date: Mon, 25 Jun 2007 13:12:42 +0800
Message-ID: <467F4ECA.8040008@tw.ibm.com>
References: <200706231346.l5NDkYm5018432@harpo.it.uu.se>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:45561 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbXFYFMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 01:12:51 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5P5CoQT027041
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 01:12:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5P5CoPF262268
	for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 23:12:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5P5Colc005912
	for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 23:12:50 -0600
In-Reply-To: <200706231346.l5NDkYm5018432@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Mikael Pettersson wrote:
> I tried (again) to convert an Intel i815EP-chipset
> machine from IDE to libata, but libata still fails
> to initialise the CDROM on the machine.
> 
> With 2.6.22-rc5, IDE says:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH2: IDE controller at PCI slot 0000:00:1f.1
> ICH2: chipset revision 5
> ICH2: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: IC35L080AVVA07-0, ATA DISK drive
> hda: selected mode 0x45
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: CRD-8320B, ATAPI CD/DVD-ROM drive
> hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
> hdc: selected mode 0x22
> hdd: selected mode 0x42
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> 
> Switching to libata (ata_piix) results in:
> 
> ata_piix 0000:00:1f.1: version 2.11
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
> ata1.00: ata_hpa_resize 1: sectors = 160836480, hpa_sectors = 160836480
> ata1.00: ATA-5: IC35L080AVVA07-0, VA4OA52A, max UDMA/100
> ata1.00: 160836480 sectors, multi 16: LBA 
> ata1.00: ata_hpa_resize 1: sectors = 160836480, hpa_sectors = 160836480
> ata1.00: configured for UDMA/100
> ata2.00: ATAPI: CRD-8320B, 1.12, max MWDMA2
> ata2.01: ATAPI: Hewlett-Packard CD-Writer Plus 9100, 1.0c, max UDMA/33
> ata2.00: configured for MWDMA2
> ata2.01: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      IC35L080AVVA07-0 VA4O PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 0:0:0:0: [sda] 160836480 512-byte hardware sectors (82348 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: device not ready (errno=-16), forcing hardreset
> ata2: BUG: prereset() requested invalid reset type
> ata2: soft resetting port
> ATA: abnormal status 0x80 on port 0x00010177
> ATA: abnormal status 0x80 on port 0x00010177
> ATA: abnormal status 0x80 on port 0x00010177

The INQUIRY timeout looks like the ATAPI DMA problem that Tejun is working on.
Could you please check if Tejun's patch that limits ATAPI DMA to multiple of
16-bytes works:
https://bugzilla.novell.com/attachment.cgi?id=147389
(The original bug is: https://bugzilla.novell.com/show_bug.cgi?id=229260#c35)

--
albert

