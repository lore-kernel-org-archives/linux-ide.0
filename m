Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981BC433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381299AbiBEUeo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:34:44 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:34256 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381048AbiBEUei (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 15:34:38 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru E54CC207212C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v4 2/3] pata_artop: use *switch* in artop_init_one()
Date:   Sat, 5 Feb 2022 23:34:33 +0300
Message-ID: <20220205203434.15339-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220205203434.15339-1-s.shtylyov@omp.ru>
References: <20220205203434.15339-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This driver uses a string of the *if* statements in artop_init_one() where
the *switch* statement would fit better...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 4:
- fixed up #define DRV_VERSION;
- expanded the patch description.

Changes in version 3:
- fixed up the patch subject.

Changes in version 2:
- updated #define DRV_VERSION.

 drivers/ata/pata_artop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index b734cafb8783..d8c388da0c70 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -28,7 +28,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.7"
+#define DRV_VERSION	"0.4.8"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -394,14 +394,18 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
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
-	else if (id->driver_data == 2) { /* 6280 or 6280 + fast */
+		break;
+	case 2:		/* 6280 or 6280 + fast */
 		ppi[0] = &info_628x;
 		if (inb(pci_resource_start(pdev, 4)) & 0x10)
 			ppi[0] = &info_628x_fast;
+		break;
 	}
 
 	BUG_ON(ppi[0] == NULL);
-- 
2.26.3

