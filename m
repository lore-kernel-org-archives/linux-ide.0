From: Andrey Gusev <ronne@list.ru>
Subject: Problem on initialization bad hardware with driver from sata
 subsystem.
Date: Sat, 8 Jan 2011 23:59:41 +0300
Message-ID: <20110108235941.6f82f6dc@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:37122 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab1AHVFj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 16:05:39 -0500
Received: from smtp8.mail.ru (smtp8.mail.ru [94.100.176.53])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id D3AEC4EA63B0
	for <linux-ide@vger.kernel.org>; Sun,  9 Jan 2011 00:00:03 +0300 (MSK)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello!

I have one old disk. It has some hardware fails, but it works. I wanted to change 
 driver from old ide subsystem (marked as deprecated). My system can't boot 
with a new driver because sata subsystem handled this error another way. There is
part dmesg for ide subsystem:

[    0.415582] Uniform Multi-Platform E-IDE driver
[    0.416249] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    1.427928] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    1.428161] Probing IDE interface ide0...
[    1.692115] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    2.304126] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.304302] hda: UDMA/100 mode selected
[    2.304616] ide0 at 0xf1362000-0xf1362070,0xf1362160 on irq 39
[    3.316952] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    3.317183] Probing IDE interface ide1...
[    3.581260] hdc: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[    4.193132] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    4.193425] hdc: UDMA/66 mode selected
[    4.193879] ide1 at 0xf10fc000-0xf10fc070,0xf10fc160 on irq 19
[    5.205975] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[    5.206199] Probing IDE interface ide2...
[    5.572162] hde: TSSTcorp CDDVDW SH-S222A, ATAPI CD/DVD-ROM drive
[    6.184154] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    6.184282] hde: MWDMA2 mode selected
[    6.184619] ide2 at 0xf135a000-0xf135a070,0xf135a160 on irq 20
[    6.185141] ide-gd driver 1.18
[    6.185286] hda: max request size: 128KiB
[    6.198192] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[    6.198635] hda: cache flushes supported
[    6.204552]  hda: [mac] hda1 hda2 hda3 hda4
[    6.206107] hdc: max request size: 128KiB
[    6.215276] hdc: Host Protected Area detected.
[    6.215279]  current capacity is 40130390 sectors (20546 MB)
[    6.215282]  native  capacity is 40132503 sectors (20547 MB)
[    6.215704] hdc: 40130390 sectors (20546 MB) w/1900KiB Cache, CHS=39811/16/63
[    6.215910] hdc: cache flushes not supported
[   26.274255] ide-pmac lost interrupt, dma status: 8480
[   26.274403] hdc: lost interrupt
[   26.274492] hdc: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   26.274706] hdc: possibly failed opcode: 0xc8
[   26.279752] hdc: DMA disabled
[   26.329249] ide1: reset: success
[   26.354166]  hdc: [mac] hdc1 hdc2
[   26.362604] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)

I don't have log, for SATA subsystem, but it tried make initialization after lost interrupt 
again and again.
Some information about disk:

andrey@power-debian:~$ sudo cat /proc/ide/hdc/settings 
[sudo] password for andrey: 
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                39811           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
current_speed           68              0               70              rw
failures                0               0               65535           rw
init_speed              12              0               70              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
wcache                  1               0               1               rw
andrey@power-debian:~$ sudo cat /proc/ide/hdc/geometry 
physical     16383/16/63
logical      39811/16/63

andrey@power-debian:~$ sudo /sbin/hdparm /dev/hdc

/dev/hdc:
 multcount     = 16 (on)
 IO_support    =  0 (default) 
 unmaskirq     =  0 (off)
 using_dma     =  0 (off)
 keepsettings  =  0 (off)
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 39811/16/63, sectors = 40130390, start = 0

Best,
Andrey
