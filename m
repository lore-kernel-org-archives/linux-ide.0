From: Petr Sebor <petr@scssoft.com>
Subject: sata_via - too slow
Date: Mon, 02 Aug 2004 14:07:56 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410E2E9C.8020606@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.inway.cz ([212.24.128.3]:57730 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S266488AbUHBMIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2004 08:08:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by relay.inway.cz (Postfix) with ESMTP id 53B0617F67C
	for <linux-ide@vger.kernel.org>; Mon,  2 Aug 2004 14:08:13 +0200 (CEST)
Received: from opteron.scssoft.com (opteron.scssoft.com [212.24.137.149])
	by relay.inway.cz (Postfix) with ESMTP id C329917F376
	for <linux-ide@vger.kernel.org>; Mon,  2 Aug 2004 14:08:11 +0200 (CEST)
Received: from [212.24.137.141] (donkey.scssoft.com [212.24.137.141])
	by opteron.scssoft.com (Postfix) with ESMTP id A2F6A1D37C2
	for <linux-ide@vger.kernel.org>; Mon,  2 Aug 2004 14:08:11 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am having performance problems on dual opteron server with two 
attached SATA disks.

Unfortunately, my hacking skills are probably not good enough to provide 
good bug
report. I will at least try to describe what is going on...

Simply put, any disk access blocks almost everything else and the system 
becomes very
unresponsitive to any user actions. Even bash console is very slow...

 From what I can see in top or vmstat, both CPUs spend all of their time 
in 'wait' state.

typical top output...
Cpu0  :  7.5% us,  2.3% sy,  0.0% ni, 11.1% id, 77.8% wa,  0.5% hi,  0.9% si
Cpu1  :  9.7% us,  1.1% sy,  0.0% ni, 28.7% id, 60.4% wa,  0.0% hi,  0.0% si

and it is being worse, I can see frequently, that the 'wait' gets 
frequently over 90%.

from 'top', I can see that almost every program that generates disk 
access waits most frequently
in 'wait_on_buffer', this was my first clue that the delays actually 
come from the 'disk access' layer,
rather that from the filesystem itself. I have also created an ext2 
partition, but the 'waits' happened
there as well, so I'd naively rule out the reiserfs I am using.

otherwise, I am using kernel 2.6.8-rc2-bk7 right now, but this happens 
since the time I have the
sata disks. it runs on dual opteron system / debian, but not in native 
mode, all code is i386.

I have tried the kernel both in SMP or UP, with noacpi, iommu=off, 
preemptible kernel or not
without difference....

vmstat output from UP kernel when zipping bigger archive.
 0  3      0 532912  68860 367552    0    0  4700     0 2575   448  1  
4  0 95
 0  3      0 524672  68864 375568    0    0  5296 17044 2406   547  1  
4  0 95
 0  3      0 516736  68872 383588    0    0  5376  1228 2561   514  1  
8  0 91
 0  3      0 508160  68884 392248    0    0  5844     4 2652   592  1  
5  0 94
 0  4      0 506624  68888 393728    0    0  1236  1188 1630   205  1  
3  0 96
 1  1      0 501200  68892 399224    0    0  3872     0 2327   346  0  
5  0 95
 0  1      0 488592  68900 411648    0    0  7496     0 2496   607  2  
7  0 91

lspci output:

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800 South] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Flags: bus master, medium devsel, latency 32, IRQ 11

I am _not_ using RAID btw....

hopefully relevant dmesg output:
libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 11
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 11
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
Using anticipatory io scheduler
  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0

 From what I have understood, these drives are SATA with PATA bridge on 
them.
The problems described happen on both. No difference.

Interesting is, that
root@opteron:$ hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  144 MB in  3.03 seconds =  47.45 MB/sec

So it is not _that_ slow...

If someone has a clue what might be wrong, please let me know (Please CC 
me),
I will gladly provide any information that might be useful.

I understand that the problem might not be even sata related even if I 
naively think so.
I simply do not have a clue, where to look or try next.

Thanks!
Petr Sebor

-- 
Petr Sebor / SCS Software [ http://www.scssoft.com ]
 

