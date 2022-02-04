Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51539C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 12:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355405AbiBDMUr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:20:47 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:49860 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbiBDMUr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 07:20:47 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru F027720EB6C6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] libata: use *switch* in artop_init_one()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <0d6a00e8-2c86-9b91-1869-0a91ae6aeab1@omp.ru>
Date:   Fri, 4 Feb 2022 15:20:42 +0300
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

This driver uses a string of the *if* statements where a *switch* statement
fits better...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/pata_artop.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

Index: libata/drivers/ata/pata_artop.c
===================================================================
--- libata.orig/drivers/ata/pata_artop.c
+++ libata/drivers/ata/pata_artop.c
@@ -394,16 +394,22 @@ static int artop_init_one (struct pci_de
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
+		break;
+	case 2:		/* 6280 or 6280 + fast */
+		{
+			unsigned long io = pci_resource_start(pdev, 4);
 
-		ppi[0] = &info_628x;
-		if (inb(io) & 0x10)
-			ppi[0] = &info_628x_fast;
+			ppi[0] = &info_628x;
+			if (inb(io) & 0x10)
+				ppi[0] = &info_628x_fast;
+		}
+		break;
 	}
 
 	BUG_ON(ppi[0] == NULL);
