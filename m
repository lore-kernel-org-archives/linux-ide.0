From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] libata-acpi.c: remove unneeded #if's
Date: Mon, 31 Mar 2008 02:05:30 +0300
Message-ID: <20080330230530.GN28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:54552 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbYC3XFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Mar 2008 19:05:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

These #if's are unneeded since they:
- did anyway not handle the CONFIG_ACPI_DOCK_MODULE case correctly and
- this is already handled in include/acpi/acpi_drivers.h and
- it's now correctly handled in kconfig.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ata/libata-acpi.c |    4 ----
 1 file changed, 4 deletions(-)

2a7326b50cd80e6570803d4efb7bc15e029e61e3 diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index bf98a56..1db912e 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -227,11 +227,9 @@ void ata_acpi_associate(struct ata_host *host)
 			acpi_install_notify_handler(ap->acpi_handle,
 						    ACPI_SYSTEM_NOTIFY,
 						    ata_acpi_ap_notify, ap);
-#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
 			/* we might be on a docking station */
 			register_hotplug_dock_device(ap->acpi_handle,
 						     ata_acpi_ap_notify, ap);
-#endif
 		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
@@ -241,11 +239,9 @@ void ata_acpi_associate(struct ata_host *host)
 				acpi_install_notify_handler(dev->acpi_handle,
 						ACPI_SYSTEM_NOTIFY,
 						ata_acpi_dev_notify, dev);
-#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
 				/* we might be on a docking station */
 				register_hotplug_dock_device(dev->acpi_handle,
 						ata_acpi_dev_notify, dev);
-#endif
 			}
 		}
 	}

