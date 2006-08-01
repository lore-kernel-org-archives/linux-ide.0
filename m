From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/11] libata: kill unused hard_port_no and legacy_mode
Date: Wed, 2 Aug 2006 05:11:50 +0900
Message-ID: <11544631101330-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:29277 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932560AbWHAUL7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:11:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1473623ugc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:11:58 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused probe_ent/ap->hard_port_no and probe_ent->legacy_mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 -
 include/linux/libata.h     |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

dbcc858991d3617344dc560ce672238e2d1b62e5
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fca6c8c..087a845 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5243,7 +5243,6 @@ static void ata_port_init(struct ata_por
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
 
-	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 10c5587..a1c25af 100644
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


