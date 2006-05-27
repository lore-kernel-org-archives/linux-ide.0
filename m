From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 00:00:53 -0400
Message-ID: <4477CEF5.9000908@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <4477C60E.1070106@rtr.ca> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050101010204050600050809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:62182 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750887AbWE0EBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 00:01:00 -0400
In-Reply-To: <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050101010204050600050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Although I didn't even bother to compile-test it, here is the 
recommended solution, as described multiple times...

Testers might wanna put msleep(500) in pata_pci_device_resume(), before 
the port loop, to let the SATA phy settle...

	Jeff




--------------050101010204050600050809
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

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
index fa476e7..95e0885 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4852,6 +4852,30 @@ int ata_pci_device_resume(struct pci_dev
 	pci_set_master(pdev);
 	return 0;
 }
+
+int pata_pci_device_resume(struct pci_dev *pdev)
+{
+	struct device *dev = pci_dev_to_dev(pdev);
+	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_port *ap;
+	int i, rc = 0;
+	u8 status;
+
+	ata_pci_device_resume(pdev);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		ap = host_set->ports[i];
+
+		status = ata_busy_wait(ap, ATA_BUSY, 200000);
+		if (status & ATA_BUSY) {
+			printk(KERN_ERR "ata%u: failed to resume\n", ap->id);
+			rc = -EIO;
+		}
+	}
+
+	return rc;
+}
+
 #endif /* CONFIG_PCI */
 
 
@@ -4970,6 +4994,7 @@ EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
+EXPORT_SYMBOL_GPL(pata_pci_device_resume);
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */

--------------050101010204050600050809--
