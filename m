From: Jens Axboe <axboe@suse.de>
Subject: Re: maximum ide request size reduced with 2.5.15-git?
Date: Mon, 16 Jan 2006 13:38:03 +0100
Message-ID: <20060116123803.GB3945@suse.de>
References: <43C94E37.9090909@gmx.net> <20060116123637.GA3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:60968 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750719AbWAPMgA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 07:36:00 -0500
Content-Disposition: inline
In-Reply-To: <20060116123637.GA3945@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 16 2006, Jens Axboe wrote:
> On Sat, Jan 14 2006, Carl-Daniel Hailfinger wrote:
> > Hi,
> > 
> > it seems that the maximum request size for my hard drive was
> > reduced with one of the patches between 2.6.15 and 2.6.15-git10.
> > 
> > diff between 2.6.15 and 2.6.15-git10 follows:
> >  Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >  ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> >  ICH4: IDE controller at PCI slot 0000:00:1f.1
> >  PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> >  ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
> >  ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
> >  ICH4: chipset revision 3
> >  ICH4: not 100% native mode: will probe irqs later
> >      ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
> >      ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
> >  Probing IDE interface ide0...
> >  hda: SAMSUNG MP0804H, ATA DISK drive
> >  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >  Probing IDE interface ide1...
> >  hdc: DV-W24ES, ATAPI CD/DVD-ROM drive
> >  ide1 at 0x170-0x177,0x376 on irq 15
> > -hda: max request size: 1024KiB
> > +hda: max request size: 512KiB
> >  hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
> >  hda: cache flushes supported
> >   hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
> >  hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2193kB Cache
> >  Uniform CD-ROM driver Revision: 3.20
> > 
> > Will this affect performance, and if so, how can I get the old
> > settings back?
> 
> It's done for latency reasons. For IDE, there really isn't a difference
> with 512 vs 1024 in throughput, since the command overhead is pretty
> low.
> 
> What IDE prints above is the software max, the hardware max is still
> capped at 2048 sectors (which could be 64k with your lba48 drive). If
> you wish, you could increase the size by echoing a larger amount to
> /sys/block/dev/queue/max_sectors_kb as long as it doesn't exceed
> max_hw_sectors_kb.
> 
> If you apply this patch, you will still get 512kb software size set, but
> it allows you to set it as high as the hardware supports (which is
> really the intention for drivers).
> 
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index ca25f9e..6c55899 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -906,7 +906,7 @@ static void idedisk_setup (ide_drive_t *
>  
>  	if (drive->addressing == 1) {
>  		ide_hwif_t *hwif = HWIF(drive);
> -		int max_s = 2048;
> +		int max_s = 65536;
>  
>  		if (max_s > hwif->rqsize)
>  			max_s = hwif->rqsize;
> @@ -914,7 +914,7 @@ static void idedisk_setup (ide_drive_t *
>  		blk_queue_max_sectors(drive->queue, max_s);
>  	}
>  
> -	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);
> +	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name, drive->queue->max_hw_sectors / 2);
>  
>  	/* calculate drive capacity, and select LBA if possible */
>  	init_idedisk_capacity (drive);

woops, that overflows ->max_hw_sectors actually. Use 65535 instead :-)

-- 
Jens Axboe

