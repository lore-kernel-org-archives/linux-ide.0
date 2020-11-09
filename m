Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C09BC5517A
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368EB20578
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="SYAC1xIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgKIRkK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:40:10 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:23136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730330AbgKIRkH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtjOfVs9E0eqlEBDFacfNosgtTi4Zu96DvQh46oBGYLXBPPueZKC8vm49TB9+iT2NeiIiCr8T0RUPh6vqydq3dUKcY5QOLbmsV9BJsEF/pWf2A/l4XTAKYmadnM/KSGCT2ZAZ5xOOguKPvCqvCnFcVQQcrN7Yjw/MAlgZ08fMZxJ9bE+OrqUCFlAvqryeKriMyIor7+iKD4sYngbrjgcKpUgsLRldDfDHGL2yEwD0BeJKhSw05ePbBiVRg9jNa7IkjQW58oMDfURU1iY4xZwsWL+HeuBrMw2Ur46ZzoaoReBH8YAB5cC9us2+tKLtDcQzrynTKL4vkJNbNU2+UtJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CHcKuKatSud0NFvZeuFmYcZ5VsPde/jOR2AAQk82eI=;
 b=TaYAugtIxAE+L0U3ZUmhojvjr4diZhgyaix7aBHlYKu+zWSfT2Rjwd4i60V7SeV+C2LBaucDjaClHyKLiMQJv1H3wyp7A10OXZecFggEaqnvegfB9X9nm96XoKreXkI32xKF71TSgPw7obcVwos62tX6r/VOUB1NeRh/vxro29HxR4Mqvj6wAgmwf/omz90pqNtHHq1p9Pawyk0lwqHr2EJj1bKVDpyCM6V3WqjBhg+veTcQkufDYoXPsUenWVZJNaN7O4VfOAjSlTk3dXK9sk8uuF0IssYD8zg5EeLzUYiSix8H4fH5fUWu/RS/bDK56avF3rAaLS67OdyoHuHmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CHcKuKatSud0NFvZeuFmYcZ5VsPde/jOR2AAQk82eI=;
 b=SYAC1xIy3EWmQ3s7468AF6iZXo8LCZGM9NymX5EgVUxCPMw4VrCY1uBi6WIpV39t3fcipyNn/fnE7oh0zNjbon3emsfxVaMgqSmzCufvDUuXxnDf6ReQ8yumgnCtTTYWLKQx2XBdCd//Jj43fsGML6RQg5hTle5OFah65q5wwv4=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR05MB5362.eurprd05.prod.outlook.com (2603:10a6:208:ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 17:39:55 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 17:39:55 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 5/9] ata: ahci: mvebu: Add support for A8k legacy DT bindings
Date:   Mon,  9 Nov 2020 18:39:44 +0100
Message-Id: <20201109173948.96663-6-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201109173948.96663-1-sven.auhagen@voleatech.de>
References: <20201109173948.96663-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:208:55::40) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.193.235.168) by AM0PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:39:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 813c5723-ab40-4614-6299-08d884d67872
X-MS-TrafficTypeDiagnostic: AM0PR05MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR05MB5362E526A89492738F444882EFEA0@AM0PR05MB5362.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diPOihkb/b/Hi4pl9h0L6MjYeKCm32HkngbmBurQZJpMm9glMd7T7Zhe85aplFitvycsdejPK5lzesMwwwbOSFk5Ek5s5lASWTYD33sSA+aszVX6VcIIRh34UMBxvrG2k8RE3Oye/EsTB0/f9Lw/gKrCR57Vl7X8HxI6vXOID0fERATTAG27uN8BCaU7uCBkdO8jLf++DAbRPqcC2zh5DJYX4GAOb0c0l70UArOtCQ+rzmAe3l6v1e2J6t5CQHCBKSYfQBwEjPQn3C5+yUtGHp390vc40QuGICy6G5QGp3W1lZX4XmC8dv0SBfrMpikJgXXIR2TyiJ203+tjc3FrNh95nt8olqViZV+UJI/hVSPJw6mWQn7mV41ByTJ08LiF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(52116002)(69590400008)(66946007)(5660300002)(1076003)(66476007)(66556008)(26005)(2906002)(478600001)(316002)(9686003)(6506007)(6512007)(86362001)(6666004)(16526019)(8936002)(956004)(4326008)(36756003)(7416002)(186003)(83380400001)(2616005)(8676002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5iJJNd+do9HMCSmAw0cDQf0swi4SVQG4v1tjA6DsAZUdazAmxzlkzksVlYkeKjvusn5wKOObgmfGBvXVumyorZmNpReF/nFF/xT9P/OF98tw6IuU/x/xt0gxCTj4RnYseFKErxp6PX24YjNNUnc466QSuwpU31VgrCezjigYVoNFwYJetHydBsxTK3QTDLcwKFUfYHjE9h8zxRwRTjOCM4iNYwCNLzf6FC9y/8T7WBDVPEv5glf+In0ELjtaH/33vkraAs0XBMUzjVrGu7tsCBMUK/s3AiXqtEK4vDCQx/mcOP8GdCgHSIfM2L1Tb4K0xFMc6eqDtUj2ytvLTkRvw2kpgv/QUQlHt4pUnyEb9UayPwIsd3qOonsuvG0ORkR4FrmC8byT5ctW/OtZYbvqfdfmHGmMHPu56EhY/7IQKb1eORzJuU9K9Wr1qv1W0iqzPf1f3HfJ6XpHDQPLAlbALpTpaUi/cxqR5YIbjPvzfudsb+xc5C8k3JMLDNQNzrznDs33NASiqr43wtn2eL8+aR/Ru9jLdFXp9xW6DIsMuIX/Gu6nz52gYePfbb6BFMA1C6QUHFsHxatK2o0HZYjvuDP6qWXJ2vLmCkhvEKEmAz2Dyrfvxj/4ejKOqW2hEb/wiObEXHu8e1H5nWrJI3LD8Q==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 813c5723-ab40-4614-6299-08d884d67872
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:39:55.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uySlKmFQ+wes5QGCiRnoq+sYnWXYJh2E0yola1AUoKRvEUZPCh7lEnqYV/rQnb80ZzZlFW6fpwTtwC8V3U/dXx5k6VxLQvhZIXI3I4C95ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5362
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

