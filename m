Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD95C433E6
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4D164F18
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCRIwM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCRIvy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:51:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44DC06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so4608457wrs.9
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7V2C5garI2m71wrt2YhHdPjHtF10QzZ2ukjtzqhJtw=;
        b=pCmBF+FhFFyD4T+PspGlle6dJSS7h31BQHp1wJ9yl/nSGdR0ztPjRS/k/1pA5x7V2o
         j6UMp0FV19vEG2Lfabj851R60ckWCU0v3SQHTm9kQpUtV1TnZu2Ao03TiP1GZmuNKZZu
         a8wq789h6a10FfhIXGrraVpYdNvEeuuKy6UcEmT8OZOAyPh1U37XoGM00XkEmG2xijNx
         i5lWNW+BVQko/sR0Ti/4F9VW/8v2VvJn0p2vopi+tXYIZj5tQ+sp2f6yf1HN/rseqRsG
         EV9wm0OD5QcN8W1rDECwETGPB/JTXnbYCxyIEQ7FkQf1JkOFLzyOjoC/WMbntM/leRn6
         AMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7V2C5garI2m71wrt2YhHdPjHtF10QzZ2ukjtzqhJtw=;
        b=PG+3ZnQzbazcp9z+0lgOuhg5OE1O613IYmAJEIeJ6gA3Q2qBX+JxuaS99jebj8+DGd
         ROnUdukfTzYuKtmGbHICgGu2l4Cl2O9sw/A+6KUM/pKf5Eq3gLYjqZKK9ZDqa39tk9kU
         mtFJvCkwvoBc3KOatK8ZPGFWlYDgGjQnqevD9ab/qGYnQHA/5HWJFQho9YT6u2JscAMH
         73zhfr25hV3g1HaiJEj7rejEPNCjVo7zQCPt43XE3naKQOlgOdo4lZ8ms6CvF8CNZZ4P
         LLWxoc6XEjbbsWicd3G+zytNLO63SxUU5EvUa4pLLHfrdgKaxpSMYsP46GzKUmt3EAb5
         /vUQ==
X-Gm-Message-State: AOAM530L/Noojc/lw8MSVE/dy40+eyvNqD1ckoYyj6uzboXWN0KeMkoU
        ohgew5KrvwZARC7+e7N1M+frAQ==
X-Google-Smtp-Source: ABdhPJwW3BgHx4D4LM4CZlczeIQk3nZCyztSvU6zNU6Kr6ikEhPCKrmuiLyifn05MJIDj99gyQ+ATg==
X-Received: by 2002:adf:a703:: with SMTP id c3mr8697373wrd.72.1616057512788;
        Thu, 18 Mar 2021 01:51:52 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Colten Edwards <pje120@cs.usask.ca>, Hat Inc <alan@redhat.com>,
        Jan Harkes <jaharkes@cwi.nl>, Jaromir Koutek <miri@punknet.cz>,
        Jens Axboe <axboe@kernel.dk>,
        "L.C. Chang" <lcchang@sis.com.tw>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Mark Lord <mlord@pobox.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 00/15] [Set 2] Rid W=1 warnings from ATA
Date:   Thu, 18 Mar 2021 08:51:35 +0000
Message-Id: <20210318085150.3131936-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 2 out of 2 sets required.

Lee Jones (15):
  ata: pata_pdc202xx_old: Fix some incorrectly named functions
  ata: pata_sil680: Add some missing function parameter docs
  ata: pata_sis: Remove superfluous param description and supply another
  ata: pata_triflex: Repair some misnamed functions and fix some param
    descriptions
  ata: pata_it821x: Fix possible doc-rotted function names
  ata: pata_via: Fix a kernel-doc formatting issue
  ata: pata_piccolo: 'ata_tosh_init()' is misnamed in its header
  ata: pata_sl82c105: Fix potential doc-rot
  ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
  ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
  ata: pata_legacy: Repair a couple kernel-doc problems
  ata: pata_cs5530: Fix misspelling of 'cs5530_init_one()'s 'pdev' param
  ata: sata_mv: Fix misnaming of 'mv_bmdma_stop()'
  ata: libata-acpi: Fix function name and provide description for
    'prev_gtf'
  ata: pata_acpi: Fix some incorrect function param descriptions

 drivers/ata/ata_generic.c       | 2 +-
 drivers/ata/libata-acpi.c       | 3 ++-
 drivers/ata/pata_acpi.c         | 6 +++---
 drivers/ata/pata_cs5530.c       | 2 +-
 drivers/ata/pata_it821x.c       | 4 ++--
 drivers/ata/pata_legacy.c       | 8 ++++----
 drivers/ata/pata_opti.c         | 2 +-
 drivers/ata/pata_pdc202xx_old.c | 4 ++--
 drivers/ata/pata_piccolo.c      | 2 +-
 drivers/ata/pata_sil680.c       | 2 ++
 drivers/ata/pata_sis.c          | 2 +-
 drivers/ata/pata_sl82c105.c     | 2 +-
 drivers/ata/pata_triflex.c      | 7 +++----
 drivers/ata/pata_via.c          | 2 +-
 drivers/ata/sata_mv.c           | 2 +-
 15 files changed, 26 insertions(+), 24 deletions(-)

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Colten Edwards <pje120@cs.usask.ca>
Cc: Hat Inc <alan@redhat.com>
Cc: Jan Harkes <jaharkes@cwi.nl>
Cc: Jaromir Koutek <miri@punknet.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "L.C. Chang" <lcchang@sis.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Mark Lord <mlord@pobox.com>
Cc: Red Hat <alan@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
-- 
2.27.0

