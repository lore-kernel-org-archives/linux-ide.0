Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8BC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 20:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiBIUZl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:25:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBIUZk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 15:25:40 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AFE01117E
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 12:25:40 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 3FC33209AD9B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v5 1/2] ata: pata_artop: use *switch* in artop_init_one()
Date:   Wed, 9 Feb 2022 23:25:34 +0300
Message-ID: <20220209202535.7679-2-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220209202535.7679-1-s.shtylyov@omp.ru>
References: <20220209202535.7679-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This driver uses a string of the *if* statements in artop_init_one()
where the *switch* statement would fit better.  While fixing this,
refactor the 6280 code to e.g. avoid a compound statement inside
the *case* section...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 5:
- merged in the former patch #1;
- fixed up #define DRV_VERSION;
- added *else* branch to the *if* statement;
- updated and reformatted the patch description;
- added "ata: " prefix to the patch subject.

Changes in version 4:
- fixed up #define DRV_VERSION;
- expanded the patch description.

Changes in version 3:
- fixed up the patch subject.

Changes in version 2:
- updated #define DRV_VERSION.

 drivers/ata/pata_artop.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ad3c5808aaad..08e88403d0ab 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -28,7 +28,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.6"
+#define DRV_VERSION	"0.4.7"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -394,16 +394,19 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	if (id->driver_data == 0)	/* 6210 variant */
+	switch (id->driver_data) {
+	case 0:		/* 6210 variant */
 		ppi[0] = &info_6210;
-	else if (id->driver_data == 1)	/* 6260 */
+		break;
+	case 1:		/* 6260 */
 		ppi[0] = &info_626x;
-	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
-		unsigned long io = pci_resource_start(pdev, 4);
-
-		ppi[0] = &info_628x;
-		if (inb(io) & 0x10)
+		break;
+	case 2:		/* 6280 or 6280 + fast */
+		if (inb(pci_resource_start(pdev, 4)) & 0x10)
 			ppi[0] = &info_628x_fast;
+		else
+			ppi[0] = &info_628x;
+		break;
 	}
 
 	BUG_ON(ppi[0] == NULL);
-- 
2.26.3

