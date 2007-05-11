From: akpm@linux-foundation.org
Subject: [patch 05/20] pata_acpi-restore-driver versus libata-clean-up-sff-init-mess
Date: Thu, 10 May 2007 22:48:47 -0700
Message-ID: <200705110548.l4B5mlAh007627@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58502 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758017AbXEKFtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

If you apply both libata-clean-up-sff-init-mess.patch and
pata_acpi-restore-driver.patch, you'll need to add this patch to
pata_acpi-restore-driver.patch

Cc: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/ata/pata_acpi.c~pata_acpi-restore-driver-vs-libata-clean-up-sff-init-mess-fix drivers/ata/pata_acpi.c
--- a/drivers/ata/pata_acpi.c~pata_acpi-restore-driver-vs-libata-clean-up-sff-init-mess-fix
+++ a/drivers/ata/pata_acpi.c
@@ -371,7 +371,7 @@ static const struct ata_port_operations 
 
 static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	static struct ata_port_info info = {
+	static const struct ata_port_info info = {
 		.sht		= &pacpi_sht,
 		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
 
@@ -381,11 +381,11 @@ static int pacpi_init_one (struct pci_de
 
 		.port_ops	= &pacpi_ops,
 	};
-	struct ata_port_info *port_info[1] = { &info };
+	const struct ata_port_info *ppi[] = { &info, NULL };
 
 	if (!ata_pata_acpi_present(pdev))
 		return -ENODEV;
-	return ata_pci_init_one(pdev, port_info, 1);
+	return ata_pci_init_one(pdev, ppi);
 }
 
 static const struct pci_device_id pacpi_pci_tbl[] = {
_
