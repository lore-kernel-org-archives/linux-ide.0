From: Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH 2/3] ahci: qoriq: Disable NCQ on ls2080a SoC
Date: Thu, 29 Oct 2015 14:22:16 +0800
Message-ID: <1446099737-41854-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:35664
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbbJ2GcH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Oct 2015 02:32:07 -0400
In-Reply-To: <1446099737-41854-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hdegoede@redhat.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@freescale.com>

NCQ feature can't be used due to the erratum A-008473.
This patch disabled NCQ as a workaround.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/ata/ahci_qoriq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index b9b691e..686d804 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -131,7 +131,7 @@ static struct ata_port_operations ahci_qoriq_ops = {
 	.hardreset	= ahci_qoriq_hardreset,
 };
 
-static const struct ata_port_info ahci_qoriq_port_info = {
+static struct ata_port_info ahci_qoriq_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
@@ -208,6 +208,12 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 	if (rc)
 		goto disable_resources;
 
+	/* Workaround for ls2080a */
+	if (qoriq_priv->type == AHCI_LS2080A) {
+		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
+		ahci_qoriq_port_info.flags &= ~(ATA_FLAG_NCQ);
+	}
+
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_qoriq_port_info,
 				     &ahci_qoriq_sht);
 	if (rc)
-- 
2.1.0.27.g96db324

