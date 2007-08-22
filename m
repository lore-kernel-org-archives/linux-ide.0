From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Allow for original IDE drives that don't support
 geometry setting
Date: Wed, 22 Aug 2007 23:25:39 +0100
Message-ID: <20070822232539.3ddb82d3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44105 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758565AbXHVWRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 18:17:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org


This is mandatory for all early ATA devices but may fail on IDE. As we
try to set the geometry to the geometry we already have a failure of this
request is harmless. We can't skip the request as its mandatory during
setup and some older ATA drives pee themselves if you don't do it.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c linux-2.6.23rc3-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/libata-core.c	2007-08-22 18:17:31.321738376 +0100
@@ -4065,6 +4126,8 @@
  *	@heads: Number of heads (taskfile parameter)
  *	@sectors: Number of sectors (taskfile parameter)
  *
+ *	FIXME: Although mandatory on ATA1-4 it is not on original IDE
+ *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  *
@@ -4092,6 +4155,11 @@
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	/* A clean abort indicates an original or just out of spec drive
+	   and we should continue as we issue the setup based on the
+	   drive reported working geometry */
+	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
+		err_mask &= ~AC_ERR_DEV;
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
