Return-Path: <SRS0=juF9=EF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A9C4741F
	for <linux-ide@archiver.kernel.org>; Fri, 30 Oct 2020 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4914620731
	for <linux-ide@archiver.kernel.org>; Fri, 30 Oct 2020 17:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m8yXnuzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJ3RJG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3RJF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2020 13:09:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825DC0613CF
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2020 10:09:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b19so3264981pld.0
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2020 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x4RRfesJUZNgGhoA4nfcCafjzKcR9bxZMBC1/ApdFqQ=;
        b=m8yXnuzLB2L1JlSnghkeKxQTi52zPURYy/RRjOeN6cHuu8i8JUKIK0IP49mkMR8QXV
         f2XAlRB+/Q/jJuPKx4t0iKpYbGs+zr+MY7viJgtA6jwhX4A41XODq+78i1d3yvSaQIQc
         Dca9NYw4L+HOcmJBJ9KFmFE9JjxkHbL0IEu+t4u9aoCb4G+53jYpB4LAhCIQPFN9t2mx
         TY5ltYzUQh7eibTU4VGPuml87OyO3y09oL9ZsocPo/IQi+0Y1hs0sSKZ4Fy1wc2TZQPV
         809Yocwmf1TzC+zi7cfWn10BU5wYhcNHGjlRCX1uO5FvSRwouAmgcLkzxsGGD0NwOjDx
         VV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=x4RRfesJUZNgGhoA4nfcCafjzKcR9bxZMBC1/ApdFqQ=;
        b=HBRZ/H7C052N9ME5z0cGhpdqHmNQHa92SuLymfT9Ayker+PLIDd4PM6PgnSqIdVD4b
         Vc1UV9TgNwB4nmX2WJxmDlMfCd1bqyNJNu4e+lveESch4XNi1yscvsbt/4+PMsjievQP
         TXGuARruvZCOOfOR3dyMHhPUCFhDrK9/nJfDsho1IHbLKbCxlKIcElZR8nc94jLPEvXg
         9HOgaMiJCkNw5rKNPYib6MUFVFn7rN4ThKJ0vqwtcWw4A/tQbfuy6SgzVjonCjct0B4M
         njDwiDSRfWgZQap9xX1SiGw//Ln11m9z2yuJozv+5mybplCYukAW7zWE6a4w3PAUxPky
         vOeg==
X-Gm-Message-State: AOAM532PjCQzzQeQjgMi8sSf3jAOhkU+BTtWfF9Wk9DutZrqsfvnegKA
        Q0P3I2ZSqRkE6PNM+JOg004bkA==
X-Google-Smtp-Source: ABdhPJySo6KjpgZgbtJCGMzdnV7WH2eFmTgyQ0fbctJfQpck/Al7Hgj4+8uFuL8AdiCLF93j+1/2hg==
X-Received: by 2002:a17:902:d901:b029:d6:9796:514e with SMTP id c1-20020a170902d901b02900d69796514emr6139085plz.84.1604077743154;
        Fri, 30 Oct 2020 10:09:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1547? ([2620:10d:c090:400::5:15c3])
        by smtp.gmail.com with ESMTPSA id m11sm6180831pgs.56.2020.10.30.10.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:09:02 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fix for 5.10-rc
Message-ID: <b88f599e-3e61-b904-4025-8c59cd985b69@kernel.dk>
Date:   Fri, 30 Oct 2020 11:09:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

Single fix for a regression with sata_nv. Not from this merge window,
from quite a while ago.

Please pull!


The following changes since commit 94bd5719e491564c61ee9f121d544e23b4e51374:

  ata: fix some kernel-doc markups (2020-10-23 12:20:32 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-30

for you to fetch changes up to 8e4c309f9f33b76c09daa02b796ef87918eee494:

  ata: sata_nv: Fix retrieving of active qcs (2020-10-28 07:58:09 -0600)

----------------------------------------------------------------
libata-5.10-2020-10-30

----------------------------------------------------------------
Sascha Hauer (1):
      ata: sata_nv: Fix retrieving of active qcs

 drivers/ata/sata_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-- 
Jens Axboe

