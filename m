From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Fix error handling for drives which clear the FIFO on error
Date: Mon, 26 Jun 2006 14:54:08 +0100
Message-ID: <1151330048.27147.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751156AbWFZNiE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 09:38:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

If the controller FIFO cleared automatically on error we must not try
and drain it as this will hang some chips.

Signed-off-by: Alan Cox <alan@redhat.com>

Based in concept on a broken patch from -mm some while back


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/ide-io.c linux-2.6.17/drivers/ide/ide-io.c
--- linux.vanilla-2.6.17/drivers/ide/ide-io.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/ide-io.c	2006-06-26 13:49:56.377579264 +0100
@@ -444,7 +444,7 @@
 		}
 	}
 
-	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
+	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ && hwif->err_stops_fifo == 0)
 		try_to_flush_leftover_data(drive);
 
 	if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/include/linux/ide.h linux-2.6.17/include/linux/ide.h
--- linux.vanilla-2.6.17/include/linux/ide.h	2006-06-19 17:29:50.000000000 +0100
+++ linux-2.6.17/include/linux/ide.h	2006-06-26 13:50:53.218938064 +0100
@@ -793,6 +793,7 @@
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
+	unsigned	err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
 
 	struct device	gendev;
 	struct completion gendev_rel_comp; /* To deal with device release() */

