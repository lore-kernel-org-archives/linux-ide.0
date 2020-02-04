Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17397C47409
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27A020674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBDQ4K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:34808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgBDQ4I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E43C0B0BE;
        Tue,  4 Feb 2020 16:56:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 05/46] libata: remove pointless debugging messages
Date:   Tue,  4 Feb 2020 17:55:06 +0100
Message-Id: <20200204165547.115220-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Debugging messages in pci init functions or sg setup are pretty
much pointless, as the workflow pretty much decides what happened.
So drop them.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/ata/acard-ahci.c  | 4 ----
 drivers/ata/ahci.c        | 2 --
 drivers/ata/libahci.c     | 3 ---
 drivers/ata/libata-core.c | 6 ------
 drivers/ata/libata-sff.c  | 2 --
 drivers/ata/sata_nv.c     | 4 ----
 6 files changed, 21 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 46dc54d18f0b..5270151ac441 100644
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
@@ -364,8 +362,6 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	struct ata_host *host;
 	int n_ports, i, rc;
 
-	VPRINTK("ENTER\n");
-
 	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b2719c64fc04..4f628e33f52e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1643,8 +1643,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int n_ports, i, rc;
 	int ahci_pci_bar = AHCI_PCI_BAR_STANDARD;
 
-	VPRINTK("ENTER\n");
-
 	WARN_ON((int)ATA_MAX_QUEUE > AHCI_MAX_CMDS);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ea5bf5f4cbed..4055071f213f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1596,8 +1596,6 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	unsigned int si;
 
-	VPRINTK("ENTER\n");
-
 	/*
 	 * Next, the S/G list.
 	 */
@@ -1671,7 +1669,6 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
 	u32 fbs = readl(port_mmio + PORT_FBS);
 	int retries = 3;
 
-	DPRINTK("ENTER\n");
 	BUG_ON(!pp->fbs_enabled);
 
 	/* time to wait for DEC is not specified by AHCI spec,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cee815ecd7df..cea065fb6282 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5052,8 +5052,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	unsigned int n_elem;
 
-	VPRINTK("ENTER, ata%u\n", ap->print_id);
-
 	n_elem = dma_map_sg(ap->dev, qc->sg, qc->n_elem, qc->dma_dir);
 	if (n_elem < 1)
 		return -1;
@@ -6016,8 +6014,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 {
 	struct ata_port *ap;
 
-	DPRINTK("ENTER\n");
-
 	ap = kzalloc(sizeof(*ap), GFP_KERNEL);
 	if (!ap)
 		return NULL;
@@ -6133,8 +6129,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	int i;
 	void *dr;
 
-	DPRINTK("ENTER\n");
-
 	/* alloc a container for our list of ATA ports (buses) */
 	sz = sizeof(struct ata_host) + (max_ports + 1) * sizeof(void *);
 	host = kzalloc(sz, GFP_KERNEL);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 038db94216a9..931ae61d69fb 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2452,8 +2452,6 @@ static int ata_pci_init_one(struct pci_dev *pdev,
 	struct ata_host *host = NULL;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	pi = ata_sff_find_valid_pi(ppi);
 	if (!pi) {
 		dev_err(&pdev->dev, "no valid port_info specified\n");
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index eb9dc14e5147..8639f66706a3 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1271,8 +1271,6 @@ static int nv_adma_host_init(struct ata_host *host)
 	unsigned int i;
 	u32 tmp32;
 
-	VPRINTK("ENTER\n");
-
 	/* enable ADMA on the ports */
 	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &tmp32);
 	tmp32 |= NV_MCP_SATA_CFG_20_PORT0_EN |
@@ -1314,8 +1312,6 @@ static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
 	struct scatterlist *sg;
 	unsigned int si;
 
-	VPRINTK("ENTER\n");
-
 	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		aprd = (si < 5) ? &cpb->aprd[si] :
 			&pp->aprd[NV_ADMA_SGTBL_LEN * qc->hw_tag + (si-5)];
-- 
2.16.4

