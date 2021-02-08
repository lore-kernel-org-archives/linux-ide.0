Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72639C433E6
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321DB64EB1
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhBHSCj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:02:39 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:63123
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235263AbhBHSAX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 8 Feb 2021 13:00:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWLJ+9iKV4Pxk84alhSiByOub1BbAJQ0Tn5GIzfvPEEf2TAcp1YjgJNaIOYNf0aF9PCwrvYPNsUEAt5P1NfR9yKoFzqyV28dbbhZ0KpQfrD1cVgSE70JRtD5+2uvB/2tnQl3qx2zoohVVeNLnotiMMqMNoVBOiKVvdT08bshRyCXKjvOBdWvRo3mEs4ZFuzjmqKeGxG3VDx+8VRqf3uAE+qt/OcfxW++cbVibO5l7lDu0JFEXuLdfT0XyttMhkc3FiHMjhgJlfF71xIsaVPwAbDRHckpuF1xsfJCeXnuU8j2UbR+nj7w1Jsc0y969XRF+uw8XHTaLR8XlMg/spdgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzmHaL98YuO+6h4sq3/Ut0TfSlc5Yur/8LLAZ64I9Ac=;
 b=Lg+McZBbO5X/37k9696mbsUWCIUSh9BY3ynREE0ycfJ9/ISXdp+J42cWLSROJVgayM6OxXcBlZ/fU5pt4QE97bvmK3dUBqxGHSbzXsbQbEYfKUF/HM8dlnrLYApRWGl7Lj0SJiO66M32GPpjyHWZq2oeeogrFz2Kb/yKaf4Ej4SH82A/Ivv8DElEQE4B/JOr8zJG1y+VJ4v80s9R7skT94GC5cY5C6X7OfTNz4iVLNL7m4Ne8dGKzimXB8lCYNyhX6UTUQZlnPW78HTvDOmZaW6OxCMAUyKXUYd7lUSJ+b7laalgClXmJdj3V2hTqdWVjNW+euHYYuR4kHCAECV8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzmHaL98YuO+6h4sq3/Ut0TfSlc5Yur/8LLAZ64I9Ac=;
 b=WwZoIqT6MTeY9sKsazFi3LGV0R0eEH3jrBy8f6+si22gCK6SMmNGC3X24xvJI0CX80D+0euX/91nIs8a8tAa53QlzoeletikiAhMfFzBE+NPcvASx0uf+5tJ6ExJb78ixmJPSwpmqIARUO3yssnNFydrHBR6XuI6rh3Zw3oNPtA=
Received: from SA0PR12CA0008.namprd12.prod.outlook.com (2603:10b6:806:6f::13)
 by BYAPR02MB5320.namprd02.prod.outlook.com (2603:10b6:a03:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 17:59:29 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::32) by SA0PR12CA0008.outlook.office365.com
 (2603:10b6:806:6f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Mon, 8 Feb 2021 17:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 17:59:28 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 8 Feb 2021 09:59:09 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 8 Feb 2021 09:59:09 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 axboe@kernel.dk,
 p.zabel@pengutronix.de,
 robh+dt@kernel.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=55682 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1l9AoW-0001aF-8t; Mon, 08 Feb 2021 09:59:08 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>, <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V3 2/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Mon, 8 Feb 2021 23:33:56 +0530
Message-ID: <1612807436-5238-3-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
References: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5593cc0b-5369-4761-2676-08d8cc5b47b2
X-MS-TrafficTypeDiagnostic: BYAPR02MB5320:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5320BB6E7FCFC7B5C82FF518D48F9@BYAPR02MB5320.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljq+xcz4qUwBLZ4rY1ihYx6W6NsuDqEX8tie60rCfa3KsS/Z1WAcCHxpzNjBk7sQ2qhAJe4EWl4GC/E7Lwc0ACxuCZIbX1/mhBZTuAfVrd1WafV2Wp13wyooWCM9kM1ISOvIJD1exU2woi1Tr+rmsMEs0xFr3e3edoleWSyToU32ugo1g0zKtZJBWeqvrMKXYMQeYBb6HW+Ycsqz1RXaiZ3tI+5r0CBiRPKC8OdlQy6V9HEv0lZgAR7l6auIS92fghgbAS/2xqhlQE4RDHOH7M3kHugBhibBWoSD37Ov2It0NFeAhFRaW0s5BFpH6acG29QE9298Jlw7uxXw1P8nDbd2LEujW3zB5/bn56s7kIvvkI5AukbutVhf798vQ+kbJbZq8Oeecc/3uCHhboQgJn9A1dQAu6Ijs6ZhY4Hl5IbXk3EFm/PCvz7OFIImRgMhTjA8P9cujC8+h/6Ug63hCSL9eyjEBporSYBxRnZU1OS8reypLbErn2ioIeP64YpT7XCpI4XV+YdUxRoxOVP+rnr6dxPYXvIzeIuGzexR6W4P8uKtGDkg6OJvrEtApU7X3duxENwnIpC4jZh8TtMIOY6R+Gb4O6VnaZkeVbwwlTLwQxoSiwG8jFQ1eNNGr4U3iRbWf7xXSujwfDsjqUVwOajcRQT2zNfiu8vfpmIUICizV/fFL9wBiA4/XIQqaCwF
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(15650500001)(47076005)(316002)(82310400003)(336012)(70206006)(70586007)(8676002)(110136005)(186003)(36906005)(5660300002)(54906003)(107886003)(356005)(8936002)(36756003)(4326008)(2616005)(7636003)(478600001)(44832011)(26005)(6666004)(83380400001)(9786002)(426003)(36860700001)(7696005)(82740400003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 17:59:28.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5593cc0b-5369-4761-2676-08d8cc5b47b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5320
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SATA controller used in Xilinx ZynqMP platform uses xilinx GT phy
which has 4 GT lanes and can be used by 4 peripherals at a time.
SATA controller uses 1 GT phy lane among the 4 GT lanes. To configure
the GT lane for the SATA controller, the below sequence is expected.

1. Assert the SATA controller reset.
2. Configure the xilinx GT phy lane for SATA controller (phy_init).
3. De-assert the SATA controller reset.
4. Wait for PLL of the GT lane used by SATA to be locked (phy_power_on).

The ahci_platform_enable_resources() by default does the phy_init()
and phy_power_on() but the default sequence doesn't work with Xilinx
platforms. Because of this reason, updated the driver to support the
new sequence.

Added cevapriv->rst check, for backward compatibility with the older
sequence. If the reset controller is not available, then the SATA
controller will configure with the older sequences.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/ata/ahci_ceva.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b10fd4c..b980218 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 /* Vendor Specific Register Offsets */
@@ -87,6 +88,7 @@ struct ceva_ahci_priv {
 	u32 axicc;
 	bool is_cci_enabled;
 	int flags;
+	struct reset_control *rst;
 };
 
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
@@ -202,13 +204,48 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 	cevapriv->ahci_pdev = pdev;
 
+	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								  NULL);
+	if (IS_ERR(cevapriv->rst)) {
+		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get reset: %ld\n",
+				PTR_ERR(cevapriv->rst));
+	}
+
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	rc = ahci_platform_enable_resources(hpriv);
-	if (rc)
-		return rc;
+	if (!cevapriv->rst) {
+		rc = ahci_platform_enable_resources(hpriv);
+		if (rc)
+			return rc;
+	} else {
+		int i;
+
+		rc = ahci_platform_enable_clks(hpriv);
+		if (rc)
+			return rc;
+		/* Assert the controller reset */
+		reset_control_assert(cevapriv->rst);
+
+		for (i = 0; i < hpriv->nports; i++) {
+			rc = phy_init(hpriv->phys[i]);
+			if (rc)
+				return rc;
+		}
+
+		/* De-assert the controller reset */
+		reset_control_deassert(cevapriv->rst);
+
+		for (i = 0; i < hpriv->nports; i++) {
+			rc = phy_power_on(hpriv->phys[i]);
+			if (rc) {
+				phy_exit(hpriv->phys[i]);
+				return rc;
+			}
+		}
+	}
 
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
-- 
2.7.4

