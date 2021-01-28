Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF27C433E6
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F57F64E1F
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhA1SH0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhA1SES (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:04:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE2C061352
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c127so5289514wmf.5
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=QMd8ysJWDHZdQ5sbfXQG3sQzlvqAiSI5lr91/8U20X+H+I3kdNCkCJXHnQkgTYJu4l
         2w2rQvHn6a4fdnfbV8+Sq1xUAQLlDGIKpCtw5Kj4LGJtUsqufzAhSG3iHsJfGDGD0ENO
         FUYJ9UDZJOfwZ9CLljbkHF40uLscAogqmxILS11Y25FuP+g1mVCAq9n7zCg18V0HAOJZ
         8/qc91mGfJC0uKQPpJAehuePNEq0Hd3iLBecOKhJesV4mjzuP+FxT+Hi1EDQTqPXrpjp
         AR5qcxG8aIFT754quwEfLCi5oQn9mi2/HTVRDpoZiKkhbKZnELie6kUCvERc3c0kx75q
         YT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=XR2nfdcGRe5xKXkcb/fkoUp0nH0/EHBPq1LlCVJ41vM4dalOrPmyOOqP2jOWLANbc8
         whAwmknk17AoMM8UM7PZYoqqDUjVcvhOekOrd0alBGngCTYNsuLBLtAFYpIVr6PVzm5w
         3xCL26hWMXlSlLy01uRsXDY1K6oAEszX5iYKrLF+jE9rS+dIfuUong/oHxoaOVguR4Mx
         FRy7DlpPojLrHAl8o7cQOO4n0/Gldxlx41rrINwEXPAxbF0QHfqUmfgfPt3dh7e959ac
         4w0R8A6SsEBhCzmp54pHgo2o+aImN0p4XyZTlsZx1suz0yEk1gxQCrZ4qLYUORhg3yeS
         iQgg==
X-Gm-Message-State: AOAM530fq2zULHHsReIkxFlzAqA2VJ/z71NogsvNcNf/kSwFdyqwj0X7
        WgdrnN70q50s2L4qnuUH6oFYATqjIgPyPJrf
X-Google-Smtp-Source: ABdhPJzt+efXXKYitxJSG0qkBeBvxKXFSW53cPvWKdkouaGicDhbubEjfCFFyjhotrF0vhCXh1dV/A==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr401685wma.177.1611856969662;
        Thu, 28 Jan 2021 10:02:49 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <teheo@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 05/20] ata: libata-pmp: Fix misspelling of 'val'
Date:   Thu, 28 Jan 2021 18:02:24 +0000
Message-Id: <20210128180239.548512-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-pmp.c:76: warning: Function parameter or member 'val' not described in 'sata_pmp_write'
 drivers/ata/libata-pmp.c:76: warning: Excess function parameter 'r_val' description in 'sata_pmp_write'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 79f2aeeb482ab..ba7be3f386171 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -62,7 +62,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
  *	sata_pmp_write - write PMP register
  *	@link: link to write PMP register for
  *	@reg: register to write
- *	@r_val: value to write
+ *	@val: value to write
  *
  *	Write PMP register.
  *
-- 
2.25.1

