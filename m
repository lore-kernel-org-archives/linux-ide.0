Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8DC6FD22
	for <linux-ide@archiver.kernel.org>; Thu, 17 Aug 2023 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbjHQWNd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355707AbjHQWNN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2023 18:13:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964A3A8F;
        Thu, 17 Aug 2023 15:12:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68879fc4871so278349b3a.0;
        Thu, 17 Aug 2023 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310362; x=1692915162;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlMQ1n8i16f6KTaYagTbQKQg5/+PxgAfX9lPv9C6FfY=;
        b=jLdQipN8I8KtJXWpazvTpCkcBtdCgJP5Z90wBfKwN/ZtqZWihNlG8BtTG2IB6ChDHj
         HzxNt5dZtu0FWmCHDl3oqiOS56WLhC/6eWf+Ror3YpnbE3TjL4yj73AAiQZMdJhYeR68
         cEMv/TBVNaiQ3EpGx9kLVhUAaPSFIMoBq5VDQHkFOsa2RbzzTPSCGc8hXCidYisyrFCd
         3qeiU8esIyIgq9iLkpzdWtZHvHVGTmXlVix/9GrNTWEJkm7XB5J0H51L3Olx4S9Zn8f3
         nqJxGBgWn1XmLTGp4WdO3N5RaFlzb8TrlZPyIQtw/UdKuyFNwTXFKKE4sw/31gdOF4Iu
         cxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310362; x=1692915162;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlMQ1n8i16f6KTaYagTbQKQg5/+PxgAfX9lPv9C6FfY=;
        b=PykLGnqsaOaweFXRfpOUsR6eHWR7IivUr06m6bOXtVD0q0gR7A5FC0DQJ28+CKCCnd
         pWOddJqWZMmZOoUGJiSZoKGAhKxmR9Wu8Dx4TbGKWGlCDQAacxUQxRvHQWD101RQYtEF
         Sq76ga0ImA8AwpGBL4MZfN/qmLG5ruH0DjKWs5MMwkeeS2eLgOKSNmurYfQ49o42ZJaj
         MpYzD1zz2jx2kVCKj4RsLxSLTyqgUgV1sNOpvGBa0WroVauJUKl473O/cjeZPBRR7M/0
         AS09BcQL1AGqvkVu4ZyloDEfJV2Czes0ZreIDd5Tg0i/15RR+nqxZobnRikOSXuTkS5u
         GveQ==
X-Gm-Message-State: AOJu0YxSXJqHds9aTpzs5U28pcAq2pR2uXAhuIaWtKjpmV6VdtiqffPU
        NjfWFQ2uxeJDzcFjy8ba+Pw=
X-Google-Smtp-Source: AGHT+IEGBNqCs1utYxbpcyOrB4mdDO/MyAF19cAR/MC6Nknf3DrfmrazBhEYCfZFo4TcNksijRmRlA==
X-Received: by 2002:a05:6a00:98d:b0:682:3126:961a with SMTP id u13-20020a056a00098d00b006823126961amr1050674pfg.5.1692310361977;
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id b21-20020a637155000000b0054fa8539681sm180609pgn.34.2023.08.17.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:12:41 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 703B536043B; Fri, 18 Aug 2023 10:12:37 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 2/3] m68k/q40: add data_swab option for pata_falcon to byte-swap disk data
Date:   Fri, 18 Aug 2023 10:12:31 +1200
Message-Id: <20230817221232.22035-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817221232.22035-1-schmitzmic@gmail.com>
References: <20230817221232.22035-1-schmitzmic@gmail.com>
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
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

---

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
 drivers/ata/pata_falcon.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 346259e3bbc8..90488f565d6f 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -33,6 +33,16 @@
 #define DRV_NAME "pata_falcon"
 #define DRV_VERSION "0.1.0"
 
+static int pata_falcon_swap_mask;
+
+module_param_named(data_swab, pata_falcon_swap_mask, int, 0444);
+MODULE_PARM_DESC(data_swab, "Data byte swap enable/disable bitmap (0x1==drive1, 0x2==drive2, 0x4==drive3, 0x8==drive4, default==0)");
+
+struct pata_falcon_priv {
+	unsigned int swap_mask;
+	bool swap_data;
+};
+
 static const struct scsi_host_template pata_falcon_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -44,13 +54,15 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 	struct ata_device *dev = qc->dev;
 	struct ata_port *ap = dev->link->ap;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
+	struct pata_falcon_priv *priv = ap->private_data;
 	unsigned int words = buflen >> 1;
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	int dev_id = dev->devno;
 	bool swap = 1;
 
 	if (dev->class == ATA_DEV_ATA && cmd &&
 	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
-		swap = 0;
+		swap = priv->swap_data && (priv->swap_mask & BIT(dev_id));
 
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ) {
@@ -123,6 +135,7 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
+	struct pata_falcon_priv *priv;
 	void __iomem *base, *ctl_base;
 	int irq = 0, io_offset = 1, reg_scale = 4;
 
@@ -165,6 +178,13 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 
+	priv = devm_kzalloc(&pdev->dev,
+		sizeof(struct pata_falcon_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ap->private_data = priv;
+
 	/* N.B. this assumes data_addr will be used for word-sized I/O only */
 	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
 
@@ -199,6 +219,10 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
 	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
 
+	priv->swap_mask = pata_falcon_swap_mask >> (2 * pdev->id);
+	if (priv->swap_mask)
+		priv->swap_data = 1;
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

