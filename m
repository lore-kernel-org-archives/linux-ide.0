Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE46C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhLJHc7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:32:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46996 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbhLJHcx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 98D771F39F;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GH5+lZVkpS1MulCUiPiUk+NUqlseWVqpOhoOywfFa3o=;
        b=BWG72Uz868OJSBwIre0JUGtoLcVc4Hehy2sMwxobgwr2Pn0EuZtwnW97SeEJ00/yr2gHoo
        xi6EbZqM8UlkjqwnYdswbFR+2hhidQZl9gColyEP8m0E4BWjcZv8CCUI/pE3NE3zRmQlRx
        nLpxc72Y5lQm9lOzC1OPv4KUY6L0hbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GH5+lZVkpS1MulCUiPiUk+NUqlseWVqpOhoOywfFa3o=;
        b=kw+XEj3v6spn9d4VePs1Oxau6XL8AGzEKMcELL/kti1FE6aIlN6vfBdytLh41dyw3MBeS8
        sLUh3+T5h0icS2BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6B4E0A3B94;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5BA905192023; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/68] libata: remove pointless debugging messages
Date:   Fri, 10 Dec 2021 08:27:58 +0100
Message-Id: <20211210072905.15666-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Debugging messages in pci init functions or sg setup are pretty
much pointless, as the workflow pretty much decides what happened.
So drop them.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/acard-ahci.c  |  4 ----
 drivers/ata/ahci.c        |  2 --
 drivers/ata/ata_piix.c    |  3 ---
 drivers/ata/libahci.c     |  3 ---
 drivers/ata/libata-core.c | 11 -----------
 drivers/ata/libata-sff.c  |  2 --
 drivers/ata/sata_nv.c     |  4 ----
 7 files changed, 29 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 2a04e8abd397..536d4cb8f08b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -185,8 +185,6 @@ static unsigned int acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	struct acard_sg *acard_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	unsigned int si, last_si = 0;
 
-	VPRINTK("ENTER\n");
-
 	/*
 	 * Next, the S/G list.
 	 */
@@ -362,8 +360,6 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	struct ata_host *host;
 	int n_ports, i, rc;
 
-	VPRINTK("ENTER\n");
-
 	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d60f34718b5d..5fa8a12c6b3b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1672,8 +1672,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int n_ports, i, rc;
 	int ahci_pci_bar = AHCI_PCI_BAR_STANDARD;
 
-	VPRINTK("ENTER\n");
-
 	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 0b2fcf0d1d6c..eb6bf30bd2e3 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1345,7 +1345,6 @@ static void piix_init_pcs(struct ata_host *host,
 	new_pcs = pcs | map_db->port_enable;
 
 	if (new_pcs != pcs) {
-		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
 		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
 		msleep(150);
 	}
@@ -1769,14 +1768,12 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_register_driver\n");
 	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
 	in_module_init = 0;
 
-	DPRINTK("done\n");
 	return 0;
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 8a6835bfd18a..8b651f55fc84 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1620,8 +1620,6 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	unsigned int si;
 
-	VPRINTK("ENTER\n");
-
 	/*
 	 * Next, the S/G list.
 	 */
@@ -1695,7 +1693,6 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
 	u32 fbs = readl(port_mmio + PORT_FBS);
 	int retries = 3;
 
-	DPRINTK("ENTER\n");
 	BUG_ON(!pp->fbs_enabled);
 
 	/* time to wait for DEC is not specified by AHCI spec,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8a0ccb190d76..f6a9e2f22a94 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -764,9 +764,6 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 		head  = track % dev->heads;
 		sect  = (u32)block % dev->sectors + 1;
 
-		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
-			(u32)block, track, cyl, head, sect);
-
 		/* Check whether the converted CHS can fit.
 		   Cylinder: 0-65535
 		   Head: 0-15
@@ -4562,8 +4559,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	unsigned int n_elem;
 
-	VPRINTK("ENTER, ata%u\n", ap->print_id);
-
 	n_elem = dma_map_sg(ap->dev, qc->sg, qc->n_elem, qc->dma_dir);
 	if (n_elem < 1)
 		return -1;
@@ -5368,8 +5363,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 {
 	struct ata_port *ap;
 
-	DPRINTK("ENTER\n");
-
 	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
 	if (!ap)
 		return NULL;
@@ -5486,8 +5479,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	int i;
 	void *dr;
 
-	DPRINTK("ENTER\n");
-
 	/* alloc a container for our list of ATA ports (buses) */
 	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
 	host = kzalloc(sz, GFP_KERNEL);
@@ -5777,9 +5768,7 @@ int ata_port_probe(struct ata_port *ap)
 		__ata_port_probe(ap);
 		ata_port_wait_eh(ap);
 	} else {
-		DPRINTK("ata%u: bus probe begin\n", ap->print_id);
 		rc = ata_bus_probe(ap);
-		DPRINTK("ata%u: bus probe end\n", ap->print_id);
 	}
 	return rc;
 }
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b71ea4a680b0..39c026f3948c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2467,8 +2467,6 @@ static int ata_pci_init_one(struct pci_dev *pdev,
 	struct ata_host *host = NULL;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	pi = ata_sff_find_valid_pi(ppi);
 	if (!pi) {
 		dev_err(&pdev->dev, "no valid port_info specified\n");
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 16272c111208..3c70405a0b80 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1277,8 +1277,6 @@ static int nv_adma_host_init(struct ata_host *host)
 	unsigned int i;
 	u32 tmp32;
 
-	VPRINTK("ENTER\n");
-
 	/* enable ADMA on the ports */
 	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
 	tmp32 |= NV_MCP_SATA_CFG_20_PORT0_EN |
@@ -1320,8 +1318,6 @@ static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
 	struct scatterlist *sg;
 	unsigned int si;
 
-	VPRINTK("ENTER\n");
-
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		aprd = (si < 5) ? &cpb->aprd[si] :
 			&pp->aprd[NV_ADMA_SGTBL_LEN * qc->hw_tag + (si-5)];
-- 
2.29.2

