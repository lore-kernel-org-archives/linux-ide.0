From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata: implement ata_host_alloc_pinfo() and ata_host_register()
Date: Wed, 11 Apr 2007 15:42:04 +0900
Message-ID: <11762737243088-git-send-email-htejun@gmail.com>
References: <1176273724198-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:40900 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbXDKGmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 02:42:10 -0400
Received: by nz-out-0506.google.com with SMTP id s1so57271nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Apr 2007 23:42:10 -0700 (PDT)
In-Reply-To: <1176273724198-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, brking@linux.vnet.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_host_alloc_pinfo() and ata_host_register().  These helpers
will be used in the following patches to adopt new init model.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   93 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    5 ++
 2 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dd4e178..6d42550 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5820,6 +5820,55 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 }
 
 /**
+ *	ata_host_alloc_pinfo - alloc host and init with port_info array
+ *	@dev: generic device this host is associated with
+ *	@ppi: array of ATA port_info to initialize host with
+ *	@n_ports: number of ATA ports attached to this host
+ *
+ *	Allocate ATA host and initialize with info from @ppi.  If NULL
+ *	terminated, @ppi may contain fewer entries than @n_ports.  The
+ *	last entry will be used for the remaining ports.
+ *
+ *	RETURNS:
+ *	Allocate ATA host on success, NULL on failure.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+struct ata_host *ata_host_alloc_pinfo(struct device *dev,
+				      const struct ata_port_info * const * ppi,
+				      int n_ports)
+{
+	const struct ata_port_info *pi;
+	struct ata_host *host;
+	int i, j;
+
+	host = ata_host_alloc(dev, n_ports);
+	if (!host)
+		return NULL;
+
+	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ppi[j])
+			pi = ppi[j++];
+
+		ap->pio_mask = pi->pio_mask;
+		ap->mwdma_mask = pi->mwdma_mask;
+		ap->udma_mask = pi->udma_mask;
+		ap->flags |= pi->flags;
+		ap->ops = pi->port_ops;
+
+		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
+			host->ops = pi->port_ops;
+		if (!host->private_data && pi->private_data)
+			host->private_data = pi->private_data;
+	}
+
+	return host;
+}
+
+/**
  *	ata_host_start - start and freeze ports of an ATA host
  *	@host: ATA host to start ports for
  *
@@ -6032,6 +6081,48 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 }
 
 /**
+ *	ata_host_activate - start host, request IRQ and register it
+ *	@host: target ATA host
+ *	@irq: IRQ to request
+ *	@irq_handler: irq_handler used when requesting IRQ
+ *	@irq_flags: irq_flags used when requesting IRQ
+ *	@sht: scsi_host_template to use when registering the host
+ *
+ *	After allocating an ATA host and initializing it, most libata
+ *	LLDs perform three steps to activate the host - start host,
+ *	request IRQ and register it.  This helper takes necessasry
+ *	arguments and performs the three steps in one go.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_host_activate(struct ata_host *host, int irq,
+		      irq_handler_t irq_handler, unsigned long irq_flags,
+		      struct scsi_host_template *sht)
+{
+	int rc;
+
+	rc = ata_host_start(host);
+	if (rc)
+		return rc;
+
+	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
+			      dev_driver_string(host->dev), host);
+	if (rc)
+		return rc;
+
+	rc = ata_host_register(host, sht);
+	/* if failed, just free the IRQ and leave ports alone */
+	if (rc)
+		devm_free_irq(host->dev, irq, host);
+
+	return rc;
+}
+
+/**
  *	ata_device_add - Register hardware device with ATA and SCSI layers
  *	@ent: Probe information describing hardware device to be registered
  *
@@ -6537,8 +6628,10 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_host_alloc);
+EXPORT_SYMBOL_GPL(ata_host_alloc_pinfo);
 EXPORT_SYMBOL_GPL(ata_host_start);
 EXPORT_SYMBOL_GPL(ata_host_register);
+EXPORT_SYMBOL_GPL(ata_host_activate);
 EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 06cf23f..300daf6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -734,9 +734,14 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern struct ata_host *ata_host_alloc(struct device *dev, int max_ports);
+extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
+			const struct ata_port_info * const * ppi, int n_ports);
 extern int ata_host_start(struct ata_host *host);
 extern int ata_host_register(struct ata_host *host,
 			     struct scsi_host_template *sht);
+extern int ata_host_activate(struct ata_host *host, int irq,
+			     irq_handler_t irq_handler, unsigned long irq_flags,
+			     struct scsi_host_template *sht);
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
-- 
1.5.0.3


