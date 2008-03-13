From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/12] amd74xx: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:26 +0100
Message-ID: <20080313224426.7051.37571.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:13615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758223AbYCMW3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:44 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539470fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:43 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/amd74xx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -32,6 +32,8 @@ enum {
 	AMD_UDMA_TIMING		= 0x50,
 };
 
+static int pci_clock;
+
 static unsigned int amd_80w;
 static unsigned int amd_clock;
 
@@ -179,7 +181,7 @@ static unsigned int __devinit init_chips
  * Determine the system bus clock.
  */
 
-	amd_clock = system_bus_clock() * 1000;
+	amd_clock = (pci_clock ? pci_clock : system_bus_clock()) * 1000;
 
 	switch (amd_clock) {
 		case 33000: amd_clock = 33333; break;
@@ -353,6 +355,9 @@ static int __init amd74xx_ide_init(void)
 
 module_init(amd74xx_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Vojtech Pavlik");
 MODULE_DESCRIPTION("AMD PCI IDE driver");
 MODULE_LICENSE("GPL");
