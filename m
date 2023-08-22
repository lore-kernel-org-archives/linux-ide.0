Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043FEE49B2
	for <linux-ide@archiver.kernel.org>; Tue, 22 Aug 2023 22:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHVWON (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Aug 2023 18:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjHVWOJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2023 18:14:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04191CCB;
        Tue, 22 Aug 2023 15:14:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686be3cbea0so4028405b3a.0;
        Tue, 22 Aug 2023 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692742447; x=1693347247;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhfFSWf7keK+MXdSC0rVYV2NnkwIJ14fQO+DFXX6fdE=;
        b=CLn1ta1FKv55/ZDKuw+teoMSovZPgSCzC4u4wa7ozJ4VJFnN6gjP1/Qg7qlDkQVkCb
         PHcglC4iXBrmu25eo5msMK+O9iVMQ/RmBHg4JNJtKQbHyr0JggvFUCzM8bwzdQTRwlc6
         M6yRAL9CQhUXfC2fod7xYbKiqZwH6m/DKHvltAR9hzgf+dMCaO6L6c1qMzrhRQcHRT+H
         /Vgn17LZHq8mYgVk9BXwnVDx4tcDU45DLzs2TlZx2l118e1Z8yRdwRCggjFG8XPaE8VZ
         /aa29gY4Yu8BPm7mDnE0ixUv9juhjYrNO89+G1PvbT2CYsA4ZVl+iFGVYURhPT6h5ted
         dlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692742447; x=1693347247;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhfFSWf7keK+MXdSC0rVYV2NnkwIJ14fQO+DFXX6fdE=;
        b=SK412GecznjqGOs1C7qRipq+dJJC4zQHSMx8PBHk0TU9yjJes+yxUGvoVb7RQnhtZm
         iZ4zTJnHzk7y8OJxDV5Pb09hc28Q4cN2boRamNJ7g2/YdHfZTFw/ViW/qCnQnUrqjma4
         7lGlnkBrCii8PNEo2GHNsofmi0Kfatuq9sIYEXmVGrla1aD73suiowf2cifonNecJuUh
         1eeej7x2pasYpwlH5eUmpsl7WWw5Yvd+8RmjtPuwhHXJzFvcrsfSh3aGNUYhxTurmqou
         fNggXk4jGG4zvGQe3zopA15ucBdikTWpOIPxy8BPdJCp1FjU1s/ANlL21ZoBC/pZkU0X
         W1uw==
X-Gm-Message-State: AOJu0YzgbPg0TNxECs6aM5Lk+E8pk4a3yIlTyjzAyRygVT5D+3Dfcpog
        lCWnFf0ZiSe2ShbusJQroKc=
X-Google-Smtp-Source: AGHT+IHkjquDCSj3CIbQuolIq5o2HkqytEn7S48PwvQ9UHmLappkMs8mzWbRVvHxxOO2nK2w800BgA==
X-Received: by 2002:a05:6a20:7f9d:b0:13e:90aa:8c8b with SMTP id d29-20020a056a207f9d00b0013e90aa8c8bmr17506578pzj.4.1692742447415;
        Tue, 22 Aug 2023 15:14:07 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id s4-20020a63af44000000b005641fadb844sm8262209pgo.49.2023.08.22.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 15:14:06 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A5E1D360447; Wed, 23 Aug 2023 10:14:02 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     sergei.shtylyov@gmail.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v4 2/2] ata: pata_falcon: add data_swab option to byte-swap disk data
Date:   Wed, 23 Aug 2023 10:13:59 +1200
Message-Id: <20230822221359.31024-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822221359.31024-1-schmitzmic@gmail.com>
References: <20230822221359.31024-1-schmitzmic@gmail.com>
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
index 3841ea200bcb..7cf15bd9764a 100644
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
@@ -194,6 +199,9 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ata_port_desc(ap, "cmd %px ctl %px data %pa",
 		      base, ctl_base, &ap->ioaddr.data_addr);
 
+	ap->private_data = (void *)(uintptr_t)(pdev->id > 0 ?
+		pata_falcon_swap_mask >> 2 : pata_falcon_swap_mask);
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

