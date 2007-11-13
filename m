From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it821x/jmicron: fix return value of {it821x,jmicron}_init_one()
Date: Tue, 13 Nov 2007 22:05:58 +0100
Message-ID: <200711132205.58797.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:58240 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758338AbXKMVHf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:07:35 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1946508fkz
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:07:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it821x.c  |    3 +--
 drivers/ide/pci/jmicron.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -653,8 +653,7 @@ static const struct ide_port_info it821x
 
 static int __devinit it821x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &it821x_chipsets[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &it821x_chipsets[id->driver_data]);
 }
 
 static const struct pci_device_id it821x_pci_tbl[] = {
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -139,8 +139,7 @@ static const struct ide_port_info jmicro
 
 static int __devinit jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &jmicron_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &jmicron_chipset);
 }
 
 /* All JMB PATA controllers have and will continue to have the same
