Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D02066CB
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918180; cv=none; b=bp6ElVO2hE57jFsEuaWAh03nECGW2VrrzCs1P+O+h4FsAFjy0A0j3XiUokU6nqTlnkEeMBmGz+ov2VLuBxS61k2j95U2+q3UrAIFCpyT+236eTdBcN8MS2MLJWBQ5+Wh8T/C0tbgoRytH24U/xLsdUSOE3i6zD2uA/1zfNezKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918180; c=relaxed/simple;
	bh=aCJBE2lgj8MkqWDd1ScVKjhjkgNXfLiCz3sz3n79pEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esUM4w757Uxs6gA/idKT5S9GyOEmE6bQLqXY7CiLdY9fTH7RHeN91kLmvOPoyiam0w2ZxYNW6ZNzznFJXqf9j0+KmaDQ1Bky3Yt+S1BV/C/9BwcFskBbn5UZUlqNsWVG2tqtaVQngnp1kbGDxsXFAkLg9k7PQmrogla0UleUaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwemU5E+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwemU5E+"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913b539aabso3198790f8f.2
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742918176; x=1743522976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iam3/iyXlFRBKEXY5zGks8R7nTB81GJyDiAoBfPEZKE=;
        b=iwemU5E+WMrvFQzo5dKeY93FUlolpilCkE3pBCeteGljdwRdQ+4o3KEav6H0BIeS2q
         YREYr7Si6OLUEBPG32iV1Um4tPCahgCwjo27Ys4ot58sZNgGwepYSmemYZFkx7LylYnw
         Lkhw9+aWyLsQvPBnaQpt+yujY1HOTZeXfgrVm3tlp7sZzVp88cSJYsv6WJb+S48XSHAA
         8SFidU3fV281stEjV/i4gO1KuvGya9n5dAkt/NpJNTigMaWfAlsfdlqD/1ynWlgt/57s
         aaUquw6nNB1ZfKjwhlvIHwUKilAiNo3U/YrZM1hLIuvcGWR5aRQhqMHd4t9fG0Wyh9pJ
         8wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918176; x=1743522976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iam3/iyXlFRBKEXY5zGks8R7nTB81GJyDiAoBfPEZKE=;
        b=S+I/ZmBCFG5KD2q0MkiayIUKx/oVjtbraX7yuuJ6nS92gKR+HyxLWi1kK6dyc2OZL/
         FxyiAv+LYoZHz0ovGCxc3Flcisad+QD2Q9FgemCEQ+97vIk+uAOzhxpBAPO06RWPr4VJ
         S7Sahns54qiju7Or/JZKibp/EhVDYVTxWiZWBouNRwUd00mAfqdAdyQgVWwZLurZDw3w
         oSvtcsl1Bfb3cnPtx7ji/OzopvioApdmXPCw0qzQwvQaVpxEi+XZxaok5ztj9+L3ONyL
         fei4ltbjXO7tZqaV9737hh6c9DFtdyQ7QpsRRGUWeCPOfDuefJZ8tNmBpk8zWVWZRFem
         NEQA==
X-Gm-Message-State: AOJu0Yx3mhpT0Q1aViBRWc1a0gSU9NICI3SZMpf3XZQ4lKC3AQxoLWmZ
	B9p2wygXVZ5xHwCsqEY5+LxK8wAeoTocszkrhK8n2yWlsSWn4K5+TJl2I6DenhQ=
X-Gm-Gg: ASbGncvaRCoQimDOU4zjrAz0DhHwvB/CGSWHDvLuqOjE/jOlSP9UQVGBC+BQTiJLMCW
	vAaNRD9R4DPB4t1feExrBmHibrOETuEsgm+HWhpUvpS9XS2SGggmgct56Q4jc2p/8LkKCfBRj30
	sUUWzVPxLH+46VJ8f8cfNwtXvHNskaiOrFUn8Efymm6FBS3AnL0A4BDowcH6k/RSM3P/EW10C0R
	kM1wn2XB/318SzRfHGsZSfrElwNIt317krCNvqkjRglSTYS5gFZKatOIGDsdUJAHiMKH+Lsgcqx
	OPAOpE0Iw1wJ4FOL8Ev2bFw0RrbufaKvJDvphT4WbM4=
X-Google-Smtp-Source: AGHT+IGDHFkdiRLiroa7erJdIHO3+tgaBQGPwGJ67hDljqSscb/hFi8075Z/Ogor7B7EuKm/tC3J2A==
X-Received: by 2002:a05:6000:418a:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-3997f94de0dmr11953840f8f.41.1742918176326;
        Tue, 25 Mar 2025 08:56:16 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:eead:4845:67bf:e110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13753454f8f.29.2025.03.25.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:56:15 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Date: Tue, 25 Mar 2025 16:56:12 +0100
Message-Id: <20250325155613.352680-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325155613.352680-1-p.pisati@gmail.com>
References: <20250325155613.352680-1-p.pisati@gmail.com>
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
 drivers/ata/Kconfig       |  11 +++
 drivers/ata/Makefile      |   1 +
 drivers/ata/pata_cswarp.c | 185 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..2fa96dbf2e3e 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1025,6 +1025,17 @@ config PATA_GAYLE
 
 	  If unsure, say N.
 
+config PATA_CSWARP
+	tristate "Amiga CS Warp PATA support"
+	depends on M68K && AMIGA && ZORRO
+	help
+	  This option enables support for the on-board IDE interface on
+	  CS-Lab Warp Expansion Card (NOTE that idemode=native has to be
+	  set in Warp Configuration)
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
index 000000000000..e0a0db6f7cfd
--- /dev/null
+++ b/drivers/ata/pata_cswarp.c
@@ -0,0 +1,185 @@
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
+
+#define WARP_OFFSET_ATA         0x6000
+
+static const struct scsi_host_template pata_cswarp_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
+					 unsigned char *buf,
+					 unsigned int buflen, int rw)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = dev->link->ap;
+	volatile void __iomem *data_addr = ap->ioaddr.data_addr;
+	unsigned int words = buflen >> 1;
+	u16 *buf16 = (u16 *)buf;
+
+	/* Transfer multiple of 2 bytes */
+	if (rw == READ)
+		raw_insw(data_addr, buf16, words);
+	else
+		raw_outsw(data_addr, buf16, words);
+
+	/* Transfer trailing byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		unsigned char pad[2] = { };
+
+		/* Point buf to the tail of buffer */
+		buf16 += words;
+
+		if (rw == READ) {
+			*pad = raw_inw(data_addr);
+			*buf16 = pad[0];
+		} else {
+			pad[0] = *buf16;
+			raw_outw(*pad, data_addr);
+		}
+	}
+
+	return buflen;
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
+	struct ata_port *ap;
+	void __iomem *base;
+	unsigned long board = z->resource.start;
+
+	dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
+		 board);
+
+	if (!devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
+				     DRV_NAME))
+		return -ENXIO;
+
+	host = ata_host_alloc(&z->dev, 1);
+	if (!host)
+		return -ENXIO;
+
+	ap = host->ports[0];
+	base = ioremap(board + WARP_OFFSET_ATA, 0x1800);
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
+	ap->ioaddr.ctl_addr		= base + (0x1000 | (6UL << 2));
+
+	ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
+		      (unsigned long)ap->ioaddr.ctl_addr);
+
+	return ata_host_activate(host, 0, NULL,
+			  IRQF_SHARED, &pata_cswarp_sht);
+}
+
+static void pata_cswarp_remove(struct zorro_dev *z)
+{
+	struct ata_host *host = dev_get_drvdata(&z->dev);
+
+	ata_host_detach(host);
+	iounmap(host->ports[0]->ioaddr.data_addr);
+}
+
+static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
+	{ ZORRO_PROD_CSLAB_WARP_1260, 0},
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
+static int __init pata_cswarp_init(void) {
+	return zorro_register_driver(&pata_cswarp_driver);
+}
+
+static void __exit pata_cswarp_unregister(void) {
+	zorro_unregister_driver(&pata_cswarp_driver);
+}
+
+module_init(pata_cswarp_init);
+module_exit(pata_cswarp_unregister);
+
+MODULE_AUTHOR("Andrzej Rogozynski");
+MODULE_DESCRIPTION("low-level driver for CSWarp PATA");
+MODULE_LICENSE("GPL");
-- 
2.34.1

