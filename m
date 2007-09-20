From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Add a horkage entry for DRQ mishandling (atapi
 tapes)
Date: Thu, 20 Sep 2007 15:27:51 +0100
Message-ID: <20070920152751.6b707705@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44161 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752410AbXITOVZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 10:21:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

This will allow us to handle the tape drive problems Mark Lord reported

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/include/linux/libata.h linux-2.6.23rc6-mm1/include/linux/libata.h
--- linux.vanilla-2.6.23rc6-mm1/include/linux/libata.h	2007-09-18 15:33:00.000000000 +0100
+++ linux-2.6.23rc6-mm1/include/linux/libata.h	2007-09-19 21:27:34.959820184 +0100
@@ -316,6 +316,7 @@
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 	ATA_HORKAGE_HPA_SIZE	= (1 << 5), 	/* Reports native size off by one */
+	ATA_HORKAGE_DRQ		= (1 << 6),	/* Device forgets to clear DRQ on error */
 
 	/* DMA mask for user DMA control: User visible values do not
 	   renumber */
diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-core.c linux-2.6.23rc6-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-core.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/libata-core.c	2007-09-19 21:49:11.808669192 +0100
@@ -5099,8 +5151,13 @@
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
 					"error, dev_stat 0x%X\n", status);
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
+
+			/* Some tape drives muck this up so don't explode
+			   in those cases */
+			if (!(qc->dev->horkage & ATA_HORKAGE_DRQ)) {
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
 			goto fsm_start;
 		}
 
