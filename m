From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/14] ahci: separate out ahci_cmd_prep()
Date: Sun, 18 Dec 2005 22:50:20 +0900
Message-ID: <20051218135020.GM31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:40910 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965117AbVLRNuZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:50:25 -0500
Received: by zproxy.gmail.com with SMTP id 13so1085278nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:50:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Separate out achi_cmd_prep() from ahci_qc_prep().  This is preparation
for adding softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-12-18 22:24:04.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-12-18 22:24:12.000000000 +0900
@@ -475,6 +475,16 @@ static void ahci_start_engine(struct ata
 	readl(port_mmio + PORT_CMD); /* flush */
 }
 
+static inline void ahci_cmd_prep(struct ata_port *ap, u32 opts)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+
+	pp->cmd_slot[0].opts = cpu_to_le32(opts);
+	pp->cmd_slot[0].status = 0;
+	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
+	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+}
+
 static int ahci_wait_for_bit(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec)
@@ -629,10 +639,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (is_atapi_taskfile(&qc->tf))
 		opts |= AHCI_CMD_ATAPI;
 
-	pp->cmd_slot[0].opts = cpu_to_le32(opts);
-	pp->cmd_slot[0].status = 0;
-	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
-	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
+	ahci_cmd_prep(ap, opts);
 
 	/*
 	 * Fill in command table information.  First, the header,
