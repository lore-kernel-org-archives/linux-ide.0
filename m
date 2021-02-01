Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098CC433DB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5333F64EA3
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhBAPdt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhBAOlJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C37C061793
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 6so16824094wri.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=xVIql7+8TZzLoGu0iro7M7rirVPW9tOh49bUKNDnqpyfpS3Whpmo74e7k4lVX93ghK
         QVGYeqDOTJbMgRuJisjN6jlFYsAmrD+1P3mj9jsLVvBnWVm93kEo66OucYsaQBVYoZYr
         WM8V68r8BOc6HohzdC0WhjVN9tseqS2ku2aX7l+ITaO++9MncJahBMgIDGPEt2RxBtgS
         CXTLa4/2IRIAwYScQVkcvkn7w4U3ydCD0dC+OX0X9QNUjRy3cR/9kPWc4jgx/qNGvH+r
         /ADOr10H5E40G+f43FuGXghvCW2ZAX+RXgxPJkCGSOjZhjjynyC4OFLmSxqdBnpPZNr3
         XkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=fu4QzztvMVz9slWh3XrA2Dt7kUbzJCrmHAWmk2buBJOesM+0WGZDTdacLFRJh78MnR
         d3dQx+u/hN2XRPQrcuVDXdOAdCsSOW8vG1nLXQkQNb0Mi+aB1JUDR0BGyum3Z963FdKo
         PEDpiS6Q2COp7ZeeSEeXR+ar64p6KJfa5qFM5Zwaw94VZM/JRVG5UR9ukKEzlcM0blQs
         Fi/6e895LFGJ0KZ98YJedBJiBPAZvfXDhGbUtNObc7M9J7f9049HGxIPK+tigPwk96lQ
         d6+SVbfh7yhX9Y8Cx87y128Rx893nThvBStmAjxc/m5MWC2gUTCVa+WPv/6PHiE7iycr
         FbyQ==
X-Gm-Message-State: AOAM5305d3ARY8/rCqMePea6/SvhohajIAATU+LcUEOE2YrOBekG7juf
        nYsS8xYaUpwqynTB12vxTuPCqw==
X-Google-Smtp-Source: ABdhPJwqgKID1G0doaFBi2aHMNjBaJI2XDkLWh9DLrsoMChHmb+g5MausIaS5inHIRB+Z2DvD+UAaQ==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr18373016wrm.337.1612190389474;
        Mon, 01 Feb 2021 06:39:49 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        linux-ide@vger.kernel.org
Subject: [PATCH 05/20] ata: pata_artop: Fix a function name and parameter description
Date:   Mon,  1 Feb 2021 14:39:25 +0000
Message-Id: <20210201143940.2070919-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_artop.c:278: warning: expecting prototype for artop_6210_qc_defer(). Prototype was for artop6210_qc_defer() instead
 drivers/ata/pata_artop.c:359: warning: Function parameter or member 'id' not described in 'artop_init_one'
 drivers/ata/pata_artop.c:359: warning: Excess function parameter 'ent' description in 'artop_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6bd2228bb6ffa..02e4fd5e3b934 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -344,7 +344,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 /**
  *	artop_init_one - Register ARTOP ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in artop_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

