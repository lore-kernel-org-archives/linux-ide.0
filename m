Return-Path: <SRS0=+WCl=X2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7351CECE587
	for <linux-ide@archiver.kernel.org>; Tue,  1 Oct 2019 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D2205F4
	for <linux-ide@archiver.kernel.org>; Tue,  1 Oct 2019 13:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Qq2uF8Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfJANXs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:23:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36274 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfJANXr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Oct 2019 09:23:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so15526435wrd.3
        for <linux-ide@vger.kernel.org>; Tue, 01 Oct 2019 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UXwphbefxoaNIa3BWF+ZDcJIqlBkv2JNP3hYy5Lkdg=;
        b=Qq2uF8Z4L27uDSCEXrRA+mqw/EEYd7dJPlm3iWU9fq7yyhv2OXMdvhnqAeWCSfsyMl
         2H6I6pT6rRwrA9Qf4jNQduD6NJ6UI1eDWRsgxB0V0buAUaIsX87eFjaLgT1Eaf+62Jx4
         HgzBlQ9OnWgK37zKc7e9Ca5v3261eNGhHWdZap5De244frCEJkBY/ORUuGmdcubJBZ3R
         ohxVyEI+XnfdXiAACAnXCpFB5JDu77LF3PgzPMT/ZnAaKYLNay/eSrEQJ6qC9bCBphcJ
         BpER6vm+n6G2/0TSUg/h41avtO+8jBEg9cVPqG3plSmJW+qUHUn5KfBrZqBOdPFueBDQ
         0zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UXwphbefxoaNIa3BWF+ZDcJIqlBkv2JNP3hYy5Lkdg=;
        b=EAZCoEvsYui7gumH2Ap/IhNMhjD6m3X9cPyV3uWCE4f5M5xAC0L4ohVjSnRTOaPs6H
         HIVuPhuaYEHIfIMI9wAJ0Zsz+clVwUThJzYxeKsqBGnM9UsITLYa0PnNprBVTEHwpqtR
         Hui9F6vs6pDoZHA430KdnFRcIyVdmiqfEjDw5vGtqOvfJy99LVyz+/WI1K4FIOqPEhAA
         TjfGRgXtairwLHd6eBi6JhToncAo85t89+QcxUftx36fg7zo8mDuwLgeqEL17oBAijfv
         IH26F6KkevjCEtQwxO/XQoE+ZxMO8e2wAKf5XYBOgSKU3HhHpviuFKMXbt5hdZTEwOXq
         KDkA==
X-Gm-Message-State: APjAAAUmWOfibQmzoz/kjrF8lRIRQ5O0pH2bcoAaegDKelcq9HeVsFpL
        Pyawr12zTbMjYRVmN3HUkODFug==
X-Google-Smtp-Source: APXvYqwPIVOEtxMwDTuDgBXmP6KdpZSgvSoDSeHMC6aZMZXAjqNPoKCPrhHyDyfQ+hRhwa9Y0StEiA==
X-Received: by 2002:adf:f801:: with SMTP id s1mr2138136wrp.293.1569936226128;
        Tue, 01 Oct 2019 06:23:46 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o22sm41847990wra.96.2019.10.01.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:23:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] phy: tegra: use regulator_bulk_set_supply_names()
Date:   Tue,  1 Oct 2019 15:23:32 +0200
Message-Id: <20191001132333.20146-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001132333.20146-1-brgl@bgdev.pl>
References: <20191001132333.20146-1-brgl@bgdev.pl>
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
2.23.0

