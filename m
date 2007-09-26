From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fix HPA handling regression
Date: Wed, 26 Sep 2007 18:02:22 +0100
Message-ID: <20070926180222.10a96afe@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57237 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754150AbXIZQ4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 12:56:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org, jeff@garzik.org

Restore the support for handling drives that report one sector too many
(ie SCSI not ATA style). This worked before the HPA update but was
removed in that process

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-core.c linux-2.6.23rc8-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23rc8-mm1/drivers/ata/libata-core.c	2007-09-26 16:46:48.515293608 +0100
+++ linux-2.6.23rc8-mm1/drivers/ata/libata-core.c	2007-09-26 17:02:06.530734048 +0100
@@ -921,7 +921,8 @@
 		*max_sectors = ata_tf_to_lba48(&tf);
 	else
 		*max_sectors = ata_tf_to_lba(&tf);
-
+        if (dev->horkage & ATA_HORKAGE_HPA_SIZE)
+		(*max_sectors)--;
 	return 0;
 }
 
@@ -3957,6 +3958,10 @@
 	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_HORKAGE_BROKEN_HPA },
 
+	/* Devices which report 1 sector over size HPA */
+	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+
 	/* End Marker */
 	{ }
 };
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.23rc8-mm1/include/linux/libata.h linux-2.6.23rc8-mm1/include/linux/libata.h
--- linux.vanilla-2.6.23rc8-mm1/include/linux/libata.h	2007-09-26 16:46:57.844875296 +0100
+++ linux-2.6.23rc8-mm1/include/linux/libata.h	2007-09-26 17:11:56.215088400 +0100
@@ -315,7 +315,8 @@
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
-	ATA_HORKAGE_DRQ		= (1 << 5),	/* Device forgets to clear DRQ on error */
+	ATA_HORKAGE_HPA_SIZE	= (1 << 5), 	/* Reports native size off by one */
+	ATA_HORKAGE_DRQ		= (1 << 6),	/* Device forgets to clear DRQ on error */
 
 	/* DMA mask for user DMA control: User visible values do not
 	   renumber */
