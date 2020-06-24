Return-Path: <SRS0=5ANp=AF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D200C433DF
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F329A20768
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ/G2+Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405429AbgFXRaR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405427AbgFXRaR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2020 13:30:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA17C061573;
        Wed, 24 Jun 2020 10:30:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so1723207pgo.9;
        Wed, 24 Jun 2020 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q15/TzuCJicAE8EEZy+jtFuuq+UiSpYK9IL1usdFcPE=;
        b=tJ/G2+ZtCC01Paj/JN3QoUPDLqFBcKO79I6h3o8CyYHSnd9q1OEH5PLyE6x9Cm/JWu
         SAhBPOwaLdcbgKSRCSSUI/nfL7Hz83CWPP1GP7dOBUlj/hTPcM7vTvHXE+bFml2SFgJ3
         mAYj7idtIZ3c7oWjrai/yX6P5+dr0+NzeoSqkHl6xpk4EIvd+alSV2NQLgRuwomJ7qjJ
         OXWqJ/4T3A58dCuAU6RYhADwClA5QxRJJ04WzB2F6zQEcPIMoAZvPslAnptjrMPsUBY7
         4gilpfPeFkzLKfLG1DBZl34eykw1orox/alt09ttTli8mgB5rl7wBr1/LppjpwxI25dn
         SycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q15/TzuCJicAE8EEZy+jtFuuq+UiSpYK9IL1usdFcPE=;
        b=QociScsDX41sARUPYXAConAJUwHyiiSYy3whS6TwRj+ktOs60qzXU7wKn/XvhVFt/Z
         wcKmVAOe0fOoB5vdOA4/Xnz+eij/ji2FtUwi/LBW/kAlInMoqdO88qwiO3rlSRTk/wR/
         jFBUWG9dQ3aXQT1VMFCPvtnvoSI1zdEcREMSoSc3abxd9VYz+mpKAqi1D3C1z6EZ4k+J
         62ClDYwIHK4Ky69zCzTo/TGz0ywE6vZUQZl2sEuEF75iEJQ1/DdwUMSLLHUUW7AFP2uZ
         YAszGYH5uWDD9t5hmNfoNDDxku5u0BAwZ1TBo48Ce9gmUVOKuP0CX1hPIZ4E2Yb5Kwh7
         BuLA==
X-Gm-Message-State: AOAM530Klcji0GMupdqxjHZEJhg+0ETIJjmKwbzz8liMM2JcQPAfHv2f
        9brfyh5jHutTNjW+KCbmSXQ=
X-Google-Smtp-Source: ABdhPJyqvWmyEtSNhauUsBE5HJ97LsiACvw4Ii9Hd2so69stSp1QeaQb5AVx7KKSl3+Uqic19cio4Q==
X-Received: by 2002:a63:1312:: with SMTP id i18mr23039279pgl.142.1593019816511;
        Wed, 24 Jun 2020 10:30:16 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id z11sm21187215pfk.141.2020.06.24.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:30:15 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v1 0/4] drivers: ide: use generic power management
Date:   Wed, 24 Jun 2020 22:58:53 +0530
Message-Id: <20200624172857.60915-1-vaibhavgupta40@gmail.com>
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

Vaibhav Gupta (4):
  ide: use generic power management
  ide: triflex: use generic power management
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
 drivers/ide/delkin_cb.c       | 35 ++++++----------------------
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
 drivers/ide/setup-pci.c       | 28 ++++-------------------
 drivers/ide/siimage.c         |  3 +--
 drivers/ide/sis5513.c         |  3 +--
 drivers/ide/sl82c105.c        |  3 +--
 drivers/ide/slc90e66.c        |  3 +--
 drivers/ide/triflex.c         | 24 +++++++++----------
 drivers/ide/via82cxxx.c       |  3 +--
 include/linux/ide.h           |  8 +------
 32 files changed, 65 insertions(+), 154 deletions(-)

-- 
2.27.0

