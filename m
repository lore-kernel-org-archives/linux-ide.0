From: Jeremy Smith <alceste@xmission.com>
Subject: PROBLEM: Silicon Image 3112 Lockups
Date: Tue, 6 Sep 2005 19:07:41 -0600 (MDT)
Message-ID: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mgr2.xmission.com ([198.60.22.202]:9955 "EHLO mgr2.xmission.com")
	by vger.kernel.org with ESMTP id S1751025AbVIGBHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 21:07:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org



I'm working on a system (K8N-DL) with a 3114 driver running 2.6.12 and 
experiencing lockups on heavy disk access.  This is the built-in on an 
ASUS-K8N-DL board.  I was wondering if the following problem is 
symptomatic of a known bug.

I will get momentary freezes, and then I'll continue.  At some point 
though, the disk access will freeze--no panic, but a lockup of all disk 
access.  I have configured the first drive as a single drive concatenation 
in the "RAID" bootup and haven't done anything with the second drive.  The 
large logical partition on each drive is configured with software RAID.

Here is one instance from the system log.  A hardboot was required.

Sep  6 17:49:12 localhost kernel: Bootdata ok (command line is 
root=/dev/ram0 mem=3000M init=/linuxrc real_root=/dev/sda2 vga=0x317)
Sep  6 17:49:12 localhost kernel: Memory: 3015772k/3072000k available 
(3153k kernel code, 0k reserved, 1323k data, 224k init)
Sep  6 17:49:14 localhost kernel: ata1: SATA max UDMA/100 cmd 
0xFFFFC2000091E080 ctl 0xFFFFC2000091E08A bmdma 0xFFFFC2000091E000 irq 3
Sep  6 17:49:14 localhost kernel: ata2: SATA max UDMA/100 cmd 
0xFFFFC2000091E0C0 ctl 0xFFFFC2000091E0CA bmdma 0xFFFFC2000091E008 irq 3
Sep  6 17:49:14 localhost kernel: ata3: SATA max UDMA/100 cmd 
0xFFFFC2000091E280 ctl 0xFFFFC2000091E28A bmdma 0xFFFFC2000091E200 irq 3
Sep  6 17:49:14 localhost kernel: ata4: SATA max UDMA/100 cmd 
0xFFFFC2000091E2C0 ctl 0xFFFFC2000091E2CA bmdma 0xFFFFC2000091E208 irq 3
Sep  6 17:49:14 localhost kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 
sectors: lba48
Sep  6 17:49:14 localhost kernel: ata1: dev 0 configured for UDMA/100
Sep  6 17:49:14 localhost kernel: scsi0 : sata_sil
Sep  6 17:49:14 localhost kernel: ata2: dev 0 ATA, max UDMA/133, 488397168 
sectors: lba48
Sep  6 17:49:14 localhost kernel: ata2: dev 0 configured for UDMA/100
Sep  6 17:49:14 localhost kernel: scsi1 : sata_sil
Sep  6 17:49:14 localhost kernel: ata3: no device found (phy stat 
00000000)
Sep  6 17:49:14 localhost kernel: scsi2 : sata_sil
Sep  6 17:49:14 localhost kernel: ata4: no device found (phy stat 
00000000)
Sep  6 17:49:14 localhost kernel: scsi3 : sata_sil
Sep  6 17:49:15 localhost kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Sep  6 17:49:15 localhost kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Sep  6 18:09:44 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:09:44 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:09:51 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:09:51 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:01 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:01 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:09 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:09 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:16 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:16 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:17 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:17 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:20 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:20 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:22 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:22 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:23 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:23 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:23 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:23 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:24 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:24 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:24 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:24 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:25 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:25 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:25 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:25 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:26 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:26 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:26 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:26 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:27 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:27 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:43 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:43 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:50 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:50 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:50 localhost kernel: ata1: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:50 localhost kernel: ata1: error=0x04 { DriveStatusError }
Sep  6 18:10:53 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:53 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:10:55 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:10:55 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 18:11:12 localhost kernel: ata2: status=0x51 { DriveReady 
SeekComplete Error }
Sep  6 18:11:12 localhost kernel: ata2: error=0x04 { DriveStatusError }
Sep  6 19:27:11 localhost kernel: Bootdata ok (command line is 
root=/dev/ram0 mem=3000M init=/linuxrc real_root=/dev/sda2 vga=0x317)


Linux localhost 2.6.12-gentoo-r9 #1 SMP Sat Sep 3 02:05:00 MDT 2005 
x86_64 AMD Opteron(tm) Processor 244 AuthenticAMD GNU/Linux

Gnu C                  3.4.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   068
Modules Loaded         nvidia vmnet parport_pc parport vmmon snd_ca0106 
snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc tg3 ata_piix sata_sil 
libata sbp2 ohci1394 ieee1394 ohci_hcd uhci_hcd usb_storage usbhid ehci_hcd

dd if=/dev/sda of=/dev/null can reproduct error, as can several 
disk-intensive activities

Thanks,
Jer
