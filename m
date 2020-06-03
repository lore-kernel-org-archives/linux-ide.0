Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC2C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 23:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBE020734
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 23:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLpfxw/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFCXcf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgFCXc1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2020 19:32:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898BC008639
        for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2020 16:32:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1379545plt.5
        for <linux-ide@vger.kernel.org>; Wed, 03 Jun 2020 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AV3zPGZvUQ01fJNeRdN9RcESkWzhMr4mEDUODLN9pLA=;
        b=BLpfxw/6wXWpxKYLlCAZ21WRkm9IiS+h8QcGOpAouQszh1iMLWmw9T4KLc9TZj8hYc
         dx6tovtKtkGDVrQF1aoFfpozdX8eHpFDTKu0YVHCTw220bEnL7QHVusBdzlPQyI7mtxq
         CBiuNg7P/T3Joe2o1yRIOs+RMoUmvb0p/GaJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AV3zPGZvUQ01fJNeRdN9RcESkWzhMr4mEDUODLN9pLA=;
        b=bIndK56hbD72K1YJR6BRLNNTKDziPc+Rtx5fngLfg7oGvptucKsYtBlK7yuWam5lOU
         v9+8aLo9NcJlAa5AnvTRbxDe3RXQ6XD4Kbs9KL27iF6BxF9ygs4e7WxcHb6wcCJp2aTw
         S1Tme2erQKSi9h1k42evr6qVRLl4kbmMXVaI6h1pCxUH5/3iFYrqolMsrZheBtU0k65j
         vxHTVyFTB4oeeCgxu9cKOLpLX/nZ2lN+Yp6LGl10NkuRmGFEwSIkzj3jgVEW034+P/DC
         W3U8m9RS88OODTB2+LKG5E9MvLMslYlifdtC2nfmwOzn3QgGGlOxPq7n671ie9dnrohG
         WJ9Q==
X-Gm-Message-State: AOAM531LkOi/r5kmZzGOBl0WBejv5FX582CB9erA+RBw8Ie6/YOr1uXh
        4T6qbZp4ic06Dk2QbvB3Kx7plQ==
X-Google-Smtp-Source: ABdhPJwKQWXIp6h2GXr8CdJrjHWBz+VhwNoB6SucfRbGarsMlcrgSptDV/HFlzDMl3tG4M3PfRVvsQ==
X-Received: by 2002:a17:90a:36aa:: with SMTP id t39mr2389819pjb.185.1591227140733;
        Wed, 03 Jun 2020 16:32:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c123sm2738945pfb.102.2020.06.03.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 07/10] spi: davinci: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:32:00 -0700
Message-Id: <20200603233203.1695403-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just remove this variable since it was
actually unused:

drivers/spi/spi-davinci.c: In function ‘davinci_spi_bufs’:
drivers/spi/spi-davinci.c:579:11: warning: unused variable ‘rx_buf_count’ [-Wunused-variable]
  579 |  unsigned rx_buf_count;
      |           ^~~~~~~~~~~~

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/spi/spi-davinci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f71c497393a6..f50c0c79cbdf 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -576,7 +576,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	u32 errors = 0;
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
-	unsigned uninitialized_var(rx_buf_count);
 
 	dspi = spi_master_get_devdata(spi->master);
 	pdata = &dspi->pdata;
-- 
2.25.1

