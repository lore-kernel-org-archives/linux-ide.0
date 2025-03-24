Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5A25DCFA
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818612; cv=none; b=eEvr4mzXAUpASB0loD/ibAMKnc0+8zGIt0INNQU22MtSf0A5NEoFS7GcDhDVvHmzbMEJap6D+G8kyv0yXv6pecbX00Ng0zUcAjAvFuqoHI//+h40d8OcIg1Fet+PqlvTEhUnuvOvPD2XSjSWfkZRc7sazcrDUPbQqI+B/RG6s1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818612; c=relaxed/simple;
	bh=y0y9DBWxWNZskx7dSirVLJ4UYEQsYJZGkerOi2idTUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSQ0Z7DGBE7Wl/gNqzGZu64CS5X2fzXCdlYKhWRI0PFzGpJG2ecfDybAPmHJ1gTqdbGsdIg9TW7dH9I8ResOMSJktgBjUEt6R/cuFiedvfWUXCkblWvk2kNjcz9eIPuTFQ+zJx5XiDbrvubpDUMtGy32/+MCCFoLdUtfzWxhGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnN35oia; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnN35oia"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2750846f8f.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818609; x=1743423409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/5QKJRQFmOiVIYZFGjmeM5uxqtjsm5TVNG+LAuHHW4=;
        b=SnN35oiaXe2nl+4d4Mo1DRvpWX1JjnEB2+/fq7M77eCf/yjmrxR4FNv23MaaQv38uX
         V2yO0zSuoka7egM4gFjtuJc7pCAyP9FFRCP5CsZN2HXY1yIVsVEOoZ+jwimUaTFXever
         aitG2cI2FqVFeGX/VDWGQDbVvg+/MPyWgf0/i5TymJnPzqgjOx4Wxmmw/+QcXgJMnvoq
         XQ6Cd+lZIuhBROrsZ9mq41Qin3Zv0zFqp00Z9F3busp3B4zq5e2QbTqOEL22JBShk/1U
         2pxtpsoSIJ8aEGVDWHkdN4dShC1xNQT/davvvaSJG5ePOWlLPkznJhT7PVb4u5RIZbtn
         DTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818609; x=1743423409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/5QKJRQFmOiVIYZFGjmeM5uxqtjsm5TVNG+LAuHHW4=;
        b=XbvNyk6rJWePQOLvHD1r+r7o3s0dC/udn6Li2ZZ0UmSvdiaYtdLvQP6lIsomo1qefS
         OesNNCmWveK2+tOQztprBWywK9Taubhd2QiRSpsNdVI73Y/rDaLSndrsYEzkMAPERKjw
         +BwqNd8H/9Z02n8qESI2eullNA1M8meARE4ubnM0AYdQ4ZyiwYF5+p4m6BL9eR2ReP+D
         7MkanqmPdDRn3twCT4a/6bQWim7B32jUmY5XSX7+Iv3X8goq665zXiRE7MZE3Ou0NIAe
         RZpEioSy2O1fRc2K79cKHPHABZ8Uxb4nxKRlB2HnDakJkGcs6dtEZTOkMco5rTyoNb8O
         ZPfQ==
X-Gm-Message-State: AOJu0YzxM0itTxKesLUw1tHvs7yGcyS3Ds/p8d7yd79YcqrWSAnIiMuj
	9kcieMUJYeOa7SUgXMReSFQhEIrVpYuIYyJ1FpwAeupD2UXTxankN/AtA+c0
X-Gm-Gg: ASbGncvIllwJAmX6rekr2sFteGBU1U46Euyp9YOiq2A+edf+Q5/nss8m4FZ4XidM1DH
	Vok+VNK0Zvcmv8x1Y9AefYq21ybgUfYgTUMCgyUakcnV1GEUFXz0e0bih3ec02Xh31S8aTyxAyP
	DtC4T/NgZhosgHaz5DpX7n548KYeLO0BWAuphWi++8I6obT4rn75LtTmzh6RXlLG9kAwphYm3xy
	iHHNvvTWtqEhFxxijY1laeSzmUcJPdhC2Gz5o27uBwEIx0/vi7m5L4bNZDzNq1YOwbfB4o51n0N
	wiFwn9F/MJ1dHOfuuKMy4kDWbsh0O0JTYXVhifna/V0=
X-Google-Smtp-Source: AGHT+IG+fLoGI0iN4FRW0j8vTx/tO3CvaqUmTkc9GOjG0wJ6nZVQuLRwtIenDrew/zYAunbD4tOFmA==
X-Received: by 2002:a5d:6c6b:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-3997f8edb2amr11190740f8f.5.1742818608948;
        Mon, 24 Mar 2025 05:16:48 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd348sm118942425e9.39.2025.03.24.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:16:48 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v3 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Date: Mon, 24 Mar 2025 13:16:44 +0100
Message-Id: <20250324121645.208368-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324121645.208368-1-p.pisati@gmail.com>
References: <20250324121645.208368-1-p.pisati@gmail.com>
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
 drivers/ata/pata_cswarp.c | 186 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..a278386f0fa2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1025,6 +1025,17 @@ config PATA_GAYLE
 
 	  If unsure, say N.
 
+config PATA_CSWARP
+	tristate "Amiga CS Warp PATA support"
+	depends on M68K && AMIGA
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
index 000000000000..fd135fe3bde7
--- /dev/null
+++ b/drivers/ata/pata_cswarp.c
@@ -0,0 +1,186 @@
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
+	struct ata_port *ap;
+	void __iomem *cswarp_ctrl_board, *base;
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
+	cswarp_ctrl_board = (void *)board;
+
+	ap = host->ports[0];
+	base = cswarp_ctrl_board + WARP_OFFSET_ATA;
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

