Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF6C433C1
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D051561967
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVIJN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhCVIIm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2021 04:08:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B118C061574
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u19so8105058pgh.10
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yPHmQYbRCahwR6DbdyU3HJljYpvQUvukibGq5GbUMU=;
        b=fHNVbXVtMD6opk+9naGx8ocJLgwojxK1Z3o8STbxR7m1n+SDN+nFBsoBGAWOk+YAUB
         AsRQAgehRLiLkJmLEcsAKhX5BeRMShR/OoHwA3HSAuUuxlggUCJSdon5X6DDfKiBv3bo
         ZPTs/hcrT0BX3xSkOegywjvuYsWUQWuTsHgFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6yPHmQYbRCahwR6DbdyU3HJljYpvQUvukibGq5GbUMU=;
        b=XGHlphpgXrO+YXavZLolXtXhOYacZf6ASdwOl6ToxZG+lWlbh5OSwfJ+mZIsTVpFU5
         ZBF/+J+P8SCRSQagFA/Ip5YhE2RXn2bsRzLvszNwxPKuL8AFW4UcmrROO0Hfhmiopz2O
         wF6PLttpyRsiL9t6Xwd2q7/WHrx/ZZjOOguE3M0bro9Jj8TDkMkzTkEh30cT7pskSMti
         5N8AtuzgN9acRZFsGwUGiNiivSp4t+l766ij6IhQJcJNTdUSyoRJUNVteG3OXmF3HpVm
         ZuyMqdpN5V8RuiCOva+m8uXigSCZTFzU10w+e/ahSBDEJxK4009FmjF8AYm17jzjIFWr
         8Ajg==
X-Gm-Message-State: AOAM530e36h8waJdSwt4+pnpOKOMl62ShvrBHTdkqgHlNDWM5WGrlLep
        9ionvkqqxzwv5YCuwPVyftXjvA==
X-Google-Smtp-Source: ABdhPJw4YwD1WwjDrusYTCEngQ4tINoofb2heNgU5IAyhgl3VozLNoHAN4GUCGIX3NtJQUFwqbRsHg==
X-Received: by 2002:a63:c901:: with SMTP id o1mr22242531pgg.232.1616400521879;
        Mon, 22 Mar 2021 01:08:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id q14sm13126714pff.94.2021.03.22.01.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:08:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/2] Disable SATA DPLM on Fizz chromebox
Date:   Mon, 22 Mar 2021 01:08:36 -0700
Message-Id: <20210322080838.1640805-1-gwendal@chromium.org>
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

