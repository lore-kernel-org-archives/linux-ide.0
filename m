Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8443C47092
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5908613BA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhFBKUG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhFBKTc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6659C061348
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3427770wmk.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5FEzmO9RZgKtbCHPkiUM3cWX79WWEVOe+3S3XV/eYg=;
        b=C2GCEG54UusFDC++LW8FQGhMV9Ae2/NdAiCrbnLSn8Dfc9HJl+/4P0+sz06JqzuqWm
         /QbsnbxardHjL/6AaH8fWYkB2yByRBcs4tJxiB7fVwBPGf1SUddsjDEpdmUV1HN17SPY
         hIfBZzGerb0kFyltrpIhV0t+K1sNRmYOieTWrjQZGgSNu6/PJHfj5PHkYIr2JUgIYeCX
         uRoJNNonKzF5LGjgs45qE8gZkQyILHHaH74MneW1jnQ00vRJ9DGo5ycXZU2JQMG136rU
         UtxvuZE6+utEsPcNZmXCEusQFKdXGlnFXPHnG/IlFcBic8QHpVKgX+HjD0MWYtjmG1wD
         kIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5FEzmO9RZgKtbCHPkiUM3cWX79WWEVOe+3S3XV/eYg=;
        b=ubO2n40Rq3NXJP7KQ4sMJU36a2KFfoS/+Qifg06XbM5wkohPZaVMqknDfH6ZgNli0q
         S3XMxct6oxO84nMKQziqUIU3e378DjwIsWSSjOSkXCEgy1mvkuyU2wwX5DzTjPTF+fZG
         i6kj9qF4fipYGjFYGUSm/KoRGNArqqNHSPJO7R4mEVs7LV3j11mWUSyJJz2yW5lF4eTM
         CUAQNHIcbVCaRLsZVtBvVM1Qzx6a/XnDDAJ8yv/h5zqfmKPvBMKrc8+olRBqW6ri0LQs
         QxZ/e7ur3gvVEYXrANUnQUvcJZTIE8bWGRR8AD/mmugFaoDiHL1WBaK9+AWRFs0F/5CJ
         S8GQ==
X-Gm-Message-State: AOAM532HIArXoucge5/qauGh+Qy5FC8pKnxKO9k1DdIpPkOZ2RhNidQ5
        80MpevEyzDvckFozogbI8MvgOw==
X-Google-Smtp-Source: ABdhPJxL98eynQkJFFkPBCCkEwJ33W9JN6L7a5MWz5uDvW4J9kyCTOJk0pF9VP0/RZ3Cq3Hp/W4C4Q==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr4526415wmg.24.1622629064563;
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 11/21] ide: slc90e66: Remove unused variable 'sitre'
Date:   Wed,  2 Jun 2021 11:17:12 +0100
Message-Id: <20210602101722.2276638-12-lee.jones@linaro.org>
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

 drivers/ide/slc90e66.c: In function ‘slc90e66_set_dma_mode’:
 drivers/ide/slc90e66.c:80:6: warning: variable ‘sitre’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/slc90e66.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
index cd47445fda1ff..0b06c74dddf36 100644
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -77,13 +77,12 @@ static void slc90e66_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
+	int a_speed		= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
 	const u8 speed		= drive->dma_mode;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_word(dev, 0x44, &reg44);
 	pci_read_config_word(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
-- 
2.31.1

