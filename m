Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEEDC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FC861246
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFBFXA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhFBFW7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 01:22:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AE4C061574;
        Tue,  1 Jun 2021 22:21:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so2765060pjz.3;
        Tue, 01 Jun 2021 22:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUCJlsJL4a/VL2RuWbxe8Ls7Xky37SrPL6mNt47ZKis=;
        b=qGb56MXpy9BfusVX/JFTOchHIWDFkj/Q560Eo1Q8sYBkj4Q9yNsNEJ9DLeZKRzdEHe
         EGRtRxc+bLcQh1TpyMBK6Ylt8ytsx1NY80AMUjrc28506gC+ItZPS1Mje8pwDvPNTHZh
         7p0h5HHLVX8F0Qn7ai6bEDZllH03dO+X2YsYpfTAyR5Jxhrk59ZMfaBW8glKg5A+/aTF
         e7HT1mpXVgHbgiXMvsp1GHnJtK8CDMRco/S819jgFivLSIL7yRE8z1yAzFPWS7ojcTNN
         61Aop1j1MO3WvXFnb76aRGlheGZZl+cH2rdGSUKyrM4D6UYjPdGS+AJY8N79V5A+L9HP
         XoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUCJlsJL4a/VL2RuWbxe8Ls7Xky37SrPL6mNt47ZKis=;
        b=dLL5zWIg2pQiY7xJCdA5fRONaG/4vvxXREVY72CUvTDPKAOp8MAK/cYb2fwTMGtcxB
         bSv0vL0wlSxqExMarnOFXvUYI34eaPxxSzZnLZ4vtzgf1tZHC8mqr+jRuic4Tz8Z8zFW
         NIg5cDO0k+Vomsk5jGh9ZDQKcaSx/NiUN8gt15xM102wSLdjyUAp6JjfHRMSj4JsSJvy
         NUIxT3Q75XlrqxRQW8QJ9bNru1u96NIRoAD12NRJ58C7XG1u5gFhPLrmyj0DvJnOtxAY
         ot3+kp4mAmawuF8QWyiLuqasXD77LFju+T/ck7YDz2+Scu4xboi7c2Xw6UhOw3t7GgH+
         yfGg==
X-Gm-Message-State: AOAM5320vwdsK8ltpumapUK+DQz0bIh7mAV4vhHteyJ5PhyIEf7YVLE4
        1H1kme4sAcgTQgjJt+EVUgzlYVC0g8U=
X-Google-Smtp-Source: ABdhPJzLwYjuekELf6hpHywdYvKL98clWE/G1xDtw0n1mkDw3YI8mr0xgVnbg4KNktdojkdv+ngf3w==
X-Received: by 2002:a17:902:db01:b029:f6:4a13:1764 with SMTP id m1-20020a170902db01b02900f64a131764mr29568441plx.25.1622611275803;
        Tue, 01 Jun 2021 22:21:15 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id u12sm14460879pfm.2.2021.06.01.22.21.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 22:21:15 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B17D8360411; Wed,  2 Jun 2021 17:21:11 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 2/2] m68k: setup_mm.c: set isa_sex for Atari if ATARI_ROM_ISA not used
Date:   Wed,  2 Jun 2021 17:21:07 +1200
Message-Id: <1622611267-15825-3-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For multiplatform kernels where CONFIG_ATARI_ROM_ISA is not set,
at least isa_sex must be set correctly to allow for correct I/O
primitive selection in shared drivers.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/setup_mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 017bac3..bb43b99 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -386,6 +386,10 @@ void __init setup_arch(char **cmdline_p)
 		isa_type = ISA_TYPE_ENEC;
 		isa_sex = 0;
 	}
+#else
+	if (MACH_IS_ATARI) {
+		isa_sex = 0;
+	}
 #endif
 #endif
 }
-- 
2.7.4

