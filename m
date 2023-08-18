Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B8C7113E
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358119AbjHRHOo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358073AbjHRHOO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:14:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD263AAE;
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1216986b3a.1;
        Fri, 18 Aug 2023 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692342853; x=1692947653;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=272VBCmXyU9wjWk6fj6Wgw0LszVaQ4zLEm2+wumWw9A=;
        b=DQPp4WFY2sLZ+txZOU01NjmRZpDdOp1flp0jqqq/CwwMvYOhQ6VnORgLbqimAWsrob
         fPq40vV806RoNdcv/TXYIdajjSinIRF8UogBrt5MFP9qK9Xan/wIhsgV6t49UfHr+lEK
         scSnYl9HU47tfS85l/0peG8pH3jR6RoITEGmObHhKOT/8n4EoSiy9vQZII7k2tNi2qqw
         HqxUmPCGV/H6vzYrHpZ7jWQ7+SgURBYmXqdf3cUchTHcjHfpYI0W/e/rS3bXgkSMKtGT
         xZtp21YVwr3JI2tuux5pM0FaTOzZxglVITgqnCzE2bPbuGDUlqJIWQu1Pdu2Qprv1qhB
         nMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342853; x=1692947653;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=272VBCmXyU9wjWk6fj6Wgw0LszVaQ4zLEm2+wumWw9A=;
        b=IbYYvamdnbU9BKYpA/en0TPJ8LYWLKhC6EJLU5zJm78O5o+H5zfkc0I7xiRSalFgxW
         99ycscyYsPJnGfPDntdejtEVnt5vDRug39aiPLsvYjiwkNclVbrrygRbc1yvJoaVvp2S
         lak1Gb43rxvyOmzAZeBYOu37DiB929RD+IMUwFA+zdPzlRD2JURUXPQvdbReLtDr/FAT
         Z802erKaf0ibL8i85W1MUQRu+QKBWi/68m0wGK3QP+3H7rb2XkX+57ilZFKVb06y0Uze
         CUnLS3v27GePtxGuU/lOKbYLq0F6UKaWaHyKqOTLiaIPFDsdaUnKNvwtK6yG13TdCT5k
         KNxA==
X-Gm-Message-State: AOJu0Yxd6xnN0YlgA9jdx6pSTe+UC+CZ1WJHzr+3FT9hkyUKvjkCegfW
        CS6CC5YitXpdWQPOHrDyMLr56rBoufc=
X-Google-Smtp-Source: AGHT+IEe/TrcFq9ONg6kFdtbFfu0CEVbtFWxH50l4ILvyBI4gGUsAXOAp/ry7/tl6AudBlzHvND1sg==
X-Received: by 2002:a05:6a20:160b:b0:13a:dd47:c31a with SMTP id l11-20020a056a20160b00b0013add47c31amr6747071pzj.20.1692342852676;
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id ca20-20020a056a02069400b00563bee47a79sm715875pgb.80.2023.08.18.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id CDC5936043B; Fri, 18 Aug 2023 19:14:08 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 2/3] ata: pata_falcon: add data_swab option to byte-swap disk data
Date:   Fri, 18 Aug 2023 19:14:04 +1200
Message-Id: <20230818071405.28581-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818071405.28581-1-schmitzmic@gmail.com>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
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
index 346259e3bbc8..27443cb757de 100644
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
@@ -46,11 +51,12 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 1;
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	int dev_id = dev->devno;
 	bool swap = 1;
 
 	if (dev->class == ATA_DEV_ATA && cmd &&
 	    !blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)))
-		swap = 0;
+		swap = (uintptr_t)ap->private_data & BIT(dev_id);
 
 	/* Transfer multiple of 2 bytes */
 	if (rw == READ) {
@@ -199,6 +205,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
 	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
 
+	ap->private_data = (void *)(uintptr_t)(pata_falcon_swap_mask >> (2 * pdev->id));
+
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-- 
2.17.1

