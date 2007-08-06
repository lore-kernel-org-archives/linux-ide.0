From: kelk1@comcast.net (Quel Qun)
Subject: Re: Boot fails on Intel SATA controller
Date: Mon, 06 Aug 2007 19:17:32 +0000
Message-ID: <080620071917.2738.46B773CC000E495500000AB22207300793CE05040A05@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_2738_1186427852_0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:35818 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933871AbXHFTRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 15:17:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Luiz Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>"linux-ide@vger.kernel.orgFernando N. Capitulino" <lcapitulino@mandriva.com.br>linux-ide@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_2738_1186427852_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

The kernel compiles and boots after applying this patch to 2.6.23-rc1.
--
Eric

 -------------- Original message ----------------------
From: Tejun Heo <htejun@gmail.com>
> Please test the attached patch.
> 
> -- 
> tejun



--NextPart_Webmail_9m3u9jl4l_2738_1186427852_0
Content-Type: message/rfc822

From: Tejun Heo <htejun@gmail.com>
To: Quel Qun <kelk1@comcast.net>
Cc: "Luiz Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,  "linux-ide@vger.kernel.orgFernando N. Capitulino" <lcapitulino@mandriva.com.br>, linux-ide@vger.kernel.org
Subject: Re: Boot fails on Intel SATA controller
Date: Sat, 4 Aug 2007 07:41:12 +0000
Content-Type: Multipart/mixed;
 boundary="NextPart_Webmail_9m3u9jl4l_2738_1186427852_1"

--NextPart_Webmail_9m3u9jl4l_2738_1186427852_1
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

--NextPart_Webmail_9m3u9jl4l_2738_1186427852_1--

--NextPart_Webmail_9m3u9jl4l_2738_1186427852_0--
