Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568ADC433DB
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F426196C
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVIJN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVIIo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2021 04:08:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B06C061756
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 32so1973744pgm.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kh/xmFXhfHtNnqJEg2fD821X69nj58fO7kUzZqMc42Y=;
        b=mlisv27tJfvboLmPEj1JWnpGIbJugxo3Agmmvfkxi+/5ARKINWIPHc7dt+WSC8nX9d
         oejV3PK5oTscj446aBJVgdKZsbBdx+WlGyV2jX12cYuRR2iKTMTL8px2tVYo1ryofRGc
         /r6BgJNiCswdx+n67KUDicklcE8OP8URigWeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kh/xmFXhfHtNnqJEg2fD821X69nj58fO7kUzZqMc42Y=;
        b=WXJSl7GDpMw99idHPkrEC3N6HjjPlHbiglfxk5xt8Df0hl+9FjYGXeBC0pzY03su6b
         FaUt+OzQnFLIVRmJIgIvw6q02XDGxh2zjVVKjOpSl7ZdkjM0wBlMvnL4l21GtZbROscq
         nNyNog2hIxjClHSzP7FCTe/pRhZlSTbSn8O3W6wx4usWbEFqFYBAAWU3rcFxBQbqQo/l
         2R57J5dsPb2FMqm9xwhIsbqAIXc3RUp9tcedDYW8IqionJ6WLTsbz+Yyd7E501YDA1HR
         6n1JlMFfI7ckX4EnWExlGLhS/VIvt2yVzqepy5KH9hNo7zUXD/wegSGiAAe0PRaW5KDW
         YknA==
X-Gm-Message-State: AOAM531zSycfY0Fsm3EyK1509BK2bweRN5TmUExKk6EworAVWG9jXtSt
        aSrYECX3xy/1lILsHrSoqM98Ou4/cgrbkw==
X-Google-Smtp-Source: ABdhPJxrjGOntJAWM/d1E6/2YCUkeyR+w5dUrpLdC/fp1IQLZ3qUhJ/N0nqxJxT+5UxdP592h6HZMA==
X-Received: by 2002:a63:df09:: with SMTP id u9mr21704387pgg.64.1616400523274;
        Mon, 22 Mar 2021 01:08:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id gm10sm12691994pjb.4.2021.03.22.01.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:08:42 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/2] driver: ahci: Allow disabling dlpm for all bios version
Date:   Mon, 22 Mar 2021 01:08:37 -0700
Message-Id: <20210322080838.1640805-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210322080838.1640805-1-gwendal@chromium.org>
References: <20210322080838.1640805-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In ahci_broken_lpm(), dmi->driver_data is encoded as a date: if the
date of the current BIOS is older than driver_data, the LPM horkage is
not applied.
Allow dmi->driver_data to be empty in case a problem is not fixed in any
BIOS version.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Changes in v2:
 Fix cut and paste error in commit message.

 drivers/ata/ahci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5f1f049063dd2..9132201f1353e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1279,6 +1279,9 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 	if (!dmi)
 		return false;
 
+	if (!dmi->driver_data)
+		return true;
+
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
-- 
2.31.0.291.g576ba9dcdaf-goog

