From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH -mm 2/6] cpu_relax(): ide_wait_stat()
Date: Wed, 21 Jun 2006 22:59:42 +0200
Message-ID: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030282AbWFUU7p@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Add cpu_relax() to drivers/ide/ide-iops.c/ide_wait_stat().
Tiny whitespace fix.


Should be quite useful.

Tested on 2.6.17-mm1.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/drivers/ide/ide-iops.c linux-2.6.17-mm1.my/drivers/ide/ide-iops.c
--- linux-2.6.17-mm1.orig/drivers/ide/ide-iops.c	2006-06-21 14:28:16.000000000 +0200
+++ linux-2.6.17-mm1.my/drivers/ide/ide-iops.c	2006-06-21 22:00:02.000000000 +0200
@@ -542,7 +542,7 @@
 	u8 stat;
 	int i;
 	unsigned long flags;
- 
+
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
 		*startstop = ide_stopped;
@@ -554,6 +554,7 @@
 		local_irq_set(flags);
 		timeout += jiffies;
 		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
+			cpu_relax();
 			if (time_after(jiffies, timeout)) {
 				/*
 				 * One last read after the timeout in case
