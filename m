Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE0C4338F
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0386560FD8
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhG1JEu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1JEu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB5C061757
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d18so2592231lfb.6
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9+TRM6L+gYZYLmbWJs+LvTpkB/3RYvaROCq22SvK4I=;
        b=UIOYRtxj4ZEDdAycVr78J0u5YjMrHZVleKk2EcB3V2eazsuiMc63353+DZFj0rn7oC
         T35jOzCZseKLnahwExhYuHJIzt3zaa0U0fb2OrD/7l7gZfFlLDqtKYQHqG8b26Aqv22n
         zALUv2c2INZ85Sl/7DnNXhHtrj4aOivI0QYSNB+FZ5J/czU92nyaYJ326A3ocXTEn61l
         NASYXhwr/eA/UAgqEMimsKhiFWsS+sbTeXis6XhpbZV/sXCn6lA86FcblXZQVbipvjIR
         9Hvv8s57XU5/xdoZZ/qaMqzYDohSIZs5zsLWV3cf5Lhl4w0HSpxvpq7XuOo80MPM3Cc9
         4ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9+TRM6L+gYZYLmbWJs+LvTpkB/3RYvaROCq22SvK4I=;
        b=jaob5YCC+MwLLf5i7PFc8E0ZGlppk0Ho5D2tx35I50xvrE7CnyQlwi0uTQ6SpLLx1s
         bzML56SM2VkcViidO58+xXjsL4rpsNzyOcFJzCmbCuSe0Id2/wxLwS/kDXBmr1nNjtbn
         YaOb26NaKs7PwYkAEaJmHbIB5EreMm8y99HZ15EXvqQkXWVTFIJK5BiNHuov959FmEzl
         Pk0Co0baC7bk2yL2m8zzwMN9fpYhGIw4mOmDhu374A3bz9YuGgOTQgmZ4psAvkqL1jZX
         No61CqxdTCRVh6UIk/adfhnIQsv3Va6RpvAb/Q+cEcvIca+uaJXEM/etspiT5DnstNU1
         1uKw==
X-Gm-Message-State: AOAM530Zzj07x8Pcmg669hvIgLnb42U5B1eA9fvcASE1wtLR4+9JDfG4
        +1Y/ULSI93bb6C3nJsoftTk1pg==
X-Google-Smtp-Source: ABdhPJxxzbrv2T2hlcowF5RkKU2lUYH2L4dj+GmvCOoOZCnJBE14hDpoH9v9zLfrSTIn5lihj0GwBw==
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr19917133lfb.631.1627463087283;
        Wed, 28 Jul 2021 02:04:47 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Update and rewrite IXP4xx PATA driver
Date:   Wed, 28 Jul 2021 11:02:37 +0200
Message-Id: <20210728090242.2758812-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This rewrites the IXP4xx PATA driver to use device tree exclusively.

It is too much trouble to triangulate over using board files and
DT at the same time, let's just replace it with device tree as
we delete all board files at the same time as we merge this.

I'd appreciate an ACK from the PATA maintainer so we can take this
through the ARM SoC tree when we delete the boardfiles at the same
time.

Linus Walleij (5):
  pata: ixp4xx: Use local dev variable
  pata: ixp4xx: Use IS_ENABLED() to determine endianness
  pata: ixp4xx: Refer to cmd and ctl rather than csN
  pata: ixp4xx: Add DT bindings
  pata: ixp4xx: Rewrite to use device tree

 .../ata/intel,ixp4xx-compact-flash.yaml       |  62 ++++
 drivers/ata/pata_ixp4xx_cf.c                  | 264 ++++++++++++------
 include/linux/platform_data/pata_ixp4xx_cf.h  |   4 +-
 3 files changed, 249 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml

-- 
2.31.1

