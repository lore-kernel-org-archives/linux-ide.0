Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8951DC47095
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BFF21927
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="NvSZqCXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgJGPqP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:15 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:61507
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbgJGPqJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buDUQ+cHyqXl+IJvMYKhMRZLK+ZPhgbyk5OMsNSvGn0Z1h1uBgzhGlRYPv/t1p2H3OjuwXTNl6RgffZpYSs8U66GzXmvihSOakGKflUBxdHKdYJ+8OYskl0KWLkR3JzdGK+yA19g54jETmhPWitlT9lZFERkzX3gOSHS7SI4mwSlD28NDuu+7SNn/uNSNG3UQINRrAZvyd4R1/WD2KG6CVgkKS4Es0TJlDzlzq+Tw8V2DHZcbC3gRPud2Pg+cM1VEQSI+3rFbb2sSVL01LOeVxCAdDZYU1KHWv8GxTZenKt0Qth20DeCKHZK/risskKznFLs1fWft9HoMh4mdMgnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeEp7BQWKU6MbeWTQRG8EuOUvawQ3v7QwTu8wiEiKkQ=;
 b=aQs5Ij8V88nVP+ZexM2TPpAs7E1OEd3kpLAxj0DpJPro/doXaD05DjcPiVWuObVf51YT/yTul4yV6Wv2XjdQuOjly5WW6OOJif3NvPMfCH0/I3fs9743/lpEO8eNoa6M2UdwSIFLtUmdKvKad/XnHLsWN+pV7Rg4zwgU76r/lf7yr+gQNZ2IPdGbDP3CWIviKrvXmW/3NKHF7MHFU7OTWT55oByr1koKUUE32fp9aRErLJY6tK0ns3fnmvXHpRt4UIIiRU+jXhcVSABckczC683BJbf0d1WNh2Tr+dV5u1lc+sNhFb8dK57w0k4HdHPvDyQLd2pT7M5Bo97DfB1C5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeEp7BQWKU6MbeWTQRG8EuOUvawQ3v7QwTu8wiEiKkQ=;
 b=NvSZqCXOXqqUV7oRg4cSoIyUwWHky4KzzK4kgjjKW7VVFHEEdpEImIFIY6LKP8sWO2AGRM3k0Mwt6PtUMSSAwXS6GKOY0wk/Lt/RyFMM4D7IyYB3F8ADtBEfibdr7eWPTY/VkEXFCzQiP7Hj+dp1BjM2pkbBf8dX27F6PscDUiM=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:46:00 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:46:00 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 3/7] ata: ahci: mvebu: Add support for A8k legacy DT bindings
Date:   Wed,  7 Oct 2020 17:45:50 +0200
Message-Id: <20201007154554.66650-4-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201007154554.66650-1-sven.auhagen@voleatech.de>
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a91ad0c-5c66-4d37-5666-08d86ad816cc
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB40185D5D81273AF1F39960D1EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlYJLMo8BOhZ0bb5m7Myh2vOCUgg2TxDknTfCFvr2n0e05w77YYwc/B2SNbLAhUiXju2t4BuWOL/15g23Cgw4emba5zA6jenzIYfjGYAutdbS9Crwn1r2QcWSzEOMP+iRqWRRTQTwjEYvEuw48X1dFm2M34xEzWOgh/KPm5Kzr+SS3VuW5WO4pT5qxmgAvQjxyPIqu/43ROg7GUj9Zk3j9+x0Ld0jEUAL0B90dqQH0vcHf0C7FQpoxhUYst9LQPDjn0AlUejg7s8uRlajNXLvpe1wf1l9UlRizmSd8OV1ZO23PZgAuoBg+KcqizkXBOVkZ20zI1c96bDk7xBR+US/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(30864003)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MWXrW09F/IQUzpkumraXBN3TeCumLSvmbaBtb99aKIpU+vGDegnvYobERtiKonZzgHGgRtje8Uzu9qI+vFlXTKCU/zDLFhfJiJkOWc0Vo6u1tmFNybsN0rQgKDIz5w0NrJnUInwb/VAy/KwEgnwtJ6oBNL6oz7VquYEDyeDPXTxPIMrmn11pGtwhkG7VCJbI51aUHjpNbCnM/NuVNLYGKTS9i6rmhrWscYPKFCB3Ip9XSobAZWQDGlhhXJDcq3oCe3Tl9QHAhCTuydSlc/bpSKFNgW2uEsUWAk/fMd7Djje0PTPs3IaOV3ueIIRshQrhSuSdIa5nK51l6+rLBswcRXKZ1aU7RgQKYHuOX8tVS8tpoe8EYDg6vg3dvWTJy5UwC+/lE1bW7oRBNGd+c84iUvc8ZC40GGo6Q2RH8nIwEvcoGHV72K+0QUgMhTZDl41t7sGWJ8xc4fsQNJ1VhkhqxDOiS74OVz/DEHHLxR4IPi6CNiv1PhAYVdhxUmr8Ru5tm1xM9vhiOHIeBYcSVZUFkmQCX8YW6rW1wgtD+P6NJDlEUkKfIpxpM69klVL8RE7FGYuEMcW59vAIfipXJIPkKNRJZBx8TJo7ZqBa32RgB2v4rjaOfvs029kQy/+jY8ev098Z75Lg6aYkWKmPoxIvxw==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a91ad0c-5c66-4d37-5666-08d86ad816cc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:46:00.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP2s/CBUJAfv10wXMPOPLHjzB7R7c/oaRasCIAwl/yHi/Q78GuzkdoFUVXaU9Ey2x29haaaMfBxNBFXHsv7hPnF4OJcKPyZ8QZQmMYxysu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
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
 drivers/ata/ahci.h             |   3 +
 drivers/ata/ahci_mvebu.c       | 235 ++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c          |   3 +-
 drivers/ata/libahci_platform.c |   3 +
 include/linux/ahci_platform.h  |   1 +
 5 files changed, 239 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d991dd46e89c..8cb256eec86b 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -407,6 +407,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 		      unsigned long deadline, bool *online);
 
+void ahci_handle_port_interrupt(struct ata_port *ap,
+				       void __iomem *port_mmio, u32 status);
+
 unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 int ahci_stop_engine(struct ata_port *ap);
 void ahci_start_fis_rx(struct ata_port *ap);
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 1cdc126882eb..62e9b94e2bba 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -16,6 +16,7 @@
 #include <linux/mbus.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include "ahci.h"
 
@@ -28,9 +29,14 @@
 #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
 #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
 
+#define ICU_SATA0_ICU_ID 109
+#define ICU_SATA1_ICU_ID 107
+
 struct ahci_mvebu_plat_data {
 	int (*plat_config)(struct ahci_host_priv *hpriv);
 	unsigned int host_flags;
+	unsigned int resource_flags;
+	unsigned int port_irq[2];
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -96,6 +102,213 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
 	return 0;
 }
 
+static int ahci_get_per_port_irq_armada8k(struct ata_host *host, int port)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
+
+	return pdata->port_irq[port];
+}
+
+static irqreturn_t ahci_multi_irqs_intr_hard_armada8k(int irq, void *dev_instance)
+{
+	struct ata_port *ap = dev_instance;
+	struct ata_host *host = ap->host;
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	void __iomem *mmio = hpriv->mmio;
+	u32 status;
+
+	VPRINTK("ENTER\n");
+
+	status = readl(port_mmio + PORT_IRQ_STAT);
+	writel(status, port_mmio + PORT_IRQ_STAT);
+
+	spin_lock(ap->lock);
+	ahci_handle_port_interrupt(ap, port_mmio, status);
+	spin_unlock(ap->lock);
+
+	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_HANDLED;
+}
+
+static int ahci_host_activate_multi_irqs_armada8k(struct ata_host *host,
+					 struct scsi_host_template *sht)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	int i, rc;
+
+	rc = ata_host_start(host);
+	if (rc)
+		return rc;
+	/*
+	 * Requests IRQs one per port
+	 */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ahci_port_priv *pp = host->ports[i]->private_data;
+		int irq = hpriv->get_irq_vector(host, i);
+
+		/* Do not receive interrupts sent by dummy ports */
+		if (!pp) {
+			disable_irq(irq);
+			continue;
+		}
+
+		rc = devm_request_irq(host->dev, irq, ahci_multi_irqs_intr_hard_armada8k,
+				0, pp->irq_desc, host->ports[i]);
+
+		if (rc)
+			return rc;
+		ata_port_desc(host->ports[i], "irq %d", irq);
+	}
+
+	return ata_host_register(host, sht);
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
+
+	if (of_get_child_count(dev->of_node))
+		return 0;
+
+	pdata->port_irq[1] = irq_create_fwspec_mapping(&fwspec);
+	if (pdata->port_irq[1])
+		hpriv->mask_port_map = GENMASK(1, 0);
+
+	return 0;
+}
+
+static int ahci_platform_init_host_armada8k(struct platform_device *pdev,
+			    struct ahci_host_priv *hpriv,
+			    const struct ata_port_info *pi_template,
+			    struct scsi_host_template *sht)
+{
+	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
+	struct device *dev = &pdev->dev;
+	struct ata_port_info pi = *pi_template;
+	const struct ata_port_info *ppi[] = { &pi, NULL };
+	struct device_node *child;
+	struct ata_host *host;
+	int i, port_irq, n_ports, rc, child_nodes, port = 0;
+
+	/* Get IRQs per port */
+	child_nodes = of_get_child_count(dev->of_node);
+	if (child_nodes) {
+		for_each_child_of_node(dev->of_node, child) {
+
+			port_irq = of_irq_get(child, 0);
+			if (!port_irq)
+				port_irq = -EINVAL;
+			if (port_irq < 0) {
+				rc = port_irq;
+				return rc;
+			}
+
+			pdata->port_irq[port] = port_irq;
+			port++;
+		}
+	} else {
+		/* Backwards Compatibility Check */
+		port_irq = platform_get_irq(pdev, 0);
+		if (port_irq > 0) {
+			pdata->port_irq[0] = port_irq;
+			ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
+		} else {
+			dev_err(dev, "no irq\n");
+			return -EINVAL;
+		}
+	}
+
+	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
+
+	/* prepare host */
+	pi.private_data = (void *)(unsigned long)hpriv->flags;
+
+	ahci_save_initial_config(dev, hpriv);
+
+	if (hpriv->cap & HOST_CAP_NCQ)
+		pi.flags |= ATA_FLAG_NCQ;
+
+	if (hpriv->cap & HOST_CAP_PMP)
+		pi.flags |= ATA_FLAG_PMP;
+
+	ahci_set_em_messages(hpriv, &pi);
+
+	/* CAP.NP sometimes indicate the index of the last enabled
+	 * port, at other times, that of the last possible port, so
+	 * determining the maximum port number requires looking at
+	 * both CAP.NP and port_map.
+	 */
+	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
+
+	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
+	if (!host)
+		return -ENOMEM;
+
+	host->private_data = hpriv;
+
+	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
+		host->flags |= ATA_HOST_PARALLEL_SCAN;
+	else
+		dev_info(dev, "SSS flag set, parallel bus scan disabled\n");
+
+	if (pi.flags & ATA_FLAG_EM)
+		ahci_reset_em(host);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		ata_port_desc(ap, "mmio %pR",
+			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
+
+		/* set enclosure management message type */
+		if (ap->flags & ATA_FLAG_EM)
+			ap->em_message_type = hpriv->em_msg_type;
+
+		/* disabled/not-implemented port */
+		if (!(hpriv->port_map & (1 << i)))
+			ap->ops = &ata_dummy_port_ops;
+	}
+
+	if (hpriv->cap & HOST_CAP_64) {
+		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+		if (rc) {
+			rc = dma_coerce_mask_and_coherent(dev,
+							  DMA_BIT_MASK(32));
+			if (rc) {
+				dev_err(dev, "Failed to enable 64-bit DMA.\n");
+				return rc;
+			}
+			dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
+		}
+	}
+
+	rc = ahci_reset_controller(host);
+	if (rc)
+		return rc;
+
+	ahci_init_controller(host);
+	ahci_print_info(host, "platform");
+
+	return ahci_host_activate_multi_irqs_armada8k(host, sht);
+}
+
 static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
 {
 	return 0;
@@ -189,15 +402,22 @@ static struct scsi_host_template ahci_platform_sht = {
 
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
 
@@ -214,7 +434,11 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (rc)
 		goto disable_resources;
 
-	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
+	if (pdata->resource_flags & AHCI_PLATFORM_A8K_QUIRK)
+		rc = ahci_platform_init_host_armada8k(pdev, hpriv, &ahci_mvebu_port_info,
+				     &ahci_platform_sht);
+	else
+		rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
 				     &ahci_platform_sht);
 	if (rc)
 		goto disable_resources;
@@ -237,6 +461,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
 	.plat_config = ahci_mvebu_armada_8k_config,
+	.resource_flags = AHCI_PLATFORM_A8K_QUIRK,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f4cbed..0e6eaa2e03a9 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1799,7 +1799,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 		ata_port_abort(ap);
 }
 
-static void ahci_handle_port_interrupt(struct ata_port *ap,
+void ahci_handle_port_interrupt(struct ata_port *ap,
 				       void __iomem *port_mmio, u32 status)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
@@ -1882,6 +1882,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 		ata_port_freeze(ap);
 	}
 }
+EXPORT_SYMBOL_GPL(ahci_handle_port_interrupt);
 
 static void ahci_port_intr(struct ata_port *ap)
 {
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 129556fcf6be..21332a33f766 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -464,6 +464,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	if (!child_nodes)
 		hpriv->nports = 1;
 
+	if (!child_nodes && flags & AHCI_PLATFORM_A8K_QUIRK)
+		hpriv->nports = 2;
+
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
 		rc = -ENOMEM;
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 49e5383d4222..b31972e0bfbf 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -42,5 +42,6 @@ int ahci_platform_suspend(struct device *dev);
 int ahci_platform_resume(struct device *dev);
 
 #define AHCI_PLATFORM_GET_RESETS	0x01
+#define AHCI_PLATFORM_A8K_QUIRK		0x02
 
 #endif /* _AHCI_PLATFORM_H */
-- 
2.20.1

