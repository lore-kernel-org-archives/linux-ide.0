From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/20] pata_rdc: add Power Management support
Date: Tue, 08 Feb 2011 13:25:12 +0100
Message-ID: <20110208122512.19110.28041.sendpatchset@linux-mhg7.site>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>From fa27d376b5fa43f73305154c1ca58aa93e1d4138 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 8 Feb 2011 12:39:27 +0100
Subject: [PATCH 13/20] pata_rdc: add Power Management support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_rdc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index f55ff82..a4a0d88 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -357,6 +357,10 @@ static struct pci_driver rdc_pci_driver = {
 	.id_table		= rdc_pci_tbl,
 	.probe			= rdc_init_one,
 	.remove			= rdc_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
 };
 
 
-- 
1.7.1
