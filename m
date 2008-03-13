From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/12] cy82c693: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:39 +0100
Message-ID: <20080313224439.7051.79036.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:13615 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758367AbYCMW36 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:58 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539470fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:57 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cy82c693.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -98,6 +98,8 @@
 #define CY82C963_MIN_BUS_SPEED	25
 #define CY82C963_MAX_BUS_SPEED	33
 
+static int pci_clock;
+
 /* the struct for the PIO mode timings */
 typedef struct pio_clocks_s {
 	u8	address_time;	/* Address setup (clocks) */
@@ -136,7 +138,7 @@ static int calc_clk(int time, int bus_sp
 static void compute_clocks(u8 pio, pio_clocks_t *p_pclk)
 {
 	int clk1, clk2;
-	int bus_speed = system_bus_clock();	/* get speed of PCI bus */
+	int bus_speed = pci_clock ? pci_clock : system_bus_clock();
 
 	/* we don't check against CY82C693's min and max speed,
 	 * so you can play with the idebus=xx parameter
@@ -447,6 +449,9 @@ static int __init cy82c693_ide_init(void
 
 module_init(cy82c693_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Andreas Krebs, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for the Cypress CY82C693 IDE");
 MODULE_LICENSE("GPL");
