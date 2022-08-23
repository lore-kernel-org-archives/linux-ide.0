Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D644C3F6B0
	for <linux-ide@archiver.kernel.org>; Tue, 23 Aug 2022 16:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiHWQKx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiHWQKW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2022 12:10:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9120289829;
        Tue, 23 Aug 2022 05:29:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so17054780pjj.4;
        Tue, 23 Aug 2022 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ccy2SxZD9TMnc96K+D8Oj+6sNQ5XNCub+nh+eTP3lQs=;
        b=XSsajTrcC9/zN+sZalxiWHuF+qvphrlwxRfBM+d81FerKXE3+WnaIl/WejghE+UQ76
         abTEJZkB8A+5IOv9hkxC5dEv/VnMrSeEZhk8i6aVH6fsjVJTv8LmGUYoAyetCUFNgTcR
         VG6jYfckfjNlHgZHUfEJh5ndUrCsmqpm3j6bWMU8O7esFDj7rLPWXwojU9xmW1mKsA6U
         4GvsANHDvXumZxpZUdF4rcpd7O8Sue9j47lzLFHQcI/PWhJQGtTHCFA2jtH+VSWZNXf4
         EJXihCE8jCpp57SLa636Bpu/nJX0WwnifSVxdSj3A/53Y+feX31mcVOKxY5Kf5/r6A/+
         xMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ccy2SxZD9TMnc96K+D8Oj+6sNQ5XNCub+nh+eTP3lQs=;
        b=xbjmSzbkpf8wWTMI6Y23KP6fESKN8CR0W+a0pnP7FVOqnFZjGIbhWQ0PnmbxfAVZ96
         DQZ58jb8+5nyrm/98uRdkzCPXcESHHNCtEfS1tKNULzo3ipzY8jU6UE4Ba77MdlBK7qt
         aw+mwuT84RIFxFErPLfw7dxpK41dLLOs02b+kXliasI2fazcZEqGHoZEUDNS8FyjivAK
         gDsZTnPMPsKsXrtahARxVCbMAzXlVm5njXzsdi3OarW5fKPw1ahaDQCqDlUgpC7asdWw
         C8yfeNtTYPix2cl37ybnLFEb8oMFsEe7ScAS+SqU9cOMjpfytLLyDBAkTfec1wbbGXld
         VhFQ==
X-Gm-Message-State: ACgBeo3otALLObhYOPhjQY3pDmBAQtiE48zcCTWjHAtZ/fLAcU4ALggD
        xtTpkDihmPJwH7BGt1kqITA=
X-Google-Smtp-Source: AA6agR5r2GBEkrp6zNq7GKBOI6CwFCVkFypVCRquWLbq+1IC8WtkXdKfIfc3hkxR02EVaDAjRX6uyQ==
X-Received: by 2002:a17:903:1c5:b0:172:f8a4:b3d1 with SMTP id e5-20020a17090301c500b00172f8a4b3d1mr5351282plh.157.1661257759793;
        Tue, 23 Aug 2022 05:29:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0052ddccd7b64sm10621650pfv.205.2022.08.23.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:29:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ata: libata-core: remove redundant err_mask variable
Date:   Tue, 23 Aug 2022 12:29:14 +0000
Message-Id: <20220823122914.211355-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value from ata_exec_internal() directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/ata/libata-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 864b26009eae..0ba0e692210f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4340,7 +4340,6 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
 {
 	struct ata_taskfile tf;
-	unsigned int err_mask;
 	unsigned int timeout = 0;
 
 	/* set up set-features taskfile */
@@ -4356,9 +4355,8 @@ unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 action)
 	if (subcmd == SETFEATURES_SPINUP)
 		timeout = ata_probe_timeout ?
 			  ata_probe_timeout * 1000 : SETFEATURES_SPINUP_TIMEOUT;
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
 
-	return err_mask;
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, timeout);
 }
 EXPORT_SYMBOL_GPL(ata_dev_set_feature);
 
-- 
2.25.1

