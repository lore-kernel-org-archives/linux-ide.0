From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 9/9] libata: kill unused hard_port_no and legacy_mode
Date: Thu, 10 Aug 2006 17:16:30 +0900
Message-ID: <1155197790636-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:11311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWHJIQi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:38 -0400
Received: by py-out-1112.google.com with SMTP id z74so730388pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:38 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused probe_ent/ap->hard_port_no and probe_ent->legacy_mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 -
 include/linux/libata.h     |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

4852ba24f647199be797545226c6d325db231937
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2ef86b4..3f963f2 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5223,7 +5223,6 @@ void ata_port_init(struct ata_port *ap, 
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 30bfe8f..ed749f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -352,12 +352,10 @@ struct ata_probe_ent {
 	struct scsi_host_template *sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
-	unsigned int		hard_port_no;
 	unsigned int		dummy_port_mask;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
-	unsigned int		legacy_mode;
 	unsigned long		irq;
 	unsigned long		irq2;
 	unsigned int		irq_flags;
@@ -509,7 +507,6 @@ struct ata_port {
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
-	unsigned int		hard_port_no;	/* hardware port #; from zero */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
-- 
1.3.2


