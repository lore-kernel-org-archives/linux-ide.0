Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1C8C4338F
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1622C60F39
	for <linux-ide@archiver.kernel.org>; Sat, 31 Jul 2021 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGaVih (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 31 Jul 2021 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhGaVig (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jul 2021 17:38:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8800C06175F
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so25735075lfj.12
        for <linux-ide@vger.kernel.org>; Sat, 31 Jul 2021 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1s2gp+Z0A+42wMyMuLTufRoIAkb04D7YA7vr8UMT6UM=;
        b=zZ/g1t1osZgQctQuobiLT625UqjXeKdwYeXz22SbvpVDw1MpB7tnuq7Uj7XCuSFVDf
         6PJ4Kg+mywE8RkEH5gC/oFfraLLlhQwAzUrSKwiNuA2W6VE/PdRhWGw99KOirVTy7Eh5
         3VExEaeudIWXxaLdClUDXG6T9T8tKQbDY9m8ImCXbcpYOGqqIGMUS+ga6oKG/V1lpfmI
         mD7D4dpX0abjzLDCzUeNe3RbL8b4NLHv8nXJcU96p+kxMBvx12I4sipShBH73vrrIIFT
         A5tBHlDxpilsfBJEEFaIzcp9AGBhq0Tc7m2KpZrFB5YXwZhyxJMIEnbr1WSK1Wz9p02n
         iV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1s2gp+Z0A+42wMyMuLTufRoIAkb04D7YA7vr8UMT6UM=;
        b=IRF2I91IuhdV/dP0n5lTtUiUn60RL2jd4ACKKRhwXyIdeSWOPUMFb1ES784St625oK
         F7gTUmSm9ioKwU89p8lXCoeCxDjT23m8pEWRndIxfJCmkouesZYft48RuBFrv9sCzTB5
         Nc7KO8/3IXTaZPTyOQclAJQ3NnZRKXsXk24Rc64eVHE/BdXg2RUDOzrZ7Njb1hxweLC1
         0o1DkIhPxwd3O2l8ZXxfS4ns8cLvFoT3r+2qr8PQ32034rlkq+1zCFWO7mTzDZSEUpzD
         G4kdskUU1PR9MA9VCMp2vcFVyNVgZjuqu7kOybImNQTNYmFyswFpiyQR47Rig4sMTWPl
         T+Lg==
X-Gm-Message-State: AOAM531PjxuSLFsvBy5E4GWdGLtKJhFjINb7StrMFrxxfELIjR8tWeqp
        OzFdza/NaSsXO/fZc7PxkJokyQ==
X-Google-Smtp-Source: ABdhPJwsHhKIULHtEBrNk92eDI/kXyQUBTX3ATT6nGpvZcj/b229z2rZHxG7PUKUCPOsk+3BkW7fBQ==
X-Received: by 2002:ac2:4475:: with SMTP id y21mr6511257lfl.487.1627767508262;
        Sat, 31 Jul 2021 14:38:28 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t17sm440430ljk.102.2021.07.31.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:38:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5 v2] pata: ixp4xx: Use IS_ENABLED() to determine endianness
Date:   Sat, 31 Jul 2021 23:35:52 +0200
Message-Id: <20210731213555.2965356-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731213555.2965356-1-linus.walleij@linaro.org>
References: <20210731213555.2965356-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Instead of an ARM-specific ifdef, use the global CPU config
and if (IS_ENABLED()).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
---
 drivers/ata/pata_ixp4xx_cf.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 23f0f7cacd52..bc5029d6525d 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -107,29 +107,28 @@ static void ixp4xx_setup_port(struct ata_port *ap,
 
 	ata_sff_std_ports(ioaddr);
 
-#ifndef __ARMEB__
-
-	/* adjust the addresses to handle the address swizzling of the
-	 * ixp4xx in little endian mode.
-	 */
-
-	*(unsigned long *)&ioaddr->data_addr		^= 0x02;
-	*(unsigned long *)&ioaddr->cmd_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->altstatus_addr	^= 0x03;
-	*(unsigned long *)&ioaddr->ctl_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->error_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->feature_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->nsect_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->lbal_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->lbam_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->lbah_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->device_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->status_addr		^= 0x03;
-	*(unsigned long *)&ioaddr->command_addr		^= 0x03;
-
-	raw_cmd ^= 0x03;
-	raw_ctl ^= 0x03;
-#endif
+	if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
+		/* adjust the addresses to handle the address swizzling of the
+		 * ixp4xx in little endian mode.
+		 */
+
+		*(unsigned long *)&ioaddr->data_addr		^= 0x02;
+		*(unsigned long *)&ioaddr->cmd_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->altstatus_addr	^= 0x03;
+		*(unsigned long *)&ioaddr->ctl_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->error_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->feature_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->nsect_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->lbal_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->lbam_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->lbah_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->device_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->status_addr		^= 0x03;
+		*(unsigned long *)&ioaddr->command_addr		^= 0x03;
+
+		raw_cmd ^= 0x03;
+		raw_ctl ^= 0x03;
+	}
 
 	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", raw_cmd, raw_ctl);
 }
-- 
2.31.1

