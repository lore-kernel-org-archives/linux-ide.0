Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA41C4320E
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD256108E
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 06:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhHRGKb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbhHRGJh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2021 02:09:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66585C0604CA
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2021 23:06:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c17so1160568plz.2
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2021 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps9jShnfYkcW7CF3s3J9G8+oGaQDbHRpYLWBXR8U5HA=;
        b=hJ+1pw+QR8SAzBduLeTRl7IL8WmBzmKdGAGA6oK7/b7O4sS34IuV1dVSvfAtXQZ8H6
         1+G1v4Tqmg5dSvosNjNMogPfbguMo4ntV0wpYm3/J+c9PeLMlM0pj3RQV41NuXQrnYYq
         S1XAq2zikRpAp6sdSo1lnGzaSXIhWByiPdi1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps9jShnfYkcW7CF3s3J9G8+oGaQDbHRpYLWBXR8U5HA=;
        b=uawk6ImN/hFnrwWNjvLA7CgcWBLfDzP+CgUrcbLHFq+FhlMrVburU9ldyIlvtMOvAr
         RzE26pnnF4EROkXwStNcmEKGpIDS8ADnpkwWdAEYfkRdIQUjG5Ed67+Fn+kkX1jwda6a
         eYu1zFSAgPqvRMuLfA+4k+JBk3ez+Nop5SbcUcvafkp6ge+GyZ5IvGqXt6qIN4vNDTRa
         qEpZJ1OUKnvl+inu4+BgWgCzSBr9Myvyy3t0pjqdinQHsI5IHVw4+cT8ruomOIoQbA7h
         MSTpW0R2zP8gvpuFRndB1JL6l9d2QvOOIZR2D9lRgyIojBMtfnO8kTRYf0cRzzfO8I3S
         PRJw==
X-Gm-Message-State: AOAM531kiOnDUk43dHv5OeUYMedqYd0pPbVqHbWggyphhuR+HYMaG1Mi
        QiKWN1Y0lWj+RUMTe6Zau8XB0g==
X-Google-Smtp-Source: ABdhPJxsNLILAxQG10XCyPYjemMd7a+ckBg4K7TIyR7mHtdyoVONVT0Fx6+Gjges8rNdRNesUHRD7A==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr7900521pjb.174.1629266760808;
        Tue, 17 Aug 2021 23:06:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm4817746pfo.175.2021.08.17.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 24/63] sata_fsl: Use struct_group() for memcpy() region
Date:   Tue, 17 Aug 2021 23:04:54 -0700
Message-Id: <20210818060533.3569517-25-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; h=from:subject; bh=490IGoO3mtJCjh0g8l7zMoK6+vhQucUWQpUj+3laYeM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMjgKcbQTO9FDMOsyq/janGS26xgJD+GS/2zaUs ZM2eCZeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIwAKCRCJcvTf3G3AJptmEA Cfi+co78goyBBrH+Zm1R/id0yh2CmjqSZTgJNwAn+IsBhLLep3r74z/+4G0L5HEEsO7K/F763D7FzV qyqSu18qX5XPvdiy0atubLyGda3UuI3umIbTFgsLY66SeEZbWNudGvJ5l2NlJeuEupRNrDDp6WTB04 +juq9wzztFjSrw5OPlb7mi4UllFs8pzBTlwgp0MlwVSG57JFMFv3kGQXHjlEXuWNfiINs3OZhr2g1Y +V2oJMY1cAXD57fne3MAALUSSuHcL59yIGtul0hNa5VmLGIBBdUwcorbjRgNqEvsgFoL3oWb78eC53 eWKn72M+cBfKnBw6p7ak9Y1aXrUbhCOU0IpIrNgQ0fS1/AWVyGj7M9WTeK4POwXFQcsbBMmsXeAVId SmQi/80UCLxGlC80dJmtFJJg794N+o2TMvlfe8RQc2xEp4HDqVCG6xAiA6VL1biQl/bMXi2/gnsZGk 5vEIc8263QtaFStfx8cXsh5/D1ZLtfxcqc99evQE+x1Z2AtFfCRvPXqUEnA5uL9Ird97I148pH2vsi YUgkY8gs+vLWH/DcLD8PuWXxZqes8m+snkfJjISzYk1/D7Vt1hdG9XS5SowqP4R1A/de8CANYlKoki VgBCMKLldP0qegznO020Xhe22ClCpYaDlUaI3GR0HC98cUXBvOfGGnUJ/5Fw==
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

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
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

