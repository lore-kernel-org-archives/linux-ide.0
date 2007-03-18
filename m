From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sun, 18 Mar 2007 16:10:33 +0100
Message-ID: <200703181610.33714.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:59461 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149AbXCRPDN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 11:03:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1094664uga
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 08:03:11 -0700 (PDT)
In-Reply-To: <45FD0F68.7090207@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org


Hi,

On Sunday 18 March 2007, YUP wrote:
> Please ignore previous message, I sent wrong file. Here is right dmesg 
> output with disabled ata_piix.

[   40.145204] PDC20269: IDE controller at PCI slot 0000:02:01.0
[   40.145244] PDC20269: chipset revision 2
[   40.145249] PDC20269: ROM enabled at 0x30020000
[   40.155202] PDC20269: PLL input clock is 16566 kHz
[   40.184954] PDC20269: 100% native mode on irq 21
[   40.184964]     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
[   40.185026]     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
[   40.185040] Probing IDE interface ide2...
[   40.214123] hda: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   40.214139] Uniform CD-ROM driver Revision: 3.20
[   40.472759] hde: SAMSUNG SP1203N, ATA DISK drive
[   40.472818] PM: Adding info for No Bus:ide2
[   40.752337] hdf: Maxtor 6Y160P0, ATA DISK drive
[   40.808410] ide2 at 0xa000-0xa007,0xa402 on irq 21
[   40.808454] PM: Adding info for ide:2.0
[   40.808825] PM: Adding info for ide:2.1
[   40.809042] Probing IDE interface ide3...
[   41.487240] hdh: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
[   41.542922] PM: Adding info for No Bus:ide3
[   41.543198] ide3 at 0xa800-0xa807,0xac02 on irq 21
[   41.543222] PM: Adding info for ide:3.1
[   41.545950] hdh: ATAPI 52X CD-ROM drive, 192kB Cache

Thanks, does reading from CD/DVD media also work fine now?

It seems that the drive works just fine in PIO mode with pdc202xx_new
IDE driver (it doesn't support ATAPI DMA at the moment) and fails
with pata_pdc2027x libata (even with DMA blacklist patch from Albert).

Thanks,
Bart
