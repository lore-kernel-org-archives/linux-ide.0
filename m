From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 9/9] libata: kill unused hard_port_no and legacy_mode
Date: Sat, 5 Aug 2006 06:01:34 +0900
Message-ID: <11547252941943-git-send-email-htejun@gmail.com>
References: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:59189 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161450AbWHDVBo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:44 -0400
Received: by py-out-1112.google.com with SMTP id z74so516815pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:44 -0700 (PDT)
In-Reply-To: <11547252923301-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused probe_ent/ap->hard_port_no and probe_ent->legacy_mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 -
 include/linux/libata.h     |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

2c79fd77ad0e0a6e0b3655411684a4c1009f41c9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 453dce0..9578b42 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5244,7 +5244,6 @@ static void ata_port_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6a81aed..1b6283c 100644
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


