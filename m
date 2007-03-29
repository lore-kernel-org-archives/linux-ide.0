From: "Scott White" <scott@riskboys.com>
Subject: Terrible performance with Promise Sata Controller (sata_promise
     vanilla 2.6.20.4)
Date: Thu, 29 Mar 2007 20:32:57 +0100 (BST)
Message-ID: <49910.87.74.24.183.1175196777.squirrel@87.74.24.183>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from real.soumian.com ([213.253.136.166]:53899 "HELO soumian.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934334AbXC2Tjj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Mar 2007 15:39:39 -0400
References: 
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Does anyone have time for a user question?  Tell me to push off if this is
not the right list.

I have a system (SMP Xeon), with
  4x Fast 10000RPM 72G SATA WD Raptor drives and
  8x 7200RPM 250G SATA Hitachi.
-The 250Gs are a RAID5 stripe on an 8 port PCI-X Marvell (sata_mv) controller
-The 72Gs are spread across the motherboard ports,
  2 I believe served by the Intel Southbridge and
  2 by an on-board Promise SATA controller
 These 4 disks are mirrored across controllers.

The 72g drives perform surprisingly badly on the Promise controller. 
Await seems particularly high, (112 Promise vs 6 ata-piix), and it often
reports that the mirrors on the ata-piix are 25% loaded as a result.

Below is an iostat -X during a resync of all the arrays, but I get the
same results doing any intensive IO on these stripes.

Could anyone point me towards what could be wrong or if this is to be
expected?  Is there anything I can Tune to help the Promise controller
out?


evice:         rrqm/s   wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz
avgqu-sz   await  svctm  %util
sda               0.00   213.27  0.00 49.90     0.00 33501.00   671.36    
0.28    5.66   4.77  23.79
sdb               0.00   215.47  0.00 50.30     0.00 33826.75   672.51    
0.29    5.85   4.90  24.63
sdc             220.66     0.20 41.12  0.60 33596.81     6.39   805.51    
4.70  112.72  23.89  99.64
sdd             222.85     1.20 41.22  0.40 33711.78    12.77   810.36    
4.69  112.56  23.96  99.72
sde            4222.75     0.60 90.22  0.50 34518.16     8.78   380.59    
2.52   27.89  10.94  99.28
sdf            4235.23     0.00 76.25  0.00 34352.89     0.00   450.54    
3.03   39.69  13.01  99.20
sdg            4213.67     0.00 98.00  0.00 34424.75     0.00   351.26    
2.36   24.06  10.07  98.64
sdh            4224.15     2.20 90.62  1.20 34451.90    27.15   375.52    
2.69   29.30  10.87  99.80
sdi            4222.36     0.00 89.12  0.00 34352.89     0.00   385.46    
2.63   29.46  11.10  98.96
sdj            4217.47     0.00 94.01  0.00 34352.89     0.00   365.41    
2.51   26.62  10.54  99.08
sdk            4219.26     0.00 92.32  0.10 34353.69     0.80   371.74    
2.53   27.25  10.75  99.32
sdl            4232.53     1.60 81.04  0.80 34372.06    19.16   420.24    
2.98   36.35  12.20  99.88
md11              0.00     0.00  0.00  0.80     0.00     6.39     8.00    
0.00    0.00   0.00   0.00
md3               0.00     0.00  0.00  3.09     0.00    24.75     8.00    
0.00    0.00   0.00   0.00
md12              0.00     0.00  0.00  1.60     0.00    12.77     8.00    
0.00    0.00   0.00   0.00
md0               0.00     0.00  0.00  0.00     0.00     0.00     0.00    
0.00    0.00   0.00   0.00
dm-0              0.00     0.00  0.00  0.00     0.00     0.00     0.00    
0.00    0.00   0.00   0.00
dm-1              0.00     0.00  0.00  0.00     0.00     0.00     0.00    
0.00    0.00   0.00   0.00
dm-2              0.00     0.00  0.00  0.00     0.00     0.00     0.00    
0.00    0.00   0.00   0.00
dm-3              0.00     0.00  0.00  2.40     0.00    19.16     8.00    
0.07   28.83  21.83   5.23


Some dmesg output, (all disks are SATA even though I see ATA messages)

ata_piix 0000:00:1f.2: version 2.00ac7
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD800 irq 16
ata2: SATA max UDMA/133 cmd 0xD000 ctl 0xD402 bmdma 0xD808 irq 16
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piixata2.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
sata_promise 0000:04:04.0: version 1.05
ata3: SATA max UDMA/133 cmd 0xF881E200 ctl 0xF881E238 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF881E280 ctl 0xF881E2B8 bmdma 0x0 irq 19
scsi2 : sata_promise
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3.00: ata3: dev 0 multi count 0ata3.00: configured for UDMA/133 scsi3 :
sata_promise
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata4.00: ata4: dev 0 multi count 0
ata4.00: configured for UDMA/133

Rgds

Scott







