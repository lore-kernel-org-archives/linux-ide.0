From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 4
Date: Tue, 2 Oct 2007 22:20:28 +0100
Message-ID: <20071002212028.GA967@srcf.ucam.org>
References: <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org> <47029423.6030605@garzik.org> <4702AC3B.2010004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:55550 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbXJBVUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 17:20:41 -0400
Content-Disposition: inline
In-Reply-To: <4702AC3B.2010004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com

Fix libata-acpi.c build failure.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- 

Sorry, I'd diffed the original against libata-dev master rather than 
ALL. This tidies up the changes.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 6896831..5ebbf16 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -101,7 +101,7 @@ static void ata_acpi_handle_hotplug (struct ata_port *ap, struct kobject *kobj,
 {
 	char event_string[12];
 	char *envp[] = { event_string, NULL };
-	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 
 	if (event == 0 || event == 1) {
 	       unsigned long flags;
@@ -127,7 +127,7 @@ static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
 	if (dev->sdev)
 		kobj = &dev->sdev->sdev_gendev.kobj;
 
-	ata_acpi_handle_hotplug (dev->ap, kobj, event);
+	ata_acpi_handle_hotplug (dev->link->ap, kobj, event);
 }
 
 static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
@@ -175,8 +175,8 @@ void ata_acpi_associate(struct ata_host *host)
 						     ata_acpi_ap_notify,
 						     ap);
 
-		for (j = 0; j < ata_port_max_devices(ap); j++) {
-			struct ata_device *dev = &ap->device[j];
+		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
+			struct ata_device *dev = &ap->link.device[j];
 
 			if (dev->acpi_handle)
 				acpi_install_notify_handler (dev->acpi_handle,

-- 
Matthew Garrett | mjg59@srcf.ucam.org
