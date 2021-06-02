Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC860C47096
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D557E613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhFBKTm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhFBKTa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCABC0613CE
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so1698339wrz.8
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2U6dF+hH5gwzcoqkIhyeiAxmO4AyHDuMvjSLxOZWmU=;
        b=i5fH5Cf/5TlEl8yM0M75Pv5KaKc40eGR7Z7O4pPGlsTzewG+uV4TditU/mWxxLCfg/
         ri2gFrE2zZZ9hdZwK4ZM3EzybMarGmmonOe5u9PHg66NoG34MbN/tS+30FrRcBmIsgrh
         YB0pFRuLkDV6b6pkGB+93Zkj+wnWeGLwmv1WUOcpfoQbl5664IYp4+cO7Cr6Ncl57J+N
         IF6Tzd3suzO3rKdbnsqjQK/Pn4uY4QeyZPQyLIFssD6hhf5m9vNAfZ+RgUnvtuTlgiuK
         aoWjiBsYkVn/ktG1w/fl79TXaGzN3yT/dVKAgsJvDhWCh+z3JD8UJ/SNN7iASUV48GH1
         FJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2U6dF+hH5gwzcoqkIhyeiAxmO4AyHDuMvjSLxOZWmU=;
        b=pTIccVmF+zohITVmpWul1VkpfGZR6Tzgie7bQ5pPKomgn6EnWFFcKLl+880nnGKaKp
         j/Vj4qUJufT40pgwjQtiSEjUDOummjNEYbQe3w+MGhOjxziRz+ckMtECSLxMsU+GKMKn
         t38+creD/mpNYTkOzJmZGQkQFJzd07qvO4s1ENxSuMYa5WYQ/4HLLZ/DjAqapwUpTPSK
         xwcQQPql+4FwnzIKeKjtwyASN7viVVGi2eiAlpWFIBvH2bhg38pPDyV/7yiRyxDIHDQS
         J1fv458kSCaxxWuTrBVwAH9qbYRSDsp1HpMXH053YACYXc9xuDInzzuiXShJpyQVlhMk
         quVA==
X-Gm-Message-State: AOAM531ylRQC4Iz56mDgynNb73giuODTyhMrymAwbG29amg5g2Hz06LS
        +fM6PmQTBnDgrsn0pCDpxVdmc3AEhw+dVA==
X-Google-Smtp-Source: ABdhPJwMO3wIYStENRGS/URkPemZcpjcLQZbT3eJrVPOcBZQB9pqIW/KfTzr7p0k0DOd5k/LO9jmFQ==
X-Received: by 2002:adf:e788:: with SMTP id n8mr19645605wrm.387.1622629058742;
        Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 05/21] ide: ide-proc: Strip out unused fops structure and accompanying call-back
Date:   Wed,  2 Jun 2021 11:17:06 +0100
Message-Id: <20210602101722.2276638-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-proc.c:457:37: warning: ‘ide_media_proc_fops’ defined but not used [-Wunused-const-variable=]

Fixes: ec7d9c9ce897 ("ide: replace ->proc_fops with ->proc_show")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-proc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3781ee9..34bed14f88c78 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -449,19 +449,6 @@ static int ide_media_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_media_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_media_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_media_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
 	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
-- 
2.31.1

