Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8445C5517A
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E4E221E2
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="JUq5h1Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgKDPxK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:53:10 -0500
Received: from mail-eopbgr10117.outbound.protection.outlook.com ([40.107.1.117]:28320
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731022AbgKDPw6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 4 Nov 2020 10:52:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVtDe0Krd0KWT59YT9i8yDdxxewZawmdhbLuGPSnckVb481CHDGXxibE5AZ5nGcy6/aiso7sUORYGOR9prnR9/ZMcOU5g5o1Xx7/66mAcfNm5A6VPqMv0ge7uSvuFv00RGOphcn0996CMit+HuXZ+VpoSGyOdJiCGTFY/lCoBbcnDYWpPMEA9MhcetwxFb+wOCQG6ysT/Sp406Ujo33i8zmQffWxHn24f0coktoMwnk+xy5DCLhKp13/saRXLSGhF6XDwp+UTBaPLves69Byn+Kx+pwPwI6ZQiKwZ25i1GTLg3dv1KiAl8zo9kp0biK48BJlRiqIhJsPdZ7jKU+aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CR56C2X115IWni2GuD3IcfSIEkIEHaMqH0RVZGOsPw=;
 b=WRqUZKaCHb0qGHTEKNkfaEdOOLzJh+KUGnGiukMyjyEvklsgFYNVtusEJJrtZ3EK2bBK0lFvONmhK7S6jsAEQJc0yrmVzvGxOMCmAWfua4wcNSNx5c0OxlGyjICBpmjsmEGUqqGuvKXH+D4zCm7KXvxiS2l4XaV+/hChzc3IKp0eTEPTSCQRhFDYoR3wgjx5NQN5IkrLXgXTCT/vemVxe7cxVpvFaGc1Fsdo4BJoZaBBrLOUGR4Jc+LyF1m1nZcSCEvj3BKgCuowfpjTga/af24A+SkP0FR2pEVlj3ait1W4D+Iko4JPEmR81u22PXbnbZd8vMXxhw1w9LpaB8+7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CR56C2X115IWni2GuD3IcfSIEkIEHaMqH0RVZGOsPw=;
 b=JUq5h1Zlodk5rRvqPBbhRUJDsfWEJ0g8FY+WCaAbT8ykoujVJT621tUP5GtfEJo5EThOeLpDKshImKMA+oIgUJqRuk90cj/RHcII0hQjCcB4qzGyQ/cSLajYpDmLGBptpB5gTztHw+LG8oX4fqwfQ2sOub8oQoREM+uA0F02qiM=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5075.eurprd05.prod.outlook.com (2603:10a6:208:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 15:52:45 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 15:52:45 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v2 5/9] ata: ahci: mvebu: Add support for A8k legacy DT bindings
Date:   Wed,  4 Nov 2020 16:52:33 +0100
Message-Id: <20201104155237.77772-6-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201104155237.77772-1-sven.auhagen@voleatech.de>
References: <20201104155237.77772-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 15:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b17d03-8b85-474b-13b1-08d880d9ab90
X-MS-TrafficTypeDiagnostic: AM0PR05MB5075:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5075E3923B4985D53844C42FEFEF0@AM0PR05MB5075.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhdDkQsalEfve1z2bs+cluwJ7J5Qdcr8l5NQLWSOgAXSgK2dadzuvSXqG0cBuvi/grFRaP07JHXpEQliQgF6Oc/DUAnEJe0axWHN+xBWa8NnK0EXiSH8NqbhazrBve/yEF7aO7k7L9E9mlY0CSNA2Zo93c2SONLY0cXdxDRAJDhdCyfzdFlbivVrc0t99Hc54YVrD4XEXUeWoq3SFbJmkjtytxabcE5K/pcf4QtH8ohC1PuHshP+HLFxQKyfwLjobDJkXP/6O/MhfpM0XXXJJGSNEajWkhIa9HvGLCUjfsc6aQEiWatZmN6qryt+kuIzTLllXcHAHUJKkfEyWYrvwx4LAcD6oBNAjo6olzP/TqWo5i5JSs8Mj+Er2bEmuE6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(376002)(136003)(396003)(366004)(8676002)(956004)(2906002)(52116002)(6666004)(316002)(4326008)(2616005)(5660300002)(8936002)(1076003)(6486002)(478600001)(66476007)(66556008)(6512007)(83380400001)(9686003)(66946007)(86362001)(186003)(36756003)(7416002)(16526019)(26005)(69590400008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: i0HrvPwj1gVYLEIJPpVO9og/8ECochnbyUBfUzxhkcmFJe0vxx12H7VXRTN0z1O5qqOaz/qIx0Y1Dd8ZDNKxow1OPVT+OBNs+5pb/oLbV9OyRR78uUtByP2j4EK1vu5BObCnDyoPT1+VSlfiJyFA+9pUw3IhykEmNF4KyBCFiHQz96eudwh2hWz9bt7e/KMocmXL5WNtKsMRLAA1HIPGP3F/tQ9QFW3Uf5GYH3wZrV8XhbRRR27AqyBPOcxvUkgcQeWvcvD7H18Tag2lGqcv71/gbz0/xoMYK2019+TAqLr3PI0XY/hyhAFQ1leJQpPdeg5qsG77wUrOjwTqwNolw4Y/8Hc8RijL5CLufSe2PA6VlZixDqIpdmM54Agev08o2Bf7CLw38trt4e5+xTqYm/pPYQRCM0WCwsQSRThnuD00XsAX3TwaJBd5S2h8dLpBBTC8QJiqOITsp8ieyImpJMe8KLvlT1ecThqHQ3cgh1nPWcwtL7AefBZEGWfDMiF/1Ch6O+trxJvNyJQn0Et8Oxy2n5HPM9g17vk25WMLZdVGX7ZW35VcZ6PA9mFChbBoMqnbilxjwKNrvymnbyDnbsZY8ZWUGu/lBZfwac1H7GMfhKKkwraMrpPS9Sjx0QTMZNHFuFyLQv0JXDnWL2c9Rg==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b17d03-8b85-474b-13b1-08d880d9ab90
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 15:52:44.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCFY8yA4gkr2Nnm9aAC7HPCvAVRRTqGus6qE9O+fk3K/KtvL3ZbRyBn8JtctCmBmwsp6vM5CIt7rGP/ZPRI3jOTvFXcQkQaCMmoUlD7weOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5075
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

The CP110 SATA unit has 2 ports, and a dedicated ICU entry per
port. In the past, the AHCI SATA driver only supported one interrupt
per SATA unit. To solve this conflict, the 2 SATA wired interrupts in
the South-Bridge got configured as 1 GIC interrupt in the
North-Bridge, regardless of the number of SATA ports actually
enabled/in use, and the DT bindings only referenced the interrupt of
one port.

Since then, this limitation has been addressed and this patch ensures
backward compatibility with old DTs not describing SATA ports
correctly directly from the AHCI MVEBU driver. This way, we will be
able to drop the hack from the ICU driver. IOW, when the A8k
compatible string is used and there is no sub-nodes in the DT, we
fake the creation and mapping of the second (missing) interrupt.

Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c       | 126 ++++++++++++++++++++++++++++++---
 drivers/ata/libahci_platform.c |   3 +
 include/linux/ahci_platform.h  |   1 +
 3 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index ed82381dc4a7..22447b1bb23f 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -16,6 +16,7 @@
 #include <linux/mbus.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include "ahci.h"
 
@@ -28,9 +29,15 @@
 #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
 #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
 
+#define ICU_SATA0_ICU_ID 109
+#define ICU_SATA1_ICU_ID 107
+
 struct ahci_mvebu_plat_data {
-	int (*plat_config)(struct ahci_host_priv *hpriv);
+	int (*plat_config)(struct platform_device *pdev,
+				   struct ahci_host_priv *hpriv);
 	unsigned int host_flags;
+	unsigned int resource_flags;
+	unsigned int port_irq[2];
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -67,7 +74,8 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
-static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
+static int ahci_mvebu_armada_380_config(struct platform_device *pdev,
+				   struct ahci_host_priv *hpriv)
 {
 	const struct mbus_dram_target_info *dram;
 	int rc = 0;
@@ -83,7 +91,8 @@ static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
 	return rc;
 }
 
-static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
+static int ahci_mvebu_armada_3700_config(struct platform_device *pdev,
+				   struct ahci_host_priv *hpriv)
 {
 	u32 reg;
 
@@ -96,8 +105,94 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
 	return 0;
 }
 
-static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
+static int multi_irq_host_ack_armada8k(int irq, struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+
+	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
+
+	return 0;
+}
+
+static int ahci_get_per_port_irq_armada8k(struct ata_host *host, int port)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
+
+	return pdata->port_irq[port];
+}
+
+static int ahci_mvebu_armada_8k_irq_backwards(struct ahci_host_priv *hpriv,
+				       struct device *dev)
+{
+	struct device_node *np = of_irq_find_parent(dev->of_node);
+	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
+	struct irq_data *irqd = irq_get_irq_data(pdata->port_irq[0]);
+	int host_irq = irqd ? irqd_to_hwirq(irqd) : 0;
+	int missing_irq = (host_irq == ICU_SATA1_ICU_ID) ?
+		ICU_SATA0_ICU_ID : ICU_SATA1_ICU_ID;
+	struct irq_fwspec fwspec = {
+		.fwnode = of_node_to_fwnode(np),
+		.param_count = 2,
+		.param = {missing_irq, IRQ_TYPE_LEVEL_HIGH},
+	};
+	int irq;
+
+	pdata->port_irq[1] = irq_create_fwspec_mapping(&fwspec);
+	hpriv->mask_port_map = GENMASK(1, 0);
+
+	if (missing_irq == ICU_SATA0_ICU_ID) {
+		irq = pdata->port_irq[0];
+		pdata->port_irq[0] = pdata->port_irq[1];
+		pdata->port_irq[1] = irq;
+	}
+
+	return 0;
+}
+
+static int ahci_mvebu_armada_8k_config(struct platform_device *pdev,
+				   struct ahci_host_priv *hpriv)
+{
+	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
+	struct device *dev = &pdev->dev;
+	struct device_node *child;
+	int port_irq, child_nodes, port = 0;
+
+	/* Get IRQs per port */
+	child_nodes = of_get_child_count(dev->of_node);
+	if (child_nodes) {
+		for_each_child_of_node(dev->of_node, child) {
+
+			port_irq = of_irq_get(child, 0);
+			if (!port_irq)
+				port_irq = -EINVAL;
+
+			if (port_irq < 0)
+				goto compat;
+
+			pdata->port_irq[port] = port_irq;
+			port++;
+		}
+
+		goto out;
+	}
+
+compat:
+	/* Backwards Compatibility Check */
+	port_irq = platform_get_irq(pdev, 0);
+	if (port_irq > 0) {
+		pdata->port_irq[0] = port_irq;
+		ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
+	} else {
+		dev_err(dev, "no irq\n");
+		return port_irq;
+	}
+
+out:
+	hpriv->flags |= AHCI_HFLAG_MULTI_MSI;
+	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
+
 	return 0;
 }
 
@@ -167,7 +262,7 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	pdata->plat_config(hpriv);
+	pdata->plat_config(pdev, hpriv);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -189,15 +284,22 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int ahci_mvebu_probe(struct platform_device *pdev)
 {
-	const struct ahci_mvebu_plat_data *pdata;
+	const struct ahci_mvebu_plat_data *pdata_plat;
+	struct ahci_mvebu_plat_data *pdata;
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	pdata = of_device_get_match_data(&pdev->dev);
-	if (!pdata)
+	pdata_plat = of_device_get_match_data(&pdev->dev);
+	if (!pdata_plat)
 		return -EINVAL;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	memcpy(pdata, pdata_plat, sizeof(*pdata));
+
+	hpriv = ahci_platform_get_resources(pdev, pdata->resource_flags);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
@@ -210,10 +312,13 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
-	rc = pdata->plat_config(hpriv);
+	rc = pdata->plat_config(pdev, hpriv);
 	if (rc)
 		goto disable_resources;
 
+	if (pdata->resource_flags & AHCI_PLATFORM_ARMADA8K_QUIRK)
+		hpriv->multi_irq_host_ack = multi_irq_host_ack_armada8k;
+
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
 				     &ahci_platform_sht);
 	if (rc)
@@ -237,6 +342,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
 	.plat_config = ahci_mvebu_armada_8k_config,
+	.resource_flags = AHCI_PLATFORM_ARMADA8K_QUIRK,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index f6f2a111d226..a5d06565a5c7 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -464,6 +464,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	if (!child_nodes)
 		hpriv->nports = 1;
 
+	if (!child_nodes && flags & AHCI_PLATFORM_ARMADA8K_QUIRK)
+		hpriv->nports = 2;
+
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
 		rc = -ENOMEM;
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 49e5383d4222..99ff30b6c37c 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -42,5 +42,6 @@ int ahci_platform_suspend(struct device *dev);
 int ahci_platform_resume(struct device *dev);
 
 #define AHCI_PLATFORM_GET_RESETS	0x01
+#define AHCI_PLATFORM_ARMADA8K_QUIRK	0x02
 
 #endif /* _AHCI_PLATFORM_H */
-- 
2.20.1

