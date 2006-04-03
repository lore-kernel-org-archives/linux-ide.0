From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] ahci: kill pp->cmd_tbl_sg
Date: Mon, 3 Apr 2006 17:32:40 +0900
Message-ID: <11440531601852-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:36988 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751642AbWDCIcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:55 -0400
Received: by xproxy.gmail.com with SMTP id t10so764240wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:55 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With NCQ, there are multiple sg tables, so pp->cmd_tbl_sg doesn't cut
it.  Directly calculate sg table address from pp->cmd_tbl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

53bd8cc0f4d783cfeb2ba226e61ba58d4534d330
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index bd4faa1..8201a06 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -187,7 +187,6 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
 	dma_addr_t		cmd_tbl_dma;
-	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
 	/* register values stored by interrupt handler for EH */
@@ -385,8 +384,6 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
-	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR_SZ;
-
 	ap->private_data = pp;
 
 	if (hpriv->cap & HOST_CAP_64)
@@ -737,7 +734,7 @@ static unsigned int ahci_fill_sg(struct 
 	/*
 	 * Next, the S/G list.
 	 */
-	ahci_sg = pp->cmd_tbl_sg;
+	ahci_sg = pp->cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
 	ata_for_each_sg(sg, qc) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
-- 
1.2.4


