Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB5DC433E6
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F964E1D
	for <linux-ide@archiver.kernel.org>; Thu, 28 Jan 2021 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA1SE7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhA1SDe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jan 2021 13:03:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA3C061574
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so6300710wre.13
        for <linux-ide@vger.kernel.org>; Thu, 28 Jan 2021 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbwKBPZ6NVdWVy9hBzvwi6MSFEiBWdxVms0lvPLWo/c=;
        b=jGGLZhr5sBVsYfDik4Q2fRSbdj2LgIPAwSXGKw5VPzycFJVyuE0l0gfLAHgwbcDJPS
         Cv0Yi5IyBomxuAtBtmdHc9ZtPsAOcbRKxE7/YMXuH7H/5kKSGfLu5+Eq4Ew1HVZLQttV
         j65bUAyxAIU4n89HCXIXohYen6xVt1LQ32JWBRenCEIeuCXLdYWUdt9ZapCaE4Pw4HNc
         nX2lSwIui2fqFt2knJAymekhKuz3dtndGIqHcUIeJwQ/X5UphCzX49DwrZoL19gh/HVS
         uqOujgFvG9Nww+QiCNiYEbC0txyw6L1VeoLQ92AeoRqt0lCI3XH/F6rSCd29hUoUZy3Z
         cfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbwKBPZ6NVdWVy9hBzvwi6MSFEiBWdxVms0lvPLWo/c=;
        b=OUAYAb6rTpzFm4aZ3sNhViHUOPMfVlGtKBxj0R2dG1m6KbE8bVZCxznlBNb/Pi1nNB
         CCE3Hr9YgJJSn3lIQuTn/kQBEYX4gTYbIbdpP5h+ubg95V9KdutcZN+YtJM2/owOcCyl
         ykJyoXS+SypK4fChsCbpHVeNNckKduxun+T4RHvPZ8AoyTTwT+ropZVqVtazywQNxKnk
         cu9W1TPCIZP7C2b9S3GgRIov2MyqM4qHOaxTyoBsnaEAt/Nh0hkOV44ZCS+wPa649/zF
         Vq5n6f/tipX8U2ncABjX3AOk3c0adj0MAEpjRcAm7XQZitwUdqkaer2JrQT0sWrlY0Ik
         Q43g==
X-Gm-Message-State: AOAM533hU2rR2CJyhvC/sgJBkgCShKnVWzA+OBclWWy28346ha6XROlV
        02hy3inZDU3exhaYWzKoPuBfoQ==
X-Google-Smtp-Source: ABdhPJxeotnLg/uBW+GP1J30t3I2dhLOQvNkQzTiwLE/S+sw703fhBKQQaGjxSH0V4NxE78Qss0BNg==
X-Received: by 2002:a5d:6044:: with SMTP id j4mr244879wrt.287.1611856962397;
        Thu, 28 Jan 2021 10:02:42 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        Jens Axboe <axboe@kernel.dk>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
Subject: [PATCH 00/20] [Set 1] Rid W=1 warnings from ATA
Date:   Thu, 28 Jan 2021 18:02:19 +0000
Message-Id: <20210128180239.548512-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 1 out of 3 sets required.

Lee Jones (20):
  ata: ahci_dm816: Ignore -Woverride-init
  ata: libata-transport: Fix some potential doc-rot issues
  ata: ahci_platform: Ignore -Woverride-init
  ata: libata-sata: Fix function names in header comments
  ata: libata-pmp: Fix misspelling of 'val'
  ata: ahci_mtk: Ignore -Woverride-init
  ata: pata_ali: Repair some misnamed kernel-doc issues
  ata: pata_artop: Fix a function name and parameter description
  ata: acard-ahci: Ignore -Woverride-init
  ata: ahci_ceva: Ignore -Woverride-init
  ata: pata_amd: Remove superfluous, add missing and fix broken params
  ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s
    'mask' param
  ata: pata_hpt37x: Fix some function misnaming and missing param issues
  ata: sata_sil24: Ignore -Woverride-init
  ata: sata_highbank: Ignore -Woverride-init
  ata: ahci_brcm: Ignore -Woverride-init
  ata: ahci_xgene: Fix incorrect naming of
    'xgene_ahci_handle_broken_edge_irq()'s 'host' param
  ata: sata_mv: Fix worthy headers and demote others
  ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
  ata: ahci: Ignore -Woverride-init

 drivers/ata/Makefile           | 10 ++++++++++
 drivers/ata/ahci_xgene.c       |  2 +-
 drivers/ata/libata-pmp.c       |  2 +-
 drivers/ata/libata-sata.c      |  4 ++--
 drivers/ata/libata-transport.c |  6 +++---
 drivers/ata/pata_ali.c         |  6 +++---
 drivers/ata/pata_amd.c         |  4 ++--
 drivers/ata/pata_artop.c       |  2 +-
 drivers/ata/pata_hpt366.c      |  1 +
 drivers/ata/pata_hpt37x.c      |  6 ++++--
 drivers/ata/sata_mv.c          | 12 ++++++------
 11 files changed, 34 insertions(+), 21 deletions(-)

Cc: Alan Cox <alan@redhat.com>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: and cc <htejun@gmail.com>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Cc: Loc Ho <lho@apm.com>
Cc: Mark Lord <mlord@pobox.com>
Cc: Suman Tripathi <stripathi@apm.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Tejun Heo <teheo@suse.de>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Tuan Phan <tphan@apm.com>
-- 
2.25.1

