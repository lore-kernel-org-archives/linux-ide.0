Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B44BC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FF8613D0
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhFBKUE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhFBKTc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF8C061345
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g204so903868wmf.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiECzVNIaAqnnDt6pnKwVNNPdqlT5g0qpNhz7Lhftfc=;
        b=CRC2LTSpC8iWLc8pLdkBi6pidI9fIS5qX+Bg0OXcSFn6ICsBqVeXNo/d/IJN+DTJrt
         WeAOuktIBnXDJCv8LGdQWD8DiAIPHLjTaGc0xWFog/WconDc5wK1XD2pH1hRMbSdUNBz
         GpkASXhYXd2bgru4ihU4Qi87o5yoNpr/RbPpvo/kkWn1J2WlH02iaGvHFZkIyTUtuZCK
         OQpN9df8bP4Y9mHAENecoyD8PYMLQfBblTo/S/lHPSn9nL55IteQAzbOpWgcyS7jB7nD
         azKYATo7wOT1jAXysZUcFWTevFpIcV9WO9J+k6XB+dNLQ1Gt7OlvsHcYylm8HwQ8/ER1
         /30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiECzVNIaAqnnDt6pnKwVNNPdqlT5g0qpNhz7Lhftfc=;
        b=OGyJaRcE08b1N/5e/8T52L8+HrKbTHxOPu1RzYgEEwVe0G1SvtdHCcwQOO6ZnuqYIz
         ILErvwXoLmIA0XwRQgGpGIdJKn/kOvZ78ZS/6Qa4BMOmyFLvezMDQxLM9Zlmx7Z5RzbP
         /nRld8C/wgUwwdjY2oMdk/g6zrTr4EBBlfe3CkDK3Xp8zd3/VVnea53JoCY2wQKKhSpJ
         KILQM7LjHHh/7qinFqc0wKbNoPiwhGumEnsJCpCGNbRa/e0QWaU3LOcbkPQCm63IP8B+
         lXXK2a+KnOLu2XTiWVaTqzroHKGe4GB+UrP06DMmRH0OWfRGmPrdEvO78VL8+JqpjT+z
         ruiQ==
X-Gm-Message-State: AOAM533qHatXKe4qcQhuvAsFl1C0pGZ7cAAcqxZNXXZ/rxhyC9VHO0V/
        cgcVNUI9k8EuXvfoJsajpq8KEA==
X-Google-Smtp-Source: ABdhPJw0M02WJo35W/Tt4aHnTpwkrficGrlEkPJpG93ilGGrvX/tTZ8xsqA1edgUt+kS33Y9oXo3LA==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr13479869wml.16.1622629062680;
        Wed, 02 Jun 2021 03:17:42 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/21] ide: piix: Remove unused variable 'sitre'
Date:   Wed,  2 Jun 2021 11:17:10 +0100
Message-Id: <20210602101722.2276638-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/piix.c: In function ‘piix_set_dma_mode’:
 drivers/ide/piix.c:146:8: warning: variable ‘sitre’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index 2634768a4e664..ede42d2a5b0b1 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -143,13 +143,11 @@ static void piix_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	int v_flag		= 0x01 << drive->dn;
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
-	int			sitre;
 	u16			reg4042, reg4a;
 	u8			reg48, reg54, reg55;
 	const u8 speed		= drive->dma_mode;
 
 	pci_read_config_word(dev, maslave, &reg4042);
-	sitre = (reg4042 & 0x4000) ? 1 : 0;
 	pci_read_config_byte(dev, 0x48, &reg48);
 	pci_read_config_word(dev, 0x4a, &reg4a);
 	pci_read_config_byte(dev, 0x54, &reg54);
-- 
2.31.1

