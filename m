Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5596EC432BE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Aug 2021 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B6B60EFE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Aug 2021 17:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhHZRoI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Aug 2021 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhHZRoH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Aug 2021 13:44:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E519C061757
        for <linux-ide@vger.kernel.org>; Thu, 26 Aug 2021 10:43:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 2so3368972pfo.8
        for <linux-ide@vger.kernel.org>; Thu, 26 Aug 2021 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1MY4FXuyrHIHxnVsVGM3kgnjUslCMqrCLSsSFVBxeBo=;
        b=t8dUDFPO19amoXQ1mSRTnweDzzs8zreWVh0cYacCz/AHe7PCKkZUn5dDEA/Pc4sYhE
         tEgQhtPO0QJ2XVf/USe8iMJVyOTWNXjMvfwRFNwvfLqrRUNsJmBkModhB6VihfNo05nu
         zsWDYunlUA5mVLZAMTDi2mxN+kwVqCEm4nDSnAqqMow+/qS1B+piiV/7L/vkNFCME3DP
         T9PgHvBYh0ysBYSrBn0LBpJXWi37eisZ3OrjijoTllll73yBFWWwh0xGLVbiwA8dGEew
         SauhREsRY04hJwV7793/L0Aixe1DNOPvqkk/mVgt/9cI1+W070k3I+wxwiirYCBaBIMq
         CTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MY4FXuyrHIHxnVsVGM3kgnjUslCMqrCLSsSFVBxeBo=;
        b=qaN3nN+6iINLIxHWHrHukcqZlCaUb+CJcSUIxl2YRD9cIZ9FddPzRE8EI6GEC8UMvp
         HfWaLV2zRDWtRGVKlwhK5AH2zcQwQxHVpjtGftPPS51UoKVYgUjf/Rg/qaE6Su2M/UPJ
         LiILwagUbInUAPcRXkza0U0KSGnCR4HAoaDUwyur20kYVgX9xkOi0E36lfLlDIrWxj8O
         DxWqr+5/3IBg79EJAoMdL0Ei8eiY0YPV/3hlU2ChjplrZGvrKFr78TUdfTVFZe/7JKO/
         qe6BP8ag6rCA088FZVTfpnOwfQJo0CASnu2i+99qloB6maKwSZsMUwSkO9dSJMLAt0eQ
         pcdA==
X-Gm-Message-State: AOAM5323RPNrL3zQmH9EkMkQbfXbKXwWr+mjfTjp3W0Dkt52JNiOgCz1
        5nafN2ZOX2/R1W93Yx4k54QZ
X-Google-Smtp-Source: ABdhPJwfd5NuG59K6vIN356JEBhcIseL+b2LZMo50wvOdadVSffI52nsAl6OnJD/mlZ+oaRyi0A/+g==
X-Received: by 2002:a62:1a03:0:b029:3e0:30aa:5172 with SMTP id a3-20020a621a030000b02903e030aa5172mr4732412pfa.69.1629999799521;
        Thu, 26 Aug 2021 10:43:19 -0700 (PDT)
Received: from localhost.localdomain ([175.157.109.217])
        by smtp.gmail.com with ESMTPSA id u6sm4125224pgr.3.2021.08.26.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:43:19 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     axboe@kernel.dk
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ATA:libata-pmp: fix warn: missing error code
Date:   Thu, 26 Aug 2021 23:13:01 +0530
Message-Id: <20210826174301.21255-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

smatch reported 'sata_pmp_eh_recover() warn: missing error code 'rc''.
This patch resolve it by adding I/O error code to 'rc'.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/ata/libata-pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba7be3f38617..2ea7b9986f4e 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -977,6 +977,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 			ata_link_warn(pmp_link,
 				"failed to disable NOTIFY (err_mask=0x%x)\n",
 				err_mask);
+			rc = -EIO;
 			goto pmp_fail;
 		}
 	}
-- 
2.17.1

