Return-Path: <SRS0=R/8C=W2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE9C3A5A3
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803902070B
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QrSrtGf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH3HRz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:17:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35934 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfH3HRz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Aug 2019 03:17:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so5876175wrd.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2019 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2VDCi/8Nc6XhM54Nc0WK1H6m9eTFCgJrShafTKplS8=;
        b=QrSrtGf9FjbrWkItYR3Mc4CqOLVCYT1FVWbRgCBg2Pu/Fdf7C/4W6eYHgzOrrBrWbq
         JHcZW2ZIjjrgIMQnvF7oziVkdb5dPpo+6eWCQ5nhUyt1Z9tP+vFcNiObTEgtx/nnWCJl
         7iD8LMqU3plCtQh2fTh2ZZFznTJef7MGmH//2p0s3OE4tADTPh08wkNf1xINmnxfzwhs
         ECTsBbUZW40ejM+T1jUx+/elyxT9b9iZnRpX3tYsx10etXTY/QLw2SW002oG3aNRq7F+
         YvYG/vUCfOfN5mPEFl9doHPOtPUb8oeaEAJp0Q32nCKYuWSi+4Vl9qItEHDWCe18BsIe
         Ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2VDCi/8Nc6XhM54Nc0WK1H6m9eTFCgJrShafTKplS8=;
        b=JMTrT7tcgFAgy6xrBQPA4oeuNZjm2g1dRTl2X7F1uktJrnPMgm8xC2bfPsuu/iipt9
         Xe3AWlGlFYasr6hnW7NChGovMz3QwC2xQR1r61o3GjuugIIOxM9VHnTA4FMe/Q2zNKgp
         HXcxSdiezS652BXzAAuHAwVr8Si2p2gIowl3tbsrRkh+f3v9VwO+Gzdh/q3DYWVLZ5x0
         I2ad9K5Db55pwTz10y6fGATg8pzMwWdN+kmuIfT7VUMm0Yl6oDAoWMPk4bXLRuFUGemk
         N6pcgf9Edan33ObVIn9gpLNpIzCnclilh+Ytq7tR0jYpme5gYG/aayfzAZvrcm+cn9YV
         8wUA==
X-Gm-Message-State: APjAAAWumCT4uA/K5agzfpDp0ahsWUqNHtwUbCE2t9lHfCudvmVmt/Mc
        Ue8UOo6GaWxutoSvlyD4iQ9Kmg==
X-Google-Smtp-Source: APXvYqxQ+fhzAN12dqj8HcI+oZPcaqT6YamoO9mQejjXIJ1ON3y2eTjRph0jPHsEoE+jZMTi9k9wbg==
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr16642888wro.31.1567149473261;
        Fri, 30 Aug 2019 00:17:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x6sm7637529wrt.63.2019.08.30.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:17:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/4] phy: tegra: use regulator_bulk_set_supply_names()
Date:   Fri, 30 Aug 2019 09:17:39 +0200
Message-Id: <20190830071740.4267-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830071740.4267-1-brgl@bgdev.pl>
References: <20190830071740.4267-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new regulator helper instead of a for loop.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/phy/tegra/xusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 2ea8497af82a..faf1137d1432 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -862,7 +862,6 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl;
 	const struct of_device_id *match;
 	struct resource *res;
-	unsigned int i;
 	int err;
 
 	/* for backwards compatibility with old device trees */
@@ -907,8 +906,9 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	for (i = 0; i < padctl->soc->num_supplies; i++)
-		padctl->supplies[i].supply = padctl->soc->supply_names[i];
+	regulator_bulk_set_supply_names(padctl->supplies,
+					padctl->soc->supply_names,
+					padctl->soc->num_supplies);
 
 	err = devm_regulator_bulk_get(&pdev->dev, padctl->soc->num_supplies,
 				      padctl->supplies);
-- 
2.21.0

