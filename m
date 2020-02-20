Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B118C11D20
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C0208E4
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/3ef9AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgBTVaE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:30:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgBTVaE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2020 16:30:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so5776409ljc.8
        for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2020 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hupLTDmJuQI92VS61+hg5m2XE3MmsNj7YAkLDXV35FM=;
        b=A/3ef9AR6DFK/P1xBTV+qdC26uwfR2qlXyWtjWxD0YhUlzwV6TfRT8s+N8Xt57jhaf
         nHpA1XT31/lOr/j0E+/iMrSzIJRIzLr1tUn6Wc1aB0+E7dcrVteAyZOZYsO9y6n5mlW7
         +Bw2fdCVR8VjxqYFHHko59R1k2E94j61Jmf+Bcrtj+4/vAeB2yK+8+dgF6WnrFtbRYjX
         wehTEbo3pQNWlNe0QCwqLa8vgDb7f9WsgeDD3667gJitLWupTxknVzZkpDaeQeJDLhoS
         t9cUEcGeMuxu5Qw73HEw1vtp+M8xWfHdgzrgCADSfk43ZxNyh61HIx5/ORiChodG2t2p
         dS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hupLTDmJuQI92VS61+hg5m2XE3MmsNj7YAkLDXV35FM=;
        b=ZRYONStY6sJMMlSJomY4Za/bY9yQC27G5AmWxvI03BXu2yaCZns0lJDoleGQdOnnRN
         79ybHZWueZgOQ+/xWIFvgB3s0BuonsrwgjwHKqy39ZJQHkaOsWttXfL2f2qxzhKmCgX+
         sH/jtwiuO8im0WZ12MLux4R5LWWq3bY+A9F0OQoH/eWXi/0IEdJ/ZMhviSaP86A8Pa2k
         HCbNTrph2e0eM7QNPE7Oy+F7MoavRv6C8n51OquBshAbA4vjW9uWO1RyYQf4kpRlwchr
         64sas+GzHfvOE5ifJqF+eyDkC5zJIql5YQiRKI3nioCL7Xg8LKK3CNf5Xvs0ef7C45HO
         +S2w==
X-Gm-Message-State: APjAAAXew1fZQ9JXVn09bG12EdRf33ILV9luoDpdy8syC3UhEgjNjFIe
        TwdRes26IVy6z5I12KPakWniqw==
X-Google-Smtp-Source: APXvYqy2p3XnfRJubZKmcZaiLfOq9HXkVP2cXqcpRjZNxuRAvBUAERdgj8Eg1du1eJvtCxAVnZTxyg==
X-Received: by 2002:a2e:8699:: with SMTP id l25mr19192175lji.137.1582234202027;
        Thu, 20 Feb 2020 13:30:02 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id q10sm340391ljm.87.2020.02.20.13.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:30:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH RESEND] libata: Assign OF node to the SCSI device
Date:   Thu, 20 Feb 2020 22:29:35 +0100
Message-Id: <20200220212935.2239-1-linus.walleij@linaro.org>
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
 drivers/ata/libata-scsi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index eb2eb599e602..0610a3a86de3 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -36,6 +36,7 @@
 #include <linux/suspend.h>
 #include <asm/unaligned.h>
 #include <linux/ioprio.h>
+#include <linux/of.h>
 
 #include "libata.h"
 #include "libata-transport.h"
@@ -4582,6 +4583,33 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
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
@@ -4607,6 +4635,7 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
 						 NULL);
 			if (!IS_ERR(sdev)) {
 				dev->sdev = sdev;
+				ata_scsi_assign_ofnode(dev, ap);
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
-- 
2.21.1

