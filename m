From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Allow translation setting to fail
Date: Wed, 8 Aug 2007 14:28:49 +0100
Message-ID: <20070808142849.7927173d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41084 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754940AbXHHNVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 09:21:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

On some early drives (pre ATA1) this feature is not supported. If it
fails then we know the drive geometry is the hardware geometry and the
one we tried to set anyway so just carry on.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
+++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-08-08 13:38:39.257549616 +0100
@@ -4081,6 +4170,11 @@
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	/* A clean abort indicates an original or just out of spec drive
+	   and we should continue as we issue the setup based on the
+	   drive reported working geometry */
+	if (err_mask == AC_ERR_DEV && (tf.feature & ATA_ABORTED))
+		err_mask &= ~AC_ERR_DEV;
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
