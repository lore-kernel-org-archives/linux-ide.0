From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: implement BROKEN_HPA horkage and apply to affected drives
Date: Thu, 16 Aug 2007 03:07:21 +0900
Message-ID: <20070815180721.GF21623@htj.dyndns.org>
References: <20070815180508.GD21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:28908 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935108AbXHOSHh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:07:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so4082rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 11:07:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070815180508.GD21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Some drives choke on READ_NATIVE_MAX_ADDRESS[_EXT].  Implement
ATA_HORKAGE_BROKEN_HPA and apply it to affected drives.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
WDC drives are from bugzilla bug 8888.

 drivers/ata/libata-core.c |    6 +++++-
 include/linux/libata.h    |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -1911,7 +1911,8 @@ int ata_dev_configure(struct ata_device 
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
-			if (ata_id_hpa_enabled(dev->id))
+			if (!(dev->horkage & ATA_HORKAGE_BROKEN_HPA) &&
+			    ata_id_hpa_enabled(dev->id))
 				dev->n_sectors = ata_hpa_resize(dev);
 
 			/* config NCQ */
@@ -3789,6 +3790,9 @@ static const struct ata_blacklist_entry 
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
+	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
+	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
+	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
 
 	/* Devices with NCQ limits */
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -303,6 +303,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 };
 
 enum hsm_task_states {
