From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/12] aec62xx: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:12 +0100
Message-ID: <20080313224412.7051.9681.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:13615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062AbYCMW3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:31 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539470fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:30 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/aec62xx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -13,6 +13,8 @@
 
 #include <asm/io.h>
 
+static int pci_clock;
+
 struct chipset_bus_clock_list_entry {
 	u8 xfer_speed;
 	u8 chipset_settings;
@@ -140,7 +142,7 @@ static void aec_set_pio_mode(ide_drive_t
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
 {
-	int bus_speed = system_bus_clock();
+	int bus_speed = pci_clock ? pci_clock : system_bus_clock();
 
 	if (bus_speed <= 33)
 		pci_set_drvdata(dev, (void *) aec6xxx_33_base);
@@ -308,6 +310,9 @@ static int __init aec62xx_ide_init(void)
 
 module_init(aec62xx_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for ARTOP AEC62xx IDE");
 MODULE_LICENSE("GPL");
