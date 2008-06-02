From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/9] ide_4drives: use struct ide_port_info
Date: Mon, 02 Jun 2008 22:23:56 +0200
Message-ID: <20080602202356.7265.68692.sendpatchset@localhost.localdomain>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:17008 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbYFBUW2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 16:22:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1229319mue.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 13:22:27 -0700 (PDT)
In-Reply-To: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Convert the driver to use struct ide_port_info - as a nice side-effect
this fixes hwif->channel initialization.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide-4drives.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

Index: b/drivers/ide/legacy/ide-4drives.c
===================================================================
--- a/drivers/ide/legacy/ide-4drives.c
+++ b/drivers/ide/legacy/ide-4drives.c
@@ -11,6 +11,23 @@ static int probe_4drives;
 module_param_named(probe, probe_4drives, bool, 0);
 MODULE_PARM_DESC(probe, "probe for generic IDE chipset with 4 drives/port");
 
+static void ide_4drives_port_init_devs(ide_hwif_t *hwif)
+{
+	if (hwif->channel) {
+		hwif->drives[0].select.all ^= 0x20;
+		hwif->drives[1].select.all ^= 0x20;
+	}
+}
+
+static const struct ide_port_ops ide_4drives_port_ops = {
+	.port_init_devs		= ide_4drives_port_init_devs,
+};
+
+static const struct ide_port_info ide_4drives_port_info = {
+	.port_ops		= &ide_4drives_port_ops,
+	.host_flags		= IDE_HFLAG_SERIALIZE | IDE_HFLAG_NO_DMA,
+};
+
 static int __init ide_4drives_init(void)
 {
 	ide_hwif_t *hwif, *mate;
@@ -49,18 +66,10 @@ static int __init ide_4drives_init(void)
 	mate = ide_find_port();
 	if (mate) {
 		ide_init_port_hw(mate, &hw);
-		mate->drives[0].select.all ^= 0x20;
-		mate->drives[1].select.all ^= 0x20;
 		idx[1] = mate->index;
-
-		if (hwif) {
-			hwif->mate = mate;
-			mate->mate = hwif;
-			hwif->serialized = mate->serialized = 1;
-		}
 	}
 
-	ide_device_add(idx, NULL);
+	ide_device_add(idx, &ide_4drives_port_info);
 
 	return 0;
 }
