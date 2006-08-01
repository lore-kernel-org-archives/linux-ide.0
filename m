From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/11] libata: implement dummy port
Date: Wed, 2 Aug 2006 05:11:50 +0900
Message-ID: <11544631101693-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:47093 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932618AbWHAUMD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:12:03 -0400
Received: by py-out-1112.google.com with SMTP id t32so1324158pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:12:02 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
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
 include/linux/libata.h     |    3 ++
 2 files changed, 54 insertions(+), 10 deletions(-)

d9efe31ff5eda88172278153c15a8fd5d0f94ec5
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fe23738..fffb38a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5311,7 +5311,6 @@ static struct ata_port * ata_port_add(co
 {
 	struct Scsi_Host *host;
 	struct ata_port *ap;
-	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -5332,15 +5331,7 @@ static struct ata_port * ata_port_add(co
 
 	ata_port_init(ap, host, host_set, ent, port_no);
 
-	rc = ap->ops->port_start(ap);
-	if (rc)
-		goto err_out;
-
 	return ap;
-
-err_out:
-	scsi_host_put(host);
-	return NULL;
 }
 
 /**
@@ -5395,11 +5386,27 @@ int ata_device_add(const struct ata_prob
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
@@ -5895,6 +5902,39 @@ u32 ata_wait_register(void __iomem *reg,
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
@@ -5904,6 +5944,7 @@ u32 ata_wait_register(void __iomem *reg,
 EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
 EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
+EXPORT_SYMBOL_GPL(ata_dummy_port_ops);
 EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_device_add);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9a94778..10c5587 100644
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
-- 
1.3.2


