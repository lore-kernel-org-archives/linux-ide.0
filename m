Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B0C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiBPVN1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:13:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiBPVN1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 16:13:27 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D122271FE
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 13:13:13 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2497320ACBA3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-sff: use *switch* statement in
 ata_sff_dev_classify()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <b4b1d7c1-b786-358f-154a-ba755a0814fb@omp.ru>
Date:   Thu, 17 Feb 2022 00:13:11 +0300
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

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/libata-sff.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -1841,8 +1841,8 @@ unsigned int ata_sff_dev_classify(struct
 
 	/* determine if device is ATA or ATAPI */
 	class = ata_port_classify(ap, &tf);
-
-	if (class == ATA_DEV_UNKNOWN) {
+	switch (class) {
+	case ATA_DEV_UNKNOWN:
 		/* If the device failed diagnostic, it's likely to
 		 * have reported incorrect device signature too.
 		 * Assume ATA device if the device seems present but
@@ -1853,10 +1853,12 @@ unsigned int ata_sff_dev_classify(struct
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
