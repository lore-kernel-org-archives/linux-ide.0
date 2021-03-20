Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64973C433E1
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E80E61955
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTDlP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 23:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCTDki (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 23:40:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA5C061761
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r17so4977795pgi.0
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yPHmQYbRCahwR6DbdyU3HJljYpvQUvukibGq5GbUMU=;
        b=CvNF9ToXNONeNu05W7GtDZvpVN8zzHat+1OcACbF8wzvixIeZ6JGpypv/TF15vGviK
         JXUg68pvYoYpdK7IpAQOH/eY0b2rzSRI3o9p1ut7OGuqqMtFe4nCu2nIuIbvOeEvjhao
         CUkDsM7hQQ8AQOjiq2ouRXb/hfkASmXRkf+x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yPHmQYbRCahwR6DbdyU3HJljYpvQUvukibGq5GbUMU=;
        b=bn0RA3O8WoLYNfEq123t6VrmVPIn+IGxD6H5TKgSeCeGMFOlGBPFMma+ryjX3J758M
         njClBAK0PJ+5HNCL+BA3qgRM/m08Nl5/H3ZYowAVvQAfsQSC+55inQiG3WLteDnX8jvh
         WuAQvlY//j58uMtukRiq3XLFazM799yYabevBiiCX353fm43Yx63MCNonkJ7TCz46GzU
         jRX4msyN21l1je78mSe24zyY4eURuDzS7Tp8Ola2o6hVB3D6DkaZt543PRPjM7G3QT8L
         J7BQ+GUfBJewyl/TAUPouOqUgkTlIQtk7y86rA2vDK5lEnh6gAQH+jCYFkaLYevsbPq8
         NWZg==
X-Gm-Message-State: AOAM533BeiruzG/PDRYfsXwmQN7e4AqZz5BwsGcWuz7DP50ovNf0CcOP
        8GbHkbHDUgdlPHrpencs61Hppw==
X-Google-Smtp-Source: ABdhPJy8QnHbG8ssY10j3jlqpFWPRMeeyaPDflmiCv3ClShkBm9npKHi+cTuMGHDs608UG9osVerkw==
X-Received: by 2002:aa7:8702:0:b029:200:50a8:2354 with SMTP id b2-20020aa787020000b029020050a82354mr12269261pfo.72.1616211638267;
        Fri, 19 Mar 2021 20:40:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3471:4d7:22d:5963])
        by smtp.gmail.com with UTF8SMTPSA id b24sm6178830pgj.58.2021.03.19.20.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 20:40:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, linux-ide@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] Disable SATA DPLM on Fizz chromebox
Date:   Fri, 19 Mar 2021 20:40:31 -0700
Message-Id: <20210320034033.396854-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On some chromebox, the CPU will hard freeze when the root SATA SSD link
goes in minimal power powermode.
Chromeboxes affected are of type Fizz, using Kabylake CPU.
Using existing ahci_broken_lpm() function to set ATA_FLAG_NO_LPM for the
controller which enables horkage ATA_HORKAGE_NOLPM for the SSD.
Once set, it is guaranteed DLPM (Data Link Power Manegement) SATA feature is
not enabled and DLPM can not be set to minimal power from user space.

The first patch allows disabling DLPM for all version of BIOSes,
the second disable DLPM for Fizz.

Gwendal Grignou (2):
  driver: ahci: Allow disabling dlpm for all bios version
  driver: ahci: Disable DLPM on Fizz chromebox

 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.31.0.291.g576ba9dcdaf-goog

