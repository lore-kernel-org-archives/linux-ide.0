From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] sata_sil24: implement link powersave
Date: Mon, 17 Jul 2006 15:52:33 +0900
Message-ID: <11531191523313-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:23400 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932338AbWGQGvy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:54 -0400
Received: by py-out-1112.google.com with SMTP id x31so3883142pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:21 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement link powersave.  sata_sil24 is mostly compliant with the
standard and standard methods can do everything other than plugging
PHY RDY changed IRQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

600172dbafec31447eaee86ca91a3aa8370fbc47
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 2e0f4a4..0b5c3f1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -230,7 +230,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_HIPS | ATA_FLAG_DIPS,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -335,6 +336,7 @@ static void sil24_freeze(struct ata_port
 static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
+static void sil24_set_powersave(struct ata_port *ap, int ps_state);
 static int sil24_port_start(struct ata_port *ap);
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
@@ -405,6 +407,8 @@ static const struct ata_port_operations 
 	.error_handler		= sil24_error_handler,
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
+	.set_powersave		= sil24_set_powersave,
+
 	.port_start		= sil24_port_start,
 	.port_stop		= sil24_port_stop,
 	.host_stop		= sil24_host_stop,
@@ -764,6 +768,10 @@ static void sil24_error_intr(struct ata_
 	irq_stat = readl(port + PORT_IRQ_STAT);
 	writel(irq_stat, port + PORT_IRQ_STAT);
 
+	/* ignore PHYRDY_CHG during dynamic powersave */
+	if (ata_ps_dynamic(ap->ps_state))
+		irq_stat &= ~PORT_IRQ_PHYRDY_CHG;
+
 	/* first, analyze and record host port events */
 	ata_ehi_clear_desc(ehi);
 
@@ -928,6 +936,18 @@ static void sil24_post_internal_cmd(stru
 		sil24_init_port(ap);
 }
 
+static void sil24_set_powersave(struct ata_port *ap, int ps_state)
+{
+	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
+
+	/* turn off SError.N IRQ if entering dynamic powersave mode */
+	if (ata_ps_dynamic(ps_state))
+		writel(PORT_IRQ_PHYRDY_CHG, port + PORT_IRQ_ENABLE_CLR);
+
+	/* everything else can be done with standard SCR registers */
+	sata_std_set_powersave(ap, ps_state);
+}
+
 static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
 {
 	const size_t cb_size = sizeof(*pp->cmd_block) * SIL24_MAX_CMDS;
-- 
1.3.2


