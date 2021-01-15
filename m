Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0DC433DB
	for <linux-ide@archiver.kernel.org>; Fri, 15 Jan 2021 02:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4823AC8
	for <linux-ide@archiver.kernel.org>; Fri, 15 Jan 2021 02:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbhAOCvu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbhAOCvu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2021 21:51:50 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72746C061575;
        Thu, 14 Jan 2021 18:51:10 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n25so5110916pgb.0;
        Thu, 14 Jan 2021 18:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJG+6kgfjZjK189KqMiGV0hwONF59DnMbu1jbDOMzZ8=;
        b=gqk5SvNWsJauD8t2n1R0I7d0ylZI8NQyTKbPkaketoQ4c//ObudvxVa4C/67jZjKg9
         1brkuQXv3sOhUdpzLEUDj0GjP8eNf9Jfwn3GlPs8L/DpOVnnUMaI3Ic1ksvG9Hu3nRw5
         3A5RI1ux3sZqwICDELrYZVs7Ug+0JekwD+N/LKaLwWRg/8F8nvjtKx5GvDlXx6JVyiuH
         uwsWUfos6+ibFL1e2fPp6TEbV6w3s6niVq9pcUbNx7LNe0XwtUWo54n5XHXxhKzWyzbu
         GVu/pn3MpC4jrTGdclYmHAXVvMANmIJhfn1/2r14svb4QxPwGKU0phA97oh3VBN6W7Xh
         ux0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJG+6kgfjZjK189KqMiGV0hwONF59DnMbu1jbDOMzZ8=;
        b=VkcGKRXzhR3p0nNYe760+oT5UBCZrPI8M5Dq/KzDr75LZ8d1ZYTpTDAo2IX0TMKXpS
         UtrxmBrHQG7PMjDsSnERZZwKRZ2nnAx5vgzYh87ANqHNd72Do4PrJe0HP+d3L4H8NDDV
         L9xdccFb2UiepPNGQeOAMGDaSeuiUoLJYVMtnmxF1YJv4+AEJkFghTz1l25oHIwWZclf
         By5+PFTN9A+je3nPifE6XGUpiH+KdPEMoR4yYJesSY+G5Qm09bA9iBvJ51VEb3rZpbAx
         tTxpKXnfSD/gMPAFYK34kbTeal1PeRNIiXjD34OmBwNvRqzoL8LxWyGhIfqj5GWCKgp8
         CRBA==
X-Gm-Message-State: AOAM531mPw30cnof6xujza3pGdqIZfIEUoBqvoyJD0OwYjZYv8rB6co/
        BHoQpWHTY4fPUABTDmyBOyMqQ5S5qfM=
X-Google-Smtp-Source: ABdhPJzVnky1wYd5Zm0EKEQs7K4mN7cwuFs1QMcl+Ww9tXIiG69Db1cNgKufSu+PIxMDMR64dxrzFw==
X-Received: by 2002:a63:445a:: with SMTP id t26mr10475355pgk.402.1610679070006;
        Thu, 14 Jan 2021 18:51:10 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id gf23sm6671302pjb.48.2021.01.14.18.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:51:09 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH v2] pata_rb532_cf: remove redundant error print in probe() method
Date:   Thu, 14 Jan 2021 18:51:04 -0800
Message-Id: <20210115025104.5033-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Coccinelle reports a redundant error print in rb532_pata_driver_probe.
As 'platform_get_irq' already prints the error message, error print
here is redundant and can be removed.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
v2:
- change patch summary.
---
 drivers/ata/pata_rb532_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 479c4b29b856..dcde84f571c4 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
-- 
2.25.1

