Return-Path: <SRS0=E6CZ=VK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92AC742A7
	for <linux-ide@archiver.kernel.org>; Sat, 13 Jul 2019 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3F72083B
	for <linux-ide@archiver.kernel.org>; Sat, 13 Jul 2019 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGMOCt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:02:49 -0400
Received: from enpas.org ([46.38.239.100]:52416 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfGMOCt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 13 Jul 2019 10:02:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 7CB70FFBD9;
        Sat, 13 Jul 2019 14:02:45 +0000 (UTC)
From:   Max Staudt <max-linux@enpas.org>
To:     linux-ide@vger.kernel.org
Cc:     Max Staudt <max-linux@enpas.org>
Subject: [PATCH] ata/pata_buddha: Probe via modalias instead of initcall
Date:   Sat, 13 Jul 2019 16:02:41 +0200
Message-Id: <20190713140241.27076-1-max-linux@enpas.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Up until now, the pata_buddha driver would only check for cards on
initcall time. Now, the kernel will call its probe function as soon
as a compatible card is detected.

Device removal remains unimplemented. A WARN_ONCE() serves as a
reminder.

Tested-by: Max Staudt <max-linux@enpas.org>
Signed-off-by: Max Staudt <max-linux@enpas.org>
---
 drivers/ata/pata_buddha.c | 240 ++++++++++++++++++++++++++++------------------
 1 file changed, 146 insertions(+), 94 deletions(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index 11a8044ff..ed9f9777b 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -19,6 +19,7 @@
 #include <linux/libata.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/zorro.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -29,7 +30,7 @@
 #include <asm/setup.h>
 
 #define DRV_NAME "pata_buddha"
-#define DRV_VERSION "0.1.0"
+#define DRV_VERSION "0.1.1"
 
 #define BUDDHA_BASE1	0x800
 #define BUDDHA_BASE2	0xa00
@@ -47,11 +48,11 @@ enum {
 	BOARD_XSURF
 };
 
-static unsigned int buddha_bases[3] __initdata = {
+static unsigned int buddha_bases[3] = {
 	BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
 };
 
-static unsigned int xsurf_bases[2] __initdata = {
+static unsigned int xsurf_bases[2] = {
 	XSURF_BASE1, XSURF_BASE2
 };
 
@@ -145,111 +146,162 @@ static struct ata_port_operations pata_xsurf_ops = {
 	.set_mode	= pata_buddha_set_mode,
 };
 
-static int __init pata_buddha_init_one(void)
+static int pata_buddha_probe(struct zorro_dev *zdev,
+			     const struct zorro_device_id *ent)
 {
-	struct zorro_dev *z = NULL;
-
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		static const char *board_name[]
-			= { "Buddha", "Catweasel", "X-Surf" };
-		struct ata_host *host;
-		void __iomem *buddha_board;
-		unsigned long board;
-		unsigned int type, nr_ports = 2;
-		int i;
-
-		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
-			type = BOARD_BUDDHA;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL) {
-			type = BOARD_CATWEASEL;
-			nr_ports++;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
-			type = BOARD_XSURF;
-		} else
-			continue;
-
-		dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
-
-		board = z->resource.start;
+	static const char * const board_name[]
+		= { "Buddha", "Catweasel", "X-Surf" };
+	struct ata_host *host;
+	void __iomem *buddha_board;
+	unsigned long board;
+	unsigned int type, nr_ports = 2;
+	int i;
+
+	switch (zdev->id) {
+	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA:
+	default:
+		type = BOARD_BUDDHA;
+		break;
+	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL:
+		type = BOARD_CATWEASEL;
+		nr_ports++;
+		break;
+	case ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF:
+		type = BOARD_XSURF;
+		break;
+	}
+
+	dev_info(&zdev->dev, "%s IDE controller\n", board_name[type]);
+
+	board = zdev->resource.start;
+
+	if (type != BOARD_XSURF) {
+		if (!devm_request_mem_region(&zdev->dev,
+					     board + BUDDHA_BASE1,
+					     0x800, DRV_NAME))
+			return -ENXIO;
+	} else {
+		if (!devm_request_mem_region(&zdev->dev,
+					     board + XSURF_BASE1,
+					     0x1000, DRV_NAME))
+			return -ENXIO;
+		if (!devm_request_mem_region(&zdev->dev,
+					     board + XSURF_BASE2,
+					     0x1000, DRV_NAME)) {
+			devm_release_mem_region(&zdev->dev,
+						board + XSURF_BASE1,
+						0x1000);
+			return -ENXIO;
+		}
+	}
+
+	/* allocate host */
+	host = ata_host_alloc(&zdev->dev, nr_ports);
+	if (!host)
+		goto err_ata_host_alloc;
+
+	buddha_board = ZTWO_VADDR(board);
+
+	/* enable the board IRQ on Buddha/Catweasel */
+	if (type != BOARD_XSURF)
+		z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
+
+	for (i = 0; i < nr_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *base, *irqport;
+		unsigned long ctl = 0;
 
 		if (type != BOARD_XSURF) {
-			if (!devm_request_mem_region(&z->dev,
-						     board + BUDDHA_BASE1,
-						     0x800, DRV_NAME))
-				continue;
+			ap->ops = &pata_buddha_ops;
+			base = buddha_board + buddha_bases[i];
+			ctl = BUDDHA_CONTROL;
+			irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
 		} else {
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE1,
-						     0x1000, DRV_NAME))
-				continue;
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE2,
-						     0x1000, DRV_NAME))
-				continue;
+			ap->ops = &pata_xsurf_ops;
+			base = buddha_board + xsurf_bases[i];
+			/* X-Surf has no CS1* (Control/AltStat) */
+			irqport = buddha_board + XSURF_IRQ;
 		}
 
-		/* allocate host */
-		host = ata_host_alloc(&z->dev, nr_ports);
-		if (!host)
-			continue;
-
-		buddha_board = ZTWO_VADDR(board);
-
-		/* enable the board IRQ on Buddha/Catweasel */
-		if (type != BOARD_XSURF)
-			z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
-
-		for (i = 0; i < nr_ports; i++) {
-			struct ata_port *ap = host->ports[i];
-			void __iomem *base, *irqport;
-			unsigned long ctl = 0;
-
-			if (type != BOARD_XSURF) {
-				ap->ops = &pata_buddha_ops;
-				base = buddha_board + buddha_bases[i];
-				ctl = BUDDHA_CONTROL;
-				irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
-			} else {
-				ap->ops = &pata_xsurf_ops;
-				base = buddha_board + xsurf_bases[i];
-				/* X-Surf has no CS1* (Control/AltStat) */
-				irqport = buddha_board + XSURF_IRQ;
-			}
-
-			ap->pio_mask = ATA_PIO4;
-			ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
-
-			ap->ioaddr.data_addr		= base;
-			ap->ioaddr.error_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
-			ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
-			ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
-			ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
-			ap->ioaddr.device_addr		= base + 2 + 6 * 4;
-			ap->ioaddr.status_addr		= base + 2 + 7 * 4;
-			ap->ioaddr.command_addr		= base + 2 + 7 * 4;
-
-			if (ctl) {
-				ap->ioaddr.altstatus_addr = base + ctl;
-				ap->ioaddr.ctl_addr	  = base + ctl;
-			}
-
-			ap->private_data = (void *)irqport;
-
-			ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
-				      ctl ? board + buddha_bases[i] + ctl : 0);
+		ap->pio_mask = ATA_PIO4;
+		ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
+
+		ap->ioaddr.data_addr		= base;
+		ap->ioaddr.error_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
+		ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
+		ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
+		ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
+		ap->ioaddr.device_addr		= base + 2 + 6 * 4;
+		ap->ioaddr.status_addr		= base + 2 + 7 * 4;
+		ap->ioaddr.command_addr		= base + 2 + 7 * 4;
+
+		if (ctl) {
+			ap->ioaddr.altstatus_addr = base + ctl;
+			ap->ioaddr.ctl_addr	  = base + ctl;
 		}
 
-		ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
-				  IRQF_SHARED, &pata_buddha_sht);
+		ap->private_data = (void *)irqport;
 
+		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
+			      ctl ? board + buddha_bases[i] + ctl : 0);
 	}
 
+	ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+			  IRQF_SHARED, &pata_buddha_sht);
+
+
 	return 0;
+
+err_ata_host_alloc:
+	switch (type) {
+	case BOARD_BUDDHA:
+	case BOARD_CATWEASEL:
+	default:
+		devm_release_mem_region(&zdev->dev,
+					board + BUDDHA_BASE1,
+					0x800);
+		break;
+	case BOARD_XSURF:
+		devm_release_mem_region(&zdev->dev,
+					board + XSURF_BASE1,
+					0x1000);
+		devm_release_mem_region(&zdev->dev,
+					board + XSURF_BASE2,
+					0x1000);
+		break;
+	}
+
+	return -ENXIO;
+}
+
+static void pata_buddha_remove(struct zorro_dev *zdev)
+{
+	/* NOT IMPLEMENTED */
+
+	WARN_ONCE(1, "pata_buddha: Attempted to remove driver. This is not implemented yet.\n");
 }
 
-module_init(pata_buddha_init_one);
+static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
+
+static struct zorro_driver pata_buddha_driver = {
+	.name           = "pata_buddha",
+	.id_table       = pata_buddha_zorro_tbl,
+	.probe          = pata_buddha_probe,
+	.remove         = pata_buddha_remove,
+};
+
+module_driver(pata_buddha_driver,
+	      zorro_register_driver,
+	      zorro_unregister_driver);
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");
-- 
2.11.0

