Return-Path: <SRS0=eb51=3D=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932CC33CA9
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jan 2020 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC602084D
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jan 2020 00:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExGfrolM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgANAKN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:10:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgANAKN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 19:10:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so12204966ljk.7
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Isr28u5HiX1c9CmxNh9gYouXSUZ6UJrNyaXjd6EuoaI=;
        b=ExGfrolMkidtazvm4349ykPqoPUMcPWTLP3mNx+9TgUnsSfTVGK1udoPuGv8hL4ttr
         9mPtFjqMul6MmFqnsUsPuOGT0wAgeUZJLuJNonB2Qz9Trr6VGmmZIwOxm/67kO+JADsf
         4d/K7RAlpjaWAEHiYiZeJluoL0xbifCSnYQGBYK0Ucq1/hELNDql19YcHjHdRfY/aoIB
         ltfqm9jFe2bZbgp1xPzslR+4+xyybl6kyGyGw0VOw5i2EvbwBN2vJErA19tCdYAHKLKs
         ixxNUwAb3nPc9u3J5YaqMt9rgyYnNTZ938ePAx/EwuqikObLY16pi33dZFRegQn/GrUH
         zkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Isr28u5HiX1c9CmxNh9gYouXSUZ6UJrNyaXjd6EuoaI=;
        b=AiDje2lkiXbHJ3kespkpjjyGXcrdVcMWbSrC93qyogJKR2IoVQP0UZgDunSOZv07UL
         e2gBhrHi+xJ/B00bLYRdN9mo6YcHOQrNVmEIorJPiF7vib+ED9hfMq9LQUNkQJ/ZP22z
         c8vEDY17SIV7FbR3VMt8+zdA3KwOBNixuM6MYxPMWA4pPXLDvnpksX8kVVgqinjqHbQO
         r+iP0sRpFOs9KpFsGocDmAYd2vGz4DQMRZj1bgYcYC+TMS6ke9jaj20C3sAfgf/Xqzw3
         uHd37tJYQRc7SxPrFQgsawgg88uUZe3sGu78W6Jz2yLySHGPDDbDuCmxyV3Osk5FRxxO
         f8FQ==
X-Gm-Message-State: APjAAAVWsmW6M3TldlEEIJTa6/NxZPqyL5TASNo5vZAFiGCuIt1L8S+I
        4WhoSekQARzhzC0HLWIB/8FEAA==
X-Google-Smtp-Source: APXvYqzZNoFnypoYj3FvUDKbRbKIl+/cINSrUEjzyuN7gQPNJgYh9KG6vUzF64k0nUCT0oHHys9eRA==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr12751710ljl.65.1578960611499;
        Mon, 13 Jan 2020 16:10:11 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id x84sm6440330lfa.97.2020.01.13.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:10:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] libata: Assign OF node to the SCSI device
Date:   Tue, 14 Jan 2020 01:09:57 +0100
Message-Id: <20200114000957.21316-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When we spawn a SCSI device from an ATA device in libata-scsi
the SCSI device had no relation to the device tree.

The DT binding allows us to define port nodes under a
PATA (IDE) or SATA host controller, so we can have proper device
nodes for these devices.

If OF is enabled, walk the children of the host controller node
to see if there is a valid device tree node to assign. The reg
is used to match to ID 0 for the master device and ID 1 for the
slave device.

The corresponding device tree bindings have been accepted by
the device tree maintainers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/libata-scsi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 58e09ffe8b9c..555a925e51c9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -35,6 +35,7 @@
 #include <linux/suspend.h>
 #include <asm/unaligned.h>
 #include <linux/ioprio.h>
+#include <linux/of.h>
 
 #include "libata.h"
 #include "libata-transport.h"
@@ -4573,6 +4574,33 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 	return rc;
 }
 
+#ifdef CONFIG_OF
+static void ata_scsi_assign_ofnode(struct ata_device *dev, struct ata_port *ap)
+{
+	struct scsi_device *sdev = dev->sdev;
+	struct device *d = ap->host->dev;
+	struct device_node *np = d->of_node;
+	struct device_node *child;
+
+	for_each_available_child_of_node(np, child) {
+		int ret;
+		u32 val;
+
+		ret = of_property_read_u32(child, "reg", &val);
+		if (ret)
+			continue;
+		if (val == dev->devno) {
+			dev_info(d, "found matching device node\n");
+			sdev->sdev_gendev.of_node = child;
+		}
+	}
+}
+#else
+static void ata_scsi_assign_ofnode(struct ata_device *dev, struct ata_port *ap)
+{
+}
+#endif
+
 void ata_scsi_scan_host(struct ata_port *ap, int sync)
 {
 	int tries = 5;
@@ -4598,6 +4626,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 						 NULL);
 			if (!IS_ERR(sdev)) {
 				dev->sdev = sdev;
+				ata_scsi_assign_ofnode(dev, ap);
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
-- 
2.21.0

