From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 28/68] add ide2libata header file
Date: Fri, 29 Jan 2010 17:06:09 +0100
Message-ID: <20100129160609.21495.41616.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754654Ab0A2QG3@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] add ide2libata header file

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide2libata.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: b/include/linux/ide2libata.h
===================================================================
--- /dev/null
+++ b/include/linux/ide2libata.h
@@ -0,0 +1,17 @@
+#ifndef __IDE2LIBATA_H
+#define __IDE2LIBATA_H
+
+#include <linux/ide.h>
+
+#define __IDE2LIBATA		1
+
+#define ATA_DEV_ATA		ide_disk
+
+#define ata_host		ide_host
+#define ata_port		hwif_s
+#define ata_device		ide_drive_s
+
+#define ata_pio_need_iordy(d)	ide_pio_need_iordy(d, d->pio_mode - XFER_PIO_0)
+#define ata_dev_pair		ide_get_pair_dev
+
+#endif /* __IDE2LIBATA_H */
