From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/12] alim15x3: add "pci_clock=" parameter
Date: Thu, 13 Mar 2008 23:44:19 +0100
Message-ID: <20080313224419.7051.7555.sendpatchset@localhost.localdomain>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbYCMW3i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 18:29:38 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3539392fga.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 15:29:37 -0700 (PDT)
In-Reply-To: <20080313224352.7051.44005.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add "pci_clock=" parameter for specifying PCI bus clock frequency (in MHz).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -40,6 +40,8 @@
 
 #define DISPLAY_ALI_TIMINGS
 
+static int pci_clock;
+
 /*
  *	ALi devices are not plug in. Otherwise these static values would
  *	need to go. They ought to go away anyway
@@ -294,7 +296,7 @@ static void ali_set_pio_mode(ide_drive_t
 	int s_time, a_time, c_time;
 	u8 s_clc, a_clc, r_clc;
 	unsigned long flags;
-	int bus_speed = system_bus_clock();
+	int bus_speed = pci_clock ? pci_clock : system_bus_clock();
 	int port = hwif->channel ? 0x5c : 0x58;
 	int portFIFO = hwif->channel ? 0x55 : 0x54;
 	u8 cd_dma_fifo = 0;
@@ -839,6 +841,9 @@ static int __init ali15x3_ide_init(void)
 
 module_init(ali15x3_ide_init);
 
+module_param(pci_clock, int, 0);
+MODULE_PARM_DESC(pci_clock, "PCI bus clock frequency (in MHz)");
+
 MODULE_AUTHOR("Michael Aubry, Andrzej Krzysztofowicz, CJ, Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for ALi 15x3 IDE");
 MODULE_LICENSE("GPL");
