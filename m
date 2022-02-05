Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3372FC433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 20:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381291AbiBEUei (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:34:38 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:60644 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349887AbiBEUei (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 15:34:38 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 4842B2096DBA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH v4 1/3] pata_artop: eliminate local variable in artop_init_one()
Date:   Sat, 5 Feb 2022 23:34:32 +0300
Message-ID: <20220205203434.15339-2-s.shtylyov@omp.ru>
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

The 'io' local variable isn't actually necessary in the inner block of
artop_init_one() -- removing it will allow to simplify a follow-up patch...

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes in version 4:
- new patch.

 drivers/ata/pata_artop.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index ad3c5808aaad..b734cafb8783 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -28,7 +28,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.6"
+#define DRV_VERSION	"0.4.7"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -398,11 +398,9 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[0] = &info_6210;
 	else if (id->driver_data == 1)	/* 6260 */
 		ppi[0] = &info_626x;
-	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
-		unsigned long io = pci_resource_start(pdev, 4);
-
+	else if (id->driver_data == 2) { /* 6280 or 6280 + fast */
 		ppi[0] = &info_628x;
-		if (inb(io) & 0x10)
+		if (inb(pci_resource_start(pdev, 4)) & 0x10)
 			ppi[0] = &info_628x_fast;
 	}
 
-- 
2.26.3

