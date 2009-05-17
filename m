From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH] [IDE] Add VIA VX855 PCI Device ID
Date: Sun, 17 May 2009 14:16:39 +0800
Message-ID: <20090517061639.GG4909@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:50229 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZEQGhz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 02:37:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Joseph Chan <JosephChan@via.com.tw>, Bruce Chang <BruceChang@via.com.tw>

This patch adds the PCI Device ID 0xc409 to the PCI ID table of via82cxxx.c,
as well as the 0x8409 south bridge ID.

This is required to make the IDE driver work on the VX855/VX875 integrated
chipset.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/ide/via82cxxx.c |    2 ++
 include/linux/pci_ids.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 3ff7231..028de26 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -67,6 +67,7 @@ static struct via_isa_bridge {
 	u8 udma_mask;
 	u8 flags;
 } via_isa_bridges[] = {
+	{ "vx855",	PCI_DEVICE_ID_VIA_VX855,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
@@ -474,6 +475,7 @@ static const struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1),  0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1),  0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_CX700_IDE), 0 },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_VX855_IDE), 0 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_6410),      1 },
 	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_SATA_EIDE), 1 },
 	{ 0, },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 06ba90c..0f71812 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1406,7 +1406,7 @@
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_838X_1	0xB188
 #define PCI_DEVICE_ID_VIA_83_87XX_1	0xB198
-#define PCI_DEVICE_ID_VIA_C409_IDE	0XC409
+#define PCI_DEVICE_ID_VIA_VX855_IDE	0xC409
 #define PCI_DEVICE_ID_VIA_ANON		0xFFFF
 
 #define PCI_VENDOR_ID_SIEMENS           0x110A
-- 
1.6.2.4
