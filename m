From: Jens Axboe <axboe@suse.de>
Subject: Re: harddisk corruption with 2.5.41bk and tcq enabled
Date: Sat, 12 Oct 2002 11:16:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021012091653.GD26719@suse.de>
References: <200210121050.01471.jan@jandittmer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200210121050.01471.jan@jandittmer.de>
To: Jan Dittmer <jan@jandittmer.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Oct 12 2002, Jan Dittmer wrote:
> Hi,
> 
> recent tcp additions seem to corrupt harddisk. X/KDE doesn't start up anymore 
> and 'mount' was broken after reboot. (Debian/unstable, ext3 fs) No Problem 
> with clean 2.5.41. Will try 2.5.42 now. You need any more information?

2.5.42 has no changes in this area, so it's probably not safe for you
either.

> Here goes dmesg/config output:
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L060AVVA07-0, ATA DISK drive

Vancouver, I'm using the very same drive here on the machine where I'm
writing this mail. This could be some odd via interaction.

> [...]
> 
> attempt to access beyond end of device
> ide0(3,2): rw=0, want=1076371720, limit=19535040

Any messages _before_ these??

-- 
Jens Axboe
