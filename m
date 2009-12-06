From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 5/6] sata_mv: store the board_idx into the host private data
Date: Sun,  6 Dec 2009 18:26:21 +0200
Message-ID: <1260116782-31714-5-git-send-email-saeed@marvell.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
 <1260116782-31714-2-git-send-email-saeed@marvell.com>
 <1260116782-31714-3-git-send-email-saeed@marvell.com>
 <1260116782-31714-4-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50752 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbZLFQ01 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:27 -0500
In-Reply-To: <1260116782-31714-4-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

This information will be used int the resume function.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3eadbd5..71ac62e 100755
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -539,6 +539,7 @@ struct mv_port_signal {
 
 struct mv_host_priv {
 	u32			hp_flags;
+	unsigned int 		board_idx;
 	u32			main_irq_mask;
 	struct mv_port_signal	signal[8];
 	const struct mv_hw_ops	*ops;
@@ -3859,7 +3860,6 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 /**
  *      mv_init_host - Perform some early initialization of the host.
  *	@host: ATA host to initialize
- *      @board_idx: controller index
  *
  *      If possible, do an early global reset of the host.  Then do
  *      our port init and clear/unmask all/relevant host interrupts.
@@ -3867,13 +3867,13 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_init_host(struct ata_host *host, unsigned int board_idx)
+static int mv_init_host(struct ata_host *host)
 {
 	int rc = 0, n_hc, port, hc;
 	struct mv_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->base;
 
-	rc = mv_chip_id(host, board_idx);
+	rc = mv_chip_id(host, hpriv->board_idx);
 	if (rc)
 		goto done;
 
@@ -4032,6 +4032,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	host->private_data = hpriv;
 	hpriv->n_ports = n_ports;
+	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
@@ -4057,7 +4058,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 		goto err;
 
 	/* initialize adapter */
-	rc = mv_init_host(host, chip_soc);
+	rc = mv_init_host(host);
 	if (rc)
 		goto err;
 
@@ -4274,6 +4275,7 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 		return -ENOMEM;
 	host->private_data = hpriv;
 	hpriv->n_ports = n_ports;
+	hpriv->board_idx = board_idx;
 
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
@@ -4306,7 +4308,7 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	}
 
 	/* initialize adapter */
-	rc = mv_init_host(host, board_idx);
+	rc = mv_init_host(host);
 	if (rc)
 		return rc;
 
-- 
1.6.0.4

