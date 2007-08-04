From: Tejun Heo <htejun@gmail.com>
Subject: Re: Boot fails on Intel SATA controller
Date: Sat, 04 Aug 2007 16:40:26 +0900
Message-ID: <46B42D6A.7030408@gmail.com>
References: <080320071730.15251.46B3662E0002B87600003B932207020853CE05040A05@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000304040806060206040107"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:45659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbXHDHl1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 03:41:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1093360wah
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 00:41:27 -0700 (PDT)
In-Reply-To: <080320071730.15251.46B3662E0002B87600003B932207020853CE05040A05@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Quel Qun <kelk1@comcast.net>
Cc: "Luiz Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>"linux-ide@vger.kernel.orgFernando N. Capitulino" <lcapitulino@mandriva.com.br>linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304040806060206040107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Please test the attached patch.

-- 
tejun

--------------000304040806060206040107
Content-Type: text/x-patch;
 name="horkage-hpa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="horkage-hpa.patch"

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
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
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

--------------000304040806060206040107--
