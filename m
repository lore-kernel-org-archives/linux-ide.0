From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata: increase max-sectors to 256
Date: Sun, 11 Jun 2006 10:04:50 -0400
Message-ID: <20060611140450.GA28229@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:14056 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751588AbWFKOEw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 10:04:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Just checked this into 'max-sect' branch of libata-dev.git, and then
merged that into 'ALL' metabranch for -mm testing.

This touches all libata drivers, so another possibility for breakage...

It'll propagate to -mm next time Andrew does a pull, but I probably
won't push it (and sii-m15w) until 2.6.19, since there is so much stuff
queued already.

diff --git a/include/linux/ata.h b/include/linux/ata.h
index c494e1c..e40e7f2 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -40,6 +40,8 @@ enum {
 	ATA_MAX_DEVICES		= 2,	/* per bus/port */
 	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
 	ATA_SECT_SIZE		= 512,
+	ATA_MAX_SECTORS		= 256,
+	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 
 	ATA_ID_WORDS		= 256,
 	ATA_ID_SERNO_OFS	= 10,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 39e6b77..e80f25c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -111,8 +111,6 @@ enum {
 	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
 	ATA_MAX_QUEUE		= 32,
 	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
-	ATA_MAX_SECTORS		= 200,	/* FIXME */
-	ATA_MAX_SECTORS_LBA48	= 65535,
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
