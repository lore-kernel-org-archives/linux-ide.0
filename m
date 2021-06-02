Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB42C47093
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEF3613D3
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhFBKTl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhFBKTa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D46C06138E
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1016009wmc.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbCVMb/2RduaP3NxcfVvRqjH6K2Y3C6V43YOwvPOwMo=;
        b=O6EsFgNyHAS9vEi2z8XPy1Ca5thrAad0/1nVqP+6uFgFy5KxXKPtDVxNlK8o4T/TcN
         IrnFqTsPyUeJxlF8Ocssr7y+i4Xk2qgguOHOc0mV1lpXCkjg1ZaaGIjF2ceK/01C9aWw
         KcxCy3hPDLhhA2Vtc7TNFFqINEpwh1240cRlGSeLAAnW+89TJXZD/RwlEULLcfN649kg
         bZX6gOXReyW4n/2zEpJAABq4PxuaVmDIGC32jLoYW2B2D2gD5mxzmpJKBG/J7txPAkAb
         jmbUMueShG3M/QmKjdEhl+Zh7CTksIpUaPvHnrVq+nV3GgzHHF/eLVrRofsQsx1SWR0W
         DgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbCVMb/2RduaP3NxcfVvRqjH6K2Y3C6V43YOwvPOwMo=;
        b=FpPRdXPyPNoJ2lcVvg1YTkeSTXMNJs9Ypqli6OFeacEpZvkaQB37TS2joeaaR91g5m
         1Sqnx/HjZk+zOLntyaKD+vlGXiD/VRPWx0MKxlqogGhCu2xLIz6mSQaXWcRSoUiqJFeR
         O2jMoTpl4gXvX0sSMJnhebP+cSL4SNKAGxbcdHp13/VrZhOl7k+1jaEenpmeP/arSRrr
         H8UrFbRMAKp67mffvoZ+rKKf+o4D6+hk8jBJ5/1FxR2OxuAP1iLZuuWnr5Mamn1gy86p
         8j4YWHAFWlqqeMNKo2uDt8/4uoQkdWGshGUSo4FlakzLoeldam8IzF/vwdUzCxrAq/Ft
         KgVA==
X-Gm-Message-State: AOAM530w4jsiam6YIEBk3T5TlnvEW+xATtGkjBOU0bbil0KAPjG1O7Zv
        +kRCyrgNSlNmLkxyjZjsOP17qg==
X-Google-Smtp-Source: ABdhPJxx5ArY9ys2+XV4uFcG+agvW9o6SVbd6qQk6h8GpabBTzeaHEUe67VMmppIwU1BTokwk2RGLg==
X-Received: by 2002:a05:600c:2250:: with SMTP id a16mr4457914wmm.189.1622629060508;
        Wed, 02 Jun 2021 03:17:40 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Lord <mlord@pobox.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Andre Hedrick <andre@linux-ide.org>,
        support to <linux-ide@vger.kernel.org>
Subject: [PATCH 07/21] ide: ide-probe: Fix-up incorrectly documented function probe_for_drive()
Date:   Wed,  2 Jun 2021 11:17:08 +0100
Message-Id: <20210602101722.2276638-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-probe.c:476: warning: expecting prototype for probe_for_drives(). Prototype was for probe_for_drive() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Mark Lord <mlord@pobox.com>
Cc: Gadi Oxman <gadio@netvision.net.il>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: support to <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index aefd74c0d8628..c1fde697657d7 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -461,7 +461,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
 }
 
 /**
- *	probe_for_drives	-	upper level drive probe
+ *	probe_for_drive	-	upper level drive probe
  *	@drive: drive to probe for
  *
  *	probe_for_drive() tests for existence of a given drive using do_probe()
-- 
2.31.1

