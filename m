From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IT821x: no DMA since 2.6.21
Date: Sat, 2 Jun 2007 23:32:49 +0200
Message-ID: <200706022332.49229.bzolnier@gmail.com>
References: <20070515125308.3a9f6442@SiRiUS.home> <200705241146.24079.bzolnier@gmail.com> <20070531212335.77486121@SiRiUS.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47387 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbXFBVTd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 17:19:33 -0400
Received: by ug-out-1314.google.com with SMTP id j3so464033ugf
        for <linux-ide@vger.kernel.org>; Sat, 02 Jun 2007 14:19:32 -0700 (PDT)
In-Reply-To: <20070531212335.77486121@SiRiUS.home>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Kuther <gimpel@sonnenkinder.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 31 May 2007, Thomas Kuther wrote:
> On Do, 24.05.07 11:46 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> wrote:
> 
> > 
> > Hi,
> > 
> > [...]
> > 
> > Improved patch - this time the issue should be fixed for good (I was
> > looking only at the RAID specific part of the fixups and I overlooked
> > the fact that the original code was clearing too much of
> > id->field_valid), there is now also an extra debugging printk to give
> > us some more info.
> > 
> > Please give it a try.
> > 
> > [ recal_intr warning (which should be harmless) is not fixed by this
> >   patch because it is a different problem and requires some more
> > work. ]
> > 
> 
> Hi,
> 
> Sorry again for late response.
> 
> This patch works. At least it restores the behaviour before .21 :)
> ----------------------------
> IT8212: IDE controller at PCI slot 0000:00:09.0
> ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 18
> IT8212: chipset revision 17
> it821x: controller in smart mode.
> IT8212: 100% native mode on irq 18
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: SAMSUNG SP2514N, ATA DISK drive
> hdf: Maxtor 6Y120L0, ATA DISK drive
> hde: field_valid=0007 capability=2f dma_mword=0007 dma_status=04
> hde: Performing identify fixups.
> hdf: field_valid=0007 capability=2f dma_mword=0007 dma_status=04
> hdf: Performing identify fixups.
> hde: selected mode 0x22
> hdf: selected mode 0x22
> ide2 at 0xec00-0xec07,0xe802 on irq 18
> hde: max request size: 128KiB
> hde: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63,
> DMA hde:hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: recal_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: unknown
>  hde1
> hdf: max request size: 128KiB
> hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, DMA
>  hdf:hdf: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> hdf: recal_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: unknown
>  hdf1
> ----------------------------------------
> 
> hdparm does not complain, and disk IO speed is OK.

I'm glad that the issue is finally fixed. :)

Thanks,
Bart
