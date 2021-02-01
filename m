Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A6C43381
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C694364EBF
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhBAPdU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhBAOld (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C5C06121D
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so14119249wru.9
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/xsj8QnzTyjZTuByN2rtr+7Bim8nVB2CCDQafkvd6A=;
        b=nfEkhzEbgz14R/tMpOwQ02Eojho5vUVU6vM5evj27Ooo/l1N7p5vTWgkfFKNa0uKE7
         +gL6H7kg3w41Bpb8ofpNmElwXHFyNIzGswnfbEVq/OFUytD3g/H/mgX+4QlicbyFv0/w
         WljXKAe/AzV6xBwDr0P8gni8A31IN+pDSzCjGJuPRXFeFypKWYwrh+IzBWGDbTzPOHlm
         bIWi94gCiNKCUhCft7VLMbp9LwTOu26W7vti9odQn6WaLswVKDBHrRMrkc85EeApTMHC
         YbMkMAAZXD/5paEW4cT6W09tmhnY1tzAB/fUOvKHbMBAcCbWQrVd5pc3c1Lh7e9sI2He
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/xsj8QnzTyjZTuByN2rtr+7Bim8nVB2CCDQafkvd6A=;
        b=EP8vjL1YDk5KByLpXY3NXa4uO+oFOnFSG8HSPgTuFye3DNZq0Mo3QFmz+wTRtJnNpG
         gyGCc97I4W4N4ACn2oNvPWVOeyqH8pPAL0L0ykOxZZ+chX9Qhz3Vc7u5BAdDHl0G0XkD
         TwGLdc6iUuHe4xBN7F58jkzWj9WiRoanntdR7wiSpTkilRifrObmv56myeuISmGoZ8eo
         DnZApjwn7/Tf+6QfJE7cbOMfsubaTLAIucbXID8ev3s1JArf4xE6Q/Bs+SXqcCAhN7Hy
         ByWpraPHKw6IIaSPDdhmJepZ4YAIIv+9tuJSqo0R8MgtHgYIkiaFjoI7woNY8oypncJk
         z/zA==
X-Gm-Message-State: AOAM53087iP5K9OLGqZtI3Ll7KWmmmztA7bcSCMsCqinBVwyJyMqdnn1
        rS+nLQ61FsEVBOXDCmm9gUpOww==
X-Google-Smtp-Source: ABdhPJzPmYic1cm2Sz5pCBPwPCfylEgtpIbm5kuKCNjN5CBDvdpU0QDAwGLOOSsk3STc3hYIRx2dGQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr18522509wrm.207.1612190396737;
        Mon, 01 Feb 2021 06:39:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 12/20] ata: pata_amd: Fix incorrectly named function in the header
Date:   Mon,  1 Feb 2021 14:39:32 +0000
Message-Id: <20210201143940.2070919-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_amd.c:331: warning: expecting prototype for nv_probe_init(). Prototype was for nv_pre_reset() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 75b830eb3c542..c8acba162d02f 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -319,7 +319,7 @@ static unsigned long nv_mode_filter(struct ata_device *dev,
 }
 
 /**
- *	nv_probe_init	-	cable detection
+ *	nv_pre_reset	-	cable detection
  *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
-- 
2.25.1

