Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F1C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 18 Nov 2021 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC91613DB
	for <linux-ide@archiver.kernel.org>; Thu, 18 Nov 2021 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhKRSlL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhKRSlL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Nov 2021 13:41:11 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BD5C061748
        for <linux-ide@vger.kernel.org>; Thu, 18 Nov 2021 10:38:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so6017625plg.5
        for <linux-ide@vger.kernel.org>; Thu, 18 Nov 2021 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67r8F0/sx9q+LGM+Wt7NDN9RqixdzHVjgcdUmlc55vY=;
        b=X5xGc74onqJ3Mnmz3GFI9VwuiV1dU0VR/iZk1apwAKikDZddfQ3iqIwNhODPuPVbIb
         nQOjtH7yxVhzxgaouhfVI1zpr8COiM/Q5PLkB+/rXcrgI/s9keHuefDr2z2MojYwS6Ku
         nrdvGlTfurlo/2gJfJe4zoxmzhrhU4wWTPKyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67r8F0/sx9q+LGM+Wt7NDN9RqixdzHVjgcdUmlc55vY=;
        b=xSJCScm+e8v7p5k0n9tgECSEJhcaeMzTdgQJBEpcsczlDgC/rNxZUgEKh8bzHGETkm
         VI8FhWdb/vgmze2B8mm0f4yE2fJRHKG13jwMenHSzI50D0V99yt5GBZDGiaYSbZFLyrT
         bJhQhsMPLQoqc1X8sIlXR3af9DJAjpJAMGOUaG5hJBacztb1dx1uK00WlLjrXBxod5ph
         A04HNFSDWgKYb6EuO6fo7Qybibypo/dSEAQbRE2Q3hBC9emtx4qBA39550Ws7flaX9yL
         MR08dZWOsG+AWFBIJeXMO1h0OJ1GrQRTWbM8V8N9JjWGEEyXyear6+cUbRHVA/+KvfqE
         e6BQ==
X-Gm-Message-State: AOAM532KN09KXzXIs03rhio4eio0AyhaGvR1b+un+jZCUmLOtqK+pmFq
        Iu1M4zWqKzV9le38fSzOStl/bg==
X-Google-Smtp-Source: ABdhPJzxZJhkgk3/UTN/PTa3qc95MynPtxwFJgrX8FIc9hGFvqkb/ak+LE/E7bVC7uHBfZVQybKL1A==
X-Received: by 2002:a17:903:10d:b0:142:6343:a48e with SMTP id y13-20020a170903010d00b001426343a48emr68148113plc.29.1637260689750;
        Thu, 18 Nov 2021 10:38:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm8838800pjs.30.2021.11.18.10.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:38:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Date:   Thu, 18 Nov 2021 10:38:07 -0800
Message-Id: <20211118183807.1283332-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; h=from:subject; bh=6F3Hbtl0qNeNG8U8V+w5sB9aTa4zVRLFY4AiTt0tp9g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlp2Px6D/hRDhXYVtZDKrKpJoBeWgsIp4owxiTf+2 R2mhhzeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZadjwAKCRCJcvTf3G3AJhTSD/ 9gAVFmbAytcjL9YYE9+bRQqgtVOevbPlQvD/AI//SohjvY+B2WMdCpteORsPNGagz3VtVWyzLmNmZu BxYhzRmmq5pHiQHZDHIBu//MCiHRjBA5g2AXAauWUZIv7pRFe5m/Y1OPrS+NV283NuPiE8B/0aNVEu WjS7dHIPQLdyxTPq4VBtQqQVkPyPuPtVEl7BoWD4kGGb15YRVR8kHIw8FcBj++4TIrOpLs+yXdoOXK v30S/4/p9Ml1OzkjwLs5hx7+V3J36EfzGog2zaeasmHJdg25GK2QVxeYU2u00Czhww4x2LNh5Lx0ya KmaXrzhTh99hJlIeWnuhpk7pqnweHD0K3ppCZ/rblNd+H6s32872o7uytzFvdrA/Cx6DdTR131AKeA 8ctfNY3KjipThrZy62aq80W0YSpGtqFPLLztzN87Iun6eFz471J78VJOEL6KCwAYDhkWMFt5Hf59VA mmHw1cyBlOf8pJt7Vhe/WRGawqEM3Ijks24mCNiijPlI8kALQdE8EB1DwL3hf3lp/ibU4gi2KcAdgN S3RLvyWfQP9o187CJY4M09m54H+GfWQl5NETdJ1BCju/yz+VqhiqEeDDULXLPvQYjtgqVPOJtK3UD8 nRrZWY2H9xx/h8+LKr8h9m58RtfPGkQmNRDKPMHQS3B6UFqaq+e9ClLjwZXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct command_desc around members acmd and fill,
so they can be referenced together. This will allow memset(), memcpy(),
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of acmd:

In function 'fortify_memset_chk',
    inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ata/sata_fsl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index e5838b23c9e0..fec3c9032606 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -246,8 +246,10 @@ enum {
 struct command_desc {
 	u8 cfis[8 * 4];
 	u8 sfis[8 * 4];
-	u8 acmd[4 * 4];
-	u8 fill[4 * 4];
+	struct_group(cdb,
+		u8 acmd[4 * 4];
+		u8 fill[4 * 4];
+	);
 	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
 	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
 };
@@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
 	if (ata_is_atapi(qc->tf.protocol)) {
 		desc_info |= ATAPI_CMD;
-		memset((void *)&cd->acmd, 0, 32);
-		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
+		memset(&cd->cdb, 0, sizeof(cd->cdb));
+		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
 	}
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
-- 
2.30.2

