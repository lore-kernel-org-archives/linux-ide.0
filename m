From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: kill ATA_HORKAGE_DMA_RW_ONLY
Date: Wed, 27 Jun 2007 02:49:38 +0900
Message-ID: <20070626174938.GT29122@htj.dyndns.org>
References: <20070626174735.GR29122@htj.dyndns.org> <20070626174843.GS29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:21123 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXFZRto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jun 2007 13:49:44 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1790409nzf
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2007 10:49:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070626174843.GS29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com

ATA_HORKAGE_DMA_RW_ONLY for TORiSAN is verified to be subset of using
DMA for ATAPI commands which aren't aligned to 16 bytes.  As libata
now doesn't use DMA for unaligned ATAPI commands, the horkage is
redundant.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
In case it wasn't clear.  The one before this one was 2/3 and all
three patches are against 2.6.22-rc5.  Thanks.

 drivers/ata/libata-core.c |    7 +------
 include/linux/libata.h    |    1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -2046,10 +2046,6 @@ int ata_dev_configure(struct ata_device 
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,
 					 dev->max_sectors);
 
-	/* limit ATAPI DMA to R/W commands only */
-	if (ata_device_blacklisted(dev) & ATA_HORKAGE_DMA_RW_ONLY)
-		dev->horkage |= ATA_HORKAGE_DMA_RW_ONLY;
-
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(dev);
 
@@ -3780,8 +3776,7 @@ static const struct ata_blacklist_entry 
 	{ "IOMEGA  ZIP 250       ATAPI", NULL,	ATA_HORKAGE_NODMA }, /* temporary fix */
 
 	/* Weird ATAPI devices */
-	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 |
-						ATA_HORKAGE_DMA_RW_ONLY },
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
 
 	/* Devices we expect to fail diagnostics */
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -298,7 +298,6 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
-	ATA_HORKAGE_DMA_RW_ONLY	= (1 << 4),	/* ATAPI DMA for RW only */
 };
 
 enum hsm_task_states {
