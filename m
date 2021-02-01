Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC59C433DB
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C764DAD
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBAOsT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhBAOmX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:42:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F1C0611BD
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so16849975wry.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5vWVj1PxyNkZrXGNhPOfAFboUN5KZo8O3CdBy4NesU=;
        b=B4G7JSQdB4HA8+vgLEnKbugF9Ks5XEiRVYap9L6+9NSD+70VrhCfdfm7XnfeA2Dn15
         FuZC8w+qFLpr86V5MFxKi/66rZoqFvOwKHShk6axOBXrEb7qs4C0J0KIo5V4kiujlvql
         U9rY5/Envm5r/vBZ3LVjS7VGPvqxN+cXTIJuGk2N83ODoP72l2QuCJi48ly+JROj9ptR
         BfIeTExkdYJuCwedU75cYifeXxEqNlZM2YkOAk3lAEM7mL/Je4x3TwgNY6fB5Ofy2vXM
         1P/WNFhlit/SaOFpzYyCiwhnMqbZzlHuHZuSJj0PWKHjVXj7D/y/xE/da33gjtlpLkHn
         Qc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5vWVj1PxyNkZrXGNhPOfAFboUN5KZo8O3CdBy4NesU=;
        b=O8yfAklXtgdyEtxfdZWvsAAyYiNwEIp+/MKUjZNGLpBtym48HuAFBhvaeLyLHZ7yzD
         bYCG5NiVlEn2EOajSqbSxaHPslMFg+YchvxJYzk1559oR+Avoy0yNYhUUYssAec8RCCT
         D9FjYPmM4RGgk/jaKYjk/Mnoi+zuwQSl18Xde1fhblK+jPrUqV6ApUaCSB9aPiSxGLzT
         c00/kvX6Bh6En5njhHY8fBuSAPkiFbQ2yxsfNIoEyZ8U4cMGbeSTRLsd26YDSwZKZPkW
         R0NR4yUNll4ApcL6lvTV69UHZtUfgCr032xKUqixXd+u457yT69Uhkst+Fmxm8kln8aV
         Uv5w==
X-Gm-Message-State: AOAM533rGBVD7Fw5MyfL3DWYuLTBBQrfDJfHZ8RnWSi7SN16lVFaFFEZ
        M7JENwr3IJW6pL/nxhzsrH12/A==
X-Google-Smtp-Source: ABdhPJyHgmUqVQc96gVAt9CQolaGiQEbbEm8oddOV9JXaA61Fnhy21TVEPpeAq8fVb/tJI/+LbQi8g==
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr17869868wru.283.1612190404772;
        Mon, 01 Feb 2021 06:40:04 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 19/20] ata: pata_optidma: Fix a function misnaming, a formatting issue and a missing description
Date:   Mon,  1 Feb 2021 14:39:39 +0000
Message-Id: <20210201143940.2070919-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_optidma.c:298: warning: expecting prototype for optidma_make_bits(). Prototype was for optidma_make_bits43() instead
 drivers/ata/pata_optidma.c:319: warning: Function parameter or member 'r_failed' not described in 'optidma_set_mode'
 drivers/ata/pata_optidma.c:361: warning: Function parameter or member 'pdev' not described in 'optiplus_with_udma'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_optidma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index fbcf0af34924d..f6278d9de3486 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -287,7 +287,7 @@ static void optiplus_set_dma_mode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	optidma_make_bits	-	PCI setup helper
+ *	optidma_make_bits43	-	PCI setup helper
  *	@adev: ATA device
  *
  *	Turn the ATA device setup into PCI configuration bits
@@ -309,6 +309,7 @@ static u8 optidma_make_bits43(struct ata_device *adev)
 /**
  *	optidma_set_mode	-	mode setup
  *	@link: link to set up
+ *	@r_failed: out parameter for failed device
  *
  *	Use the standard setup to tune the chipset and then finalise the
  *	configuration by writing the nibble of extra bits of data into
@@ -354,7 +355,7 @@ static struct ata_port_operations optiplus_port_ops = {
 
 /**
  *	optiplus_with_udma	-	Look for UDMA capable setup
- *	@pdev; ATA controller
+ *	@pdev: ATA controller
  */
 
 static int optiplus_with_udma(struct pci_dev *pdev)
-- 
2.25.1

