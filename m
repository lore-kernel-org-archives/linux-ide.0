From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 11:51:05 -0300
Message-ID: <20070807115105.4f5cbc66@localhost>
References: <20070807054250.GQ13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:43574 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbXHGOvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 10:51:16 -0400
In-Reply-To: <20070807054250.GQ13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net

Em Tue, 7 Aug 2007 14:42:50 +0900
Tejun Heo <htejun@gmail.com> escreveu:

| HDS724040KLSA80 reports that it supports HPA && LBA48 but craps itself
| on READ_NATIVE_MAX_EXT.  Implement BROKEN_HPA horkage and apply it to
| the drive.  If the horkage is set, all HPA operations are skipped.
| 
| While at it, make HPA test a bit more reliable by also checking
| ata_id_has_hpa().

 Tejun, is the following patch ok for 2.6.22.1?

--- linux-2.6.22.orig/drivers/ata/libata-core.c
+++ linux-2.6.22/drivers/ata/libata-core.c
@@ -1939,7 +1939,8 @@ int ata_dev_configure(struct ata_device 
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
-			if (ata_id_hpa_enabled(dev->id))
+			if (!(dev->horkage & ATA_HORKAGE_BROKEN_HPA) &&
+			    ata_id_has_hpa(id) && ata_id_hpa_enabled(dev->id))
 				dev->n_sectors = ata_hpa_resize(dev);
 
 			/* config NCQ */
@@ -3800,6 +3801,7 @@ static const struct ata_blacklist_entry 
 	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
 	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
 	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "HDS724040KLSA80",    "KFAOA20N",     ATA_HORKAGE_BROKEN_HPA, },
 
 	/* Devices with NCQ limits */
 
--- linux-2.6.22.orig/include/linux/libata.h
+++ linux-2.6.22/include/linux/libata.h
@@ -298,6 +298,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 };
 
 enum hsm_task_states {


-- 
Luiz Fernando N. Capitulino
