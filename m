From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/20] libata: implement several LLD init helpers
Date: Sat, 19 Aug 2006 17:59:31 +0900
Message-ID: <11559779712708-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:37636 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751643AbWHSI75 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:57 -0400
Received: by py-out-1112.google.com with SMTP id n25so1465939pyg
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:56 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement the following init helpers.

* ata_host_alloc_pinfo()	: alloc host, init with port_info
* ata_host_alloc_pinfo_ar()	: alloc host, init with port_info array
* ata_host_add_ports_pinfo()	: add ports to host, init with port_info
* ata_host_add_ports_pinfo_ar()	: add ports to host, init with port_info array
* ata_host_request_irq_marker()	: prep host for IRQ, request IRQ with marker
* ata_host_request_irq()	: prep host for IRQ, request IRQ
* ata_host_free_irqs_marker()	: free IRQs with the given marker
* ata_host_free_irqs()		: free all IRQs

libata core layer keeps track of allocated IRQs and can free subset
designated by @marker or all of them.

These helpers will be used in new LLD init model.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  300 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |    6 +
 include/linux/libata.h    |   19 ++-
 3 files changed, 321 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index eeb9dc6..b293d47 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -59,6 +59,13 @@ #include <asm/byteorder.h>
 
 #include "libata.h"
 
+struct ata_irq {
+	struct list_head node;
+	unsigned int irq;
+	void *dev_id;
+	void *marker;
+};
+
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
@@ -5421,6 +5428,7 @@ struct ata_host *ata_host_alloc(struct d
 
 	spin_lock_init(&host->lock);
 	host->dev = dev;
+	INIT_LIST_HEAD(&host->irq_list);
 
 	if (ata_host_add_ports(host, sht, n_ports))
 		goto err_free;
@@ -5475,6 +5483,147 @@ int ata_host_add_ports(struct ata_host *
 	return 0;
 }
 
+static void __ata_host_init_pinfo(struct ata_host *host,
+				  const struct ata_port_info **pinfo,
+				  int n_ports, int pi_is_ar)
+{
+	int i;
+
+	if (host->private_data == NULL)
+		host->private_data = pinfo[0]->private_data;
+	host->ops = pinfo[0]->port_ops;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
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
+		ap->flags |= pi->flags;
+		ap->ops = pi->port_ops;
+
+		WARN_ON(pi->private_data &&
+			pi->private_data != host->private_data);
+	}
+}
+
+/**
+ *	ata_host_alloc_pinfo - allocate host and init with port_info
+ *	@dev: generic device this host is associated with
+ *	@pinfo: ATA port_info to initialize host with
+ *	@n_ports: number of ATA ports attached to this host
+ *
+ *	Allocate ATA host and initialize with info from @pi.
+ *
+ *	RETURNS:
+ *	Allocate ATA host on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host *ata_host_alloc_pinfo(struct device *dev,
+				      const struct ata_port_info *pinfo,
+				      int n_ports)
+{
+	struct ata_host *host;
+
+	if (!n_ports)
+		return NULL;
+
+	host = ata_host_alloc(dev, pinfo->sht, n_ports);
+	if (host)
+		__ata_host_init_pinfo(host, &pinfo, n_ports, 0);
+	return host;
+}
+
+/**
+ *	ata_host_alloc_pinfo_ar - alloc host and init with port_info ar
+ *	@dev: generic device this host is associated with
+ *	@pinfo_ar: array of ATA port_info to initialize host with
+ *	@n_ports: number of ATA ports attached to this host
+ *
+ *	Allocate ATA host and initialize with info from @pinfo_ar.
+ *
+ *	RETURNS:
+ *	Allocate ATA host on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host *ata_host_alloc_pinfo_ar(struct device *dev,
+					 const struct ata_port_info **pinfo_ar,
+					 int n_ports)
+{
+	struct ata_host *host;
+
+	if (!n_ports)
+		return NULL;
+
+	host = ata_host_alloc(dev, pinfo_ar[0]->sht, n_ports);
+	if (host)
+		__ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
+	return host;
+}
+
+/**
+ *	ata_host_add_ports_pinfo - add ports and init with port_info
+ *	@host: target ATA host
+ *	@pinfo: ATA port_info to initialize host with
+ *	@n_ports: number of ATA ports attached to this host
+ *
+ *	Add @n_ports ports to @host and initialize @host with
+ *	info from @pinfo.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_add_ports_pinfo(struct ata_host *host,
+			     const struct ata_port_info *pinfo, int n_ports)
+{
+	int rc;
+
+	rc = ata_host_add_ports(host, pinfo->sht, n_ports);
+	if (rc == 0)
+		__ata_host_init_pinfo(host, &pinfo, n_ports, 0);
+	return rc;
+}
+
+/**
+ *	ata_host_add_ports_pinfo_ar - add ports and init with port_info ar
+ *	@host: target ATA host
+ *	@pinfo_ar: array of ATA port_info to initialize host with
+ *	@n_ports: number of ATA ports attached to this host
+ *
+ *	Add @n_ports ports to @host and initialize @host with
+ *	info from @pinfo_ar.
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+int ata_host_add_ports_pinfo_ar(struct ata_host *host,
+				const struct ata_port_info **pinfo_ar,
+				int n_ports)
+{
+	int rc;
+
+	rc = ata_host_add_ports(host, pinfo_ar[0]->sht, n_ports);
+	if (rc == 0)
+		__ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
+	return rc;
+}
+
 /**
  *	ata_sas_host_init - Initialize a host struct
  *	@host:	host to initialize
@@ -5494,6 +5643,7 @@ void ata_host_init(struct ata_host *host
 	host->dev = dev;
 	host->flags = flags;
 	host->ops = ops;
+	INIT_LIST_HEAD(&host->irq_list);
 }
 
 /**
@@ -5541,6 +5691,108 @@ int ata_host_start(struct ata_host *host
 }
 
 /**
+ *	ata_host_request_irq_marker - request IRQ helper
+ *	@host: ATA host requesting IRQ for
+ *	@irq: IRQ to request
+ *	@handler: IRQ handler
+ *	@irq_flags: IRQ flags
+ *	@dev_id: IRQ dev_id
+ *	@marker: marker
+ *	@p_reason: out arg for error message (can be NULL)
+ *
+ *	Freeze all ports and request IRQ with given parameters.
+ *	devname for the IRQ will be the name of the associated LLD.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	Return value of request_irq().
+ */
+int ata_host_request_irq_marker(struct ata_host *host, unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned int irq_flags, void *dev_id, void *marker,
+			const char **p_reason)
+{
+	struct ata_irq *airq = NULL;
+	const char *reason;
+	int i, rc;
+
+	/* make sure ports are started */
+	rc = ata_host_start(host);
+	if (rc) {
+		reason = "failed to start host";
+		goto err;
+	}
+
+	/* freeze before requesting IRQ */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+			ata_chk_status(ap);
+			host->ops->irq_clear(ap);
+			ata_eh_freeze_port(ap);
+		}
+	}
+
+	/* request irq */
+	airq = kzalloc(sizeof(*airq), GFP_KERNEL);
+	if (!airq) {
+		reason = "failed to allocate ata_irq";
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = request_irq(irq, handler, irq_flags, DRV_NAME, dev_id);
+	if (rc) {
+		reason = "failed to request IRQ";
+		goto err;
+	}
+
+	airq->irq = irq;
+	airq->dev_id = dev_id;
+	airq->marker = marker;
+	list_add_tail(&airq->node, &host->irq_list);
+
+	return rc;
+
+ err:
+	kfree(airq);
+	if (p_reason)
+		*p_reason = reason;
+	return rc;
+}
+
+/**
+ *	ata_host_request_irq - request IRQ helper
+ *	@host: ATA host requesting IRQ for
+ *	@irq: IRQ to request
+ *	@handler: IRQ handler
+ *	@irq_flags: IRQ flags
+ *	@dev_id: IRQ dev_id
+ *	@p_reason: out arg for error message (can be NULL)
+ *
+ *	Freeze all ports and request IRQ with given parameters.
+ *	devname for the IRQ will be the name of the associated LLD.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	Return value of request_irq().
+ */
+int ata_host_request_irq(struct ata_host *host, unsigned int irq,
+			 irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			 unsigned int irq_flags, void *dev_id,
+			 const char **p_reason)
+{
+	return ata_host_request_irq_marker(host, irq, handler, irq_flags,
+					   dev_id, ata_host_request_irq,
+					   p_reason);
+}
+
+/**
  *	ata_host_attach - attach initialized ATA host
  *	@host: ATA host to attach
  *
@@ -5886,6 +6138,48 @@ void ata_host_stop(struct ata_host *host
 	}
 }
 
+static void __ata_host_free_irqs(struct ata_host *host, void **markerp)
+{
+	struct ata_irq *airq, *tmp;
+
+	list_for_each_entry_safe(airq, tmp, &host->irq_list, node) {
+		if (!markerp || airq->marker == *markerp) {
+			list_del(&airq->node);
+			free_irq(airq->irq, airq->dev_id);
+			kfree(airq);
+		}
+	}
+}
+
+/**
+ *	ata_host_free_irqs_marker - free the IRQs with matching marker
+ *	@host: target ATA host
+ *	@marker: marker to match
+ *
+ *	Free IRQs @host is holding and marked with @marker.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_free_irqs_marker(struct ata_host *host, void *marker)
+{
+	__ata_host_free_irqs(host, &marker);
+}
+
+/**
+ *	ata_host_free_irqs - free all IRQs an ATA host is holding
+ *	@host: target ATA host
+ *
+ *	Free all IRQs @host is holding.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_free_irqs(struct ata_host *host)
+{
+	__ata_host_free_irqs(host, NULL);
+}
+
 /**
  *	ata_host_free - Release a host
  *	@host: ATA host set to be freed
@@ -6266,11 +6560,17 @@ EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
 EXPORT_SYMBOL_GPL(ata_host_add_ports);
+EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
+EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo_ar);
+EXPORT_SYMBOL_GPL(ata_host_add_ports_pinfo);
+EXPORT_SYMBOL_GPL(ata_host_add_ports_pinfo_ar);
 EXPORT_SYMBOL_GPL(ata_host_start);
+EXPORT_SYMBOL_GPL(ata_host_request_irq);
 EXPORT_SYMBOL_GPL(ata_host_attach);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_stop);
+EXPORT_SYMBOL_GPL(ata_host_free_irqs);
 EXPORT_SYMBOL_GPL(ata_host_free);
 EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5ecb71..1d24254 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -73,7 +73,11 @@ extern void ata_port_init(struct ata_por
 			  const struct ata_probe_ent *ent, unsigned int port_no);
 extern struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev,
 						 const struct ata_port_info *port);
-
+extern int ata_host_request_irq_marker(struct ata_host *host, unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned int irq_flags, void *dev_id, void *marker,
+			const char **p_reason);
+extern void ata_host_free_irqs_marker(struct ata_host *host, void *marker);
 
 /* libata-scsi.c */
 extern struct scsi_transport_template ata_scsi_transport_template;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5e8160a..b050517 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -378,6 +378,7 @@ struct ata_host {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
+	struct list_head	irq_list;	/* list of acquired irqs */
 	struct ata_port		*ports[0];
 };
 
@@ -692,15 +693,27 @@ extern int ata_pci_device_resume(struct 
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern struct ata_host *ata_host_alloc(struct device *dev,
-				       struct scsi_host_template *sht,
-				       int n_ports);
+			struct scsi_host_template *sht, int n_ports);
 extern int ata_host_add_ports(struct ata_host *host,
-			      struct scsi_host_template *sht, int n_ports);
+			struct scsi_host_template *sht, int n_ports);
+extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
+			const struct ata_port_info *pinfo, int n_ports);
+extern struct ata_host *ata_host_alloc_pinfo_ar(struct device *dev,
+			const struct ata_port_info **pinfo_ar, int n_ports);
+extern int ata_host_add_ports_pinfo(struct ata_host *host,
+			const struct ata_port_info *pinfo, int n_ports);
+extern int ata_host_add_ports_pinfo_ar(struct ata_host *host,
+			const struct ata_port_info **pinfo_ar, int n_ports);
+extern int ata_host_request_irq(struct ata_host *host, unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned int irq_flags, void *dev_id,
+			const char **p_reason);
 extern int ata_host_start(struct ata_host *host);
 extern int ata_host_attach(struct ata_host *host);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_stop(struct ata_host *host);
+extern void ata_host_free_irqs(struct ata_host *host);
 extern void ata_host_free(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
-- 
1.4.1.1


