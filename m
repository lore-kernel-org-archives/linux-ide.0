From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/23] libata-sff: rename ap->ops->drain_fifo() to sff_drain_fifo()
Date: Mon, 10 May 2010 21:41:36 +0200
Message-ID: <1273520507-32459-13-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44921 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767Ab0EJTmI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:08 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

->drain_fifo() is SFF specific.  Rename and relocate it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c  |    6 +++---
 drivers/ata/pata_pcmcia.c |    2 +-
 include/linux/libata.h    |    3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 470553d..9effce9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -53,7 +53,6 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.softreset		= ata_sff_softreset,
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
-	.drain_fifo		= ata_sff_drain_fifo,
 	.error_handler		= ata_sff_error_handler,
 	.post_internal_cmd	= ata_sff_post_internal_cmd,
 
@@ -65,6 +64,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.sff_data_xfer		= ata_sff_data_xfer,
 	.sff_irq_on		= ata_sff_irq_on,
 	.sff_irq_clear		= ata_sff_irq_clear,
+	.sff_drain_fifo		= ata_sff_drain_fifo,
 
 	.lost_interrupt		= ata_sff_lost_interrupt,
 };
@@ -2378,8 +2378,8 @@ void ata_sff_error_handler(struct ata_port *ap)
 	 * if we touch the data port post reset. Pass qc in case anyone wants
 	 *  to do different PIO/DMA recovery or has per command fixups
 	 */
-	if (ap->ops->drain_fifo)
-		ap->ops->drain_fifo(qc);
+	if (ap->ops->sff_drain_fifo)
+		ap->ops->sff_drain_fifo(qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 4164dd2..8ddeb84 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -175,7 +175,7 @@ static struct ata_port_operations pcmcia_8bit_port_ops = {
 	.sff_data_xfer	= ata_data_xfer_8bit,
 	.cable_detect	= ata_cable_40wire,
 	.set_mode	= pcmcia_set_mode_8bit,
-	.drain_fifo	= pcmcia_8bit_drain_fifo,
+	.sff_drain_fifo	= pcmcia_8bit_drain_fifo,
 };
 
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7f438e1..3c451ab 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -855,13 +855,12 @@ struct ata_port_operations {
 	u8   (*sff_irq_on)(struct ata_port *);
 	bool (*sff_irq_check)(struct ata_port *);
 	void (*sff_irq_clear)(struct ata_port *);
+	void (*sff_drain_fifo)(struct ata_queued_cmd *qc);
 
 	void (*bmdma_setup)(struct ata_queued_cmd *qc);
 	void (*bmdma_start)(struct ata_queued_cmd *qc);
 	void (*bmdma_stop)(struct ata_queued_cmd *qc);
 	u8   (*bmdma_status)(struct ata_port *ap);
-
-	void (*drain_fifo)(struct ata_queued_cmd *qc);
 #endif /* CONFIG_ATA_SFF */
 
 	ssize_t (*em_show)(struct ata_port *ap, char *buf);
-- 
1.6.4.2

