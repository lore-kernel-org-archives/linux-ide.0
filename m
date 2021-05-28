Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039AEC4708C
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A876124B
	for <linux-ide@archiver.kernel.org>; Fri, 28 May 2021 09:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhE1JGo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 May 2021 05:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhE1JGm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2021 05:06:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954CC06174A
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f11so2562177wrq.1
        for <linux-ide@vger.kernel.org>; Fri, 28 May 2021 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4wIuz1s2gqzP/x9A7F4zXqS69dsm+xjTMP8Z10m2eY=;
        b=VgAkxOnEHVE33AmTNHtRtlTa7zzJjxyTD1gpG+b2Mavafk8F0338x5+4UXlrN4Zyz9
         sGfeBIMiVQHNK1yousB7Ud7ByBjfgQgI1lnm3yoowYR/YjAMGbk2rTJu23fDc9mY1bR5
         F77CD44p+DVYaMT4TkVmeCqsoKoBmwGtSE1hY+7Sil59GNuLEY3LForZOIu2I5esDYXR
         hwNx+SI2bY15RHVuZ9CR5ev+qlMIsbsVV2IYWy+2Mr5ASr+tNuXmix6oesXecGOjq6hz
         01mIQDVzPo+/joQ+obEucPWJq+dZlfhiLtyK0UJWTq3kWoo+oO4pYWyY5G/DP7MjRr2c
         JlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4wIuz1s2gqzP/x9A7F4zXqS69dsm+xjTMP8Z10m2eY=;
        b=qgUFuonqtuMFy/EEg1Lr5i1Ou0IJ9x21LMHHtUN9jTam/A+yNr3yYkbK6JiYK6T2Ts
         +LVz9WfQe/FMUxy/IFMCU2pt7jMb18rk0SXaGa6ZrEcRXGIWmODGDcntuiaNOFhhvQL/
         b6scRcvToWjmnENG7YjCV4slbcis5iMAwAllyG86awusKo3HhLL8IkCOJdNi8FSv7i5J
         cxue0MpaH5NsUiun/bPs5HxLHgqaT3TKtcoiffBFdRkm3hE4rld9vJNGZB0xfaHHKhWa
         6q5DvuQ/ZkWo1bW5Cd58eumHe9gf3sFobl4ndskLIS5u1gxzfiDCs+YfrdZcgKUL0lMA
         GqPw==
X-Gm-Message-State: AOAM532/+DAeATYYl9EWlxAvh1NW+/CApsnSE3fG5803K8Yllle9cb64
        1Z8BykX+K0OVeAfj42VmSb/6Gg==
X-Google-Smtp-Source: ABdhPJy6NC8fxoezbUSmaO5XCtCmwNj7bvGHW5AKd99pOPgdnngB+i8JCHjpvpXdFLGhZ1bdwlTt/Q==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr7482638wrt.365.1622192704884;
        Fri, 28 May 2021 02:05:04 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 00/11] Rid W=1 warnings from ATA
Date:   Fri, 28 May 2021 10:04:51 +0100
Message-Id: <20210528090502.1799866-1-lee.jones@linaro.org>
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

Lee Jones (11):
  ata: include: libata: Move fields commonly over-written to separate
    MACRO
  ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
  ata: sata_sil24: Do not over-write initialise fields in 'sil24_sht'
  ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
  ata: sata_nv: Do not over-write initialise fields in 'nv_adma_sht' and
    'nv_swncq_sht'
  ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
  ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
  ata: pata_cs5530: Avoid overwriting initialised field in 'cs5530_sht'
  ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
  ata: pata_serverworks: Avoid overwriting initialised field in
    'serverworks_osb4_sht
  ata: pata_macio: Avoid overwriting initialised field in
    'pata_macio_sht'

 drivers/ata/ahci.h             |  7 +++++--
 drivers/ata/pata_atiixp.c      |  3 ++-
 drivers/ata/pata_cs5520.c      |  3 ++-
 drivers/ata/pata_cs5530.c      |  3 ++-
 drivers/ata/pata_macio.c       |  5 ++++-
 drivers/ata/pata_sc1200.c      |  3 ++-
 drivers/ata/pata_serverworks.c |  3 ++-
 drivers/ata/sata_mv.c          |  6 +++++-
 drivers/ata/sata_nv.c          | 10 ++++++++--
 drivers/ata/sata_sil24.c       |  5 ++++-
 include/linux/libata.h         | 13 ++++++++-----
 11 files changed, 44 insertions(+), 17 deletions(-)

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: ATI Inc <hyu@ati.com>
Cc: benh@kernel.crashing.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Cc: Mark Lord <mlord@pobox.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
-- 
2.31.1

