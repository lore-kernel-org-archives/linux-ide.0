Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E7C433E0
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190A461981
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTDlP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 23:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCTDkk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 23:40:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6FC061761
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r17so4977808pgi.0
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miJiQ4iKYG8UwvADzlTSpMJaTYGcIVqdAwKgXjUDpzE=;
        b=RwtOvO5xaIOoHQVcxinJmMu5Xvsi7T4JUNQDluZkNaZkhVEx2gVHcwEL1dq0JnYu6U
         Xl03Huypv2mkFeWoBBRUddJdOGcSshpnzuZbCRSuckBYGoHbiD7Q/ztpD7qL8MCxOs3P
         0i951uTdDjOMqm3aQDPrt1qTOppfgin3hhEXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miJiQ4iKYG8UwvADzlTSpMJaTYGcIVqdAwKgXjUDpzE=;
        b=lTDj1D5yyXAkZZ0pOIJWkQgFDmAFEALTaHSiNzFSESZCJhuWerdMjIk5KW+VhvOxrE
         wAUO6mvvWQuDyww1IluTCTYWeaxOjuMH5bFGiyZ3RCxRhzybYt6fo4iXF7MXEKVG6bUj
         Mu6WSfyc3b46YAqcUWCd1/SM9KI8Ye0GHkWgjAoXWJ9/kpdXOfvl46zSC23Tsi/gQJoh
         jBmd4blfcSKTc0cehjIxjaK4XXsNwdW54KuO5jxtoIT0p80qQCMS8m6R+S+HQsaaFJ3+
         JgATUJIfFV6TES+H+rMYUgR1yHgcXTFP0Bd0v2Gz+y65PrbOI0Gqr9M8G+MO1EcpEqgY
         BGFw==
X-Gm-Message-State: AOAM530G+yZrdXcxRkBNL4iB/5Lew6QYbx0Cn6o9Eq0bL+7tmM4izYZs
        OY+0HSqimklt1sLtYctM6lzwZQ==
X-Google-Smtp-Source: ABdhPJzP7OoUD8JtPT5gWX7JZXcXrWR23KXKW0o2A1eFXmxyhRQsNimqZsvri/hExa1PgLs6GiXBYA==
X-Received: by 2002:a63:df10:: with SMTP id u16mr14147186pgg.308.1616211639942;
        Fri, 19 Mar 2021 20:40:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3471:4d7:22d:5963])
        by smtp.gmail.com with UTF8SMTPSA id w79sm6941613pfc.87.2021.03.19.20.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 20:40:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, linux-ide@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] driver: ahci: Allow disabling dlpm for all bios version
Date:   Fri, 19 Mar 2021 20:40:32 -0700
Message-Id: <20210320034033.396854-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210320034033.396854-1-gwendal@chromium.org>
References: <20210320034033.396854-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In ahci_broken_lpm(), dmi->driver_data is encoded as a date: if the
date of the current BIOS is older than driver_data, the LPM horkage is
not applied.
Allow dmi->driver_data is be empty in case a problem is not fixed in any
BIOS version.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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

