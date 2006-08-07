From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/17] libata: implement several LLD init helpers
Date: Mon, 7 Aug 2006 12:04:00 +0900
Message-ID: <11549198402637-git-send-email-htejun@gmail.com>
References: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:7494 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750951AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855330pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:07 -0700 (PDT)
In-Reply-To: <1154919839169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement the following init helpers.

* ata_host_set_alloc_pinfo():
	alloc host_set and init with the given port_info.
* ata_host_set_alloc_pinfo_ar():
	alloc host_set and init with the given port_info array.
* ata_host_set_add_ports_pinfo():
	add ports to host_set and init with the given port_info.
* ata_host_set_add_ports_pinfo_ar():
	add ports to host_set and init with the given port_info array.
* ata_host_set_request_irq():
	prep host_set for IRQ enabling and request IRQ.

These helpers will be used in new LLD init model.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  201 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |   17 +++-
 2 files changed, 215 insertions(+), 3 deletions(-)

23919795368e0b7ed49f63b7aeb36fc5217c6ec7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index eccc6bc..78ee73a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5369,6 +5369,147 @@ int ata_host_set_add_ports(struct ata_ho
 	return 0;
 }
 
+static void __ata_host_set_init_pinfo(struct ata_host_set *host_set,
+				      const struct ata_port_info **pinfo,
+				      int n_ports, int pi_is_ar)
+{
+	int i;
+
+	if (host_set->private_data == NULL)
+		host_set->private_data = pinfo[0]->private_data;
+	host_set->ops = pinfo[0]->port_ops;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+		const struct ata_port_info *pi;
+
+		if (pi_is_ar)
+			pi = pinfo[i];
+		else
+			pi = pinfo[0];
+
+		ap->pio_mask = pi->pio_mask;
+		ap->mwdma_mask = pi->mwdma_mask;
+		ap->udma_mask = pi->udma_mask;
+		ap->flags |= pi->host_flags;
+		ap->ops = pi->port_ops;
+
+		WARN_ON(pi->private_data &&
+			pi->private_data != host_set->private_data);
+	}
+}
+
+/**
+ *	ata_host_set_alloc_pinfo - allocate host_set and init with port_info
+ *	@dev: generic device this host_set is associated with
+ *	@pinfo: ATA port_info to initialize host_set with
+ *	@n_ports: number of ATA ports attached to this host_set
+ *
+ *	Allocate ATA host_set and initialize with info from @pi.
+ *
+ *	RETURNS:
+ *	Allocate ATA host_set on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host_set *
+ata_host_set_alloc_pinfo(struct device *dev,
+			 const struct ata_port_info *pinfo, int n_ports)
+{
+	struct ata_host_set *host_set;
+
+	if (!n_ports)
+		return NULL;
+
+	host_set = ata_host_set_alloc(dev, pinfo->sht, n_ports);
+	if (host_set)
+		__ata_host_set_init_pinfo(host_set, &pinfo, n_ports, 0);
+	return host_set;
+}
+
+/**
+ *	ata_host_set_alloc_pinfo_ar - alloc host_set and init with port_info ar
+ *	@dev: generic device this host_set is associated with
+ *	@pinfo_ar: array of ATA port_info to initialize host_set with
+ *	@n_ports: number of ATA ports attached to this host_set
+ *
+ *	Allocate ATA host_set and initialize with info from @pinfo_ar.
+ *
+ *	RETURNS:
+ *	Allocate ATA host_set on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host_set *
+ata_host_set_alloc_pinfo_ar(struct device *dev,
+			    const struct ata_port_info **pinfo_ar, int n_ports)
+{
+	struct ata_host_set *host_set;
+
+	if (!n_ports)
+		return NULL;
+
+	host_set = ata_host_set_alloc(dev, pinfo_ar[0]->sht, n_ports);
+	if (host_set)
+		__ata_host_set_init_pinfo(host_set, pinfo_ar, n_ports, 1);
+	return host_set;
+}
+
+/**
+ *	ata_host_set_add_ports_pinfo - add ports and init with port_info
+ *	@host_set: target ATA host_set
+ *	@pinfo: ATA port_info to initialize host_set with
+ *	@n_ports: number of ATA ports attached to this host_set
+ *
+ *	Add @n_ports ports to @host_set and initialize @host_set with
+ *	info from @pinfo.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_set_add_ports_pinfo(struct ata_host_set *host_set,
+				 const struct ata_port_info *pinfo, int n_ports)
+{
+	int rc;
+
+	rc = ata_host_set_add_ports(host_set, pinfo->sht, n_ports);
+	if (rc == 0)
+		__ata_host_set_init_pinfo(host_set, &pinfo, n_ports, 0);
+	return rc;
+}
+
+/**
+ *	ata_host_set_add_ports_pinfo_ar - add ports and init with port_info ar
+ *	@host_set: target ATA host_set
+ *	@pinfo_ar: array of ATA port_info to initialize host_set with
+ *	@n_ports: number of ATA ports attached to this host_set
+ *
+ *	Add @n_ports ports to @host_set and initialize @host_set with
+ *	info from @pinfo_ar.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_set_add_ports_pinfo_ar(struct ata_host_set *host_set,
+				    const struct ata_port_info **pinfo_ar,
+				    int n_ports)
+{
+	int rc;
+
+	rc = ata_host_set_add_ports(host_set, pinfo_ar[0]->sht, n_ports);
+	if (rc == 0)
+		__ata_host_set_init_pinfo(host_set, pinfo_ar, n_ports, 1);
+	return rc;
+}
+
 /**
  *	ata_host_set_start - start ports of an ATA host_set
  *	@host_set: ATA host_set to start ports for
@@ -5417,6 +5558,61 @@ int ata_host_set_start(struct ata_host_s
 }
 
 /**
+ *	ata_host_set_request_irq - request IRQ helper
+ *	@host_set: ATA host_set requesting IRQ for
+ *	@irq: irq to request
+ *	@handler: irq handler
+ *	@irq_flags: irq flags
+ *	@reason: out arg for error message
+ *
+ *	Freeze all ports and request IRQ with given parameters.
+ *	dev_id for the IRQ will be @host_set and devname the name of
+ *	the associated LLD.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer.
+ *
+ *	RETURNS:
+ *	Return value of request_irq().
+ */
+int ata_host_set_request_irq(struct ata_host_set *host_set,
+			unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned long irq_flags, const char **reason)
+{
+	const char *drv_name;
+	int i, rc;
+
+	/* make sure ports are started */
+	rc = ata_host_set_start(host_set);
+	if (rc) {
+		*reason = "failed to start host_set";
+		return rc;
+	}
+
+	/* freeze */
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		ata_chk_status(ap);
+		host_set->ops->irq_clear(ap);
+		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
+	}
+
+	/* request irq */
+	drv_name = dev_driver_string(host_set->dev);
+	if (drv_name[0] == '\0')
+		drv_name = DRV_NAME;
+
+	host_set->irq = irq;
+
+	rc = request_irq(irq, handler, irq_flags, drv_name, host_set);
+	if (rc)
+		*reason = "failed to request IRQ";
+	return rc;
+}
+
+/**
  *	ata_host_set_attach - attach initialized ATA host_set
  *	@host_set: ATA host_set to attach
  *
@@ -6117,7 +6313,12 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_set_alloc);
 EXPORT_SYMBOL_GPL(ata_host_set_add_ports);
+EXPORT_SYMBOL_GPL(ata_host_set_alloc_pinfo);
+EXPORT_SYMBOL_GPL(ata_host_set_alloc_pinfo_ar);
+EXPORT_SYMBOL_GPL(ata_host_set_add_ports_pinfo);
+EXPORT_SYMBOL_GPL(ata_host_set_add_ports_pinfo_ar);
 EXPORT_SYMBOL_GPL(ata_host_set_start);
+EXPORT_SYMBOL_GPL(ata_host_set_request_irq);
 EXPORT_SYMBOL_GPL(ata_host_set_attach);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_detach);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fed12ae..91b1fc5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -692,10 +692,21 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern struct ata_host_set *ata_host_set_alloc(struct device *dev,
-					       struct scsi_host_template *sht,
-					       int n_ports);
+			struct scsi_host_template *sht, int n_ports);
 extern int ata_host_set_add_ports(struct ata_host_set *host_set,
-				  struct scsi_host_template *sht, int n_ports);
+			struct scsi_host_template *sht, int n_ports);
+extern struct ata_host_set *ata_host_set_alloc_pinfo(struct device *dev,
+			const struct ata_port_info *pinfo, int n_ports);
+extern struct ata_host_set *ata_host_set_alloc_pinfo_ar(struct device *dev,
+			const struct ata_port_info **pinfo_ar, int n_ports);
+extern int ata_host_set_add_ports_pinfo(struct ata_host_set *host_set,
+			const struct ata_port_info *pinfo, int n_ports);
+extern int ata_host_set_add_ports_pinfo_ar(struct ata_host_set *host_set,
+			const struct ata_port_info **pinfo_ar, int n_ports);
+extern int ata_host_set_request_irq(struct ata_host_set *host_set,
+			unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned long irq_flags, const char **reason);
 extern int ata_host_set_start(struct ata_host_set *host_set);
 extern int ata_host_set_attach(struct ata_host_set *host_set);
 extern int ata_device_add(const struct ata_probe_ent *ent);
-- 
1.3.2


