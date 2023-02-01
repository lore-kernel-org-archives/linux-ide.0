Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03DC636CD
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBAOK2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAOK1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 09:10:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712E5D905;
        Wed,  1 Feb 2023 06:10:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q10so17441124wrm.4;
        Wed, 01 Feb 2023 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6PShDVUBgCEmFh6QpzXZ6mZIDgHxW/uxw0nQ4RD00c=;
        b=ZR1yJdD9JHdFz5GoMnaoX73GtfmUkomGLRKYINJFlfV+axUnadPDnSwaugTj61FTnP
         vedDNZtywZxb1Ceyd+zuy5bp2Ifgyn/JPeJLEmPZ3Fz3iVvJmU6WNURZhhhirCjjBJtK
         hL8MVcF+3fbix56+yCMEUhheJ2i2P3HVWBl8UmVmw74YxP5fy8rFPDLmG1djtnfX2Xw7
         0BoVS5lioZem5FjaG42Ggmh4vPlG9kE6GCDxep9BmYvJtrbRCddQgmmzFk/QqDfn1oVh
         A4E6CQgHKmY5HqOnVSOG7mAuMLjtWg21eclZSBhlM3zwkNYkxct6PHzVe+8+nlQ3dgYV
         kkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6PShDVUBgCEmFh6QpzXZ6mZIDgHxW/uxw0nQ4RD00c=;
        b=14pNM8r4ZbwTIY440E6DcNILynlVN/fMcd3tUBZAx7uz7+kGPrXGmwgW5+P3jb6UWK
         JdIgW/Q8VyUycJGrr9YBC/NJz4vdTDFGtOixUrsotr1o5nWOqpPUpbRsRfLpiBe/1tUW
         ImZ5a2v++EpBMg/IVJ/qyYroXvNVhhT37p68/IvG5FtdxI6lm0qShYu46LgdZN/1+kBB
         XWf3WtzLxoFlAuBvK+7ZfXX6mh9Qjl0zyJJIlKqGJ0sNa0+AHEJoUS3iDx6FstY99Kvz
         3QmIRYvHAERW3RHq5Tar8ak6FgbkvE8pzhb3NS7x/uU36k6FLmukjIqXqLDGzDFtefoe
         ILiQ==
X-Gm-Message-State: AO0yUKWNYGfPCsQUgyiSPR4CZH8krkdLNQ2I0oWLb1Ae2DhQvrup1ebI
        NUJGpsPsvFRd9Rcr1pbt8PI=
X-Google-Smtp-Source: AK7set/a7ReyJsVtJgCquu6EtEkHujVhZJjLx7ZMQ2eDlW6WRKy9xJczK87Dp3y8Ik38QPIZJK82zA==
X-Received: by 2002:adf:fcd2:0:b0:2bf:bdbd:25c1 with SMTP id f18-20020adffcd2000000b002bfbdbd25c1mr5783100wrs.26.1675260624161;
        Wed, 01 Feb 2023 06:10:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm17187777wro.8.2023.02.01.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:10:23 -0800 (PST)
Date:   Wed, 1 Feb 2023 17:10:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ata: pata_hpt3x2n: prevent potential forever loop in
 hpt3xn_calibrate_dpll()
Message-ID: <Y9pyzLUShZJeLDq7@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This code accidentally reuses "tries" as the iterator for both the inside
and outside loops.  It means that the potentially the "tries" could be
reset to 0x1000 and never reach 0x5000.

Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/ata/pata_hpt3x2n.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 617c95522f43..447dc287a2d4 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -380,14 +380,14 @@ static int hpt3xn_calibrate_dpll(struct pci_dev *dev)
 {
 	u8 reg5b;
 	u32 reg5c;
-	int tries;
+	int tries, tries2;
 
 	for (tries = 0; tries < 0x5000; tries++) {
 		udelay(50);
 		pci_read_config_byte(dev, 0x5b, &reg5b);
 		if (reg5b & 0x80) {
 			/* See if it stays set */
-			for (tries = 0; tries < 0x1000; tries++) {
+			for (tries2 = 0; tries2 < 0x1000; tries2++) {
 				pci_read_config_byte(dev, 0x5b, &reg5b);
 				/* Failed ? */
 				if ((reg5b & 0x80) == 0)
-- 
2.35.1

