From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/12] via82cxxx: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:53 +0100
Message-ID: <20080313224453.7051.50484.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758455AbYCMWaM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:30:12 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539392fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:30:11 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/via82cxxx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -94,6 +94,8 @@ static struct via_isa_bridge {
 	{ NULL }
 };
 
+static int pci_clock;
+
 static unsigned int via_clock;
 static char *via_dma[] = { "16", "25", "33", "44", "66", "100", "133" };
 
@@ -340,7 +342,7 @@ static unsigned int __devinit init_chips
 	 * Determine system bus clock.
 	 */
 
-	via_clock = system_bus_clock() * 1000;
+	via_clock = (pci_clock ? pci_clock : system_bus_clock()) * 1000;
 
 	switch (via_clock) {
 		case 33000: via_clock = 33333; break;
@@ -495,6 +497,9 @@ static int __init via_ide_init(void)
 
 module_init(via_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Vojtech Pavlik, Michel Aubry, Jeff Garzik, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for VIA IDE");
 MODULE_LICENSE("GPL");
