Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511ACC433E6
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1AA64E9A
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBAOma (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhBAOmB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:42:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F3C0611C1
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f16so12847282wmq.5
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJaD217hQSKXajKZh4odA4Ej+1+v0RwQsiQWigDD874=;
        b=SG05VYxhmiATV5Ec3tvOkXLMrtpO6V14Fm3Zwv0mZhiDBH4OZFX5TaUa9sOHOjC+Tu
         d10ZRrDCUN6tUnyWCTknGMLanH76OlM07HYXalx1cPDtjztamew6UjyupxXAgpe9Uj9b
         RHsaF6AvlaoQbyIJqOYIfVBlVOFAFLYmn4fWjNmb0xG4/DIdg2fjrkeIj9vIgRJpolOu
         029hZeLOkgBTeWwhiStraalAbZ2mGo8Qm7kKukpgOTgMvkBpJPf0fqvLtsutVVvIR9x4
         wpu3bCQzEOyj/tv/aaZEjLyuRyU1lcHSQHESU/XWfFbDAsc6l/rK4Xtla45p1qX84lI1
         nzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJaD217hQSKXajKZh4odA4Ej+1+v0RwQsiQWigDD874=;
        b=pHbvdokrccvXPbrUCsdQVu3SMW/18yf/EqTe/Nls3x+zW0a8KW4cJzmrRPEuCkqniE
         aFTGfyG/FluqJp1XUTNxbYsDr4mskNWZ1EdoZX832UktW4gn9XZTxJG6pZnhAELvPt/o
         qpVUhMfMgJwANt2/mESHUmSIVA08W5WyFgJ/az9cQBIDO5LYk1wRSHJPyZOKr4tG+h37
         kT2eXZzoCcjcFB1oe2E0nMOpOr1ZFzL21jatSNcU0lmeEx2MvQh7/QNJc4+vcdIYQ/F6
         +PSixcS+15w7DDeCsf11RyUsqfT7Be3qhZ0qXTJDUwUKgAbo/kzgoQV3Cl0El5XdluKL
         rBRQ==
X-Gm-Message-State: AOAM533iSZ4QX9UIROTlMMNnhXRKgVTYCw7Y2T1w7fsBvswhCH8XNQNz
        A4QWhXzkXqnlejT1rnPwLYZXEg==
X-Google-Smtp-Source: ABdhPJxypag9z0BgoaEL/svkoZORBrkuDUZgll+5UCqGmWHIy0AIcFk/35ta5jgAWFKrNRwwoacCAQ==
X-Received: by 2002:a05:600c:358e:: with SMTP id p14mr15081905wmq.73.1612190402700;
        Mon, 01 Feb 2021 06:40:02 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 17/20] ata: pata_marvell: Fix incorrectly documented function parameter
Date:   Mon,  1 Feb 2021 14:39:37 +0000
Message-Id: <20210201143940.2070919-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_marvell.c:125: warning: Function parameter or member 'id' not described in 'marvell_init_one'
 drivers/ata/pata_marvell.c:125: warning: Excess function parameter 'ent' description in 'marvell_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index b066809ba9a11..361597d14c569 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -110,7 +110,7 @@ static struct ata_port_operations marvell_ops = {
 /**
  *	marvell_init_one - Register Marvell ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in marvell_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

