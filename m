From: Patrick Dreker <patrick@dreker.de>
Subject: [Bug] Regression with Intel Triton II (PIIX3) and linux 2.4.21
Date: Tue, 22 Jun 2004 03:15:51 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406220315.57984.patrick@dreker.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.173]:52695 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266502AbUFVBQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jun 2004 21:16:00 -0400
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BcZtH-0000vV-00
	for linux-ide@vger.kernel.org; Tue, 22 Jun 2004 03:15:59 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello...

I recently got a decommisioned lab machine (Tyan Titan Pro (S1668) Board, only 
one Pentium Pro 200 CPU (of two) installed) and wanted to repurpose the 
machine as my internal router/web server.

As the machine was running kernel 2.4.18 (Debian Woody) I wanted to upgrade 
the kernel to 2.4.26 to make sure I have all security fixes. I did some 
simple hardware tests before setting the machine up and everything was fine.

After upgrading to Kernel 2.4.26 I suddenly got the following errors (usually 
in identical groups of 3), and the harddisk became extremely slow:
- -----------------------
hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
- -----------------------

At first I thought the disk had gone bad and replaced it with a known good 
drive (which ran without problems before and runs without problems now in 
another machine), but this drive generated the same errors. Putting another 
known good  drive on the other controller port also yielded the same errors 
(now with hda *and* hdc instead of only hda). I have also checked all cables 
and tried an UP kernel without any changes. 12 hours of memtest86 also 
detected no errors.

After finding that the old 2.4.18 kernel prduced no errors at all no matter 
what drives were connected, I did a quick bisection search across several 
kernel versions and found that all kernels upto (and including) 2.4.20 work 
without problems with all drives. Any later kernel (>= 2.4.21 including 
2.6.7) exposes the errors no matter what drives are connected. A little 
digging around shows that kernel 2.4.21 merged the 7.00beta IDE drivers, 
while the working kernels have ide.c version 6.31. So I would point my finger 
in that direction...

I am currently stuck with kernel 2.4.20, so what can I do? I am willing to try 
patches or help debugging, but my kernel hacking experience is limited and my 
IDE expertise is non-existent, so any help is appreciated. If you need any 
further information, please ask.

Thanks,
Patrick

lspci of the machine:
- --------------------------
0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
0000:00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 
01)
0000:00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
- --------------------------

relevant parts of dmesg from 2.4.20:
- -------------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPF3204AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c032d984, I/O limit 4095Mb (mask 0xffffffff)
hda: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=2491/255/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3
- --------------------------------

relevant parts of dmesg from 2.4.26:
- ------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPF3204AT, ATA DISK drive
blk: queue c03443e0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=2491/255/63, (U)DMA
Partition check:
 hda:<4>hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
 hda1 hda2 hda3
NET4: Linux TCP/IP 1.0 for NET4.0
 IP Protocols: ICMP, UDP, TCP
 IP: routing cache hash table of 2048 buckets, 16Kbytes
 TCP: Hash tables configured (established 16384 bind 16384)
 NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
- -------------------------------------

Patrick
- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA14hNcERm2vzC96cRAuZ7AJ9QPS9/dlII7A0/wv6L7HLazmSb0wCgh8bB
YwpjkR9GwbHa/HtqvpkJaJI=
=c0ig
-----END PGP SIGNATURE-----
