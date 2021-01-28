Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D64DC433E9
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237CA64E1E
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhA1SE7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1SDe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:03:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DEFC061797
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m13so6324821wro.12
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=l6j6sHisEv3Syi3TRnQNqc6U3bhlxtCL6A+8C76hJHNJyVyr2m5puQfClCPg6ZQlYy
         qIKIMq29we6Ef0IFTdty05v59otQXhQpGmu00fGYgNcVq8S1dohwX+DfUYzv5f8rjxyc
         Op/DMGdmrp5jxBiUJqDn5BhvW+8aIV81BH/L1ULv14ruptw2hVA9jmGmdjd0Fl8q2L18
         Qkc+9TkH/UESqbJzNw7c9r4QbOiXRd3S6vNHnrjcg372P1gE103rhsJB73kSxPCbsZdd
         Jeq0lMdmK3c9QVQcgjKjcXUWIOH32xuIn5bbrE0PTyUQWjLMeQw0uTIZDvCyNBxOC1Y7
         9DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK/LGNOy9DsyBBjFZYPOvNZ8xWqyFdDwYmos4fe8lCA=;
        b=VfRa8UlVMqq+53ZXqHNBK9H+mo/8X+qAp0GWNC+c/CkwfPt4VrA7W8fEFdOKOAO9id
         MvEfQ4zIsgLvDWHqhYfTTlGKYJin+ZAmYS3GZ127YWJHVudehAAbLEhMoiJo+ZPQi/F7
         Q/BVW5Ey6YMta72xl2GeI2k4TFRcFoZbq9KyaiQOXiHQ9k8BeLRVh8pQwh0pGVmYgdo9
         PXhSm7R/96hBV6TsPTpwSkXv9eixG7tgtCkqTg2F0wTbAo//aHqI2+medJXWYHbDV/OY
         J4ewWzOSuHDR4AKWv7nrSGfUURHFZxC84vc1DaWDUfSfd+nb6ngIlBIGD5SxPohaoXQd
         ZAYQ==
X-Gm-Message-State: AOAM533ka402qAxiBh4Lyw1Ko8imcZfSgsB9Lpk8FJSbCJVBNLnin5LY
        vWlnMaiZZlSCoVFbc+jNgBLTdQ==
X-Google-Smtp-Source: ABdhPJzEkZVqERpDZYMPU4xNVbLl99aNDBErtpPPLk/+9aUXBl1cYJw/1Z0WP+KPvVGOpdjOKb/3hw==
X-Received: by 2002:adf:f512:: with SMTP id q18mr291783wro.55.1611856964946;
        Thu, 28 Jan 2021 10:02:44 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 02/20] ata: libata-transport: Fix some potential doc-rot issues
Date:   Thu, 28 Jan 2021 18:02:21 +0000
Message-Id: <20210128180239.548512-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-transport.c:258: warning: Function parameter or member 'ap' not described in 'ata_tport_delete'
 drivers/ata/libata-transport.c:258: warning: Excess function parameter 'port' description in 'ata_tport_delete'
 drivers/ata/libata-transport.c:384: warning: Function parameter or member 'link' not described in 'ata_tlink_delete'
 drivers/ata/libata-transport.c:384: warning: Excess function parameter 'port' description in 'ata_tlink_delete'
 drivers/ata/libata-transport.c:640: warning: Function parameter or member 'ata_dev' not described in 'ata_tdev_delete'
 drivers/ata/libata-transport.c:640: warning: Excess function parameter 'port' description in 'ata_tdev_delete'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 6a40e3c6cf492..34bb4608bdc67 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -250,7 +250,7 @@ static int ata_tport_match(struct attribute_container *cont,
 
 /**
  * ata_tport_delete  --  remove ATA PORT
- * @port:	ATA PORT to remove
+ * @ap:	ATA PORT to remove
  *
  * Removes the specified ATA PORT.  Remove the associated link as well.
  */
@@ -376,7 +376,7 @@ static int ata_tlink_match(struct attribute_container *cont,
 
 /**
  * ata_tlink_delete  --  remove ATA LINK
- * @port:	ATA LINK to remove
+ * @link:	ATA LINK to remove
  *
  * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
  */
@@ -632,7 +632,7 @@ static void ata_tdev_free(struct ata_device *dev)
 
 /**
  * ata_tdev_delete  --  remove ATA device
- * @port:	ATA PORT to remove
+ * @ata_dev:	ATA device to remove
  *
  * Removes the specified ATA device.
  */
-- 
2.25.1

