Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A616C11F66
	for <linux-ide@archiver.kernel.org>; Tue, 29 Jun 2021 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF7761DB3
	for <linux-ide@archiver.kernel.org>; Tue, 29 Jun 2021 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhF2ONi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhF2ONi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2021 10:13:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E76C061760;
        Tue, 29 Jun 2021 07:11:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bu12so36720070ejb.0;
        Tue, 29 Jun 2021 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U6uGs3YmCXyn4Y7G+MQpzXdsUDWV4pSJZDyFwqAipI=;
        b=LVUtcnKHfwvA0mIo3dybEaUfhMQxSO47CigyvLVBtW/TCHM1JXgPL/CftOfbtLBxyy
         xkNZKELqP8dc8LlcIHWMYTTcv0BAq6yNn1SOQxtewSStxdxw6HUknpF3wUqPHf6x40Zo
         XkXQMeveY4450U4OOaDTmKHh6sBOEDfWo4Tdev0P5uO8MZTp2G9hl0btVJijrmQeZdb+
         cNbCJyUHHvVTFGFBTH5weFEoG1PVC6VGaOmob8IK26Ad8JB0Y0XH2API/vYA1KHoZ2zI
         661zSvlAwtrH4k3WC7vChNWyK+1p/ZT9V6a8YhqTXRWduI14f1t4reXVKEs0XHSpyVIc
         ttQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U6uGs3YmCXyn4Y7G+MQpzXdsUDWV4pSJZDyFwqAipI=;
        b=mMRXSuOU3YG4+wZNyvDxS89U7iRZDU6HM9TnC/xFsP30NdnUpMbf6QpijyiBClVZ1N
         ZvBYaNm5zMKr8TgnbjWoao7cCxN4C0I/BEM/FETDufidDZzFTKO8PRI7UyS3bFZOr4/v
         3bmiIC4v9nyTlaWczbuF+wfxoKv4TLnNrUojwpgLQ+EOeava76vQXMrw0LVcjM2bh7IR
         lk2EQED6XVd4FJD/mLiQ6mRiTWqqgtJsWdZEUyv6NhUXNFeELhLmwOPVQsM1xEXhZWBT
         y/Vt2x6QInxnw5h7ddQ4je4AwLEgUx2Zd9TDTZMUJrYa1TVChEm1BkYct7gT85RgMcfd
         22GA==
X-Gm-Message-State: AOAM530CYbK9lYPfYhs7Xc+T+nQDiXc/Pg21PN48BaiYzWxpvBAOARPL
        HYGK4gtcBPQA8NGf7Oa01VI=
X-Google-Smtp-Source: ABdhPJx40775Fe+/nbIEdf8NQ8oyL2K702Zku8wA4tEagAzwvKDHDFkMEdMu+mbAIRJw8dV8ICenlw==
X-Received: by 2002:a17:906:7004:: with SMTP id n4mr22897161ejj.524.1624975869020;
        Tue, 29 Jun 2021 07:11:09 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id v28sm8542587ejk.84.2021.06.29.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:11:08 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [PATCH] drivers: ata: Replace DPRINTK with pr_debug and add __func__ in pr_debug
Date:   Tue, 29 Jun 2021 16:08:28 +0200
Message-Id: <20210629140828.237848-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Replaced DPRINTK with pr_debug and made it print the name of the function
by using __func__ macro.

Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
---
 drivers/ata/ahci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..61b3e5b3dee0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -702,7 +702,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	pr_debug("ENTER %s();\n", __func__);
 
 	hpriv->stop_engine(ap);
 
@@ -711,7 +711,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	hpriv->start_engine(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+	pr_debug("EXIT %s();, rc=%d, class=%u\n", __func__, rc, *class);
 
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
@@ -792,7 +792,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc, i;
 
-	DPRINTK("ENTER\n");
+	pr_debug("ENTER %s();\n", __func__);
 
 	hpriv->stop_engine(ap);
 
@@ -831,7 +831,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+	pr_debug("EXIT %s();, rc=%d, class=%u\n", __func__, rc, *class);
 	return rc;
 }
 
-- 
2.29.0.rc1.dirty

