From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH alt4 v3] libata resume fixes
Date: Sat, 27 May 2006 16:52:13 -0400
Message-ID: <20060527205213.GA30686@havoc.gtf.org>
References: <20060527195847.GA28334@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:17350 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964964AbWE0UwO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:52:14 -0400
Content-Disposition: inline
In-Reply-To: <20060527195847.GA28334@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: liml@rtr.ca, torvalds@osdl.org


Here's alt4 v3.  Having the host_stat == 0x1 was suspicious.
After digging through the hardware manual, it might be a good idea to
configure BMDMA registers properly, in case that was done by BIOS but
not by D3->D0 silicon reset values.

One core problem with all of libata suspend/resume is that
* we boot from a configuration set up by BIOS
* but going D3->D0, we simply get silicon defaults

Randy Dunlap's ACPI patches will probably help a bit.


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 6dc8814..949d496 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -201,7 +201,7 @@ static struct pci_driver piix_pci_driver
 	.probe			= piix_init_one,
 	.remove			= ata_pci_remove_one,
 	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
+	.resume			= pata_pci_device_resume,
 };
 
 static struct scsi_host_template piix_sht = {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..1289e80 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4296,10 +4296,8 @@ static int ata_start_drive(struct ata_po
  */
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
-	if (ap->flags & ATA_FLAG_SUSPENDED) {
+	if (ap->flags & ATA_FLAG_SUSPENDED)
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
-		ata_set_mode(ap);
-	}
 	if (!ata_dev_present(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
@@ -4852,6 +4850,40 @@ int ata_pci_device_resume(struct pci_dev
 	pci_set_master(pdev);
 	return 0;
 }
+
+int pata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_port *ap;
+	unsigned long bmdma;
+	int i;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		bmdma = ap->ioaddr.bmdma_addr;
+
+		outb(0, bmdma + ATA_DMA_CMD);
+		ata_altstatus(ap);
+		outb(0xff, bmdma + ATA_DMA_STATUS);
+		ata_altstatus(ap);
+	}
+
+	pci_set_master(pdev);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+		if (ata_bus_probe(ap))
+			printk(KERN_ERR "ata%u: failed to resume\n", ap->id);
+	}
+
+	return 0;
+}
+
 #endif /* CONFIG_PCI */
 
 
@@ -4970,6 +5002,7 @@ EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
+EXPORT_SYMBOL_GPL(pata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b80d2e7..cad531a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -516,6 +516,7 @@ extern int ata_pci_init_one (struct pci_
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
+extern int pata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);

