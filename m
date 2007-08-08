From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Note that our cache flush code needs fixing up
Date: Wed, 8 Aug 2007 14:30:31 +0100
Message-ID: <20070808143031.70aaf474@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41087 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757874AbXHHNW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:22:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Remembered this while doing auditing and code review versus the specs

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-08-08 13:38:39.257549616 +0100
@@ -5980,6 +6110,10 @@
 	else
 		cmd = ATA_CMD_FLUSH;
 
+	/* This is wrong. On a failed flush we get back the LBA of the lost
+	   sector and we should (assuming it wasn't aborted as unknown) issue
+	   a further flush command to continue the writeback until it 
+	   does not error */
 	err_mask = ata_do_simple_cmd(dev, cmd);
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
