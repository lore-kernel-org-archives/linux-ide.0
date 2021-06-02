Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C3C47096
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F1A613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhFBKUy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhFBKUH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:20:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2ACC061354
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so1721102wrq.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtnD+zGZfyDjb47352gUiRgkQO/5qCyVYr5fUC47UEQ=;
        b=HlDzsjy3jGmMEPA1Cdi22KnzTcGlVq/CYnYWR/tA+FBDBUn8MQTrxkxf9fCrhb9EiY
         AP+DCRABV+UBwY2goSJqt0gomdcXSqhl/hLxokVr3BortHhumCHv7V2pt1VWxUzV/wQ2
         sIryHyzPAgDSW+3fLjBwyvu/jJaDrExZ7yTTw0jIy0kXCyS1R90d3nX9nVvmtw5tu9pH
         bE8xKyEEMbd9Y3Oi4fGtsy9Qfc7YSqRMGWSb0koyiriYFxqLAEwj/z0Y4LgrUfjj/u5R
         aiug7yL15FwpLx2lhNT3PkDP+jip8ZpZQWNQQKDuDaLQ7ccdu+fn3vt+7vt67JEPwev4
         sPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtnD+zGZfyDjb47352gUiRgkQO/5qCyVYr5fUC47UEQ=;
        b=uoMw7r6zi4dcrAvfdi7YPQ17OWefyELyU1o8mv0xDmaWp0mYllGRy1LAIQhcL8XZKK
         SjVjmrsS96x/Wyp4LSNDIRxv6C311iISrCfOwjFb6nxP0KsjyiyAkBDrlYdFPmurtsEE
         /EbtRdbhqV2jLMXIDT4zXinRdoyoDHB1SAq6WpDRVU0Ti1+1c6XODZaogRLEk1vid/kx
         UZHnEjukFmzF8BGwd70PxLXH+Bwq/U8h8o/9fgzLuyHnS3e1+vGxH4gmzLjNGMZODwzg
         ylxji1qz1Q3Urq+rG9I9HBVa+YsO+/SwS+syvJpeh35gQi0x41GJw9qEp2yPQo0HdWBF
         rirg==
X-Gm-Message-State: AOAM530L8UCuBpd/bTXur6t5k0Nf8c4xlsqLVltXk+1gC2GQPQcF95bx
        cMlUWEW+hN6afJnlEYy7C3CVSQ==
X-Google-Smtp-Source: ABdhPJxx4Lux9HjDIJYRif25LB8bbY+qG3ZeqQpM1q+K1vvbQ3pirOgL8N54fTtJkQHarwFy77UX7w==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr33512577wrr.248.1622629073919;
        Wed, 02 Jun 2021 03:17:53 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/21] ide: pmac: Staticise local function 'pmac_ide_probe'
Date:   Wed,  2 Jun 2021 11:17:22 +0100
Message-Id: <20210602101722.2276638-22-lee.jones@linaro.org>
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

 drivers/ide/pmac.c:1418:12: warning: no previous prototype for ‘pmac_ide_probe’ [-Wmissing-prototypes]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index ea0b064b5f56b..d51a2e252b6f2 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1415,7 +1415,7 @@ static struct pci_driver pmac_ide_pci_driver = {
 };
 MODULE_DEVICE_TABLE(pci, pmac_ide_pci_match);
 
-int __init pmac_ide_probe(void)
+static int __init pmac_ide_probe(void)
 {
 	int error;
 
-- 
2.31.1

