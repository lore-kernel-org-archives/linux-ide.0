From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 10/11] libata: add ATAPI support to ahci
Date: Thu,  7 Jul 2005 22:10:04 +0900 (KST)
Message-ID: <20050707130840.63AB5EBF@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:54395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261484AbVGGNKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:10:15 -0400
Received: by wproxy.gmail.com with SMTP id i11so199660wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:10:13 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

10_libata_ahci-atapi.patch

	This patch adds ATAPI support to ahci driver.  This currently
	doesn't work.  I'll write a reply to this thread to tell more
	about this.  However, it at least shows that NCQ ATAPI error
	handling works.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-07-07 22:08:37.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-07-07 22:08:37.000000000 +0900
@@ -543,14 +543,22 @@ static void ahci_qc_prep(struct ata_queu
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	const u32 cmd_fis_len = 5; /* five dwords */
+	void *cmd_tbl;
 	dma_addr_t cmd_tbl_dma;
 	u32 opts;
 	int offset;
 
 	/*
-	 * Fill in command slot information
+	 * the tag determines the offset into the allocated cmd table
 	 */
+	offset = qc->tag * AHCI_CMD_TOTAL;
+
+	cmd_tbl = pp->cmd_tbl + offset;
+	cmd_tbl_dma = pp->cmd_tbl_dma + offset;
 
+	/*
+	 * Fill in command slot information
+	 */
 	opts = (qc->n_elem << 16) | cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
@@ -559,6 +567,7 @@ static void ahci_qc_prep(struct ata_queu
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_ATAPI_NODATA:
 	case ATA_PROT_ATAPI_DMA:
+		memcpy(cmd_tbl + 0x40, qc->cdb, qc->ap->cdb_len);
 		opts |= AHCI_CMD_ATAPI;
 		break;
 
@@ -567,13 +576,6 @@ static void ahci_qc_prep(struct ata_queu
 		break;
 	}
 
-	/*
-	 * the tag determines the offset into the allocated cmd table
-	 */
-	offset = qc->tag * AHCI_CMD_TOTAL;
-
-	cmd_tbl_dma = pp->cmd_tbl_dma + offset;
-
 	pp->cmd_slot[qc->tag].opts = cpu_to_le32(opts);
 	pp->cmd_slot[qc->tag].status = 0;
 	pp->cmd_slot[qc->tag].tbl_addr = cpu_to_le32(cmd_tbl_dma & 0xffffffff);

