From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: add hp-poll support to controllers without hotplug interrupts
Date: Mon, 17 Jul 2006 16:00:49 +0900
Message-ID: <11531196492681-git-send-email-htejun@gmail.com>
References: <11531196483920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:31080 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932363AbWGQG7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:59:31 -0400
Received: by nz-out-0102.google.com with SMTP id x7so399152nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:59:31 -0700 (PDT)
In-Reply-To: <11531196483920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds hp-poll support to the following drivers.

* sata_nv (generic)
* sata_sis
* sata_svw
* sata_uli
* sata_via
* sata_vsc

All the above drivers currently don't support hotplug interrupts (H/W
restrictions or lack of doc/effort) and all hotplug operations should
be done via hp-poll; thus, ATA_FLAG_HP_POLLING is set for these
drivers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c  |    5 ++++-
 drivers/scsi/sata_sis.c |    5 ++++-
 drivers/scsi/sata_svw.c |    4 +++-
 drivers/scsi/sata_uli.c |    6 +++++-
 drivers/scsi/sata_vsc.c |    4 +++-
 5 files changed, 19 insertions(+), 5 deletions(-)

3a5e2866b5e69d113c1a7740969b9847ed41b545
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index cdf3b65..7bd9305 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -189,6 +189,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= nv_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -261,7 +263,8 @@ static struct ata_port_info nv_port_info
 	/* generic */
 	{
 		.sht		= &nv_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_HP_POLLING,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
index ee6b5df..3b4bc5a 100644
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -117,6 +117,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sis_scr_read,
@@ -128,7 +130,8 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_port_info = {
 	.sht		= &sis_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x7,
 	.udma_mask	= 0x7f,
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 7d08580..9a446ad 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -324,6 +324,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= k2_sata_scr_read,
@@ -424,7 +426,7 @@ static int k2_sata_init_one (struct pci_
 
 	probe_ent->sht = &k2_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 33cdb48..d3ab9ed 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -115,6 +115,9 @@ static const struct ata_port_operations 
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
+
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -128,7 +131,8 @@ static const struct ata_port_operations 
 
 static struct ata_port_info uli_port_info = {
 	.sht            = &uli_sht,
-	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask       = 0x1f,		/* pio0-4 */
 	.udma_mask      = 0x7f,		/* udma0-6 */
 	.port_ops       = &uli_ops,
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ad37871..d7da4c2 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -302,6 +302,8 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	= sata_std_hp_poll_activate,
+	.hp_poll		= sata_std_hp_poll,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= vsc_sata_scr_read,
@@ -396,7 +398,7 @@ static int __devinit vsc_sata_init_one (
 
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-- 
1.3.2


