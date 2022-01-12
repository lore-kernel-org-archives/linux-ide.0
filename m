Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF6C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 12 Jan 2022 23:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiALXro (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Jan 2022 18:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiALXro (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2022 18:47:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D7C06173F;
        Wed, 12 Jan 2022 15:47:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so2596352wmf.3;
        Wed, 12 Jan 2022 15:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJ+t5KPBHmObAXEucp1lDxWIckLxKNo3ipApmjpHFS8=;
        b=FoHKvy8jOXROJPA/BKAAFbGezF6+Ysz69F/HtVV1vyaKKwc5zkG9kPCbIkdTIiSqC3
         InQwrQ/ZuIBngh+RJCnw9SL3dcWgv3QfezIYVF45/N1Zl98/LSbrxrm2/uyR2/ESz+lY
         F22HBnCGfyh+zAFU5ZqzxpfluKvjhxTavKvyaUVU1EvkYMA2s8bXlXMcuu3R3lYfmA90
         J+wSBlWEVzoSscSzjbQe6vAfAtXqTE8yEk4LEgZIOhGw7z8gN/9M0wDzk7upFInCgdKm
         +FiAr75dq+PvaWo0pTxSpy0KM/eTlv/WrZMwtxiTySuKkduqXyVUpme9qs6YpSJSSrNf
         AvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJ+t5KPBHmObAXEucp1lDxWIckLxKNo3ipApmjpHFS8=;
        b=wqd+XIPKZmLtzQBfijkKL7B+uhJ+jAME50fsH1zVe/f2/LvKVktFByv7xyNV+WmF1h
         rSAOjNtml3W3fwWC2bO1qkeWnS37grIraFbGyFGq1ubST8tskLpyDki3uV68cialCoha
         buJqhafxQnchRhjhb7GdngcDSoClFVBLJZHKREykXi1vMSsuaW0b96EsgM3s9oBqJX2h
         06dhLhRyjvDdZKq6AMmEESMJs7DyEwHxF7rOwWPCeb/9qxrOsdyKnLAp9hj7Z2Q5LRKx
         M2L81h/z7jFuyWhi1hOu4nS57f7ypKcQ4PTn5fXpJ5Aoj1IYuqDMvy7eyqyd0WOjnoBx
         QLig==
X-Gm-Message-State: AOAM533Od9M/lG8lGRalbEnMhrIFq+1rsz8VLgRPEOb2pNa7l9Pd+p4D
        xQimioNJzAoJ3BQZG8g7q8dP26RTuGISfg==
X-Google-Smtp-Source: ABdhPJyeOMPQZMVd+rSnSZLcDVDIAEXJEqv6bt22UWvapDnuA+0wOSfrEODnidchAY4Z60MZbcRdzA==
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr1533052wmp.14.1642031262336;
        Wed, 12 Jan 2022 15:47:42 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u3sm1321186wrs.0.2022.01.12.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:47:41 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_ali: remove redundant return statement
Date:   Wed, 12 Jan 2022 23:47:41 +0000
Message-Id: <20220112234741.1232858-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

A return statement is unnecessarily complicated, currently value
in variable mask is bitwise-masked and the variable is being
updated and then returned. Just updating the mask is all that is
required as the following statement is a return.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index ab28a6707b94..1b90cda27246 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -123,7 +123,7 @@ static unsigned long ali_20_filter(struct ata_device *adev, unsigned long mask)
 		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	if (strstr(model_num, "WDC"))
-		return mask &= ~ATA_MASK_UDMA;
+		mask &= ~ATA_MASK_UDMA;
 	return mask;
 }
 
-- 
2.33.1

