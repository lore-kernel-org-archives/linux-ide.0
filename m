Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC8C83F18
	for <linux-ide@archiver.kernel.org>; Sun, 27 Aug 2023 04:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjH0EOO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 27 Aug 2023 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjH0EN7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 27 Aug 2023 00:13:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4C1B3;
        Sat, 26 Aug 2023 21:13:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686be3cbea0so2130956b3a.0;
        Sat, 26 Aug 2023 21:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693109636; x=1693714436;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+GvtWHb+sPnadbXAI9yeROqIVFCXtFoHwNsTt134Jw=;
        b=OJoVbqZO9/A5jzqj88CZTsuqOFdOvE897nda9VQu96UTyHFRo4v5LUjDFLqiPHbaED
         gcLfwj4zNrZnN687awxAARZwZ7O1dOejN+lr1fVoztNNicDlIZUsbgAE1BBWPBFE/15s
         lZ5u4s6qZj2Nbd0TxCHOJHD7esktHrTe43FwpfmmGYumTddaLx6wUf+esrnAAUBYXaW1
         e9UJVNUyWkWaGUkurKmlg9CxWvSaJmZ9JEkFk2enTAVP2DKvQt5XX6n/v6fHAZtFvk4C
         VklnYIeIM6NlO2vDs1/bmCBRmXay4dLmfe4dXq1h9lUFGFydVfKnR+Az3ZtFhC7Oknt0
         RUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693109636; x=1693714436;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+GvtWHb+sPnadbXAI9yeROqIVFCXtFoHwNsTt134Jw=;
        b=CITO3ykgQA1oMAqXLkRxQv8wksnFgUojjI+1HVkXbF0HVOLA8yCO7OXPxI0T/NSmF0
         f9jPL8kMipaUXNwOdPvNJJ3uMNffzn6Fnm3NCVwdCGiHxnKltHqM9O0odEbuOhyBRU8B
         ZH7bcJXdl10vF1kF6VIOp2sr7kceia+0AWG//7E6vetQZ8q9SvzihV9DU1oJ+8nBGMke
         EPJNkdghYnAVK3joX6ikjTHmx2P9AGDhHoOeYWgNwJZbJ/R9rYGEHP3MusnCZkdPqHB7
         cHpNBufi7ZDOX/iQg1VvrZ/4G7MAxKO6QigSRR56CEKGTwDt9wbj6NYQ48Rh4ZbmyWXD
         VIFw==
X-Gm-Message-State: AOJu0YzGmYh3YjkQOBKlR/9SgXIlXXZhPjkI9RNNNoHJKHfBw7eSvhhG
        aEBnmsBPtVqY9miL6HQnRx0=
X-Google-Smtp-Source: AGHT+IHv3OwN3NUkui+Y6ev4ol958GInuGSxxGuKi3IEkqIN2NF5bzMdVH2XCHOOestfOoaEoy2UNA==
X-Received: by 2002:a05:6a20:1456:b0:13f:c159:63ec with SMTP id a22-20020a056a20145600b0013fc15963ecmr33650125pzi.24.1693109635558;
        Sat, 26 Aug 2023 21:13:55 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068bda522245sm4067275pff.155.2023.08.26.21.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 21:13:54 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 6CAE136043F; Sun, 27 Aug 2023 16:13:51 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v6 2/2] ata: pata_falcon: add data_swab option to byte-swap disk data
Date:   Sun, 27 Aug 2023 16:13:48 +1200
Message-Id: <20230827041348.18887-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230827041348.18887-1-schmitzmic@gmail.com>
References: <20230827041348.18887-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some users of pata_falcon on Q40 have IDE disks in default
IDE little endian byte order, whereas legacy disks use
host-native big-endian byte order as on the Atari Falcon.

Add module parameter 'data_swab' to allow connecting drives
with non-native data byte order. Drives selected by the
data_swap bit mask will have their user data byte-swapped to
host byte order, i.e. 'pata_falcon.data_swab=2' will byte-swap
all user data on drive B, leaving data on drive A in native
byte order. On Q40, drives on a second IDE interface may be
added to the bit mask as bits 2 and 3.

Default setting is no byte swapping, i.e. compatibility with
the native Falcon or Q40 operating system disk format.

Cc: William R Sowerbutts <will@sowerbutts.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: William R Sowerbutts <will@sowerbutts.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v5:

Geert Uytterhoeven:
- correct mask_shift comment

Changes since v4:

Damien Le Moal:
- spell out bitmask shift calculation

Changes since v2:

Geert Uytterhoeven:
- only shift swap bitmask if pdev->id > 0

Finn Thain:
- use pdev->devno directly for byte swap check

Changes since v1:

Damien Le Moal:
- change patch title
- drop swap_data flag

Finn Thain:
- drop allocation of ap->private struct, use field as bitmask

Changes since RFC v4:

Geert Uytterhoeven:
- don't shift static module parameter for drive 3/4 bitmask
- simplify bit mask calculation to always use pdev->id

Finn Thain:
- correct bit numbers for drive 3/4

Changes since RFC v3:

- split off this byte swap handling into separate patch

- add hint regarding third and fourth drive on Q40

Finn Thain:
- rename module parameter to 'data_swab' to better reflect its use

William Sowerbutts:
- correct IDE drive number used in data swap conditional
---
 drivers/ata/pata_falcon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 616064b02de6..e3a0aa384f59 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -33,6 +33,11 @@
 #define DRV_NAME "pata_falcon"
 #define DRV_VERSION "0.1.0"
 
+static int pata_falcon_swap_mask;
+
+module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
+MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
+
 static const struct scsi_host_template pata_falcon_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -50,7 +55,7 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 
 	if (dev->class == ATA_DEV_ATA && cmd &&
 	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
-		swap = 0;
+		swap = (uintptr_t)ap->private_data & BIT(dev->devno);
 
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ) {
@@ -124,6 +129,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *base, *ctl_base;
+	int mask_shift = 0; /* Q40 & Falcon default */
 	int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
@@ -194,6 +200,10 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ata_port_desc(ap, "cmd %px ctl %px data %px",
 		      base, ctl_base, ap->ioaddr.data_addr);
 
+	if (pdev->id > 0)
+		mask_shift = 2;
+	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> mask_shift);
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

