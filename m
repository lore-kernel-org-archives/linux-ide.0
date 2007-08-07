From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement BROKEN_HPA horkage and apply it to HDS724040KLSA80
Date: Tue, 7 Aug 2007 14:42:50 +0900
Message-ID: <20070807054250.GQ13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:48554 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbXHGFm7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 01:42:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1315220rvb
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 22:42:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
the drive.  If the horkage is set, all HPA operations are skipped.

While at it, make HPA test a bit more reliable by also checking
ata_id_has_hpa().

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Quel Qun <kelk1@comcast.net>
Cc: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
The drive worked fine before HPA support was added and thus this is a
regression fix.  Please consider for -stable.

Thanks.

 drivers/ata/libata-core.c |    4 +++-
 include/linux/libata.h    |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e78be..7158a06 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1911,7 +1911,8 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
-			if (ata_id_hpa_enabled(dev->id))
+			if (!(dev->horkage & ATA_HORKAGE_BROKEN_HPA) &&
+			    ata_id_has_hpa(id) && ata_id_hpa_enabled(dev->id))
 				dev->n_sectors = ata_hpa_resize(dev);
 
 			/* config NCQ */
@@ -3789,6 +3790,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
 	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
 	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },
+	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 
 	/* Devices with NCQ limits */
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 41978a5..a67bb90 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -303,6 +303,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 };
 
 enum hsm_task_states {
