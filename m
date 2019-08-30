Return-Path: <SRS0=R/8C=W2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC790C3A5A3
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA4A23405
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NPaPVEvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfH3HRv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:17:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39784 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfH3HRv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Aug 2019 03:17:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so5858374wra.6
        for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2019 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpbAWeVajE7jbJxx72Z5QEPjasF1SzZQc9KND43zWKM=;
        b=NPaPVEvAlEP1JwwBNRmZqQu1oXjgq7Ehu6IWBk/Gm3+47TQiElN7qNOrM8NdxNJUuY
         8DW4Wrl4pGsO/FwXlQ28jwaPDg7vIjLNOf6/dDceSHDcw6t452DKc72rkFpL5vLXJw9z
         bxHQsUHERyRczWxhfjNaoEdhqrFm0OuM17Ek+8MIkp8+MW8aItdbwahIw5ASVWUERoje
         SwmdYGGcXSqH9DUAZTxDfsiQXxXy7TqNKuA2PQ0SCakmDuySWzcw8FZO4n6cncx/pLlD
         C0nd8nKnnjLOle0TdsfC5KolLs4Sn9BaEX2McZqo6rx0UpNcxTGCy7z79ZyOK6OAyP7C
         bcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpbAWeVajE7jbJxx72Z5QEPjasF1SzZQc9KND43zWKM=;
        b=c1kbqhyIXNHYbuuvxcCQrAUNuU7OnhTVmsN1iVHgEkNi3DJ7HrmLZI0zzd/K87MJ/C
         reFgIhsDP3d706Lsi3Nm3QfG5fR8chRjPZXj8YRjHH4FrkPfA/y3dKJwfRKxMFVujSOa
         lOy0tFgN6ayOc6i44U0nqPDFQ/Tn6KTNJjYrKSm6vPq7nMH4HuKFglc0Bun4ApRWtvvp
         yXKtl7IcZGQ9U9jW/0h52PYJP8i0uDn+wm1wYFUr1/fzvu9+mexYppKcYPA+oRZ/UCzq
         5Oipzaet7Rt6HsBVVu5FVB52osx/awjbyIEi8Qbufq8h66jCfXoSNze9xLPoB1y/35i0
         bxTw==
X-Gm-Message-State: APjAAAVXPu+OTCD7vMhuxXHgzNXJDYDYM1YAVNR23mmETbTI5nGrzvxY
        eLHg/+7TPV5vJLsCNuqu6l+xoA==
X-Google-Smtp-Source: APXvYqytZc9V3iUoascFuNBlkNrDdlZGsMbx4k8y04BWHaakkVhzfSq61JeOcecviPSZKeU4s3zm4w==
X-Received: by 2002:adf:aa85:: with SMTP id h5mr4534823wrc.329.1567149469792;
        Fri, 30 Aug 2019 00:17:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x6sm7637529wrt.63.2019.08.30.00.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:17:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] regulator: add and use a helper for setting supply names
Date:   Fri, 30 Aug 2019 09:17:36 +0200
Message-Id: <20190830071740.4267-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are ~80 users of regulator bulk APIs that set the supply names
in a for loop before using the bulk helpers.

This series proposes to add a helper function for setting supply names
and uses it in a couple tegra drivers. If accepted: a coccinelle script
should be easy to develop that would address this in other drivers.

Bartosz Golaszewski (4):
  regulator: provide regulator_bulk_set_supply_names()
  ahci: tegra: use regulator_bulk_set_supply_names()
  phy: tegra: use regulator_bulk_set_supply_names()
  usb: host: xhci-tegra: use regulator_bulk_set_supply_names()

 drivers/ata/ahci_tegra.c           |  6 +++---
 drivers/phy/tegra/xusb.c           |  6 +++---
 drivers/regulator/helpers.c        | 21 +++++++++++++++++++++
 drivers/usb/host/xhci-tegra.c      |  5 +++--
 include/linux/regulator/consumer.h | 12 ++++++++++++
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.21.0

