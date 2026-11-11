Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415059;
	b=fVpQcNorF6DCTdfbT6XXHOK6khjpI0dOD08bCr0A3MwDi8WPmjD4kYTHgP8HwxJ+ELMk
	 O5RjYFPwHrg0R0Smn5YIFXBUdgeVyGz1YXHXWeo6RmiYzLH89Tc0bTm3WAVbfWFnGxEMn
	 DxDyXYhltWZZ9QACZVMl8ZOTSHVZaAnOESB22yMNaDGAhME57nd4af3EHKKWzpGP9f4zR
	 YAkgeeicnuNuYvwwDyzaCAqdrZhsQ4AXNfU8Jmp6TIQr5yGBU8Xdlh6tNobKHViCe13SP
	 4Ed192cZbArJsuSuMFnA35y8Mi39zVDkQ8vrd0p3vIiyTOGwT0J6XKwzjgLRAfyx5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wuyvace6ciytd5jUR1xreUhLnUkhsuMz/ZH/NBTGYXo=;
	b=XZSfqpODCPa6XEAB2VAAJws4Tpq4Jwde0xGYwkLweBvua/c8wb26H37sgetljKDtnI5J
	 1Lwj8/M89Cwf76hd3lnOmcvgU/asRiIzFeTsDgbZSQap04+i2OsCXEV05NKBPd7TZ8bBi
	 C9+xlU4KQcFTI+t7b+gQbu6e4HmLPGBoy2OQxH25W/YKe6N7+Iqio9H9VADT2HkGW88ax
	 YaxeBDDnjTGm/SKIJznp0H40NH6zLy4auSK/LnyatSTM03MqDd3d3Rjy0hfIBfoumZx0R
	 gl06CJXNwZsRURAo5+MYFHUlw81QLG7BCa4aZex0zi0qejA1PqpJu/zfIaQhnIH7B3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrylLEmy;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59624606A32A
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59624606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrylLEmy
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214af2076so25015475e9.0
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415058; x=1795019858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wuyvace6ciytd5jUR1xreUhLnUkhsuMz/ZH/NBTGYXo=;
        b=VrylLEmytbtCh+/tOwdIO2gs1oXNpb9z6/fnfzmC8zJk0DfDNb9Af1mQYWS30w1sMV
         xZfmv7FuAS6VhDRxgkP589nn7fK5d0uWFtPgbnHwLNF1l34/v+hw37oADR8l3jp02Emq
         H9gSQg1w79NHWVvoELrchnCpd0hWRaOlIlP2iv3XOJ+b4H54fQpq3TGRp2c5QvPcMagV
         odlbf5p1z/YhVsH3TYxtz55jEsB0k+GyEugRh/ZE3VO8BO1R+4tFaVk5Wckpr8uNNb0t
         KQrIXNyfzFctXiF9V5vesS6hkOGdfuurbdKpk/TD3hxZ+Klocg6sBTP/ewf9oL8fpaGh
         i5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415058; x=1795019858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wuyvace6ciytd5jUR1xreUhLnUkhsuMz/ZH/NBTGYXo=;
        b=E5W2Ob6xnU7gzmn8XKMmIB8Qz/yR2DMqyb+0F+Gca1nLcBjaZgna6nL9MxVk8Faxnr
         KeXltc9r+xNG2zF02yVf9+eTqLe5O1EFeYKsB2jkZDkkI4p1H89pvlqXJrjMNgKUKeMt
         6dq7HMH7yZzdqV5Ygkqym0swSHt0t5CaNU9QWoFz2aatvXzK/Z5P+i2TJIP38Mfhdtw3
         Mx1lU4ufqpkLwLZHx8YbvNcFToUVA8LDT20a7vWsf9Cb15gXsPJz4v7O0RarBsmBKAwv
         0CxbgLr1KfVzpPzXlhBhut4vOBrY4Ys3ruGyc4aym7RzzTw9AJvCgeBKY3KGE4jzC8jf
         PBww==
X-Forwarded-Encrypted: i=1; AL+hErEt8GIUzCzFNxYB07ijYSHsYTW1qvq/2RC1Eb3I94vIICJB+eRbMxLuo4c+ggksUproZ1KFngkWqXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d96AgNxYhQeDvKeFc7bKnQV6naT9nP5wWFpJ3rSg3G3DlMr8T
	pCSboIuqO9lma7zZf8PabrGMWwKlAL1ca2OQ7/vSZ0QgW8YR5t4RIo+C
X-Gm-Gg: AYBFou3jmCco5Iz4zLvzF0DK9WGVRSzMN7oDpoSpCJWbb3mclefztxW9arcvUjuMnPZ
	Nb4o8MIGx2DSd+PSThibzYgfJWW9C9TeMX+2cQe5Hs6WaR6XoY3q6SJ5CYm5zxGR3lzq36IJ971
	dp0g63NsRcjnVGpHmkKkMznuVSbktav9usjeSY4nZFzEJKUblKi5MSBvkROBHHaBP9vi76SpwHY
	GhzT2boWEYl0y+UxOQblTgU6cJcXGHMeMq+iqgrYZRD76X4KFXZqOOJec/7h/G/0/uKWXQSx64w
	FE+e+/CGgguSx0hhrnI8luwTHO47tUh7GZWZRQuxqNWIech4l3POXHM0Y/Snco5HjC7UgZ7B3u3
	a75j5wakWl9VYv2QZJh39h+Xo2vOty6oRWRIc4xm8a7lPrumDbQ7EaAK5WCqyKBqV49Jtu4KQdU
	aNR/rfAY6+7ScwK1wUvZQk8tvgK6uE3C9hjackWxIqmSrv7l6xcXG+X7TgbGzw+qwJFjNmw/JYr
	ZD09qdIKYERs7YLAj2GFIJ9zVQzRvxrJbzZTZMelQu6bhp5us3u1jdQic8IHrpk/5hxrbl7BuXf
	cO2L4pOQgsSIyrwrZAIorUXHip0X0krlAeDtaIbQUqe2iC9169ALlIRvai/mniG5uTGhr829zCc
	FcuSqADoTLbXG+A==
X-Received: by 2002:a05:600c:310b:b0:4ba:a5:b920 with SMTP id 5b1f17b1804b1-4ba0936d8dcmr54021965e9.16.1794415057486;
        Wed, 11 Nov 2026 08:37:37 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e258e8dsm825955e9.4.2026.11.11.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:37 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 1/7] zorro: warp mfd: add the CS-Lab Warp multifunction parent
Date: Wed, 11 Nov 2026 17:37:28 +0100
Message-ID: <20261111163735.227286-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111163735.227286-1-p.pisati@gmail.com>
References: <20261111163735.227286-1-p.pisati@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Warp 1260 is an A1200 trapdoor accelerator whose single Zorro device
fronts several functions: an ARM co-processor reached through a
dual-port RAM window, and an IDE interface and an RTG display controller
that the 68k drives directly.
pata_cswarp claims the whole device for the IDE window alone, which
leaves no way for anything else on the board to get a driver.

Add a parent that owns the Zorro device and describes the functions as
mfd cells, starting with the IDE window as a "warp-pata" cell.

Only the window layout is described here; the dual-port RAM protocol
arrives with its first user.
pata_cswarp is converted in the next patch.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 MAINTAINERS              |  7 ++++
 drivers/zorro/Kconfig    | 30 ++++++++++++++
 drivers/zorro/Makefile   |  2 +
 drivers/zorro/warp-mfd.c | 89 ++++++++++++++++++++++++++++++++++++++++
 drivers/zorro/warp-mfd.h | 19 +++++++++
 5 files changed, 147 insertions(+)
 create mode 100644 drivers/zorro/warp-mfd.c
 create mode 100644 drivers/zorro/warp-mfd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..cfabc4609c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7173,6 +7173,13 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	tools/crypto/tcrypt/tcrypt_speed_compare.py
 
+CS-LAB WARP MULTIFUNCTION DRIVER
+M:	Paolo Pisati <p.pisati@gmail.com>
+L:	linux-m68k@lists.linux-m68k.org
+S:	Maintained
+F:	drivers/zorro/warp-mfd.c
+F:	drivers/zorro/warp-mfd.h
+
 CS3308 MEDIA DRIVER
 M:	Hans Verkuil <hverkuil@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/zorro/Kconfig b/drivers/zorro/Kconfig
index 41475ad46e45..c9ab9fb4b9ee 100644
--- a/drivers/zorro/Kconfig
+++ b/drivers/zorro/Kconfig
@@ -17,3 +17,33 @@ config ZORRO_NAMES
 
 	  When in doubt, say Y.
 
+# Zorro multifunction drivers
+
+config WARP_MFD
+	tristate "CS-Lab Warp multifunction driver"
+	depends on ZORRO
+	select MFD_CORE
+	help
+	  The CS-Lab Warp 1260 is an A1200 trapdoor accelerator. Besides the
+	  68060 it carries an FPGA and an ARM co-processor; its control
+	  registers, the dual-port RAM and the IDE interface share one Zorro
+	  device, which this driver binds to.
+
+	  The 68k drives these through the FPGA: the on-board IDE interface and
+	  an RTG display controller.
+
+	  The co-processor owns the rest, reached over the dual-port RAM: two
+	  USB host ports, an SD card slot, an ESP32 WiFi bridge,
+	  an audio mixer, the Kickstart slot selection, the CPU clock and turbo
+	  levels, thermal regulation of the fan, and the board telemetry.
+
+	  This driver hands the IDE window to pata_cswarp - which needs
+	  idemode=native set in Warp Configuration to be of any use - and
+	  exposes the configuration and telemetry reachable over the dual-port
+	  RAM in sysfs: voltages, temperatures, fan, firmware version and
+	  Kickstart slot. Nothing else on the list has a driver yet.
+
+	  If you have a CS-Lab Warp 1260 board, say Y. Otherwise, say N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called warp-mfd.
diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index 91ba82e633e7..6fe7cc1822dc 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_ZORRO_NAMES) +=  names.o
 
+obj-$(CONFIG_WARP_MFD) += warp-mfd.o
+
 hostprogs		:= gen-devlist
 
 # Files generated that shall be removed upon make clean
diff --git a/drivers/zorro/warp-mfd.c b/drivers/zorro/warp-mfd.c
new file mode 100644
index 000000000000..94af7c9d0ea5
--- /dev/null
+++ b/drivers/zorro/warp-mfd.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CS-Lab Warp multifunction driver
+ *
+ * Copyright 2026 Paolo Pisati <p.pisati@gmail.com>
+ *
+ * The Warp 1260 is an A1200 trapdoor accelerator made by CS-Lab. Besides the
+ * 68060 it carries an ARM co-processor which owns most of the peripherals,
+ * and the IDE interface and RTG display controller, which the 68k drives
+ * directly.
+ *
+ * This driver claims the Zorro device and hands the IDE window to pata_cswarp
+ * as an mfd cell.
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+
+#include <linux/zorro.h>
+
+#include <linux/mfd/core.h>
+
+#include "warp-mfd.h"
+
+static const struct mfd_cell warp_mfd_cells[] = {
+	{
+		.name		= "warp-pata",
+		.num_resources  = 1,
+		.resources	= (const struct resource []) {
+			DEFINE_RES_MEM_NAMED(WARP_OFFSET_ATA, WARP_ATA_SIZE,
+					     "pata"),
+		}
+	}
+};
+
+static int warp_mfd_probe(struct zorro_dev *z,
+			  const struct zorro_device_id *ent)
+{
+	int error;
+
+	dev_info(&z->dev, "Warp at %pR\n", &z->resource);
+
+	error = mfd_add_devices(&z->dev, z->dev.id, warp_mfd_cells,
+				ARRAY_SIZE(warp_mfd_cells), &z->resource,
+				0, NULL);
+	if (error) {
+		dev_err(&z->dev, "mfd_add_devices() failed %d\n", error);
+		return error;
+	}
+	return 0;
+}
+
+static void warp_mfd_remove(struct zorro_dev *z)
+{
+	mfd_remove_devices(&z->dev);
+}
+
+static const struct zorro_device_id warp_mfd_ids[] = {
+	{ .id = ZORRO_PROD_CSLAB_WARP_1260 },
+	{ }
+};
+MODULE_DEVICE_TABLE(zorro, warp_mfd_ids);
+
+static struct zorro_driver warp_mfd_driver = {
+	.name		= "warp-mfd",
+	.id_table	= warp_mfd_ids,
+	.probe		= warp_mfd_probe,
+	.remove		= warp_mfd_remove
+};
+
+static int __init warp_mfd_init(void)
+{
+	return zorro_register_driver(&warp_mfd_driver);
+}
+
+static void __exit warp_mfd_exit(void)
+{
+	zorro_unregister_driver(&warp_mfd_driver);
+}
+
+module_init(warp_mfd_init);
+module_exit(warp_mfd_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paolo Pisati <p.pisati@gmail.com>");
+MODULE_DESCRIPTION("CS-Lab Warp multifunction driver");
diff --git a/drivers/zorro/warp-mfd.h b/drivers/zorro/warp-mfd.h
new file mode 100644
index 000000000000..3f44f2b57c76
--- /dev/null
+++ b/drivers/zorro/warp-mfd.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CS-Lab Warp - board window layout
+ *
+ * Copyright 2026 Paolo Pisati <p.pisati@gmail.com>
+ */
+
+#ifndef _WARP_MFD_H
+#define _WARP_MFD_H
+
+/* Offsets from the start of the board's Zorro window. */
+#define WARP_OFFSET_DPREG_CR	0x1000	/* dual-port interrupt control reg */
+#define WARP_OFFSET_DPRAM	0x2000	/* dual-port RAM */
+#define WARP_OFFSET_ATA		0x6000	/* on-board IDE interface */
+
+#define WARP_DPRAM_SIZE		0x2000
+#define WARP_ATA_SIZE		0x1800
+
+#endif /* _WARP_MFD_H */
-- 
2.43.0

