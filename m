From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/15] ahci: kill pp->cmd_tbl_sg
Date: Tue, 11 Apr 2006 22:53:37 +0900
Message-ID: <1144763617603-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:17886 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750994AbWDKNxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:49 -0400
Received: by zproxy.gmail.com with SMTP id o37so1097580nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:49 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With NCQ, there are multiple sg tables, so pp->cmd_tbl_sg doesn't cut
it.  Directly calculate sg table address from pp->cmd_tbl.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

54c5e95cb986b8045d510cb62d2f89376ffcbc30
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 375857b..027fea1 100644
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
@@ -715,7 +712,7 @@ static unsigned int ahci_fill_sg(struct 
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


