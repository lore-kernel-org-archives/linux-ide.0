From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
Date: Wed, 22 Feb 2006 14:01:40 -0800
Message-ID: <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751486AbWBVWLB@vger.kernel.org>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Do drive/taskfile-specific commands before setting the drive mode.
This allows the taskfile to unlock the drive before trying to
set the drive mode.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-core.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
@@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
+	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);
+
+	WARN_ON (irqs_disabled());
+
+	if (!ata_dev_present(dev))
+		return 0;
+	ata_acpi_exec_tfs(ap);
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
-	if (!ata_dev_present(dev))
-		return 0;
-	ata_acpi_exec_tfs(ap);
 	if (dev->class == ATA_DEV_ATA)
 		ata_start_drive(ap, dev);
 
@@ -4319,6 +4323,7 @@ int ata_device_resume(struct ata_port *a
  */
 int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
 {
+	printk(KERN_DEBUG "ata%d: suspend device\n", ap->id);
 	if (!ata_dev_present(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
@@ -5099,6 +5104,7 @@ int pci_test_config_bits(struct pci_dev 
 
 int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
 {
+	dev_printk(KERN_DEBUG, &pdev->dev, "suspend PCI device\n");
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, PCI_D3hot);
@@ -5107,6 +5113,7 @@ int ata_pci_device_suspend(struct pci_de
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
+	dev_printk(KERN_DEBUG, &pdev->dev, "resume PCI device\n");
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
