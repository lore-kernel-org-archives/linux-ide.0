From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: libata-acpi.c ata_acpi_register_power_resource copy and paste mistake ?
Date: Thu, 28 Feb 2013 17:45:10 +0100
Message-ID: <928867757.20130228174510@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Jeff,

During the last merge of ahci code (d9978ec5680059d727b39d6c706777c6973587f2), i saw this coming by:


--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1024,30 +1024,20 @@ static void ata_acpi_register_power_resource(struct ata_device *dev)
 {
        struct scsi_device *sdev = dev->sdev;
        acpi_handle handle;
-       struct device *device;
 
        handle = ata_dev_acpi_handle(dev);
-       if (!handle)
-               return;
-
-       device = &sdev->sdev_gendev;
-
-       acpi_power_resource_register_device(device, handle);
+       if (handle)
+               acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);
 }

shouldn't:

acpi_dev_pm_remove_dependent(handle, &sdev->sdev_gendev);

be

acpi_dev_pm_add_dependent(handle, &sdev->sdev_gendev);

in the ata_acpi_register_power_resource function ?

(seems like a copy and paste mistake from the unregister function)

--
Sander
