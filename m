Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E21D54CF
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570067; cv=none; b=AQoyPRL+HW6sBUd/XicZzUgYxWUSZc4HwMYiEuOjMF1TiGkI+Y9TqtCr+3HZp2z/blvAZHz4TFQsDY59wY4vq/0YqD9j6eP1bJLbvf7NQ+hZbhNWKO87LpzbsqDaPc3wBgOuripiW27qY6o8YrVmsGPi9GTovMeRxWGkoYvvK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570067; c=relaxed/simple;
	bh=DawW5PCjNnIhqqs1JO7l1UIOU1hgJMK1H/jEEo0z1N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APlOn5OpS1qVQI958wJBm8VQ05fNx13xqb6mytVYqQotoH/dXne0yLAGSk8Mgh/4ZL++uyHP/DepynlOLu8mtM4KkDOlerIdMR6Vr+Jc0BW+ZS2dWezjvg5kbuiu6zira7IDPgz2qRC5wcaJOqyKN3QsT8XLe7moUVa/U+dwUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp73xayU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp73xayU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf848528aso17639955e9.2
        for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2025 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570062; x=1743174862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/QrWl0NR+D5Vl8+O++b8dZnZ72cF0vdmQ4hfy1eiwk=;
        b=Rp73xayU9wx3zC4JitK6WsiTWmeULzK2ouTsVlxJS+561TIxV4DrkLFpoL6FtmDYOv
         g62slBwcA5XW/vu/kJoo43Gj3Cz4g73d/NnyrqsSi0SyTPSjm3doRfwOVuWD1RcdVGAt
         wPz8SAoqDOUoifPizBSacBP7BON9cDRxu3zzJn21W76XYwCWh9tGajvdsyEbqNUFE7/2
         o4VzNZCQvnPsOU1toWNDSlcAmVxZJIIXhofsi0vhKO9TsPxuone76vSWPQ/jgZzSeMjk
         Z5Y8ICZZwiQXZDlJObLEiVXn0ELh/8Zy+Umvtf2lvBI7UuyrT3vS2ZpXuzzAuL97XMsc
         OcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570062; x=1743174862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/QrWl0NR+D5Vl8+O++b8dZnZ72cF0vdmQ4hfy1eiwk=;
        b=mybiDDXPZTHH94LJTT4x8LXbfBBC525FcJardpBv+5UcoXOrUjjJ/e8UCu12nahAdo
         bMWtYH5hSyoVmSPUTPNCEfmSaaMa9R2x+JS3qfWC2HQ9pLj8XJDJn8GjLsCAhbtT8Y9q
         ddOxbuW0Ai8xAsORCmyewEUMnhBrZLE8rUDUyw+fH/F6HwAQsleivV4Q37i9rycl0GKG
         jFQuKDQKu80Na5u9yDb/dQb8882KqlkkzHwJe4VRytp7MT0SSWDFGP3IPcwclbD/fm3C
         2Dki+i1pVRggpn4SCrfqjYN20gVfoZuDDLhkNP/CGprAcKnfSgsHfqVz0A1+4djWnwEo
         4oMQ==
X-Gm-Message-State: AOJu0Yyc12RUsa3H1d0eBSw2d3kQoOCk7x8Nd5gKg5zk0lA6kU+FNHji
	Zn8iU4BZmo1oM7QTqZjC5MUgStFgsbGbV1DB1VxdZOY8xywvovRs
X-Gm-Gg: ASbGncsfQB6mDa+FrWPtnvy71voNySE2kXFOZ4+xY3LPKHvsS1DzC4Rk4HQC0aEM2lD
	1HsM6HqiYemhwUOxUtWpW81QZ0CsSyPaOmblP55LNDuPBcVr59TGDLzjqe5jDy9sv6Fee0tV1DC
	E6l9vRFZHlEPMXloEznBdjTdIiN72eNOtPyu1EQFsDW4MPzxOtI+fGi45mL/cHB+UKyUyRsi4AF
	d+/VxgpsnBDCVWImKz/DBRcdIIF/wDZmk1maV5L/59DPapkLkSkQ4gVCXaYDy5BXfgw9EAlH06t
	SmirVhDQEZT/alcUC7dBw0on+RBbirRoe6b6C63+OoM=
X-Google-Smtp-Source: AGHT+IHfO/15ShIut24Th0Z/N6iktnYQWvYiPe4qIdvkGxEHa5DGDz0WNnYOpeAzA3uU4E8PVuogHg==
X-Received: by 2002:a05:6000:400f:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-3997f8fb09emr3763061f8f.14.1742570062002;
        Fri, 21 Mar 2025 08:14:22 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:91ef:3e94:acab:b42b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995a05sm2589159f8f.8.2025.03.21.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:14:21 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 2/3] amiga: cslab ata support
Date: Fri, 21 Mar 2025 16:14:15 +0100
Message-Id: <20250321151416.338756-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321151416.338756-1-p.pisati@gmail.com>
References: <20250321151416.338756-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
(NOTE that idemode=native has to be set in Warp Configuration)

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/ata/Kconfig            |  12 ++
 drivers/ata/Makefile           |   1 +
 drivers/ata/pata_cswarp.c      | 210 +++++++++++++++++++++++++++++++++
 drivers/zorro/zorro.ids        |   5 +
 include/uapi/linux/zorro_ids.h |   6 +
 5 files changed, 234 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..9ec4d3a7ec1e 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1025,6 +1025,18 @@ config PATA_GAYLE
 
 	  If unsure, say N.
 
+config PATA_CSWARP
+	tristate "Amiga CS Warp PATA support"
+	depends on M68K && AMIGA
+	help
+	  This option enables support for the on-board IDE
+	  interface on CS-Lab Warp Expansion Card
+	  (NOTE that idemode=native has to be set in Warp
+	  Configuration)
+
+	  If unsure, say N.
+
+
 config PATA_BUDDHA
 	tristate "Buddha/Catweasel/X-Surf PATA support"
 	depends on ZORRO
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 20e6645ab737..7b9b87ebacea 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_FALCON)	+= pata_falcon.o
 obj-$(CONFIG_PATA_GAYLE)	+= pata_gayle.o
+obj-$(CONFIG_PATA_CSWARP)	+= pata_cswarp.o
 obj-$(CONFIG_PATA_BUDDHA)	+= pata_buddha.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
diff --git a/drivers/ata/pata_cswarp.c b/drivers/ata/pata_cswarp.c
new file mode 100644
index 000000000000..29d76b22f1b2
--- /dev/null
+++ b/drivers/ata/pata_cswarp.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Amiga CS Warp PATA controller driver
+ *
+ * Copyright (c) 2024 CS-Lab s.c.
+ *		http://www.cs-lab.eu
+ *
+ * Based on pata_gayle.c, pata_buddha.c and warpATA.device:
+ *
+ *     Created 2 Jun 2024 by Andrzej Rogozynski
+ */
+
+#include <linux/ata.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/zorro.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_host.h>
+
+#include <asm/amigahw.h>
+#include <asm/amigaints.h>
+#include <asm/amigayle.h>
+#include <asm/setup.h>
+
+#define DRV_NAME "pata_cswarp"
+#define DRV_VERSION "0.1.0"
+
+#define WARP_OFFSET_ATA         0x6000
+#define REV16(x) ((uint16_t)((x << 8) | (x >> 8)))
+
+static const struct scsi_host_template pata_cswarp_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+/* FIXME: is this needed? */
+static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
+					 unsigned char *buf,
+					 unsigned int buflen, int rw)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
+	unsigned int words = buflen >> 1;
+
+	/* Transfer multiple of 2 bytes */
+	if (rw == READ)
+		raw_insw((u16 *)data_addr, (u16 *)buf, words);
+	else
+		raw_outsw((u16 *)data_addr, (u16 *)buf, words);
+
+	/* Transfer trailing byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		unsigned char pad[2] = { };
+
+		/* Point buf to the tail of buffer */
+		buf += buflen - 1;
+
+		if (rw == READ) {
+			raw_insw((u16 *)data_addr, (u16 *)pad, 1);
+			*buf = pad[0];
+		} else {
+			pad[0] = *buf;
+			raw_outsw((u16 *)data_addr, (u16 *)pad, 1);
+		}
+		words++;
+	}
+
+	return words << 1;
+}
+
+/*
+ * Provide our own set_mode() as we don't want to change anything that has
+ * already been configured..
+ */
+static int pata_cswarp_set_mode(struct ata_link *link,
+			       struct ata_device **unused)
+{
+	struct ata_device *dev;
+
+	ata_for_each_dev(dev, link, ENABLED) {
+		/* We don't really care */
+		dev->pio_mode = dev->xfer_mode = XFER_PIO_0;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		dev->flags |= ATA_DFLAG_PIO;
+		ata_dev_info(dev, "configured for PIO\n");
+	}
+	return 0;
+}
+
+static struct ata_port_operations pata_cswarp_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.sff_data_xfer	= pata_cswarp_data_xfer,
+	.cable_detect	= ata_cable_unknown,
+	.set_mode	= pata_cswarp_set_mode,
+};
+
+static int pata_cswarp_probe(struct zorro_dev *z,
+			     const struct zorro_device_id *ent)
+{
+	static const char board_name[] = "csWarp";
+	struct ata_host *host;
+	void __iomem *cswarp_ctrl_board;
+	unsigned long board;
+
+	board = z->resource.start;
+
+	dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
+		 board);
+
+	if (!devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
+				     DRV_NAME))
+		return -ENXIO;
+
+	/* allocate host */
+	host = ata_host_alloc(&z->dev, 1);
+	if (!host)
+		return -ENXIO;
+
+	cswarp_ctrl_board = (void *)board;
+
+	struct ata_port *ap = host->ports[0];
+	void __iomem *base = cswarp_ctrl_board + WARP_OFFSET_ATA;
+
+	ap->ops = &pata_cswarp_ops;
+
+	ap->pio_mask = ATA_PIO4;
+	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY |
+		ATA_FLAG_PIO_POLLING;
+
+	ap->ioaddr.data_addr		= base;
+	ap->ioaddr.error_addr		= base + 1 * 4;
+	ap->ioaddr.feature_addr		= base + 1 * 4;
+	ap->ioaddr.nsect_addr		= base + 2 * 4;
+	ap->ioaddr.lbal_addr		= base + 3 * 4;
+	ap->ioaddr.lbam_addr		= base + 4 * 4;
+	ap->ioaddr.lbah_addr		= base + 5 * 4;
+	ap->ioaddr.device_addr		= base + 6 * 4;
+	ap->ioaddr.status_addr		= base + 7 * 4;
+	ap->ioaddr.command_addr		= base + 7 * 4;
+
+	ap->ioaddr.altstatus_addr	= base + (0x1000 | (6UL << 2));
+	ap->ioaddr.ctl_addr			= base + (0x1000 | (6UL << 2));
+
+	ap->private_data = (void *)0;
+
+	ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
+		      (unsigned long)ap->ioaddr.ctl_addr);
+
+	ata_host_activate(host, 0, NULL,
+			  IRQF_SHARED, &pata_cswarp_sht);
+
+	return 0;
+}
+
+static void pata_cswarp_remove(struct zorro_dev *z)
+{
+	struct ata_host *host = dev_get_drvdata(&z->dev);
+
+	ata_host_detach(host);
+}
+
+static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
+	{ ZORRO_PROD_CSLAB_WARP_CTRL, 0},
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(zorro, pata_cswarp_zorro_tbl);
+
+static struct zorro_driver pata_cswarp_driver = {
+	.name           = "pata_cswarp",
+	.id_table       = pata_cswarp_zorro_tbl,
+	.probe          = pata_cswarp_probe,
+	.remove         = pata_cswarp_remove,
+};
+
+/*
+ * We cannot have a modalias for X-Surf boards, as it competes with the
+ * zorro8390 network driver. As a stopgap measure until we have proper
+ * MFD support for this board, we manually attach to it late after Zorro
+ * has enumerated its boards.
+ */
+static int __init pata_cswarp_late_init(void)
+{
+	struct zorro_dev *z = NULL;
+
+	/* Auto-bind to regular boards */
+	zorro_register_driver(&pata_cswarp_driver);
+
+	/* Manually bind to all boards */
+	while ((z = zorro_find_device(ZORRO_PROD_CSLAB_WARP_CTRL, z))) {
+		static struct zorro_device_id cswarp_ent = {
+			ZORRO_PROD_CSLAB_WARP_CTRL, 0
+		};
+
+		pata_cswarp_probe(z, &cswarp_ent);
+	}
+	return 0;
+}
+late_initcall(pata_cswarp_late_init);
+
+MODULE_AUTHOR("Andrzej Rogozynski");
+MODULE_DESCRIPTION("low-level driver for CSWarp PATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/zorro/zorro.ids b/drivers/zorro/zorro.ids
index 119abea8c6cb..33418af7488a 100644
--- a/drivers/zorro/zorro.ids
+++ b/drivers/zorro/zorro.ids
@@ -400,6 +400,11 @@
 	0100  ISDN Blaster Z2 [ISDN Interface]
 	0200  HyperCom 4 [Multi I/O]
 	0600  HyperCom 4+ [Multi I/O]
+1400 CSLab
+	6000  Warp DDR3 Memory
+	0001  Warp Video Memory
+	0101  Warp Control Registers
+	0201  Warp Flash ROM
 157c  Information
 	6400  ISDN Engine I [ISDN Interface]
 2017  Vortex
diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
index 0be1fb0c3915..5736d2bf0295 100644
--- a/include/uapi/linux/zorro_ids.h
+++ b/include/uapi/linux/zorro_ids.h
@@ -455,6 +455,12 @@
 #define ZORRO_PROD_CSLAB_WARP_CTRL				ZORRO_ID(CSLAB, 0x65, 0)
 #define ZORRO_PROD_CSLAB_WARP_XROM				ZORRO_ID(CSLAB, 0x66, 1)
 
+#define ZORRO_MANUF_CSLAB                   0x1400
+#define ZORRO_PROD_CSLAB_WARP_DDR3          ZORRO_ID(CSLAB, 0x3c, 0)
+#define ZORRO_PROD_CSLAB_WARP_VRAM          ZORRO_ID(CSLAB, 0x64, 0)
+#define ZORRO_PROD_CSLAB_WARP_CTRL          ZORRO_ID(CSLAB, 0x65, 0)
+#define ZORRO_PROD_CSLAB_WARP_XROM          ZORRO_ID(CSLAB, 0x66, 1)
+
 #define ZORRO_MANUF_INFORMATION					0x157C
 #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I			ZORRO_ID(INFORMATION, 0x64, 0)
 
-- 
2.34.1

