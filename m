From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/9] libata: implement dummy port
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <11551977892870-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:1893 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751457AbWHJIQ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:56 -0400
Received: by nf-out-0910.google.com with SMTP id a4so452539nfc
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:41 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement dummy port which can be requested by setting appropriate bit
in probe_ent->dummy_port_mask.  The dummy port is used as placeholder
for stolen legacy port.  This allows libata to guarantee that
index_of(ap) == ap->port_no == actual_device_port_no, and thus to
remove error-prone ap->hard_port_no.

As it's used only when one port of a legacy controller is reserved by
some other entity (e.g. IDE), the focus is on keeping the added *code*
complexity at minimum, so dummy port allocates all libata core
resources and acts as a normal port.  It just has all dummy port_ops.

This patch only implements dummy port.  The following patch will make
libata use it for stolen legacy ports.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   61 +++++++++++++++++++++++++++++++++++++-------
 include/linux/libata.h     |    8 ++++++
 2 files changed, 59 insertions(+), 10 deletions(-)

dd5b06c490de72440ec39f814de99a714a45a1a9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3634279..f2e7e2f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5311,7 +5311,6 @@ static struct ata_port * ata_port_add(co
 {
 	struct Scsi_Host *shost;
 	struct ata_port *ap;
-	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -5333,15 +5332,7 @@ static struct ata_port * ata_port_add(co
 	ata_port_init(ap, host_set, ent, port_no);
 	ata_port_init_shost(ap, shost);
 
-	rc = ap->ops->port_start(ap);
-	if (rc)
-		goto err_out;
-
 	return ap;
-
-err_out:
-	scsi_host_put(shost);
-	return NULL;
 }
 
 /**
@@ -5415,11 +5406,27 @@ int ata_device_add(const struct ata_prob
 		if (!ap)
 			goto err_out;
 
+		host_set->ports[i] = ap;
+
+		/* dummy? */
+		if (ent->dummy_port_mask & (1 << i)) {
+			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
+			ap->ops = &ata_dummy_port_ops;
+			continue;
+		}
+
+		/* start port */
+		rc = ap->ops->port_start(ap);
+		if (rc) {
+			host_set->ports[i] = NULL;
+			scsi_host_put(ap->host);
+			goto err_out;
+		}
+
 		/* Report the secondary IRQ for second channel legacy */
 		if (i == 1 && ent->irq2)
 			irq_line = ent->irq2;
 
-		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
@@ -5941,6 +5948,39 @@ u32 ata_wait_register(void __iomem *reg,
 }
 
 /*
+ * Dummy port_ops
+ */
+static void ata_dummy_noret(struct ata_port *ap)	{ }
+static int ata_dummy_ret0(struct ata_port *ap)		{ return 0; }
+static void ata_dummy_qc_noret(struct ata_queued_cmd *qc) { }
+
+static u8 ata_dummy_check_status(struct ata_port *ap)
+{
+	return ATA_DRDY;
+}
+
+static unsigned int ata_dummy_qc_issue(struct ata_queued_cmd *qc)
+{
+	return AC_ERR_SYSTEM;
+}
+
+const struct ata_port_operations ata_dummy_port_ops = {
+	.port_disable		= ata_port_disable,
+	.check_status		= ata_dummy_check_status,
+	.check_altstatus	= ata_dummy_check_status,
+	.dev_select		= ata_noop_dev_select,
+	.qc_prep		= ata_noop_qc_prep,
+	.qc_issue		= ata_dummy_qc_issue,
+	.freeze			= ata_dummy_noret,
+	.thaw			= ata_dummy_noret,
+	.error_handler		= ata_dummy_noret,
+	.post_internal_cmd	= ata_dummy_qc_noret,
+	.irq_clear		= ata_dummy_noret,
+	.port_start		= ata_dummy_ret0,
+	.port_stop		= ata_dummy_noret,
+};
+
+/*
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
  * likely to change as new drivers are added and updated.
@@ -5950,6 +5990,7 @@ u32 ata_wait_register(void __iomem *reg,
 EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
+EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_set_init);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4504776..30bfe8f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -353,6 +353,7 @@ struct ata_probe_ent {
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		hard_port_no;
+	unsigned int		dummy_port_mask;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -652,6 +653,8 @@ extern const unsigned long sata_deb_timi
 extern const unsigned long sata_deb_timing_hotplug[];
 extern const unsigned long sata_deb_timing_long[];
 
+extern const struct ata_port_operations ata_dummy_port_ops;
+
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
 {
@@ -661,6 +664,11 @@ sata_ehc_deb_timing(struct ata_eh_contex
 		return sata_deb_timing_normal;
 }
 
+static inline int ata_port_is_dummy(struct ata_port *ap)
+{
+	return ap->ops == &ata_dummy_port_ops;
+}
+
 extern void ata_port_probe(struct ata_port *);
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
-- 
1.3.2


