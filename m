From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Sun, 28 Oct 2007 20:17:45 +0000
Message-ID: <1193602665.2647.23.camel@localhost.localdomain>
References: <1193332621.2349.26.camel@localhost.localdomain>
	 <200710252111.47097.bzolnier@gmail.com>
	 <1193394094.2348.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.mail.iol.ie ([193.95.141.54]:44564 "EHLO
	mail2.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbXJ1Uqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 16:46:32 -0400
In-Reply-To: <1193394094.2348.23.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, 2007-10-26 at 11:21 +0100, Declan Moriarty wrote:

> > > This laptop currently has
> > > hda1 - windows 2000 2 Gigs
> > > hda4 - linux system 1 Gig
> > > 
> > > The linux system uses kernel-2.6.22.6, uClibc-0.9.29 & gcc-4.1.2, and
> > > was compiled on a box here with a uname hack, as  the laptop has a
> > > pentium-233 only. Then it was copied on with a usb stick (which the bios
> > > won't boot from, of course) I do have floppy, but no networking or
> > > cdrom. Booting is currently from a grub floppy.
> > > 
> > > The kernel on hda4 boots, finds things and gets this far
> > 
> > If hda drive is found and configured correctly this is most likely
> > not an IDE problem (user-space compiled for CPU newer than i586?
> > configuration problem?) but can't tell for sure.
> 
> I did use a uname hack, so the last kernel tried was compiled for i486
> with all chipset bugfix code. 
> > 
> > > kjournald starting. Commit interval 5 seconds
> > > EXT3-fs: mounted filesystem with ordered data mode
> > > VFS: mounted root (ext3 filesystem) readonly
> > > Freeing unused kernel memory: <so much> freed
> > 
> > IDE kernel messages would be far more useful...
> > 
> > PS Please cc: linux-ide@vger.kernel.org mailing list on IDE problems so
> >    the mail reaches more knowledgeable people who may be able to help.

> > > But I never get to this
> > > 
> > > EXT3 FS on hda4, internal journal 
> > > 
> > > which is the next line on a good boot. Instead the kernel folds it's
> > > arms, the disk goes quiet, no error shows, and everything sits back. USB
> > > devices will register & deregister, but booting stops and even
> > > init=/bin/bash won't happen
> > > 
> > > I have tried several kernels. The chipset, btw is the Intel 82371
> > > Southbridge and Intel 82439 Northbridge. The hard disk is 6282/16/63 or
> > > 721/128/63, but if I try the old driver with lba & large disk access, it
> > > also reads and boots the kernel (Up above cylinder 4000), and then
> > > complains (At the same point as the others) that it can only handle 16
> > > heads, and we appear to have 128! Disable lba & large disk access for
> > > the old driver, (There's real health warnings on that!) and the old
> > > driver behaves in an identical fashion to the new.
> > > This makes me think grub is handing over to the kernel driver, but I
> > > just don't know.
> > > We're on 'fast PIO 4' because any faster settings (3 weirdo dma options)
> > > seem to barf
> 
> OK, IDE messages: (transcribed)
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuning 33Mhz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller at PCU slot 0000:00:01linux-ide@vger.kernel.org
> PIIX4: chipset revision 1
> PIIX4: not 100% native, will probe irqs later 
> ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hda:pio
> ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
> hda: HITATCHI_DK226A-32, ATA DISK drive
> ide0; at 0x1f0-1f7 on irq 14
> hda: 6332256 sectors (3242MB) w/128KiB Cache CHS=6282/16/63 DMA
> hda: hda1, hda4

Let me give you a laugh on this, and you can tell me if anyone can solve
it quickly or slowly.

I got fed up with this, and dumped windows. I feared that the correct
cylinders value was getting through lba to nobble access above 1024
cylinders. So I repartitioned and got the entire thing below the most
pessimistic 1024 cylinders; It's all below the 504MB limit.

The same thing exactly happens, which would indicate that 1024 cylinder
problem was not the cause. I've also lost usb access, because my shiny
new system won't boot, and windows has been overwritten.

That leaves me curious as hell as to what's going on.
-- 
        With Best Regards,

        Declan Moriarty

