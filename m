Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1261C4160E
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38C064F3B
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCRIwU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCRIwH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDCC06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo2828467wmq.4
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRryIhNUKwY1QYHRIg2sGv85PaIDusUy0ZBOcz1fZQo=;
        b=DUUigHziSClduf61W1BDu9G+kg9n3s8DvQle1mFQ4sOdNetVpq5lyMJ7Hq3VbbXz7E
         y84mzWnh2OP6GNb7qnpSDYgDRCzZdxxIHmeAab6v4OJfhG+gkVZALKG7QTiFr3cofUxU
         +suMHKqSr8XogTRoVqH+CJi4mPU4nVRA/9h05QkCxEWCjBrn2n4xqq5hadR4ohImtXaH
         PMcrrZQvS9X+kDxrqAr6JvLKSK3vnMUiZ/9MIw+5AfO0OjWnEjEZThLCtpsBnvqcV1v+
         k6i4NiI1PMcFOh14P2ByM5BqyotkR1Ig3mcBCJn7nmF3V6KGZ+uqrIajVVkjxb5jbjpH
         cZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRryIhNUKwY1QYHRIg2sGv85PaIDusUy0ZBOcz1fZQo=;
        b=F+zeNi+HkM4qvfFknADuZtDJfGkoB8jGG43xgl+3G5ioG8vyXGZcmRktVdTB0U2m6s
         WE0lab9lXkSeZXdmIlyrnSa9tjAJXu+qYA58/eiaQVsIvsniZF8Kvm6Kppd8avclpkJF
         R6vAAIkE2svzmXqdOshVd3wg+IdBi4YDlYzvixpXWsE6dGNb5yopcHn1gGr5HNW0RA0/
         bYavHQjt8xygo443/Qyee2iv1FR+diwEybVYIYvdwtsgGx55+RJHY4JX0HekQaIAiPV8
         0lNKx5VcaNouz/Ixboo6LHOtnNi/DfaUWrk62eGP4m6pxFIKSQaS+dYJuobvTYHjGhtL
         IgGg==
X-Gm-Message-State: AOAM533EqC2gPHlyf8DRAVgg3mZK3KL7TY9l9G1FJ4jfQVZQr41A7EpL
        JB+VpGcNFuTcbjiOeRDtn4A8ug==
X-Google-Smtp-Source: ABdhPJw2I2wmFHMlXj5ytsp5gjkUQJyefdh0nS4u5Qour/ISlcXWVPy5BA7e3K7YbbVUBJruqfZ+SQ==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr2520548wmg.33.1616057525892;
        Thu, 18 Mar 2021 01:52:05 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 15/15] ata: pata_acpi: Fix some incorrect function param descriptions
Date:   Thu, 18 Mar 2021 08:51:50 +0000
Message-Id: <20210318085150.3131936-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_acpi.c:38: warning: Function parameter or member 'link' not described in 'pacpi_pre_reset'
 drivers/ata/pata_acpi.c:38: warning: Excess function parameter 'ap' description in 'pacpi_pre_reset'
 drivers/ata/pata_acpi.c:74: warning: Function parameter or member 'ap' not described in 'pacpi_discover_modes'
 drivers/ata/pata_acpi.c:74: warning: Excess function parameter 'mask' description in 'pacpi_discover_modes'
 drivers/ata/pata_acpi.c:239: warning: Function parameter or member 'id' not described in 'pacpi_init_one'
 drivers/ata/pata_acpi.c:239: warning: Excess function parameter 'ent' description in 'pacpi_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index fa2bfc344a976..ade4c3eee2304 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -28,7 +28,7 @@ struct pata_acpi {
 
 /**
  *	pacpi_pre_reset	-	check for 40/80 pin
- *	@ap: Port
+ *	@link: ATA link
  *	@deadline: deadline jiffies for the operation
  *
  *	Perform the PATA port setup we need.
@@ -63,8 +63,8 @@ static int pacpi_cable_detect(struct ata_port *ap)
 
 /**
  *	pacpi_discover_modes	-	filter non ACPI modes
+ *	@ap: ATA port
  *	@adev: ATA device
- *	@mask: proposed modes
  *
  *	Try the modes available and see which ones the ACPI method will
  *	set up sensibly. From this we get a mask of ACPI modes we can use
@@ -224,7 +224,7 @@ static struct ata_port_operations pacpi_ops = {
 /**
  *	pacpi_init_one - Register ACPI ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in pacpi_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.27.0

