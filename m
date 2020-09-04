Return-Path: <SRS0=qdst=CN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C2C2BB84
	for <linux-ide@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169E120770
	for <linux-ide@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KqciaOou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgIDP0X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgIDP0Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Sep 2020 11:26:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE584C061244
        for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2020 08:26:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so4507745pgl.3
        for <linux-ide@vger.kernel.org>; Fri, 04 Sep 2020 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5282YCIbjYXuoDELr0tgCw3lmbT1e3lQtz3uBh49A5w=;
        b=KqciaOouN3G0T0BpZ+nf3ctA74+2AtRh6tEhtU9HzF5zny++REty5f+5upK7wBTdT0
         ZSD1SVZWQRZRcM/2VKoRlJEA5LO8fEpumqdT7HRfaWci2v8omzhLuF4oEKWy8QmNqH0r
         iPE7seIHejvz+6TspV1qVue7CafhahPjlFPiVLzX6Wtn/smZZlQ/apex3bFHk5HZ23rE
         KeynWoZJf++xordcvhc1Nab8GR6aO2Wu3rQgs/Sj9n9aMrnnKyu6xxryFYgS66oRvl6h
         B1N5+V0mjXaWnnJz1F7iDCqhQwMBIYaNRHZSbiM3cv8UFkl1qSagq5pXLYUwm0+CTrXq
         T0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5282YCIbjYXuoDELr0tgCw3lmbT1e3lQtz3uBh49A5w=;
        b=sZqCgxEm/LlgyLVP77BPBRwZSdnBUR+rGADP+K8nfKJEiiSVXQD/rwOm7muMWWduNG
         Ql7FAlo5nsjAW4tEx3GflqxDuTmvTrwgm/A1q+aduYKwiBiVuVqk+uJy46xAT2/b88ja
         8Q4xDxuwCfiMvlxpbZpSAOwxhqfh0qqazn55WbqZ2PrrtUQlXGXHF32nOZoHWuzDA9ds
         hNAo4+RpQznlu06X0mfF39N/a+28W7ctz6Z8fMLPGN1QmpXyTzHeWbOgGYsIdYClgnkJ
         FL32Fid613d0dfL8/efzlywgEdKDaonFyndxmRbdlITibg+sY8+JuuejQL6dFAM0kgIG
         uOCA==
X-Gm-Message-State: AOAM531xQAjWLb+cLk5ZXjakOC9W9rPHavkxPDlnxY2xVSFTMMNT1gcg
        74t8aMjx4UKNCgAcjo+tabQVZA==
X-Google-Smtp-Source: ABdhPJzWB1+Vzj3MMeE+uWismLmPVQESORqcKfWp3rBhgKzrwzRcqAem1QG2+r6cwXW16qiQ02z6kQ==
X-Received: by 2002:a63:a53:: with SMTP id z19mr7435489pgk.67.1599233176257;
        Fri, 04 Sep 2020 08:26:16 -0700 (PDT)
Received: from [192.168.1.11] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v10sm6707177pff.192.2020.09.04.08.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:26:07 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.9-rc4
Message-ID: <ecf36c20-0cfd-9010-84f7-334e3ea3b67d@kernel.dk>
Date:   Fri, 4 Sep 2020 09:26:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

- Improve Sandisks ATA_HORKAGE on NCQ (Tejun)

- link printk cleanup (Xu)

Please pull!


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.9-2020-09-04

for you to fetch changes up to 3b5455636fe26ea21b4189d135a424a6da016418:

  libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks (2020-09-02 11:31:23 -0600)

----------------------------------------------------------------
libata-5.9-2020-09-04

----------------------------------------------------------------
Tejun Heo (1):
      libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks

Xu Wang (1):
      ata: ahci: use ata_link_info() instead of ata_link_printk()

 drivers/ata/ahci.c        | 3 +--
 drivers/ata/libata-core.c | 5 ++---
 drivers/ata/libata-scsi.c | 8 +++++++-
 include/linux/libata.h    | 1 +
 4 files changed, 11 insertions(+), 6 deletions(-)

-- 
Jens Axboe

