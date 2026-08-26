Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF443BDC3
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760558; cv=none; b=e+G4P2D0gxFHkwRIGWZLuvRswQh7rhfo0qeDEQr6wPT9EqzMLAlGUAZnT4oEcm16XgRSYHTBYJEF9gSMhr64H5MCgpNP2A0L07PNAIMEKA1l/gzZhnv9X62POqrUQ+dvf/o77vFQat5ejqfmq+KS9lWWe4lpzlbwd8vTRV30UQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760558; c=relaxed/simple;
	bh=L4+/ZQw3YHf0BCOhgBrZwXFZUwSTK2iDO/3+BWEZN5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfBTnCq8Vbb0+83e1iL2SrbsMwn2HWwijJfWAK3eCHoLhfd/sSEQ/7uhggiIkFjl+kXZRmihL3WIY0mY44wzyh3zLtyzeY05VrpCEKD9TPZreSjn6I7aL3pd0mXO52Kll8Wne0tB7hV7MgnaUu7qzW35iJDILMqb1pWhqdcOHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5r07cfI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5r07cfI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c207cb16cf5so173324666b.1
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760555; x=1788365355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hI3mYRdhlr5CeiAItzv4SK5OhRBppU0F4bFSHdSvzCA=;
        b=J5r07cfIJgPcg4MawNiGzAgptV1NhZdMrxA7s3kkG8KdXSnjY1JZRWoFVGIpxdVlCY
         FAH+LgKDIEsv457KEAEl9TKE5fv6OLgBt2Ig6tyPmtAGQNXFvN9IWG9MywnGs4kvLOS2
         8kxoF1CWdIel+c+o84LSvO7pGfb1ZostMB4uXImHR3q69zue795HgWdtjoJJcQ9NzHzx
         TWf2Tm1Al1E1wEFt2hjpl9jKEBJXUwNTbBX9b16Bl00w2PzZl3e80akT9X9NYpW2DtPD
         k+hl4hb7/jqJxZFaVV5QbUSdh89kd+GX8zTh2ggPqqVOxj/rCpGX6+5o0Do2galut5YW
         AyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760555; x=1788365355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hI3mYRdhlr5CeiAItzv4SK5OhRBppU0F4bFSHdSvzCA=;
        b=SX3PIMcgtm1UGhaK/OL+GqW6DPhC3gRC6Q8co48CLAvtFRiS86kXMpM/HsApH1tD0n
         1xDpOtSKfOy6I7/L3zKJAqepPDFLTCIm7mDbJGORc26yBFnxrkfF+QdfAI5ZY4ztmS7y
         1EfbUxVuwlt8bZtFc8G5lGcLhMvvPH1xZ1Q4Dl2Uz1ta8mMO4QlCVAx4Aei4tGuiMJWT
         XpnpWJ7V/lxQh1qZpopkG9B6t/vfiGq4FHYAxuuq4MpXC+ZtNJXOdm2zGZ/uVEIdREId
         J5N414xkuNXY7JI5GuBEl9OYUM8xgbQW5TOHnYSccG+xNW4d2D0NKKfmSHAf0FYUQAxL
         CAXw==
X-Gm-Message-State: AFuF++n8eGrvSFrJ3fMboZxnKkTZXEPM/YX1hF12m8erYT9QUCmu/zj+
	Peu5ezD2dmt4v50F92aItobwbL2t1zYvte9xu92GsgXrlam7NBSXoUGR
X-Gm-Gg: AR+sD13mWYAY18RfaIaUsiZ3qZPJtcBG+mDMadTSVDjQA0T5HFvFWd4tlsckMax92CY
	4YJarrlLuGwoshXMvYBJG7+MNe81lgAqL+7qY8Roay/4sieqZL4Lqqn7ALxVffR3SubFXDFOVk2
	TtBOGDFVnXDfGj4oYJOdzYmJ8E5cg5cRE1Ih7GnGBfkLKU6cjXiGNX4LklLjVeub8m9kk7DI7eX
	UN7A3SOJSrqL6L0MUf+XxSTFSfKSaC9vIhf+DTWF80poDYw4oiS3Ag6SGrH+6itj9c349qe6GTC
	JNheQ1Gt/k+FxEQkgiskwXC5XrkD85dvEgcRkx5GMrjSbLNMGLhZaaDnfkIRwLSDWamfmbnmG56
	yStHA6ZxNhkZdMajTn9iye5WAefvtDSrp3K3imwl3rdPH7VJWykZvS6KpFDZ/Bu2nOSMe+VOFFV
	FzaAeZwtZTkpOQwVJXWO/jkOTehp+IEPF6msnEKljxqKMmIqMXrGNbT0OfP95C+Punl8bPTDQiW
	0j9gIDUo5n396WvIO21MSkKKRf/e/ujFPTKw2/vSPgyuHrfrs3Si7WpwA==
X-Received: by 2002:a17:907:c22:b0:c21:4393:c41a with SMTP id a640c23a62f3a-c250c312bbbmr948010466b.11.1787760554568;
        Wed, 26 Aug 2026 09:09:14 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:78ce:12f6:160d:28db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c251b7a9936sm413925966b.49.2026.08.26.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:09:13 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Date: Wed, 26 Aug 2026 18:09:10 +0200
Message-ID: <20260826160911.460165-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826160911.460165-1-p.pisati@gmail.com>
References: <20260826160911.460165-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver for the on-board IDE interface on CS-Lab Warp Expansion Card
(NOTE that idemode=native has to be set in Warp Configuration)

Assisted-by: Claude_Code:claude-opus-5
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/ata/Kconfig       |  10 +++
 drivers/ata/Makefile      |   1 +
 drivers/ata/pata_cswarp.c | 183 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/ata/pata_cswarp.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 28ca856ecc75..86af89a9bfce 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1040,6 +1040,16 @@ config PATA_GAYLE
 
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
 config PATA_BUDDHA
 	tristate "Buddha/Catweasel/X-Surf PATA support"
 	depends on ZORRO
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b96025abd45e..647e3d4b6f75 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_PATA_WINBOND)	+= pata_sl82c105.o
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_FALCON)	+= pata_falcon.o
 obj-$(CONFIG_PATA_GAYLE)	+= pata_gayle.o
+obj-$(CONFIG_PATA_CSWARP)	+= pata_cswarp.o
 obj-$(CONFIG_PATA_BUDDHA)	+= pata_buddha.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
diff --git a/drivers/ata/pata_cswarp.c b/drivers/ata/pata_cswarp.c
new file mode 100644
index 000000000000..58fe6d0012dc
--- /dev/null
+++ b/drivers/ata/pata_cswarp.c
@@ -0,0 +1,183 @@
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
+#include <linux/device-id/zorro.h>
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
+					  unsigned char *buf,
+					  unsigned int buflen, int rw)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
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
+		if (rw == READ)
+			buf[buflen - 1] = raw_inw(data_addr) >> 8;
+		else
+			raw_outw(buf[buflen - 1] << 8, data_addr);
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
+				struct ata_device **unused)
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
+	struct resource *res;
+	void __iomem *base;
+	unsigned long board = z->resource.start;
+
+	dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
+		 board);
+
+	res = devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
+				      DRV_NAME);
+	if (!res)
+		return -ENXIO;
+
+	host = ata_host_alloc(&z->dev, 1);
+	if (!host)
+		return -ENXIO;
+
+	ap = host->ports[0];
+	base = devm_ioremap(&z->dev, board + WARP_OFFSET_ATA, 0x1800);
+	if (!base)
+		return -ENOMEM;
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
+	ata_port_desc(ap, "mmio %pR", res);
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
+	{ .id = ZORRO_PROD_CSLAB_WARP_1260 },
+	{ }
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
+static int __init pata_cswarp_init(void)
+{
+	return zorro_register_driver(&pata_cswarp_driver);
+}
+
+static void __exit pata_cswarp_unregister(void)
+{
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
2.43.0

