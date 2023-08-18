Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D2EE49A3
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 23:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbjHRXtc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbjHRXtM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 19:49:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E453AAE;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso11204445ad.1;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692402550; x=1693007350;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oljmmYm8UWE9+YsgpSkeYSwLA/jX0XBYv5JPNbeqwxc=;
        b=qSCKz82j7XL8gB9t/e6WI/SUw8amEUwEcd2lxbWBye+eAGQQAiE+ysBUeRedUW/XS3
         Emk7GuVTR8RNqmAiFS2Dm38t0Z3UkpMcKE9cPOANAMcPVzatIGD1L6oT+hxtLBn/fpya
         /SUrRjHps8Oqnc4X2jQkiSElh79JuUe0JiM9AxsaMG2MJKiWmiMZAxHQfB7SQ9CgX7Lq
         St6x6lnVm9q6EcACvdFDe15vMYm3A0i/nJADFk+y5G8vr+XIMlKrYq1Qj0Z4T/2ivMGD
         C0Z+vMZQLJp1pZKFArIu1Ab70CuM4VzUnqncvFPwXIZwkrODBhoe16DIZU3OHmtwZJnx
         esjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692402550; x=1693007350;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oljmmYm8UWE9+YsgpSkeYSwLA/jX0XBYv5JPNbeqwxc=;
        b=Ff8wO9Vm4y9fi0V91MYSeYB3um5jKmJRUv00DlVNUPrW/nzH49FmxZCjM12fupFAYK
         FrzdYXGwl21F5FSUmoILoREVKlmbGGliNzZghh2RnP2T0kMj/P7A6jgXKpxNln82OqF1
         VGE7sWKx70ueu8v0yGU/S0oZIsXSWQGJX1VKl19uqokyLrriX5vp2OiJT+eIp3X5Ic5+
         papMGfusbtTtZtSvoW35IR/PZDh/Gl6MMBWfGkdhtCYYgDrJ9rStwYaAa8/zOk09NtUP
         nbAH1TK7ZY02GyZvnr2QtxsmfwuD1KD5T7xbDqdhvQHbVx35oz3rPFMwc/bxGdkmXm+U
         ejPA==
X-Gm-Message-State: AOJu0Yy4QGPX/bTD5x3cXnYVJ9pF2hdzW0gPqQrgy93F/q/ToLed5tQz
        b/vYwEWxK7AH8taEIUSyTB1m9N8E/lc=
X-Google-Smtp-Source: AGHT+IEiWxHGGZc/QFIawIfhZw+AuGzC6xGgbhpk48AkVcUFmL/tXe8hKsL0iT97AY9zfsZR2HrgYw==
X-Received: by 2002:a17:902:e743:b0:1b5:2b12:6f50 with SMTP id p3-20020a170902e74300b001b52b126f50mr680788plf.12.1692402550060;
        Fri, 18 Aug 2023 16:49:10 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001bf3bdbceb5sm2023966pli.134.2023.08.18.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:49:09 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 5AC9A360442; Sat, 19 Aug 2023 11:49:06 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 2/2] ata: pata_falcon: add data_swab option to byte-swap disk data
Date:   Sat, 19 Aug 2023 11:49:03 +1200
Message-Id: <20230818234903.9226-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818234903.9226-1-schmitzmic@gmail.com>
References: <20230818234903.9226-1-schmitzmic@gmail.com>
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

---

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
 drivers/ata/pata_falcon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 346259e3bbc8..e95658bc36e3 100644
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
@@ -199,6 +204,9 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
 	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
 
+	ap->private_data = (void *)(uintptr_t)(pdev->id > 0 ?
+		pata_falcon_swap_mask >> 2 : pata_falcon_swap_mask);
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

