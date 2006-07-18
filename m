From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: harddisk or controller broken?
Date: Tue, 18 Jul 2006 07:08:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607180706280.6000@p34.internal.lan>
References: <20060718064712.GA16538@scavenger.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:4817 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932171AbWGRLI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2006 07:08:29 -0400
In-Reply-To: <20060718064712.GA16538@scavenger.homeip.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Schieder <blindcoder@scavenger.homeip.net>
Cc: linux-ide@vger.kernel.org

On Tue, 18 Jul 2006, Benjamin Schieder wrote:

> Hi list.
>
> Recently I've had trouble with my software raid which have been (mosstly)
> resolved with the help of people from the linux-raid list.
>
> While doing that, I stumbled over these lines in my /var/log/messages:
>
> ---
> Jul 16 16:59:36 ceres kernel: hdb: status error: status=0x00 { }
> Jul 16 16:59:36 ceres kernel: ide: failed opcode was: 0xea
> Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:36 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:36 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:36 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:36 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:36 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:36 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: ide0: reset: success
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x00 { }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: ide0: reset: success
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x00 { }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: unknown
> Jul 16 16:59:37 ceres kernel: end_request: I/O error, dev hdb, sector 488391932
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: hdb: status error: status=0x10 { SeekComplete }
> Jul 16 16:59:37 ceres kernel: ide: failed opcode was: 0xea
> Jul 16 16:59:37 ceres kernel: raid5: Disk failure on hdb8, disabling device. Operation continuing on 2 devices
> Jul 16 16:59:37 ceres kernel: hdb: drive not ready for command
> Jul 16 16:59:37 ceres kernel: RAID5 conf printout:
> Jul 16 16:59:37 ceres kernel:  --- rd:3 wd:2 fd:1
> Jul 16 16:59:37 ceres kernel:  disk 0, o:0, dev:hdb8
> Jul 16 16:59:37 ceres kernel:  disk 1, o:1, dev:hda8
> Jul 16 16:59:37 ceres kernel:  disk 2, o:1, dev:hdc8
> Jul 16 16:59:37 ceres kernel: RAID5 conf printout:
> Jul 16 16:59:37 ceres kernel:  --- rd:3 wd:2 fd:1
> Jul 16 16:59:37 ceres kernel:  disk 1, o:1, dev:hda8
> Jul 16 16:59:37 ceres kernel:  disk 2, o:1, dev:hdc8
> ---
>
> Now, is this a broken IDE controller or harddisk? Because smartctl claims
> that everything is fine.
>
> ---
> root@ceres:~# smartctl -H /dev/hdb
> smartctl version 5.33 [i586-unknown-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> ---
>
> I run short tests every night and long tests every sunday to check the
> devices. They're brand new, although I know that that isn't always a guarantee
> that they also work.
>
> If it's important, I've attached the IDE specific output of the boot messages.
>
> ---
> Jul  7 23:15:08 ceres kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Jul  7 23:15:08 ceres kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Jul  7 23:15:08 ceres kernel: VP_IDE: IDE controller at PCI slot 0000:00:04.1
> Jul  7 23:15:08 ceres kernel: VP_IDE: chipset revision 6
> Jul  7 23:15:08 ceres kernel: VP_IDE: not 100%% native mode: will probe irqs later
> Jul  7 23:15:08 ceres kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
> Jul  7 23:15:08 ceres kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
> Jul  7 23:15:08 ceres kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> Jul  7 23:15:08 ceres kernel: hda: ST3250624A, ATA DISK drive
> Jul  7 23:15:08 ceres kernel: hdb: ST3250624A, ATA DISK drive
> Jul  7 23:15:08 ceres kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Jul  7 23:15:08 ceres kernel: hdc: ST3250624A, ATA DISK drive
> Jul  7 23:15:08 ceres kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Jul  7 23:15:08 ceres kernel: PDC20268: IDE controller at PCI slot 0000:00:0a.0
> Jul  7 23:15:08 ceres kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 16
> Jul  7 23:15:08 ceres kernel: PDC20268: chipset revision 2
> Jul  7 23:15:08 ceres kernel: PDC20268: ROM enabled at 0x20010000
> Jul  7 23:15:08 ceres kernel: PDC20268: 100%% native mode on irq 16
> Jul  7 23:15:08 ceres kernel:     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
> Jul  7 23:15:08 ceres kernel:     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
> Jul  7 23:15:08 ceres kernel: hde: IC35L120AVV207-0, ATA DISK drive
> Jul  7 23:15:08 ceres kernel: Warning: Primary channel requires an 80-pin cable for operation.
> Jul  7 23:15:08 ceres kernel: hde reduced to Ultra33 mode.
> Jul  7 23:15:08 ceres kernel: ide2 at 0xb800-0xb807,0xb402 on irq 16
> Jul  7 23:15:08 ceres kernel: hda: max request size: 512KiB
> Jul  7 23:15:08 ceres kernel: hda: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, UDMA(100)
> Jul  7 23:15:08 ceres kernel: hda: cache flushes supported
> Jul  7 23:15:08 ceres kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
> Jul  7 23:15:08 ceres kernel: hdb: max request size: 512KiB
> Jul  7 23:15:08 ceres kernel: hdb: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, UDMA(100)
> Jul  7 23:15:08 ceres kernel: hdb: cache flushes supported
> Jul  7 23:15:08 ceres kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 >
> Jul  7 23:15:09 ceres kernel: hdc: max request size: 512KiB
> Jul  7 23:15:09 ceres kernel: hdc: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, UDMA(100)
> Jul  7 23:15:09 ceres kernel: hdc: cache flushes supported
> Jul  7 23:15:09 ceres kernel:  hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
> Jul  7 23:15:09 ceres kernel: hde: max request size: 512KiB
> Jul  7 23:15:09 ceres kernel: hde: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(33)
> Jul  7 23:15:09 ceres kernel: hde: cache flushes supported
> Jul  7 23:15:09 ceres kernel:  hde: hde1
> ---
>
> hde has since been removed from the machine, but the pdc20268 is still
> present.
>
> If someone has an idea if it's the controller or the disk or anything else
> I'd very much appreciate any help you can offer!
>
>
> Greetings,
> 	Benjamin
>
> -- 
> Today, memory either forgets things when you don't want it to,
> or remembers things long after they're better forgotten.
>

Jul 16 16:59:37 ceres kernel: end_request: I/O error, dev hdb, sector 
488391932

Run a short & long test (smart -t short /dev/hdb and smartctl -a /dev/hdb 
to see the status) and also run a badblocks -v /dev/hdb (read-only test) 
to see if there are any problems.  Also, when I have had drives go bad, 
ultimately you need to remove that drive from the array and do a badblocks 
write & read test (which takes 10-12 hours), this will ultimately show 
whether the drive is going to croak or not.

Justin.

