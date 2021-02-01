Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED759C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A2E64DFA
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhBAOk2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhBAOk0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:40:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F60C06174A
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p15so16784802wrq.8
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtHVyu1JXH6engiBuN8GwfBJD+cwjKiDFMpMO9CFV/s=;
        b=TaJ/QvJzU5EiMtUfKirUgEGeOZERgwMHIg1CXOvZQNCBWKAeBIYd+f8A/HLrV8fdZl
         Urp4cpswUmsOLAnSzmYSAHkrGw6fDfevzB3sxIftzq8145TlizHw9PlnunVmD0BwMRR0
         8mgd+stTnTkjC4vb1t7SyN9iG7e2Bw039EX4pdz88sCwXeC49deb6huanzEbe5XOVsnY
         UC8AtQ9VDP3xCtYICmyBWDvUY6dRIVlITeCP2zfMECSe+4bN9veruSQaVDYpxGhMPwA7
         NL74puAEkUSjSWctxQz1875cc8H/T8QLJ6e8aGsd6uFgZa0e2VsBEY2WbdxJqae4IXww
         UWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtHVyu1JXH6engiBuN8GwfBJD+cwjKiDFMpMO9CFV/s=;
        b=EZi28eeN6SnboC4qGHKbzudsb6Lrm+an2gsD+9zA89kEC8rYUQj9H2jxOImWONMVJL
         ntnd/uKh6e5v/IZoJX8baHAmnlVWRCTG22yMZBRlJ0V3xWu701Y7iY3NEUptYAd3JeXm
         P/H2c2H8lz/e4xqGIWwaIY54oM+HdLQe6t9T8yV3WakoDmberZyKdIhuPnhQzSil4H/H
         jnzBZ3H/IqCMx932/Zh+8ILbMpqGBoFwaJ87W0duzGuBdSsF4aKkovrFkZjnEArxnGil
         MnNziwmL652bp8WBOi1Obc+WS2lGa3W6ay1raJ3gk5WoGMbBNz5H/xGS/PmixeWqDvKb
         e6Ag==
X-Gm-Message-State: AOAM533z5ScE8E5i0UIiPvtgJKPLNW2H7z9P1WoWkw0gh7LyrhAbj8gB
        SXQ2sGVARzPNPcrPtd58db4Mdg==
X-Google-Smtp-Source: ABdhPJzdseGS3w6kCIvHNg5GG+u5Hdzo0Yl3ZDxY51dtxoi6pDiHnAQLhs6OaiKiuduhh8Zgw6m5MA==
X-Received: by 2002:a5d:47a8:: with SMTP id 8mr18116441wrb.180.1612190383845;
        Mon, 01 Feb 2021 06:39:43 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Albert Lee <albertcc@tw.ibm.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        ATI Inc <hyu@ati.com>, CJ <cjtsai@ali.com.tw>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        Frank Tiernan <frankt@promise.com>,
        Jens Axboe <axboe@kernel.dk>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
Subject: [PATCH v2 00/20] [Set 1] Rid W=1 warnings from ATA
Date:   Mon,  1 Feb 2021 14:39:20 +0000
Message-Id: <20210201143940.2070919-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 1 out of 2 sets required.

v2:
 - Removed "Ignore -Woverride-init" patches
 - Back-filled them with others

Lee Jones (20):
  ata: libata-transport: Fix some potential doc-rot issues
  ata: libata-sata: Fix function names in header comments
  ata: libata-pmp: Fix misspelling of 'val'
  ata: pata_ali: Repair some misnamed kernel-doc issues
  ata: pata_artop: Fix a function name and parameter description
  ata: pata_amd: Remove superfluous, add missing and fix broken params
  ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s
    'mask' param
  ata: pata_hpt37x: Fix some function misnaming and missing param issues
  ata: ahci_xgene: Fix incorrect naming of
    'xgene_ahci_handle_broken_edge_irq()'s 'host' param
  ata: sata_mv: Fix worthy headers and demote others
  ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
  ata: pata_amd: Fix incorrectly named function in the header
  ata: pata_artop: Repair possible copy/paste issue in
    'artop_6210_qc_defer()'s header
  ata: pata_atiixp: Fix a function name and supply description for 'pio'
  ata: pata_cs5520: Add a couple of missing param descriptions
  ata: pata_hpt3x2n: Fix possible doc-rotted function name
  ata: pata_marvell: Fix incorrectly documented function parameter
  ata: pata_jmicron: Fix incorrectly documented function parameter
  ata: pata_optidma: Fix a function misnaming, a formatting issue and a
    missing description
  ata: pata_pdc2027x: Fix some incorrect function names and parameter
    docs

 drivers/ata/ahci_xgene.c       |  2 +-
 drivers/ata/libata-pmp.c       |  2 +-
 drivers/ata/libata-sata.c      |  4 ++--
 drivers/ata/libata-transport.c |  6 +++---
 drivers/ata/pata_ali.c         |  6 +++---
 drivers/ata/pata_amd.c         |  6 +++---
 drivers/ata/pata_artop.c       |  4 ++--
 drivers/ata/pata_atiixp.c      |  3 ++-
 drivers/ata/pata_cs5520.c      |  2 ++
 drivers/ata/pata_hpt366.c      |  1 +
 drivers/ata/pata_hpt37x.c      |  6 ++++--
 drivers/ata/pata_hpt3x2n.c     |  2 +-
 drivers/ata/pata_jmicron.c     |  2 +-
 drivers/ata/pata_marvell.c     |  2 +-
 drivers/ata/pata_optidma.c     |  5 +++--
 drivers/ata/pata_pdc2027x.c    | 10 +++++-----
 drivers/ata/sata_mv.c          | 12 ++++++------
 17 files changed, 41 insertions(+), 34 deletions(-)

Cc: Alan Cox <alan@redhat.com>
Cc: Albert Lee <albertcc@tw.ibm.com>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: and cc <htejun@gmail.com>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: ATI Inc <hyu@ati.com>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: Frank Tiernan <frankt@promise.com>
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

