Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE79C433E2
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FC9207DA
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="cFWcyXqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgGSG7w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:52 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgGSG7v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5cVZ/GAyP5PTRYQ2KmqEeYuQyyJ3ZTMGhLA+K/R9PEmCMjlc6mza4q0hiYAtPC3IQxAbWTKlqV5bNCftWuaEHgXaovSL0mwSTJc/nHoBSORJ7NnzVr09yOtmdF5g3gbnLXZmyLg4Htyv4yAvVxqi91AJegd50fOxpMKQ7VVnRQO47I+wKz5aq+o6ZHkIYphzYBShtVqGE9drk0JfRfKLiL0/xObm0KYoLLnDGhpU78GzzqmpgIZDcgVKVJklTh6eDYpldZPzIMpc08HZP18VdpAcWpdnRGKfBSit2UU9eFBpinJrB0Eck7gGsWRjNr10ZEBCFgkh3FENb3vf04i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQXjikctgJcHuuPcRCgVm3kBFyL/4d/HT6S9MWWUAPk=;
 b=WmtAWpiU7l8d2WMbxSgJrM+BqLTXPJucOETQ4WE2aLih/kWQHQP+9s4jOS9saLGxKMJ4U3bhRBdkLi9T1aXpbMnZkWgUlYNIsnxI7+w+evUz8UpTyTFlxQwHf+NDJgODK24LgR2TatX7Ts0K2SgxOzF+wDW0xqgSnMCqD4KN18rid03wL4JPzitW6IHiHx6M9W/o8OCLmp6/acKRChv0ZS6fdMUMO7jv+Mxfp4cxtr+8aKAmgw/QwkFR864qQxWTNdkfGFV0+bJh1k+ofs7Usbw/SfPX5mx1oLFt1wgZfM5s1w8zYVmpuf3m3xNfYukK6TLHN7D6bnZbLbb+YmWHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQXjikctgJcHuuPcRCgVm3kBFyL/4d/HT6S9MWWUAPk=;
 b=cFWcyXqLm+ZcTOINLmSordS14aL/e3xTb4xHnm4H9tGd5DBtmhqIG9ditFLgGo4nHHgZsnkY7gX5VVagozyUMDi4fSf3lhymsUFGW5s/9LKdNVSCX0HngdcaQqU+hXR/4Q8T30eCnYtRjRrl7uwcMKHwuzeVrIimLcKwGPTRAIM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM4PR05MB3396.eurprd05.prod.outlook.com
 (2603:10a6:205:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sun, 19 Jul
 2020 06:59:47 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:47 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 3/7] ata: ahci: mvebu: Add support for A8k legacy DT bindings
Date:   Sun, 19 Jul 2020 08:59:38 +0200
Message-Id: <20200719065942.24693-4-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200719065942.24693-1-sven.auhagen@voleatech.de>
References: <20200719065942.24693-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:46 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd099ad-6f4f-41d2-1802-08d82bb152d0
X-MS-TrafficTypeDiagnostic: AM4PR05MB3396:
X-Microsoft-Antispam-PRVS: <AM4PR05MB339672FCB906040B62E22AAEEF7A0@AM4PR05MB3396.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TgohRx/sK1c0sNEqIMPZ+H9sRQf1Tb0k5LY8zG7sBGkh5ar3VKOQmN7vTjxRSjNIdHTmRU0xrid38nZSePhQPy/nfo9zKRLP6eQeb+0QOOAYyYh3brBnWl/vC6mxWjcdPIptPLquZ4toOInCVyPsBALdqfnuUb8Bu0i5RzLNhlsuETPrKMuVrAiSJm3UDMMrBs+w5C/za3g01ynvaALHH3nqSB7PMuXsazm7Gp+RyGgoBCvjHrYli6hhKOs5tW/T/XW+vwCgCN8jzaFLjEVVeaF8JUXLvpWY/xNZ4c7BfmhpzrCf/gJqOBK6FEQI4ATnNtRya0ovEFZAZqYndig6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(396003)(39830400003)(136003)(36756003)(316002)(5660300002)(2906002)(6666004)(6486002)(7416002)(66556008)(508600001)(6916009)(83380400001)(8676002)(66476007)(30864003)(8936002)(6506007)(956004)(1076003)(4326008)(2616005)(26005)(16526019)(86362001)(9686003)(6512007)(186003)(66946007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Yby8SaHjs0IXx/tw1ZuBtVim2E8o3fSVNrjuvavIRrEcT1me2jOaQuQ/fxTqHefa+FnX4ue/g+FGsP7EU1f/k+4S7/8cZh6RdShquJGP8kensH8rKgahi5eC8Xqe0z9QrO1fl95Kv4QjBypM62/Tj8z889h0vPDybqVf5Og5+GcXUSDze43xWEX6rGutrhW0nyln5OVtQsZokmVtmi4hmqd5ovIVRvCmH8Wgdfd/NQD7bormmy7kKRipWjlFg7zJKoEOEOFcKgZ/5gT2bnrjV6GpE1qYezPlqFkSpmmB72A/hUDxIl6XG3to/jix6VoTtZteqACuRqPS1xxCEGZFUdeaX0BJDlcEbZtVfqmVyy27TtRcLoAdoN9oFSRv9wya9CzBqC0/A1Avs//jbqWRqKoN/GJuthY1f9iBBM7h0R64Xumkr27A+TFiSfgt2xz2lKLL3Tv5wdVXbP5fpl278+iWkLkbxoc970cj9y2avS31nuYYMlMy4Wxfi1rdPuPZ
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd099ad-6f4f-41d2-1802-08d82bb152d0
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:47.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDprDv/qfkbtHWGnucFA+rOOXlusRejvE2/NeYnq3XjxMDgsRvkIhJVxWbWpvvL2C18pf16TmVuk+J4MmSdYISlIbfN+MyiyNAASxDqJGcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3396
Sender: linux-ide-owner@vger.kernel.org
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
2.24.3 (Apple Git-128)

