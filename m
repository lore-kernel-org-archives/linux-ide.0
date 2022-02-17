Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCCC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 17 Feb 2022 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiBQPiv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:38:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbiBQPiu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2022 10:38:50 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD302B2E0E
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2022 07:38:33 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 7AD4F206FFE3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <201f6b13-80a0-3906-7308-d1ef2d68ad04@omp.ru>
Date:   Thu, 17 Feb 2022 18:38:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In ata_sff_dev_classify(), replace a string of the *if* statements checking
the device's class with the *switch* statement that fits better here...

While at it, fix the multi-line comment style in the vicinity...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 2:
- fixed the multi-line comment style, updating the patch description.

 drivers/ata/libata-sff.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -1841,9 +1841,10 @@ unsigned int ata_sff_dev_classify(struct
 
 	/* determine if device is ATA or ATAPI */
 	class = ata_port_classify(ap, &tf);
-
-	if (class == ATA_DEV_UNKNOWN) {
-		/* If the device failed diagnostic, it's likely to
+	switch (class) {
+	case ATA_DEV_UNKNOWN:
+		/*
+		 * If the device failed diagnostic, it's likely to
 		 * have reported incorrect device signature too.
 		 * Assume ATA device if the device seems present but
 		 * device signature is invalid with diagnostic
@@ -1853,10 +1854,12 @@ unsigned int ata_sff_dev_classify(struct
 			class = ATA_DEV_ATA;
 		else
 			class = ATA_DEV_NONE;
-	} else if ((class == ATA_DEV_ATA) &&
-		   (ap->ops->sff_check_status(ap) == 0))
-		class = ATA_DEV_NONE;
-
+		break;
+	case ATA_DEV_ATA:
+		if (ap->ops->sff_check_status(ap) == 0)
+			class = ATA_DEV_NONE;
+		break;
+	}
 	return class;
 }
 EXPORT_SYMBOL_GPL(ata_sff_dev_classify);
