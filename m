From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] ahci: kill pp->cmd_tbl_sg
Date: Thu, 11 May 2006 23:44:43 +0900
Message-ID: <11473586832630-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:31404 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751814AbWEKOoz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:55 -0400
Received: by py-out-1112.google.com with SMTP id f28so269358pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:55 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

With NCQ, there are multiple sg tables, so pp->cmd_tbl_sg doesn't cut
it.  Directly calculate sg table address from pp->cmd_tbl.

---

 drivers/scsi/ahci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

51dea343a3a00edf4389d9efbe024b478f9ba377
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index beb269a..49f5101 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -191,7 +191,6 @@ struct ahci_port_priv {
 	dma_addr_t		cmd_slot_dma;
 	void			*cmd_tbl;
 	dma_addr_t		cmd_tbl_dma;
-	struct ahci_sg		*cmd_tbl_sg;
 	void			*rx_fis;
 	dma_addr_t		rx_fis_dma;
 };
@@ -397,8 +396,6 @@ static int ahci_port_start(struct ata_po
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
-	pp->cmd_tbl_sg = mem + AHCI_CMD_TBL_HDR_SZ;
-
 	ap->private_data = pp;
 
 	if (hpriv->cap & HOST_CAP_64)
@@ -750,7 +747,7 @@ static unsigned int ahci_fill_sg(struct 
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


