From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/13] libata: implement ata_host_detach()
Date: Wed, 10 Jan 2007 14:35:37 +0900
Message-ID: <11684073371703-git-send-email-htejun@gmail.com>
References: <11684073353213-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932598AbXAJFi4@vger.kernel.org>
In-Reply-To: <11684073353213-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

Implement ata_host_detach() which calls ata_port_detach() for each
port in the host and export it.  ata_port_detach() is now internal and
thus un-exported.  ata_host_detach() will be used as the 'deregister
from libata layer' function after devres conversion.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    3 +--
 drivers/ata/libata-core.c |   22 +++++++++++++++++++---
 include/linux/libata.h    |    2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5998f74..d089217 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1767,8 +1767,7 @@ static void ahci_remove_one (struct pci_dev *pdev)
 	unsigned int i;
 	int have_msi;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	have_msi = hpriv->flags & AHCI_FLAG_MSI;
 	free_irq(host->irq, host);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2cc7a17..c63fe10 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6001,6 +6001,23 @@ void ata_port_detach(struct ata_port *ap)
 }
 
 /**
+ *	ata_host_detach - Detach all ports of an ATA host
+ *	@host: Host to detach
+ *
+ *	Detach all ports of @host.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_host_detach(struct ata_host *host)
+{
+	int i;
+
+	for (i = 0; i < host->n_ports; i++)
+		ata_port_detach(host->ports[i]);
+}
+
+/**
  *	ata_host_remove - PCI layer callback for device removal
  *	@host: ATA host set that was removed
  *
@@ -6015,8 +6032,7 @@ void ata_host_remove(struct ata_host *host)
 {
 	unsigned int i;
 
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_detach(host->ports[i]);
+	ata_host_detach(host);
 
 	free_irq(host->irq, host);
 	if (host->irq2)
@@ -6391,7 +6407,7 @@ EXPORT_SYMBOL_GPL(ata_std_bios_param);
 EXPORT_SYMBOL_GPL(ata_std_ports);
 EXPORT_SYMBOL_GPL(ata_host_init);
 EXPORT_SYMBOL_GPL(ata_device_add);
-EXPORT_SYMBOL_GPL(ata_port_detach);
+EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_host_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7cfc18f..816d6ef 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -721,7 +721,7 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
-extern void ata_port_detach(struct ata_port *ap);
+extern void ata_host_detach(struct ata_host *host);
 extern void ata_host_init(struct ata_host *, struct device *,
 			  unsigned long, const struct ata_port_operations *);
 extern void ata_host_remove(struct ata_host *host);
-- 
1.4.4.3
