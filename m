From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 28/30] loongson: fixup for FUJITSU disk
Date: Sat, 16 May 2009 06:33:23 +0800
Message-ID: <1242426803.10164.179.camel@falcon>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:57417 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbZEOWd3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 18:33:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so780208wah.21
        for <linux-ide@vger.kernel.org>; Fri, 15 May 2009 15:33:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org
Cc: Arnaud Patard <apatard@mandriva.com>, loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com, Philippe Vachon <philippe@cowpig.ca>, Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>

>From 2bf0cdb93b8b319fea11ee801a466d153667af83 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:57:52 +0800
Subject: [PATCH 28/30] loongson: fixup for FUJITSU disk

---
 drivers/ide/amd74xx.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 77267c8..3e1a487 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -23,6 +23,11 @@
 
 #define DRV_NAME "amd74xx"
 
+static const char *am74xx_quirk_drives[] = {
+	"FUJITSU MHZ2160BH G2",
+	NULL
+};
+
 enum {
 	AMD_IDE_CONFIG		= 0x41,
 	AMD_CABLE_DETECT	= 0x42,
@@ -112,6 +117,19 @@ static void amd_set_pio_mode(ide_drive_t *drive,
const u8 pio)
 	amd_set_drive(drive, XFER_PIO_0 + pio);
 }
 
+static void amd_quirkproc(ide_drive_t *drive)
+{	
+	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
+
+	for (list = am74xx_quirk_drives; *list != NULL; list++)
+			if (strstr(m, *list) != NULL) {
+				drive->quirk_list = 2;
+				return;
+			}
+
+	drive->quirk_list = 0;
+}
+
 static void amd7409_cable_detect(struct pci_dev *dev)
 {
 	/* no host side cable detection */
@@ -194,6 +212,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
*hwif)
 static const struct ide_port_ops amd_port_ops = {
 	.set_pio_mode		= amd_set_pio_mode,
 	.set_dma_mode		= amd_set_drive,
+	.quirkproc		= amd_quirkproc,
 	.cable_detect		= amd_cable_detect,
 };
 
-- 
1.6.2.1



