From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v1 1/2] libahci: Implement the capability to override the generic ahci interrupt handler
Date: Thu, 14 Jan 2016 11:00:23 +0530
Message-ID: <1452749424-28919-2-git-send-email-stripathi@apm.com>
References: <1452749424-28919-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452749424-28919-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This patch implements the capability to override the generic
ahci interrupt handler so that LDD drivers can implement there
own interrupt handler routines.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/ata/ahci.h    |    2 ++
 drivers/ata/libahci.c |   18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 45586c1..f59d517 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -352,6 +352,7 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	irqreturn_t 		(*ahci_irq_intr)(int irq, void *dev_instance);
 };

 extern int ahci_ignore_sss;
@@ -400,6 +401,7 @@ int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
 void ahci_error_handler(struct ata_port *ap);
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);

 static inline void __iomem *__ahci_port_base(struct ata_host *host,
 					     unsigned int port_no)
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 096064c..cc1f774 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1832,7 +1832,7 @@ static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
 	return IRQ_WAKE_THREAD;
 }

-static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 {
 	unsigned int i, handled = 0;

@@ -1858,6 +1858,7 @@ static u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)

 	return handled;
 }
+EXPORT_SYMBOL_GPL(ahci_handle_port_intr);

 static irqreturn_t ahci_single_edge_irq_intr(int irq, void *dev_instance)
 {
@@ -2517,16 +2518,21 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
 	int irq = hpriv->irq;
+	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
 	int rc;

 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
 		rc = ahci_host_activate_multi_irqs(host, irq, sht);
-	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
-		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
-				       IRQF_SHARED, sht);
-	else
-		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
+	else {
+		ahci_irq_handler = hpriv->ahci_irq_intr ? hpriv->ahci_irq_intr :
+				   (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
+				   ahci_single_edge_irq_intr :
+				   ahci_single_level_irq_intr);
+
+		rc = ata_host_activate(host, irq, ahci_irq_handler,
 				       IRQF_SHARED, sht);
+	}
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
--
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
