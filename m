Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E8EE49A5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Aug 2023 01:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjHYBN6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Aug 2023 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjHYBNo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2023 21:13:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E2A1BFF;
        Thu, 24 Aug 2023 18:13:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a76d882052so335047b6e.0;
        Thu, 24 Aug 2023 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692926021; x=1693530821;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoAoxtgqzVrJU/fBQ+EbpVxGjsbEkiMEB7CyIEPnDFs=;
        b=N5k8+rnarRp+nFsFSbwtUUMJZmZSVt0J5DEU1DNzwt9bpIFaT49XzdH4KZRpFhM+3V
         lPKhqE3uTS9LGovFRcaBIGp6x6RxQMvNUG9kMjn4VsW34aSE5TYmshIQf8Fj5HvhVagL
         blNsgqGB6ghV3NM6Z83VV1+mtz2+lMcutNiEcQ3P9MPmxgjbKH1b/L4wJnTvYzjUK0aQ
         3k8A8hNPiWvFve4m9BCO4MKYMvLxpxsOVrM5izyN2y64YuALT0kc2TZUxM4CJUjaBt/7
         70Jccx9EwjjMtrI6KSufSJYWwFJBmcrDHVkDYLg8UE6boY3qZWnf9U/ivoLhezlOrgOU
         S3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692926021; x=1693530821;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoAoxtgqzVrJU/fBQ+EbpVxGjsbEkiMEB7CyIEPnDFs=;
        b=B27El61QqCxWO4EUrTcyi822O1VqIHoYlc+4X71drUCEVI8SUCY0BNaBiiA391wXQG
         S7REpsEoGsSmcEcQmslObVvle21Eks19UStMuPqKHkjFSoQ2YR1GcuZy6ZEt/Ub4QHE3
         6K4YKxWc9Um1NlHiNsRpV6OC+X18+wI6WSOGE8rubVLWEVT+oUo5WnQWUCudatKzdCbc
         NiDz41LxH5kbIwjbh3JSHwYoWSBBiqBV7Zqo1Fs1J7QwmrBWtxGgSBMLp28wS7MOwaIk
         sLvv3gKXvCKwIICQipdjYsrAM4GrZpHiqiDlHAmqq1/MqApzfuoRyePAWPae2/i6Wcfy
         v4cw==
X-Gm-Message-State: AOJu0Yy7+hDhgx9ozali0716R/wZKkUVby7wQI/l1Ymm0giQkb39QTEw
        SqBegYwRQksiTKv/5zE2w6I=
X-Google-Smtp-Source: AGHT+IGG0QesE0j5hLHCxYelQIDOVUlluIC7fa6TMpVjfk2KTHMZlrXbg9bADEhOXOEg/7W8TxtNGg==
X-Received: by 2002:a05:6808:30d:b0:3a7:3ab9:e589 with SMTP id i13-20020a056808030d00b003a73ab9e589mr1120457oie.35.1692926021728;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b00689f1ce7dacsm356614pff.23.2023.08.24.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D77AE36043B; Fri, 25 Aug 2023 13:13:37 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5 2/2] ata: pata_falcon: add data_swab option to byte-swap disk data
Date:   Fri, 25 Aug 2023 13:13:35 +1200
Message-Id: <20230825011335.25808-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825011335.25808-1-schmitzmic@gmail.com>
References: <20230825011335.25808-1-schmitzmic@gmail.com>
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
 drivers/ata/pata_falcon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 616064b02de6..8da044fa1825 100644
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
@@ -124,7 +129,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *base, *ctl_base;
-	int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
+	int irq = 0, io_offset = 1, reg_shift = 2, mask_shift; /* Falcon defaults */
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -194,6 +199,12 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ata_port_desc(ap, "cmd %px ctl %px data %px",
 		      base, ctl_base, ap->ioaddr.data_addr);
 
+	if (pdev->id > 0)
+		mask_shift = 2;
+	else
+		mask_shift = 0;
+	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> mask_shift);
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

