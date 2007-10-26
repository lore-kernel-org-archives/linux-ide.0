From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Fri, 26 Oct 2007 11:21:34 +0100
Message-ID: <1193394094.2348.23.camel@localhost.localdomain>
References: <1193332621.2349.26.camel@localhost.localdomain>
	 <200710252111.47097.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.mail.iol.ie ([193.120.142.151]:51837 "EHLO
	mail1.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbXJZKl7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 06:41:59 -0400
In-Reply-To: <200710252111.47097.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2007-10-25 at 21:11 +0200, Bartlomiej Zolnierkiewicz wrote: 
> Hi,
> 
> On Thursday 25 October 2007, Declan Moriarty wrote:
> > Hi,
> > 
> > You're down as the maintainer of the ide code, and I'm hoping for a
> > diagnosis. This mail is largely because I'm sure you're more familiar
> > with kernel boot messages than I am.
> > 
> > This laptop currently has
> > hda1 - windows 2000 2 Gigs
> > hda4 - linux system 1 Gig
> > 
> > The linux system uses kernel-2.6.22.6, uClibc-0.9.29 & gcc-4.1.2, and
> > was compiled on a box here with a uname hack, as  the laptop has a
> > pentium-233 only. Then it was copied on with a usb stick (which the bios
> > won't boot from, of course) I do have floppy, but no networking or
> > cdrom. Booting is currently from a grub floppy.
> > 
> > The kernel on hda4 boots, finds things and gets this far
> 
> If hda drive is found and configured correctly this is most likely
> not an IDE problem (user-space compiled for CPU newer than i586?
> configuration problem?) but can't tell for sure.

I did use a uname hack, so the last kernel tried was compiled for i486
with all chipset bugfix code. 
> 
> > kjournald starting. Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode
> > VFS: mounted root (ext3 filesystem) readonly
> > Freeing unused kernel memory: <so much> freed
> 
> IDE kernel messages would be far more useful...
> 
> PS Please cc: linux-ide@vger.kernel.org mailing list on IDE problems so
>    the mail reaches more knowledgeable people who may be able to help.
> 
> Thanks,
> Bart
> 
> > But I never get to this
> > 
> > EXT3 FS on hda4, internal journal 
> > 
> > which is the next line on a good boot. Instead the kernel folds it's
> > arms, the disk goes quiet, no error shows, and everything sits back. USB
> > devices will register & deregister, but booting stops and even
> > init=/bin/bash won't happen
> > 
> > I have tried several kernels. The chipset, btw is the Intel 82371
> > Southbridge and Intel 82439 Northbridge. The hard disk is 6282/16/63 or
> > 721/128/63, but if I try the old driver with lba & large disk access, it
> > also reads and boots the kernel (Up above cylinder 4000), and then
> > complains (At the same point as the others) that it can only handle 16
> > heads, and we appear to have 128! Disable lba & large disk access for
> > the old driver, (There's real health warnings on that!) and the old
> > driver behaves in an identical fashion to the new.
> > This makes me think grub is handing over to the kernel driver, but I
> > just don't know.
> > We're on 'fast PIO 4' because any faster settings (3 weirdo dma options)
> > seem to barf

OK, IDE messages: (transcribed)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuning 33Mhz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCU slot 0000:00:01linux-ide@vger.kernel.org
PIIX4: chipset revision 1
PIIX4: not 100% native, will probe irqs later 
ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hda:pio
ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
hda: HITATCHI_DK226A-32, ATA DISK drive
ide0; at 0x1f0-1f7 on irq 14
hda: 6332256 sectors (3242MB) w/128KiB Cache CHS=6282/16/63 DMA
hda: hda1, hda4

It doesn't find the time source or the PS/2 mouse very easily, so if IDE
relies on that, that could be the issue. The ide messages all come in a
bundle. Ide1 has no devices.

Booting the same kernel on a newer box gives me these differences.
In place of the first two lines beginning 'PIIX4' I get similar lines
beginning 'VP_IDE'
Then comes
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA CD/DVDW SDR5372V, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20


I suspect a 1024 cylinder limit problem. The kernel lies above cylinder
4000 and I have no way of finding out where. But grub finds it, loads
it, and boots it! The only other access is under tomsrtbt, which won't
chroot into the new system. Windows 2000 also boots from a grub boot
floppy, but I have to kill that (and my usb connection with it) to come
in under 1024 cylinders. Bios are the latest revision afaict.

Please cc me on this as I am not a programmer and am not on the list.
-- 
        With Best Regards,

        Declan Moriarty

