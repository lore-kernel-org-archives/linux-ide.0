From: <Yuantian.Tang@freescale.com>
Subject: [PATCH v2] ahci: qoriq: fixed using uninitialized variable warnings
Date: Thu, 10 Sep 2015 15:13:32 +0800
Message-ID: <1441869212-14695-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2on0101.outbound.protection.outlook.com ([65.55.169.101]:30754
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752055AbbIJHT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Sep 2015 03:19:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

kbuild test robot reports the warnings:
drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
>> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
>> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here

This patch fixed it by making type as a local variable.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- try another way to fix the warnings
	- remove clean up code

 drivers/ata/ahci_qoriq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index e5e4988..0d06e76 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -48,9 +48,9 @@ enum ahci_qoriq_type {
 	AHCI_LS2085A,
 };
 
+enum ahci_qoriq_type type;
 struct ahci_qoriq_priv {
 	struct ccsr_ahci *reg_base;
-	enum ahci_qoriq_type type;
 	void __iomem *ecc_addr;
 };
 
@@ -71,7 +71,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
-	struct ahci_qoriq_priv *qoriq_priv = hpriv->plat_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
 	bool online;
@@ -92,7 +91,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	 * After the sequence is complete, software should restore the
 	 * PxCMD and PxIS with the stored values.
 	 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (type == AHCI_LS1021A) {
 		px_cmd = readl(port_mmio + PORT_CMD);
 		px_is = readl(port_mmio + PORT_IRQ_STAT);
 	}
@@ -106,7 +105,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 				 ahci_check_ready);
 
 	/* restore the PxCMD and PxIS on ls1021 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (type == AHCI_LS1021A) {
 		px_val = readl(port_mmio + PORT_CMD);
 		if (px_val != px_cmd)
 			writel(px_cmd, port_mmio + PORT_CMD);
@@ -146,7 +145,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	struct ahci_qoriq_priv *qpriv = hpriv->plat_data;
 	void __iomem *reg_base = hpriv->mmio;
 
-	switch (qpriv->type) {
+	switch (type) {
 	case AHCI_LS1021A:
 		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
@@ -188,9 +187,9 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 	if (!qoriq_priv)
 		return -ENOMEM;
 
-	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
+	type = (enum ahci_qoriq_type)of_id->data;
 
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (type == AHCI_LS1021A) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 				"sata-ecc");
 		qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
-- 
2.1.0.27.g96db324

