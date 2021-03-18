Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68988C43603
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FDE64F18
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCRIwS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhCRIwD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B47C06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so4602640wrc.3
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5wivGTr87AFeSVjq+RPxAGgUPqftM9xBrGW+nIjIr0=;
        b=n6g2xoisS0ymTmWPWtvMfF3pktpNrRfc38MouzDXCl2G9wZiRyN1IJDDU0DrjekF0f
         G6GW9SmWZmmnoBQvbNepQYyYcSCHHGzUAYyvZMoV+ZCkn3JmPYfu78sXT9V/9RgyJysU
         peE/74Rml5/Me/rthJLUdzQALRajCSfLvmYbHPx2/WTIWIJcWv3nfCM+jKTeAIPKo5je
         LVvrFLkcdxQdiZG3XNhChfZMIVlqo2KyOAEeOTguUbezO6Pq3LWjYpMTM8fvpdn+q2pU
         rRISqXuHy+MgDpbwz2LNQ63udW8Wewm/TO/uZyJqCeCUNzKER6TGJsbtHu+4FqBH0+Cr
         0d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5wivGTr87AFeSVjq+RPxAGgUPqftM9xBrGW+nIjIr0=;
        b=h/IrhzefGUZuQx6kZqIAld5ojG7BNCyvyYiM4mvYyTYNYY2oXq3L8diNh5vHNkzHMs
         TDTc33rnsga8aKo7p+xrQdGmn1n4vu0sXpsRTpmUuC95jAntY/zcjrzrFpaoFadmhGzu
         P++pfOR01U6o9gNc6qGGUKKs7r99RAevQF57HiD+UrnyStUinV+65KF76vG1mIRtK3Z7
         84BUHKhFqSCsuqs7+Cp5q1ZE7gR53cqaX//tcnbICzAMWzvGBWAYYUmXAi+yqc5NtiWJ
         tEf4S81nDBvvhytgUm0563Uhzf5KoVjfiRjGDTkeUcNk8qTCbnMt8jOIt2O08j323a7V
         aBzw==
X-Gm-Message-State: AOAM532dBbbZjzx/0pgcISed/iHDUkF6TO4OdGo6QbbNrAfRM//lcgJG
        kBjj4MQzJmwhZRy8JDDrDJuLXA==
X-Google-Smtp-Source: ABdhPJw2Na7Ak0qwm6kHBbG3Of6Eg8McOWqQOjJsj4cpF+pgsUQWGQ4wyl9sDf8tJEBgBkCkLW+Riw==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr8629682wrr.161.1616057521488;
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Hat Inc <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 10/15] ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
Date:   Thu, 18 Mar 2021 08:51:45 +0000
Message-Id: <20210318085150.3131936-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/ata_generic.c:164: warning: expecting prototype for ata_generic_init(). Prototype was for ata_generic_init_one() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Hat Inc <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ata_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9ff545ce8da3e..20a32e4d501d3 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -151,7 +151,7 @@ static int is_intel_ider(struct pci_dev *dev)
 }
 
 /**
- *	ata_generic_init		-	attach generic IDE
+ *	ata_generic_init_one		-	attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
  *
-- 
2.27.0

