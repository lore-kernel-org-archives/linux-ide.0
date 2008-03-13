From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/12] opti621: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:46 +0100
Message-ID: <20080313224446.7051.13895.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:13615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406AbYCMWaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:30:05 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539470fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:30:04 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -123,6 +123,8 @@
 
 static int reg_base;
 
+static int pci_clock;
+
 #define PIO_NOT_EXIST 254
 #define PIO_DONT_KNOW 255
 
@@ -210,7 +212,7 @@ static void compute_clocks(int pio, pio_
 {
 	if (pio != PIO_NOT_EXIST) {
 		int adr_setup, data_pls;
-		int bus_speed = system_bus_clock();
+		int bus_speed = pci_clock ? pci_clock : system_bus_clock();
 
 		adr_setup = ide_pio_timings[pio].setup_time;
 		data_pls = ide_pio_timings[pio].active_time;
@@ -376,6 +378,9 @@ static int __init opti621_ide_init(void)
 
 module_init(opti621_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Jaromir Koutek, Jan Harkes, Mark Lord");
 MODULE_DESCRIPTION("PCI driver module for Opti621 IDE");
 MODULE_LICENSE("GPL");
