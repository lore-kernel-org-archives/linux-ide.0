Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55386C7112F
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358065AbjHRHOn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358091AbjHRHOO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:14:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A3C30E6;
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76d7fcb2c71so41705085a.2;
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692342852; x=1692947652;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NTdc9lAEq/m7twaOMlgf9J8gF6zBqL4ZNnp8pbkVcSY=;
        b=E+DCCQZTeiGMkkwkGizlAzGifUW74nUFWa3AO9Rda6wA1uKu9RpxCsyTgCMFuXs8C9
         M4pKrRYRLu1BdwZTWV7chT7OyCaBS+TdN9TsReVUV/E10IRCLuUfptBcBwdMMX2UwpBf
         OEmNoh2QFSo3gQU6DwKkk8lsRHAIAigFmdavfh2n60bGCzT8/qhgtgEvw04LlC5Lc0T5
         QQD7HobhLzRoplqdOD0rRBdJD+t+8ushxlYkOq11zfj7BC1uYVknBUz31NjkqSvXv2ZQ
         e182fwpQsOdM6NvpAvfGVjoU4SQvMgGU4sfRrZeYLTil4dU6JjkSlFg6W0ShgvudeJeI
         Kilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342852; x=1692947652;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTdc9lAEq/m7twaOMlgf9J8gF6zBqL4ZNnp8pbkVcSY=;
        b=UsjDsFkHE+r29teu4vvKlmg7y6U7SHv1h6lq3ZMtvLLntMsQydkQ7/bQX6d2mQCXo6
         AeWEx/Qg/9WCIc/mX9d5YlXIuz8wCwAdtIyel1GnV4EYMeqhUjuAjoDWCMtWwyUbsS3P
         /H50+TYEXEZ9EiROSPkMH5GvUSTWgojT8w+/W9ehi4O9kaixfCdU4jzVrYyKkBzDxLhS
         EMzKZJOCLayyv1tcLUT1HgK5wRYN6grPd1TaP7PJ4zL1fTMbNNJmTtccacbX4hdHlfmG
         t1Am5uwBhtrn1UCNlhN0MFk+RyQL6R+PcdJYWpOiYOhtj317iXlxg5kZiIxUHj1b8syv
         R/0g==
X-Gm-Message-State: AOJu0Yw5kYRiuvEjnfY3T96lbjFeozWTTwqLl+1r+6Qvp9CbOmlcCrCL
        5xVgA9lZmyHsgXJnnFmqgtoVho8CGmA=
X-Google-Smtp-Source: AGHT+IGH6QTC3wluNwnj8LLp3cEMIrIciQyzyX3wRT2fqgopc905WsAaXnX14Cw9VgZjuM4Bhn2E4Q==
X-Received: by 2002:a05:620a:3725:b0:76c:ca4d:f82e with SMTP id de37-20020a05620a372500b0076cca4df82emr2264788qkb.20.1692342852318;
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id h3-20020a63b003000000b00565009a97f0sm800125pgf.17.2023.08.18.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:14:11 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 3B423360370; Fri, 18 Aug 2023 19:14:08 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 1/3] ata: pata_falcon: fix IO base selection for Q40
Date:   Fri, 18 Aug 2023 19:14:03 +1200
Message-Id: <20230818071405.28581-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818071405.28581-1-schmitzmic@gmail.com>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

With commit 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver
with pata_falcon and falconide"), the Q40 IDE driver was
replaced by pata_falcon.c.

Both IO and memory resources were defined for the Q40 IDE
platform device, but definition of the IDE register addresses
was modeled after the Falcon case, both in use of the memory
resources and in including register scale and byte vs. word
offset in the address.

This was correct for the Falcon case, which does not apply
any address translation to the register addresses. In the
Q40 case, all of device base address, byte access offset
and register scaling is included in the platform specific
ISA access translation (in asm/mm_io.h).

As a consequence, such address translation gets applied
twice, and register addresses are mangled.

Use the device base address from the platform IO resource,
and use standard register offsets from that base in order
to calculate register addresses (the IO address translation
will then apply the correct ISA window base and scaling).

Encode PIO_OFFSET into IO port addresses for all registers
except the data transfer register. Encode the MMIO offset
there (pata_falcon_data_xfer() directly uses raw IO with
no address translation).

Reported-by: William R Sowerbutts <will@sowerbutts.com>
Closes: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Link: https://lore.kernel.org/r/CAMuHMdUU62jjunJh9cqSqHT87B0H0A4udOOPs=WN7WZKpcagVA@mail.gmail.com
Fixes: 44b1fbc0f5f3 ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---

Changes from v1:

Damien Le Moal:
- change patch title
- drop stable backport tag

Changes from RFC v3:

- split off byte swap option into separate patch

Geert Uytterhoeven:
- review comments

Changes from RFC v2:
- add driver parameter 'data_swap' as bit mask for drives to swap

Changes from RFC v1:

Finn Thain:
- take care to supply IO address suitable for ioread8/iowrite8
- use MMIO address for data transfer
---
 drivers/ata/pata_falcon.c | 55 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 996516e64f13..346259e3bbc8 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	void __iomem *base;
-	int irq = 0;
+	void __iomem *base, *ctl_base;
+	int irq = 0, io_offset = 1, reg_scale = 4;
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -165,26 +165,39 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 
-	base = (void __iomem *)base_mem_res->start;
 	/* N.B. this assumes data_addr will be used for word-sized I/O only */
-	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
-	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
-	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
-	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
-	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
-	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
-	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
-	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
-
-	base = (void __iomem *)ctl_mem_res->start;
-	ap->ioaddr.altstatus_addr	= base + 1;
-	ap->ioaddr.ctl_addr		= base + 1;
-
-	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
-		      (unsigned long)base_mem_res->start,
-		      (unsigned long)ctl_mem_res->start);
+	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
+
+	if (base_res) {		/* only Q40 has IO resources */
+		io_offset = 0x10000;
+		reg_scale = 1;
+		base = (void __iomem *)base_res->start;
+		ctl_base = (void __iomem *)ctl_res->start;
+
+		ata_port_desc(ap, "cmd %pa ctl %pa",
+			      &base_res->start,
+			      &ctl_res->start);
+	} else {
+		base = (void __iomem *)base_mem_res->start;
+		ctl_base = (void __iomem *)ctl_mem_res->start;
+
+		ata_port_desc(ap, "cmd %pa ctl %pa",
+			      &base_mem_res->start,
+			      &ctl_mem_res->start);
+	}
+
+	ap->ioaddr.error_addr	= base + io_offset + 1 * reg_scale;
+	ap->ioaddr.feature_addr	= base + io_offset + 1 * reg_scale;
+	ap->ioaddr.nsect_addr	= base + io_offset + 2 * reg_scale;
+	ap->ioaddr.lbal_addr	= base + io_offset + 3 * reg_scale;
+	ap->ioaddr.lbam_addr	= base + io_offset + 4 * reg_scale;
+	ap->ioaddr.lbah_addr	= base + io_offset + 5 * reg_scale;
+	ap->ioaddr.device_addr	= base + io_offset + 6 * reg_scale;
+	ap->ioaddr.status_addr	= base + io_offset + 7 * reg_scale;
+	ap->ioaddr.command_addr	= base + io_offset + 7 * reg_scale;
+
+	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
+	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
-- 
2.17.1

