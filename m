From: Marc MERLIN <marc@merlins.org>
Subject: Re: PMP failure decoding help
Date: Thu, 25 Mar 2010 20:08:46 -0700
Message-ID: <20100326030846.GI4442@merlins.org>
References: <20100325182109.GZ4442@merlins.org> <4BAC14F9.4070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:53399 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab0CZDIt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 23:08:49 -0400
Content-Disposition: inline
In-Reply-To: <4BAC14F9.4070109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Thu, Mar 25, 2010 at 07:59:21PM -0600, Robert Hancock wrote:
> These are two different issues, see below.

Thanks for looking.

> >ata6.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
> >scsi_eh_7: page allocation failure. order:4, mode:0x10
> 
> Well, that's abnormal. Does dmesg show a stack trace after that line?

Wep. I snipped it not to muddle the logs.
scsi_eh_7: page allocation failure. order:4, mode:0x10
Pid: 1798, comm: scsi_eh_7 Not tainted 2.6.31.6-core2smp-1khznohz-preempt-noticks-noide-4gb-20091118 #1
Call Trace:
 [<c03a2203>] ? printk+0xf/0x14
 [<c017735b>] __alloc_pages_nodemask+0x3da/0x41c
 [<c01907ff>] cache_alloc_refill+0x245/0x404
 [<c0190b23>] kmem_cache_alloc+0x4f/0xe4
 [<c02f035c>] sata_pmp_attach+0xde/0x355
 [<c02ebcfa>] ata_eh_recover+0x5d6/0xa8b
 [<c02e20e8>] ? ata_std_postreset+0x0/0x126
 [<f8aec732>] ? sil24_hardreset+0x0/0x222 [sata_sil24]
 [<f8aec9c4>] ? sil24_softreset+0x0/0x1e0 [sata_sil24]
 [<c02e235d>] ? ata_std_prereset+0x0/0x9e
 [<c02efa97>] sata_pmp_error_handler+0xad/0x894
 [<f8aec732>] ? sil24_hardreset+0x0/0x222 [sata_sil24]
 [<c02e20e8>] ? ata_std_postreset+0x0/0x126
 [<c013c1d2>] ? __cancel_work_timer+0x2b/0x144
 [<c03a4d3f>] ? _spin_unlock_irq+0x15/0x29
 [<c02e0db6>] ? ata_wait_register+0x27/0x5c
 [<f8aec1c1>] ? sil24_init_port+0x80/0xae [sata_sil24]
 [<f8aec6ad>] sil24_error_handler+0x24/0x2f [sata_sil24]
 [<c02eca44>] ata_scsi_error+0x2bc/0x5a6
 [<c02ab3a7>] scsi_error_handler+0xb2/0x4c4
 [<c012069b>] ? complete+0x34/0x3e
 [<c02ab2f5>] ? scsi_error_handler+0x0/0x4c4
 [<c013eb00>] kthread+0x6b/0x70
 [<c013ea95>] ? kthread+0x0/0x70
 [<c0103707>] kernel_thread_helper+0x7/0x10
Mem-Info:
DMA per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
CPU    1: hi:    0, btch:   1 usd:   0
CPU    2: hi:    0, btch:   1 usd:   0
CPU    3: hi:    0, btch:   1 usd:   0
Normal per-cpu:
CPU    0: hi:  186, btch:  31 usd:   0
CPU    1: hi:  186, btch:  31 usd:   0
CPU    2: hi:  186, btch:  31 usd:   0
CPU    3: hi:  186, btch:  31 usd:   0
HighMem per-cpu:
CPU    0: hi:   42, btch:   7 usd:   0
CPU    1: hi:   42, btch:   7 usd:   0
CPU    2: hi:   42, btch:   7 usd:   0
CPU    3: hi:   42, btch:   7 usd:   0
Active_anon:10305 active_file:47093 inactive_anon:28812
 inactive_file:46344 unevictable:675 dirty:110 writeback:37 unstable:0
 free:13169 slab:103294 mapped:5706 pagetables:1206 bounce:0
DMA free:3672kB min:64kB low:80kB high:96kB active_anon:20kB inactive_anon:56kB active_file:4048kB inactive_file:2588kB unevictable:0kB present:15800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 865 1000 1000
Normal free:48088kB min:3728kB low:4660kB high:5592kB active_anon:22648kB inactive_anon:70080kB active_file:153232kB inactive_file:146932kB unevictable:360kB present:885944kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 1079 1079
HighMem free:916kB min:132kB low:276kB high:420kB active_anon:18552kB inactive_anon:45112kB active_file:31092kB inactive_file:35856kB unevictable:2340kB present:138120kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 764*4kB 35*8kB 24*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3720kB
Normal: 8864*4kB 1525*8kB 25*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 48088kB
HighMem: 164*4kB 18*8kB 6*16kB 2*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 960kB
101437 total pagecache pages
7322 pages in swap cache
Swap cache stats: add 46622724, delete 46615402, find 110219915/113491673
Free swap  = 440648kB
Total swap = 1050608kB
262112 pages RAM
34802 pages HighMem
4882 pages reserved
111180 pages shared
166683 pages non-shared
ata6.15: failed to initialize PMP links

> >ata6.04: configured for UDMA/100
> >ata6.05: unsupported device, disabling
> 
> The device that's being disabled is the configuration pseudo-disk built 
> into the PMP, I believe. Nothing to really worry about there.
 
Ok, thanks.

> >sd 7:2:0:0: [sdo] Attached SCSI disk
> >sd 7:4:0:0: [sdq] Attached SCSI disk
> >ata6.00: failed to read SCR 1 (Emask=0x40)
> >ata6.01: failed to read SCR 1 (Emask=0x40)
> >ata6.02: failed to read SCR 1 (Emask=0x40)
> >ata6.03: failed to read SCR 1 (Emask=0x40)
> >ata6.04: failed to read SCR 1 (Emask=0x40)
> >ata6.05: failed to read SCR 1 (Emask=0x40)
> >ata6.06: failed to read SCR 1 (Emask=0x40)
> >ata6.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xe frozen
> >ata6.15: irq_stat 0x01140010, PHY RDY changed
> >ata6.15: SError: { 10B8B }
> 
> This one looks like some kind of communication error between the 
> controller and the PMP (maybe the cable wasn't plugged in all the way 
> yet or something?)
 
Well, I plugged the cable in first and then turned the disk array on to
hopefully avoid a half connection, but who knows?

> >ata6.00: exception Emask 0x0 SAct 0xd SErr 0x0 action 0x6
> >ata6.00: irq_stat 0x00060002, device error via SDB FIS
> >ata6.00: cmd 60/d8:00:77:05:90/00:00:d0:00:00/40 tag 0 ncq 110592 in
> >          res 2e/36:00:00:00:00/00:00:00:00:2e/00 Emask 0x2 (HSM violation)
> >ata6.00: status: { DF DRQ }
> >ata6.00: error: { IDNF ABRT }
> >ata6.00: cmd 60/10:10:5f:05:90/00:00:d0:00:00/40 tag 2 ncq 8192 in
> >          res 41/40:00:69:05:90/2e:00:d0:00:00/40 Emask 0x409 (media 
> >          error)<F>
> >ata6.00: status: { DRDY ERR }
> >ata6.00: error: { UNC }
> 
> That drive doesn't seem to be happy, it's reporting an uncorrectable 
> read error. Have you checked its SMART status? Could be a bad drive, 
> insufficient power, too hot, etc.
 
It's in a hot swappable disk enclosure with 5 drives. I'm hoping it has enough power.
As for too hot, I don't think so. I have reasonable cooling in that cabinet
and 14 other drives running without problem.

But you're right, the drive looks toast out of the box. I should have
checked this first, silly me.

gargamel:~# smartctl -A /dev/sdm
smartctl 5.39 2009-10-10 r2955 [i686-pc-linux-gnu] (local build)
Copyright (C) 2002-9 by Bruce Allen, http://smartmontools.sourceforge.net

=== START OF READ SMART DATA SECTION ===
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   200   200   051    Pre-fail  Always       -       6
  3 Spin_Up_Time            0x0027   100   253   021    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       4
  5 Reallocated_Sector_Ct   0x0033   166   166   140    Pre-fail  Always       -       267
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  7 Seek_Error_Rate         0x002e   200   191   000    Old_age   Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       20
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       3
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       2
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       31
194 Temperature_Celsius     0x0022   126   122   000    Old_age   Always       -       26
196 Reallocated_Event_Count 0x0032   188   188   000    Old_age   Always       -       12
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always       -       3
198 Offline_Uncorrectable   0x0030   200   200   000    Old_age   Offline      -       3
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0008   200   200   000    Old_age   Offline      -       4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
