Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677BC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CF3613BA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFBKTT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBKTS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD98C06174A
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso1355532wmq.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPDD51qpMRPuv9Fk8qUYAfWOGjtsRuaqysDYxI5Q/mI=;
        b=keQ0CzhjrxmKEuq4uYSZoRrwSn6RtvmaGeh9jNo3hvZLRsVHdsTM2erFYYaThZAWs1
         hNhbwAo3PWnzyxxcSOnuDVbRq6fV7a718bo/zFgk6OVzhHy0r2Jrzku/+jVUkeNW0klc
         qLCEvCekHPxx2HYoHMTmdTPo1dc6V7303f6xuRXAhQPBf4LxxpkkHSJORsZpZG6koC6g
         9xwBi4zelbNLoIN8/KyMI4+eLlVVP856HRaiO4oXxx3h1CcAV0qSjbyrArw8kilHeE+k
         NFTGGOEyjXaI02QcUAGrlLu62lU6Lhi9G0kkfqQ0v1HHVvFHiLSGgLp5KJ94yD+YjNjg
         H03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPDD51qpMRPuv9Fk8qUYAfWOGjtsRuaqysDYxI5Q/mI=;
        b=n5RLNyWSYHTid7T0f7sl1vnbDv96c7MWRkAzGSHUZjv62ejJxQ1Ih/Yjx1nlfHaA6W
         RwmgcjByl7m5gtmMObU9MOue3O8ZlUuxjPoypr0uCjwPHmRnXrzZxWszi30wan5Mhalq
         wCCMJIdlWsTMqHlq+OoFtgBCkpL27ssAccGzwE3O7XggYfDGpRqQ/Bu1WrSImrS/dYXG
         5ZRCwSCYmdfCJn6OvhBHhhk6DytKhyQvqzN7JkIdrQFECRtQ0TZNZMkNVZ1WOq8DUbyg
         DiTwTxG7+XIAbssQpalwNNMr5FluWagFz4S1bO1yS2wB0uVtmYyNwcZUGMrKnrCnxwOV
         hCYg==
X-Gm-Message-State: AOAM5306v1kmY99EvW1RsG9t4HcAzVtcteXyPHCCgYgZTbgC4s58evKo
        zPufxSWFH4N1qcD3XlcQT/+FZQ==
X-Google-Smtp-Source: ABdhPJzADrdrNiLpSSBqh+JLm+XosLbtT8oiPSK6y5ZObKbLSuSjoZ+bLBl1gBM7fEy9Urb25f5LFQ==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr2061219wmq.45.1622629054376;
        Wed, 02 Jun 2021 03:17:34 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Adrian Sun <a.sun@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        "David S. Miller" <davem@davemloft.net>,
        Duncan Laurie <void@sun.com>,
        Erik Andersen <andersee@debian.org>,
        Frank Tiernan <frankt@promise.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Lord <mlord@pobox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Waychison <crlf@sun.com>, or <source@mvista.com>,
        Paul Mackerras <paulus@samba.org>,
        Robert Bringman <rob@mars.trion.com>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Tim Hockin <thockin@sun.com>
Subject: [PATCH 00/21] Rid W=1 warnings from IDE
Date:   Wed,  2 Jun 2021 11:17:01 +0100
Message-Id: <20210602101722.2276638-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (21):
  ide: alim15x3: Document alim15x3_init_one()'s 'id' param
  ide: ide-dma: Document ide_dma_unmap_sg()'s missing 'cmd' param
  ide: ide-dma-sff: Provide some missing 'param' descriptions
  ide: ide-io: Fix a few kernel-doc misdemeanours
  ide: ide-proc: Strip out unused fops structure and accompanying
    call-back
  ide: cs5530: Fix incorrect documentation for function
    init_chipset_cs5530()
  ide: ide-probe: Fix-up incorrectly documented function
    probe_for_drive()
  ide: hpt366: Provide some missing descriptions for 'f_{low,high}'
  ide: piix: Remove unused variable 'sitre'
  ide: pdc202xx_new: Supply missing description for 'set_indexed_reg()'s
    'value' param
  ide: slc90e66: Remove unused variable 'sitre'
  ide: it821x: Fix a couple of incorrectly documented functions
  ide: siimage: Fix some incorrectly documented functions/params
  ide: via82cxxx: Fix misdocumentation of via_set_speed()'s 'hwif' param
  ide: ide-cd_ioctl: Remove unused variable 'stat'
  ide: ide-cd: Demote kernel-doc abuse
  ide: ide-acpi: Mark debugging variable 'bus' as __maybe_unused
  ide: ide-io: Document ide_intr()'s param 'irq'
  ide: piix: Fix incorrectly documented param 'hwif'
  ide: ide-acpi: Provide missing description for param 'obj_loc'
  ide: pmac: Staticise local function 'pmac_ide_probe'

 drivers/ide/alim15x3.c     |  1 +
 drivers/ide/cs5530.c       |  2 +-
 drivers/ide/hpt366.c       |  2 ++
 drivers/ide/ide-acpi.c     |  4 +++-
 drivers/ide/ide-cd.c       |  2 +-
 drivers/ide/ide-cd_ioctl.c |  3 +--
 drivers/ide/ide-dma-sff.c  |  4 ++++
 drivers/ide/ide-dma.c      |  1 +
 drivers/ide/ide-io.c       |  9 +++++----
 drivers/ide/ide-probe.c    |  2 +-
 drivers/ide/ide-proc.c     | 13 -------------
 drivers/ide/it821x.c       |  4 ++--
 drivers/ide/pdc202xx_new.c |  1 +
 drivers/ide/piix.c         |  4 +---
 drivers/ide/pmac.c         |  2 +-
 drivers/ide/siimage.c      |  4 ++--
 drivers/ide/slc90e66.c     |  3 +--
 drivers/ide/via82cxxx.c    |  2 +-
 18 files changed, 29 insertions(+), 34 deletions(-)

Cc: Adrian Sun <a.sun@sun.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Benoit Poulot-Cazajous <poulot@chorus.fr>
Cc: Christian Brunner <chb@muc.de>
Cc: "Christopher J. Reimer" <reimer@doe.carleton.ca>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Duncan Laurie <void@sun.com>
Cc: Erik Andersen <andersee@debian.org>
Cc: Frank Tiernan <frankt@promise.com>
Cc: Gadi Oxman <gadio@netvision.net.il>
Cc: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Mark Lord <mlord@pobox.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Waychison <crlf@sun.com>
Cc: or <source@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Robert Bringman <rob@mars.trion.com>
Cc: Scott Snyder <snyder@fnald0.fnal.gov>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Software, Inc" <source@mvista.com>
Cc: support to <linux-ide@vger.kernel.org>
Cc: Tim Hockin <thockin@sun.com>
-- 
2.31.1

