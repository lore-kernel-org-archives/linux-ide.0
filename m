From: Brett Russ <russb@emc.com>
Subject: [PATCH] (IDE) restore access to low order LBA following error
Date: Thu, 05 Aug 2004 12:46:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41126458.1050203@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267788AbUHEQty@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
List-Id: linux-ide@vger.kernel.org

I've been playing with code which needs access to the drive's reported 
error LBA following a drive detected sector error.  Currently, as far as 
I can tell, the only code which uses this information are the 
*_dump_status routines (ide_, idedisk_, and (only in 2.4) taskfile_) 
which put the error info in the syslog.  Anyone else who wants to read 
the LBA that the error occurred on will be accessing the drive registers 
after these functions have run.

The problem is, these routines assume no one else looks at the registers 
and leaves them pointed to the high 24 bits of the 48 bit address.  I 
think the kernel should leave the registers in a known state.

The following patches restore the drive register access to a known state 
(the low order bits of the LBA) following status dumps.  The  patches 
are based on 2.4.26 and 2.6.7 respectively and apply cleanly to 
2.4.27-rc5 and 2.6.8-rc3.

I previously sent a version of this patch to the IDE list, please ignore 
that one as it was rushed, incomplete, and had a mistake.

I considered several alternatives to the patch I'm submitting:
1) whether ide_read_24 should take an argument (low/high) that would 
access the desired bits and clean up after itself
2) whether all readers of the LBA register should point to the desired 
bits before reading the LBA

...but I think this patched implementation may be more acceptable.  If 
not, please advise and I will code either alternative.

I have one question on the ide-taskfile.c patch for 2.4 below: should 
drive->ctl be OR'ed with 0x80 when setting the high order LBA access 
bit?  As you can see, it wasn't previously but this seems at risk of 
losing the nIEN bit.  It may be a non-issue though because I don't think 
taskfile_dump_status is used.


Thank you!
Brett


2.4============================================
--- linux-2.4.26/drivers/ide/ide-disk.c Fri Nov 28 13:26:20 2003
+++ linux/drivers/ide/ide-disk.c        Thu Aug  5 11:25:58 2004
@@ -857,6 +857,9 @@
                                 low = idedisk_read_24(drive);
                                 hwif->OUTB(drive->ctl|0x80, 
IDE_CONTROL_REG);
                                 high = idedisk_read_24(drive);
+                               /* Restore access to low order LBA */
+                               hwif->OUTB(drive->ctl & ~0x80,
+                                          IDE_CONTROL_REG);
                                 sectors = ((__u64)high << 24) | low;
                                 printk(", LBAsect=%llu, high=%d, low=%d",
                                        (unsigned long long) sectors,
--- linux-2.4.26/drivers/ide/ide.c      Wed Feb 18 08:36:31 2004
+++ linux/drivers/ide/ide.c     Thu Aug  5 11:37:04 2004
@@ -407,8 +407,12 @@
                                         u64 sectors = 0;
                                         u32 high = 0;
                                         u32 low = read_24(drive);
-                                       hwif->OUTB(drive->ctl|0x80, 
IDE_CONTROL_REG);
+                                       hwif->OUTB(drive->ctl | 0x80,
+                                                  IDE_CONTROL_REG);
                                         high = read_24(drive);
+                                       /* Restore access to low order 
LBA */
+                                       hwif->OUTB(drive->ctl & ~0x80,
+                                                  IDE_CONTROL_REG);

                                         sectors = ((u64)high << 24) | low;
                                         printk(", LBAsect=%llu, 
high=%d, low=%d",
--- linux-2.4.26/drivers/ide/ide-taskfile.c     Fri Jun 13 10:51:33 2003
+++ linux/drivers/ide/ide-taskfile.c    Thu Aug  5 11:27:59 2004
@@ -308,8 +308,11 @@
                                 u64 sectors = 0;
                                 u32 high = 0;
                                 u32 low = task_read_24(drive);
-                               hwif->OUTB(0x80, IDE_CONTROL_REG);
+                               hwif->OUTB(drive->ctl | 0x80, 
IDE_CONTROL_REG);
                                 high = task_read_24(drive);
+                               /* Restore access to low order LBA */
+                               hwif->OUTB(drive->ctl & ~0x80,
+                                          IDE_CONTROL_REG);
                                 sectors = ((u64)high << 24) | low;
                                 printk(", LBAsect=%lld", sectors);
                         } else {


2.6============================================
--- linux-2.6.7/drivers/ide/ide.c       Wed Jun 16 01:19:03 2004
+++ linux/drivers/ide/ide.c     Thu Aug  5 11:09:25 2004
@@ -409,6 +409,9 @@
                                         u32 low = ide_read_24(drive);
                                         hwif->OUTB(drive->ctl|0x80, 
IDE_CONTROL_REG);
                                         high = ide_read_24(drive);
+                                       /* Restore access to low order 
LBA */
+                                       hwif->OUTB(drive->ctl & ~0x80,
+                                                  IDE_CONTROL_REG);

                                         sectors = ((u64)high << 24) | low;
                                         printk(", LBAsect=%llu, 
high=%d, low=%d",
--- linux-2.6.7/drivers/ide/ide-disk.c  Wed Jun 16 01:19:17 2004
+++ linux/drivers/ide/ide-disk.c        Thu Aug  5 11:10:28 2004
@@ -675,6 +675,9 @@
                                 low = ide_read_24(drive);
                                 hwif->OUTB(drive->ctl|0x80, 
IDE_CONTROL_REG);
                                 high = ide_read_24(drive);
+                               /* Restore access to low order LBA */
+                               hwif->OUTB(drive->ctl & ~0x80,
+                                          IDE_CONTROL_REG);
                                 sectors = ((__u64)high << 24) | low;
                                 printk(", LBAsect=%llu, high=%d, low=%d",
                                        (unsigned long long) sectors,
