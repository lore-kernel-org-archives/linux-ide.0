Return-Path: <SRS0=eeaJ=4K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F79C35666
	for <linux-ide@archiver.kernel.org>; Sat, 22 Feb 2020 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310920702
	for <linux-ide@archiver.kernel.org>; Sat, 22 Feb 2020 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3Sb1unG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBVLVE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:21:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41448 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgBVLVD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 22 Feb 2020 06:21:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so4962751ljc.8
        for <linux-ide@vger.kernel.org>; Sat, 22 Feb 2020 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8rxKbQOnYyJEPmLOImLnquWRWgtWqLNGUp6E0H9EeU=;
        b=W3Sb1unGH3r2cSkrOltqQqFBD8ulOqN8w9aHtztRqVggG2alGhbtiGXTUjSMUjaM0Z
         rs5ZS0McuAWZr/ilSdeOw/gT31tx5GWc8QH77kOH9hPwD8AO4KuuUnnFCWiHvnyLMzsK
         tgaY/rlbKOK0FkPTaEVVeWdHrhe43ihPa7AqsJuZlONJmplGCIQ9RdzL2RGjCKG8ZXQC
         QHnGwCVGYl0SoEuopBnLO5ZdImDFjB/o0rGFIL9Xj21JcdMMRfgoHH64UJCzB4lNnPXZ
         lLC/zAJKMKcYLkX3FIRTez39TjDxrYm6N5KwSaGg08uEcpDbYYAabMH5mNbbjK1rZD6q
         EzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N8rxKbQOnYyJEPmLOImLnquWRWgtWqLNGUp6E0H9EeU=;
        b=FmCsR7ZA/wpKf/zj/VinLHkVZve2BOBTmwXxAPVk8EfeHu6YorhmtQ7ZtDj1wQO8r+
         KpmDY5i0YgBD8VIfQz1sn+UzQt2B7cFDTPr1E5G4jMK91VagrHsydpVtXLRxkLcCAcX9
         VvA+7wzU33XABfQguUkgabSZC/hYbNrbNV82b9LYYT0TARKuWCqPvRNWr5BPW9kXdeWW
         PljIZRY3RncWclpjM/kvAYcah7qt/QeDv2UAVLiqr9xreugCPza1RPhHAVztHXuXStMe
         fTm5kFEb2ETb4EQKv8gY1BnEDkCsgmBSoS3UTrWNqDninAWtwziJrJzaVq16lQqbVlWw
         jqlg==
X-Gm-Message-State: APjAAAXJp47i9AD+s/qFu3JtvdXa4qjdAen6zRGvwb4bo/yTzMDaPxfV
        raozLS/nN4AABrUWvHTZFomNKQ==
X-Google-Smtp-Source: APXvYqybr7+I3CHJO4xA8SyqTd7dKGh3n2ZS7PhavPn8921pek7tf4x4ql7FBz5gGnqLtQS2bnONew==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr25017321ljj.14.1582370462028;
        Sat, 22 Feb 2020 03:21:02 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id z1sm2981267lfh.35.2020.02.22.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 03:21:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] libata: Assign OF node to the SCSI device
Date:   Sat, 22 Feb 2020 12:20:57 +0100
Message-Id: <20200222112057.31476-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
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

Cc: Chris Healy <cphealy@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use dev_dbg() for the debug print
- return immediately after finding a matching OF node
---
 drivers/ata/libata-scsi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index eb2eb599e602..9b2bd080f4e4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -36,6 +36,7 @@
 #include <linux/suspend.h>
 #include <asm/unaligned.h>
 #include <linux/ioprio.h>
+#include <linux/of.h>
 
 #include "libata.h"
 #include "libata-transport.h"
@@ -4582,6 +4583,34 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
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
+			dev_dbg(d, "found matching device node\n");
+			sdev->sdev_gendev.of_node = child;
+			return;
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
@@ -4607,6 +4636,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 						 NULL);
 			if (!IS_ERR(sdev)) {
 				dev->sdev = sdev;
+				ata_scsi_assign_ofnode(dev, ap);
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
-- 
2.21.1

