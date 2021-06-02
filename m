Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE4C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF9B613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFBKTt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhFBKTc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12651C061346
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m18so938744wmq.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9iIf6zIMattTW/alV/9VT7gtBfDmu2Z2RdNdHc+834=;
        b=ONIgXmYJd1qjLKOTGHrbCG3Urp/fw+Op4avACr5zJQCxd60DT/K8uer8Y20+742e+6
         9KJZb5lnFhuN1eE6sb/NimLHBWLg6L/fypednUQq8Ir4LWI9lSQzcpgexTJDG0HMA9C3
         yRopcrYziW+Eai2VyR2J/YVyO7p0x0f2wtIgzmlZN83cdQ9p9iK1iaiaCnVukMFP81EE
         ouF0nr9yBSitL0XvK4lxHxuYgRtFiG2aSUSIGf8AgBigEUvNqX6kup6JIvUZKMBC39r1
         VmdqgUWFstZsj0rJnJLA9LtLRKiBH7vDLUZDR6XkFVEEGRzzvmw4qYrrUsMobvvSlL9L
         ROgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9iIf6zIMattTW/alV/9VT7gtBfDmu2Z2RdNdHc+834=;
        b=aIg4KCzis9Hc9nVu15PI7c0fla5Sm0eaZDeJNlqsdqGwNAzpbEE2Z6Sx8pUWZ6mucU
         2985rTjSfoPODHu/xS7QThQmWCg8SDw/M29TK2LGYQwCNrX6UnnSTIGcEc6N7+vuVH+Y
         XmDB8rIRs9L0IgTh7iN47iIX+A8UYUojeTmMM6EDbGs6CBUAjIHypB7+oYXgDa6iJp3r
         tPsRuczRhyifENwZYAjjWDTAoDh6fa3t4gUX89DjpgMc7NBHc42xiIT6JYK7Xnh+I5Yg
         mObnAw7lfWpDF9ily75ymXaQ6YlDmxv+4zOyODaiQiyG0UfGL8WVO74ZzY4lW1lwbxjw
         8sGg==
X-Gm-Message-State: AOAM531vHSsQJtcJV/ZZgg286/gq8kScTaehVDmqVmF+TMuXXckQ3EJh
        zud18YmrEbmkAmwcCVtiLc9qWA==
X-Google-Smtp-Source: ABdhPJwRdQ1H5GkOhiTpyCUEjoVrQCMIlPxMLgxh17oU9dl1M2Cdmlw57RsVhL8ZO/wJ3//pVi98jA==
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr4328451wmh.20.1622629063711;
        Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        Frank Tiernan <frankt@promise.com>, linux-ide@vger.kernel.org
Subject: [PATCH 10/21] ide: pdc202xx_new: Supply missing description for 'set_indexed_reg()'s 'value' param
Date:   Wed,  2 Jun 2021 11:17:11 +0100
Message-Id: <20210602101722.2276638-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/pdc202xx_new.c:84: warning: Function parameter or member 'value' not described in 'set_indexed_reg'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Frank Tiernan <frankt@promise.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/pdc202xx_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 7c276b8aeb5fe..537521213e148 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -79,6 +79,7 @@ static u8 get_indexed_reg(ide_hwif_t *hwif, u8 index)
  * set_indexed_reg - Set indexed register
  * @hwif: for the port address
  * @index: index of the indexed register
+ * @value: value of the indexed register
  */
 static void set_indexed_reg(ide_hwif_t *hwif, u8 index, u8 value)
 {
-- 
2.31.1

