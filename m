Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415061;
	b=Q69kgQ8SkGR4wJTNM8lqH2F7l8pO7gSycNV1VfZYCPXc/VsIQwSGuTGoEF+OkEam+GGY
	 rKuudK5hKX36G7GoAtDjqwMt2TFJbXAkAWOcnc/rekz00fhL2ycGshKYE3rorXx9RkyZm
	 HXgo5eISvzm1gNsLWUTA4Qonj9jn71dDmgsbSs1D2sLHUQ4jjhsm8BBUt5759rkdt3Bv3
	 fu4RUDdvpYbaFRG29noHEAU58AZwTeXR4k3YJ2+hulXxq+EBZj8gTUElod6vfTMYEQ3Rl
	 19RrTvunTlnrkPpgTMpi7s9XRGzY96SEH/g6uOY3nI9EIH8d3Pldr4Qch+x/94Gm2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KXjsm9ORz3HR//q2A0kstQ3Pi4RAW90rgXKjKRzFtHY=;
	b=yBf3lXpew0aoIi1YrNFz3VusjJ9j3FR7H96j3Pnufuxg44krnjxwlJdLHq/OljCltwh1
	 YRW5mZ54DgwVdROLyxULOayXW2zxCvpNeBXNt4g4sa/7HpxXHzCu7pbih3KSFa5x10Jdn
	 KiX9cU6pO1qFyZq6PxWazLMUH1ggb1gv/bKe1NJsXQp2JP25Z8As3Yr8gmSLtQ89MsLOu
	 6uAocrnWuouprhB80hEKf4jODiSsnqH8rwHhf7GbE3svI/ujCiKxaDMWOLjSNSSe+sVbJ
	 38/j5SrXJws8hju0JtQ/+zbDurTO30vq2aGkp4fXbGuDMh2Y/hOyXG9adQjID3TGIYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X2vnYYI;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15827606A885
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 16:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15827606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0X2vnYYI
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2242915f8f.3
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2026 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415059; x=1795019859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXjsm9ORz3HR//q2A0kstQ3Pi4RAW90rgXKjKRzFtHY=;
        b=0X2vnYYIBgVC9/TjHP1o3AwyHS4/VoUR0IZ8uxXkMGTdMD5WPhv7RegoaIRLZwesQT
         d1lHJUz83MB1vYnLvNC2UF/1wUBUcH+Iy8eZpqhPuax+caYYUn9JzEKuvdmRPaFBoted
         vFwMTGV/zZ3adkfAUu32zcKcNPhzb+0duIHyWY3BmU3U5bZZs5uTLPed4TzpZ9WFkuRR
         RXufv194brSxSALqNE/grKASrOYFCZCfq6K+SwbPLGyoe2SoOpSSU5LADzo1JMWtcKZF
         J6TLT9NsGmlJUoOU1cYPk8Vo06fOMp9mGpT9pmZDK8/ZWyfqqkm/zc5Ynf6jpj0IWoBW
         DCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415059; x=1795019859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXjsm9ORz3HR//q2A0kstQ3Pi4RAW90rgXKjKRzFtHY=;
        b=O5Ua/GDR3CzVIFw/vBiE+6r3I0cJIBCW7s30fjyoc5znyOSCODY4jk/OYQt5rT+3B6
         tQIEgFdZsPxYk9CAZGDpZfpqLksdL916HrAA5bcJdhjFCLaFr6vgq4uPNC7Z1NIYwamj
         mzeoNXv7CB7JndcvSlPCH0cx/GFDAmcJP9xm5aRXiuoMXgG+RhUkEAwx763OTGTc4EqT
         9TkwDnkIbf5O6U3oxvylG+i4nnyFwi+1+b/fVnhRfjDZ3myS70p0Nxt0LeAeyQiRaVX5
         /B/y8mNGtPlub5jN4237A0KIBcgoj+V5OOh8stuvW0/gSSCVvcIPMmGI3LUp4d00G15g
         7zXg==
X-Forwarded-Encrypted: i=1; AL+hErFnZbUhgoFWkHZEAyuzjZ0La7yCb3gTdXipYcLgZMo91Cxdh7vawieCrlfLvfJIHawx11KZiM9tVsw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cYXbvDeInBCKoPSHofEoBNq7Gg4c858tqKlclZD2VoKDNKcsu
	v1fEhKo7n2oKbzYSBCu5eLteCTdAgAErVOYwkY15jM7dUN6vv/CZjFRV
X-Gm-Gg: AYBFou269cS+fSViSzj28Xcv/D7hBKYaRkpQflC4ezmxkTLB3CoGHc8z/3B0FOBODPx
	PJVXedvZzivbFTTd7xTHlPixmGKcekYOZZ5lxj1MswMHO6+J/t7+uZz+xMpnnljQVh+qsjxSVdq
	haqsSKWcz8aoMJ4wrkYCfrNv9GbWdBOg992My65ZgW2zY1QSE5FOXdfsl/5jHJ3xGByu8hSLpjk
	g702srtXv7Z8A9yAh9irJQ6EuporkqthTfFWQhJc7PK0mnCG+Ry6m0RSbYi7Q0eP1sWKtE+HPIw
	SPJxg/VeH5ir2ru7XfqzGv49qJlrkCs6r0stdHKSzpxa5+XCZ1vbiwRNVJawS9HtkXzz20NtYDA
	P+LDewVCQN5w6hDpXPVYg41nGv//vo7OAtrgOZKCkRLVhVLbdpe5E2V/GSfH4jN7cRkWxJ+xm1t
	Gi02Y8zJYa0VN2gEIUBFO8ECzjD89KDvQ96Wc+LVa0n5qs4pEiP59//nBitYljNRsQxEZA74/AZ
	gihBsXDW69L2GxMqW1waadXXQ7IvwbAgIc0CDBfJkMqFZC3FfvpRRsXg6exFS5mBVmVC9auPNxS
	ZDZxKKWm627nXX64Hyn4dL59hSAWOUCDnDleX7aUl5PjmBHWvuJ+VV0ngZIv6tAz1b+FnVYNBvP
	Fr2JZUAUHdMzw
X-Received: by 2002:a05:6000:18a9:b0:48e:5df9:1ec9 with SMTP id ffacd0b85a97d-499c6f8db6cmr5151187f8f.24.1794415059075;
        Wed, 11 Nov 2026 08:37:39 -0800 (PST)
Received: from gmail.com ([2a01:e11:1403:8620:6e81:13fe:ca06:8db8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm11895837f8f.22.2026.11.11.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:37:38 -0800 (PST)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev
Subject: [PATCH v1 2/7] ata: pata_cswarp: bind to the Warp mfd cell instead of the Zorro device
Date: Wed, 11 Nov 2026 17:37:29 +0100
Message-ID: <20261111163735.227286-3-p.pisati@gmail.com>
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

Now that warp-mfd owns the device and hands the window out as the
"warp-pata" cell, take it from there.

PATA_CSWARP depends on WARP_MFD from here on.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/ata/Kconfig       |  2 +-
 drivers/ata/pata_cswarp.c | 48 ++++++++++++++-------------------------
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9704ed688775..407b79bf9405 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1035,7 +1035,7 @@ config PATA_GAYLE
 
 config PATA_CSWARP
 	tristate "Amiga CS Warp PATA support"
-	depends on M68K && AMIGA && ZORRO
+	depends on WARP_MFD
 	help
 	  This option enables support for the on-board IDE interface on
 	  CS-Lab Warp Expansion Card (NOTE that idemode=native has to be
diff --git a/drivers/ata/pata_cswarp.c b/drivers/ata/pata_cswarp.c
index 58fe6d0012dc..41b4c93052cf 100644
--- a/drivers/ata/pata_cswarp.c
+++ b/drivers/ata/pata_cswarp.c
@@ -14,14 +14,12 @@
 #include <linux/ata.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
-#include <linux/device-id/zorro.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/zorro.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
 
@@ -32,8 +30,6 @@
 
 #define DRV_NAME "pata_cswarp"
 
-#define WARP_OFFSET_ATA         0x6000
-
 static const struct scsi_host_template pata_cswarp_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -92,33 +88,27 @@ static struct ata_port_operations pata_cswarp_ops = {
 	.set_mode	= pata_cswarp_set_mode,
 };
 
-static int pata_cswarp_probe(struct zorro_dev *z,
-			     const struct zorro_device_id *ent)
+static int pata_cswarp_probe(struct platform_device *pdev)
 {
 	static const char board_name[] = "csWarp";
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct resource *res;
 	void __iomem *base;
-	unsigned long board = z->resource.start;
 
-	dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
-		 board);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pata");
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
-	res = devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
-				      DRV_NAME);
-	if (!res)
-		return -ENXIO;
+	dev_info(&pdev->dev, "%s IDE controller (board: %pR)\n", board_name,
+		 res);
 
-	host = ata_host_alloc(&z->dev, 1);
+	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host)
 		return -ENXIO;
 
 	ap = host->ports[0];
-	base = devm_ioremap(&z->dev, board + WARP_OFFSET_ATA, 0x1800);
-	if (!base)
-		return -ENOMEM;
-
 	ap->ops = &pata_cswarp_ops;
 
 	ap->pio_mask = ATA_PIO4;
@@ -145,34 +135,29 @@ static int pata_cswarp_probe(struct zorro_dev *z,
 			  IRQF_SHARED, &pata_cswarp_sht);
 }
 
-static void pata_cswarp_remove(struct zorro_dev *z)
+static void pata_cswarp_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&z->dev);
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 
 	ata_host_detach(host);
 }
 
-static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
-	{ .id = ZORRO_PROD_CSLAB_WARP_1260 },
-	{ }
-};
-MODULE_DEVICE_TABLE(zorro, pata_cswarp_zorro_tbl);
-
-static struct zorro_driver pata_cswarp_driver = {
-	.name           = "pata_cswarp",
-	.id_table       = pata_cswarp_zorro_tbl,
+static struct platform_driver pata_cswarp_driver = {
+	.driver = {
+		.name	= "warp-pata",
+	},
 	.probe          = pata_cswarp_probe,
 	.remove         = pata_cswarp_remove,
 };
 
 static int __init pata_cswarp_init(void)
 {
-	return zorro_register_driver(&pata_cswarp_driver);
+	return platform_driver_register(&pata_cswarp_driver);
 }
 
 static void __exit pata_cswarp_unregister(void)
 {
-	zorro_unregister_driver(&pata_cswarp_driver);
+	platform_driver_unregister(&pata_cswarp_driver);
 }
 
 module_init(pata_cswarp_init);
@@ -181,3 +166,4 @@ module_exit(pata_cswarp_unregister);
 MODULE_AUTHOR("Andrzej Rogozynski");
 MODULE_DESCRIPTION("low-level driver for CSWarp PATA");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:warp-pata");
-- 
2.43.0

