From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] ata_piix: fix suspend/resume for some TOSHIBA laptops
Date: Tue, 10 Jul 2007 15:55:43 +0900
Message-ID: <20070710065543.GA23568@htj.dyndns.org>
References: <20070710063605.GA21994@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:57659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXGJGzu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 02:55:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1727283wah
        for <linux-ide@vger.kernel.org>; Mon, 09 Jul 2007 23:55:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070710063605.GA21994@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

ACPI implementations in several TOSHIBA laptops are weird and burn cpu
cycles for tens of seconds while trying to suspend if the PCI device
for the ATA controller is disabled when the ACPI suspend is called.

This patch uses DMI to match those machines and bypass device disable
on those machines during suspend.  As the device needs to be put into
enabled state on resume without affecting PCI enable count, matching
resume callback uses __pci_reenable_device().

This bug is reported in bugzilla bug 7780.

  http://bugzilla.kernel.org/show_bug.cgi?id=7780

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/libata.h |    2 
 2 files changed, 113 insertions(+), 2 deletions(-)

Index: work/drivers/ata/ata_piix.c
===================================================================
--- work.orig/drivers/ata/ata_piix.c
+++ work/drivers/ata/ata_piix.c
@@ -91,6 +91,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
+#include <linux/dmi.h>
 
 #define DRV_NAME	"ata_piix"
 #define DRV_VERSION	"2.11"
@@ -140,6 +141,9 @@ enum {
 	RV			= -3, /* reserved */
 
 	PIIX_AHCI_DEVICE	= 6,
+
+	/* host->flags bits */
+	PIIX_HOST_BROKEN_SUSPEND = (1 << 24),
 };
 
 struct piix_map_db {
@@ -159,6 +163,10 @@ static void piix_set_piomode (struct ata
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
+#ifdef CONFIG_PM
+static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
+static int piix_pci_device_resume(struct pci_dev *pdev);
+#endif
 
 static unsigned int in_module_init = 1;
 
@@ -255,8 +263,8 @@ static struct pci_driver piix_pci_driver
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
 #ifdef CONFIG_PM
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
+	.suspend		= piix_pci_device_suspend,
+	.resume			= piix_pci_device_resume,
 #endif
 };
 
@@ -878,6 +886,107 @@ static void ich_set_dmamode (struct ata_
 	do_pata_set_dmamode(ap, adev, 1);
 }
 
+#ifdef CONFIG_PM
+static struct dmi_system_id piix_broken_suspend_dmi_table[] = {
+	{
+		.ident = "TECRA M5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M5"),
+		},
+	},
+	{
+		.ident = "Satellite U200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U200"),
+		},
+	},
+	{
+		.ident = "Satellite U205",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U205"),
+		},
+	},
+	{
+		.ident = "Portege M500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE M500"),
+		},
+	},
+	{ }
+};
+
+static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+	int rc = 0;
+
+	rc = ata_host_suspend(host, mesg);
+	if (rc)
+		return rc;
+
+	/* Some braindamaged ACPI suspend implementations expect the
+	 * controller to be awake on entry; otherwise, it burns cpu
+	 * cycles and power trying to do something to the sleeping
+	 * beauty.
+	 */
+	if (dmi_check_system(piix_broken_suspend_dmi_table) &&
+	    mesg.event == PM_EVENT_SUSPEND) {
+		pci_save_state(pdev);
+
+		/* mark its power state as "unknown", since we don't
+		 * know if e.g. the BIOS will change its device state
+		 * when we suspend.
+		 */
+		if (pdev->current_state == PCI_D0)
+			pdev->current_state = PCI_UNKNOWN;
+
+		/* tell resume that it's waking up from broken suspend */
+		spin_lock_irqsave(&host->lock, flags);
+		host->flags |= PIIX_HOST_BROKEN_SUSPEND;
+		spin_unlock_irqrestore(&host->lock, flags);
+	} else
+		ata_pci_device_do_suspend(pdev, mesg);
+
+	return 0;
+}
+
+static int piix_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+	int rc;
+
+	if (host->flags & PIIX_HOST_BROKEN_SUSPEND) {
+		spin_lock_irqsave(&host->lock, flags);
+		host->flags &= ~PIIX_HOST_BROKEN_SUSPEND;
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		pci_set_power_state(pdev, PCI_D0);
+		pci_restore_state(pdev);
+
+		/* PCI device wasn't disabled during suspend.  Use
+		 * __pci_reenable_device() to avoid affecting the
+		 * enable count.
+		 */
+		rc = __pci_reenable_device(pdev);
+		if (rc)
+			dev_printk(KERN_ERR, &pdev->dev, "failed to enable "
+				   "device after resume (%d)\n", rc);
+	} else
+		rc = ata_pci_device_do_resume(pdev);
+
+	if (rc == 0)
+		ata_host_resume(host);
+
+	return rc;
+}
+#endif
+
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -217,6 +217,8 @@ enum {
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
 	ATA_HOST_STARTED	= (1 << 1),	/* Host started */
 
+	/* bits 24:31 of host->flags are reserved for LLD specific flags */
+
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
