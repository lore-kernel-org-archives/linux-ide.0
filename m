Return-Path: <SRS0=Kv9U=AY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19C8C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF1D2075D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiAjnY2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgGMRj2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRj2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jul 2020 13:39:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F07C061755;
        Mon, 13 Jul 2020 10:39:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so6330832pgb.6;
        Mon, 13 Jul 2020 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsCSO99ajVdezhsvt46VhG304K0QmMvZ1SLvNQqxCN4=;
        b=DiAjnY2UF2Ft32HWCeObIacUewyoVucUpWt+zmCyKymcSy2Tsolq8SL/ZuwMUcdXYF
         UAJkTypS/GsEjJgsC2LuQCTmrKn4t6KBviNwNFx0SI861QbQSPRRWobmEMzGwcWG302T
         4QTnwskLtNwxZbO1x01R/YlaygK2dcZ/UeGLpA8tFJkFw30Qwwet8GEYzZYtZRVQ0MLa
         C9Vft6vQXPd83Bx7mDHuSucaH0to/LlDYAb7Jfw+HxeJrzZpt4hUGMixo5DbkqJTiuQv
         qRHEQgpzANLRtDvZHx4k7URY7br2LHqFeOYS3qO4XyjxEKGF8mI0GOaNaZcOKDcYZMe7
         0YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsCSO99ajVdezhsvt46VhG304K0QmMvZ1SLvNQqxCN4=;
        b=hGFUMWcqSh4Zl5yNO/M73bB/BTHc4P9c3sI4r+x8rANAtqMgqjN0Oib2Pjse27Lcun
         NOhofXhkUEj64b3Rdle+lGmOiFwQfR0H/LI388igNBdIHsGyoAeb5zjYtc4hvdDQq3YC
         RVS1Xrt3IAygHmKOZRn4fZOKGiALcYaVo5AXj4E4RPWnUOqFcgyMLHPQKXdszb0uE56V
         nDvKWwBv/9GsIe5UHIHXtFCRBjHZD/aWa4BfdHpbPSk1rsSNgV6O0U5xV7WgQBv8rPXY
         O6HnX/tTBaVSocVTE2B+CkRK3MKrAOVbVPOt1eVFUA72qN6L8cmnz9Yj4QVdjslHh8qK
         hNhg==
X-Gm-Message-State: AOAM533+ddzk9roarDao2skFavIc+A5lzg1wEYje7y3H3QX6NgTmPMzD
        k+6OVb/szZK42w4gJTmN0E0=
X-Google-Smtp-Source: ABdhPJxLjkfeTM6u2EPFb0xNzbO7HD66zJ2C9DTOFC/K2UT2od5SKnwJX1jfcQRUGjEjdIYTXhMKFg==
X-Received: by 2002:a62:1716:: with SMTP id 22mr797676pfx.99.1594661967413;
        Mon, 13 Jul 2020 10:39:27 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id w9sm186540pja.39.2020.07.13.10.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:39:26 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v3 0/3] drivers: ide: use generic power management
Date:   Mon, 13 Jul 2020 23:06:10 +0530
Message-Id: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to remove legacy power management callbacks
from ide drivers.

The suspend() and resume() callbacks operations are still invoking
pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
etc. and handling the power management themselves, which is not recommended.

The conversion requires the removal of the those function calls and change the
callback definition accordingly and make use of dev_pm_ops structure.

All patches are compile-tested only.

v3:
    - Modpost error for undefined reference by Kbuild in v1.
    - Another approach to disable PM in drivers/ide/triflex.c suggested by
      Bjorn Helgaas in v2.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (3):
  ide: use generic power management
  ide: sc1200: use generic power management
  ide: delkin_cb: use generic power management

 drivers/ide/aec62xx.c         |  3 +--
 drivers/ide/alim15x3.c        |  3 +--
 drivers/ide/amd74xx.c         |  3 +--
 drivers/ide/atiixp.c          |  3 +--
 drivers/ide/cmd64x.c          |  3 +--
 drivers/ide/cs5520.c          |  3 +--
 drivers/ide/cs5530.c          |  3 +--
 drivers/ide/cs5535.c          |  3 +--
 drivers/ide/cs5536.c          |  3 +--
 drivers/ide/cy82c693.c        |  3 +--
 drivers/ide/delkin_cb.c       | 32 +++++---------------------
 drivers/ide/hpt366.c          |  3 +--
 drivers/ide/ide-pci-generic.c |  3 +--
 drivers/ide/it8172.c          |  3 +--
 drivers/ide/it8213.c          |  3 +--
 drivers/ide/it821x.c          |  3 +--
 drivers/ide/jmicron.c         |  3 +--
 drivers/ide/ns87415.c         |  3 +--
 drivers/ide/opti621.c         |  3 +--
 drivers/ide/pdc202xx_new.c    |  3 +--
 drivers/ide/pdc202xx_old.c    |  3 +--
 drivers/ide/piix.c            |  3 +--
 drivers/ide/sc1200.c          | 43 ++++++++++++-----------------------
 drivers/ide/serverworks.c     |  3 +--
 drivers/ide/setup-pci.c       | 29 +++++------------------
 drivers/ide/siimage.c         |  3 +--
 drivers/ide/sis5513.c         |  3 +--
 drivers/ide/sl82c105.c        |  3 +--
 drivers/ide/slc90e66.c        |  3 +--
 drivers/ide/triflex.c         | 24 +++++++------------
 drivers/ide/via82cxxx.c       |  3 +--
 include/linux/ide.h           |  8 +------
 32 files changed, 62 insertions(+), 155 deletions(-)

-- 
2.27.0

