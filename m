From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/8] libata-pmp: extend ACPI support to cover PMP
Date: Mon, 16 Jul 2007 18:46:04 +0900
Message-ID: <11845791642246-git-send-email-htejun@gmail.com>
References: <1184579163885-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:53686 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbXGPJqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:46:12 -0400
Received: by nz-out-0506.google.com with SMTP id s18so784842nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:46:12 -0700 (PDT)
In-Reply-To: <1184579163885-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Extend ata_acpi_associate_sata_port() such that it can handle PMP and
call it when PMP is attached and detached.

Build breakage when !CONFIG_ATA_ACPI was spotted and fixed by Petr
Vandrovec.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Petr Vandrovec <petr@vandrovec.name>
---
 drivers/ata/libata-acpi.c |   36 ++++++++++++++++++++++++++++++++----
 drivers/ata/libata-pmp.c  |    4 ++++
 drivers/ata/libata.h      |    2 ++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 43af2e0..153388c 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -40,12 +40,40 @@ static int is_pci_dev(struct device *dev)
 	return (dev->bus == &pci_bus_type);
 }
 
-static void ata_acpi_associate_sata_port(struct ata_port *ap)
+/**
+ * ata_acpi_associate_sata_port - associate SATA port with ACPI objects
+ * @ap: target SATA port
+ *
+ * Look up ACPI objects associated with @ap and initialize acpi_handle
+ * fields of @ap, the port and devices accordingly.
+ *
+ * LOCKING:
+ * EH context.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+void ata_acpi_associate_sata_port(struct ata_port *ap)
 {
-	acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
+	WARN_ON(!(ap->flags & ATA_FLAG_ACPI_SATA));
+
+	if (!ap->nr_pmp_links) {
+		acpi_integer adr = SATA_ADR(ap->port_no, NO_PORT_MULT);
+
+		ap->link.device->acpi_handle =
+			acpi_get_child(ap->host->acpi_handle, adr);
+	} else {
+		struct ata_link *link;
+
+		ap->link.device->acpi_handle = NULL;
 
-	ap->link.device->acpi_handle =
-		acpi_get_child(ap->host->acpi_handle, adr);
+		ata_port_for_each_link(link, ap) {
+			acpi_integer adr = SATA_ADR(ap->port_no, link->pmp);
+
+			link->device->acpi_handle =
+				acpi_get_child(ap->host->acpi_handle, adr);
+		}
+	}
 }
 
 static void ata_acpi_associate_ide_port(struct ata_port *ap)
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 14d8de8..26ff24e 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -595,6 +595,8 @@ int sata_pmp_attach(struct ata_device *dev)
 	ata_port_for_each_link(tlink, ap)
 		sata_link_init_spd(tlink);
 
+	ata_acpi_associate_sata_port(ap);
+
 	return 0;
 
  fail:
@@ -634,6 +636,8 @@ static void sata_pmp_detach(struct ata_device *dev)
 	ap->nr_pmp_links = 0;
 	link->pmp = 0;
 	spin_unlock_irqrestore(ap->lock, flags);
+
+	ata_acpi_associate_sata_port(ap);
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 006c8be..b59089b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -101,11 +101,13 @@ extern struct ata_port *ata_port_alloc(struct ata_host *host);
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+extern void ata_acpi_associate_sata_port(struct ata_port *ap);
 extern void ata_acpi_associate(struct ata_host *host);
 extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
 extern int ata_acpi_on_devcfg(struct ata_device *adev);
 #else
+static inline void ata_acpi_associate_sata_port(struct ata_port *ap) { }
 static inline void ata_acpi_associate(struct ata_host *host) { }
 static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
-- 
1.5.0.3


