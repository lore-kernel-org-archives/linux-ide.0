From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and UDMA5
 instead of UDMA6
Date: Thu, 17 Dec 2009 08:16:05 -0600
Message-ID: <4B2A3D25.9030209@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:35874 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764790AbZLQOYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 09:24:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I recently added a Silicon Image 3512 based PCI card to an old Intel
440BX machine along with a single platter 500GB WD SATA2 drive.  I'd
have gone with an ahci sata2 controller but couldn't find one in 33MHz
PCI.  I compiled a new kernel, adding SCSI disk, libata and sata_sil
support using make menuconfig and kernel.org sources installed the
debian way on lenny 5.0.3.  I left the old piix diver in so I could
still boot from the old IDE disk and move the entire Linux system over.
 That all went pretty smoothly, I'm now booting from the new disk, and
the sata subsystem is working pretty well, especially compared to the
old 40GB Maxtor IDE disk (now removed from the system).

However, I noticed that when running hdparm with O_DIRECT the transfer
rate is ~85MB/s, while running buffered timings produces only ~55MB/s.
This is an approximate 38% difference and I thought something might be
amiss.  On a much newer workstation with nvidia IDE chipset and 120GB
Seagate IDE disk, running SLED10, O_DIRECT and buffered show identical
numbers.  I wouldn't think the kernel buffers in 2.6.31.1 would
introduce that much overhead even on a much slower proc/mem subsystem,
so I started digging around.  Additionally, I've read on a number of
Windows websites that this WD drive is averaging 100MB/s in various disk
benchmarks and peaking at over 120MB/s.  I have not tested my 3512/WD500
combo under Windows so I can't confirm those numbers.  However, assuming
they're valid, it seems my system is leaving quite a bit of performance
on the table...

I already knew from dmesg that the drive is being programmed at udma/100
even though the drive is capable of udma/133.  Until yesterday I didn't
realize that ncq was disabled (gasp).  This drive is not in the
blacklist in sata_sil.c or libata-core.c.  I tried enabling ncq with

echo 31 > /sys/block/sda/device/queue_depth

but that gave a permissions error.  I tried chmod +w on the above 'file'
but then received "write error: Input/output error".

So, I find myself stuck, not being a kernel hacker or even knowing the C
language, seeing the code for the first time today, and wanting to
change the behavior of my PCI card and disk.  I'd like to bump up to
udma/133 and enable ncq to at least test those modes, but don't quite
know how to do this.  I found sections in each of the c files above that
are probably relevant but I have no clue what mods I need to make to
effect the changes I want.  I've searched the interwebs twice and found
no solution, arriving at your doorstep.  Please take pity on me, and
provide me some basic english instructions on what to modify and where
in order to enable udma6 and ncq.  Or, better yet, if I could use boot
arguments that would be great.  I know how to do those, if given the
proper arguments.  I compile everything into my kernels, no driver
modules and no initrd.  Oh, and I still use LILO not grub. ;)

I know that making these changes might possibly cause problems and/or
data loss and I accept that responsibility.  I _need_ to know if I'm
leaving a bunch of performance on the table.  After seeing winders
benchmarks, I fear that I am.  I'm having trouble sleeping not knowing
the answer to this question.  I'm obsessed with it now. :(

Thanks in advance Jeff for any help you are able to provide.  I copied
the linux-ide list per your instructions in sata_sil.c.  I am not
subscribed to the list.  If anyone else has the solution or tips to
point me in the right direction, thank you all in advance as well.
Sorry for my ramblings and if I posted too much information or back
story.  I've been in this computer game since '86 and it seems more
information up front is usually better than not enough.

--
Stan

00:11.0 RAID bus controller: Silicon Image, Inc. SiI 3512
[SATALink/SATARaid] Serial ATA Controller (rev 01)
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)

SCSI subsystem initialized
libata version 3.00 loaded
sata_sil 0000:00:11.0: version 2.4
sata_sil 0000:00:11.0: PCI->APIC IRQ transform: INT A -> IRQ 19
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 mmio m512@0xe9610000 tf 0xe9610080 irq 19
ata2: SATA max UDMA/100 mmio m512@0xe9610000 tf 0xe96100c0 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 05.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
ata2: SATA link down (SStatus 0 SControl 310)

