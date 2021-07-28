Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1609AC4320A
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DC360FC0
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhG1JEy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhG1JEx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jul 2021 05:04:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8064DC061757
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d18so2592535lfb.6
        for <linux-ide@vger.kernel.org>; Wed, 28 Jul 2021 02:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8Kf3bJVsFxGxcNbJs16/QeLrm2c8RvjSq7a7W3W4Mc=;
        b=EoXHY5nQlqlMIQMFDFRIm4xHWHDS1wm6yGyxYKQ8BGxVEja9SqIozH6dgoN1xjtIn3
         uBF365hkjOLkpJgXbhCEjw3DrbMVgNj/D03H6dAh6ShyAwNC11WsEj9Sy39uVGJ3l8VI
         ojDoE018vEaHJtx9/3M1Q5wKJo4ejmWtDEnt4MKGlHWute1HONRR4NvL0rEo3/YP9cCk
         HtKR5CfaUX6BeE2XUJt6jVPOwmVOi4bkPVtKt08UFxUUsWOHgZLSnIKiUAamqsmldPZN
         xDa5CdDF1auZWUXjpkRqAftI2enQhbRLnKfOP4n3DXJqcT+CNvApjWH+Je8DgsAfKCmB
         YV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8Kf3bJVsFxGxcNbJs16/QeLrm2c8RvjSq7a7W3W4Mc=;
        b=sX0GjRpl/NRqFeT4aFFRJ91zUrQLQ86cujRQOz8o68h0Rqy0WxzXQxCd/1TQLrwX+W
         5TfFzKahW//2VAwTnsoGODTqheH7ISnCHvz3zhbFr7oQ9NKt06SQKwZ/ExG8SU/iOGe+
         TjNTEauLeoamrUOotMUj+9Yn/oH+Z3SwkFFZVsDtr9/2Zq5Xw/6LnxBwBb/kBDFM8YYW
         aDpwNfc2MlyH/uqeb6OVfBsWVZpmJBPC0dnZM68w17sKjPFvKus30WSIH9X5TmCUL7vY
         SW1DrYSlvgVzNUqv7RAmuq/oCHKvfT1k9GG7HHdxExLpWDPA7u6HJ/IPSkpdvCvAvKEi
         lRBA==
X-Gm-Message-State: AOAM530izg2e1rEAYaF4wLGNhCCxYTo48BWtPJRmpFmzqOSK7glGtwQ4
        PqW+5Eiwg2K0mcHShh8ta3IWzg==
X-Google-Smtp-Source: ABdhPJwegtpEsG+OHXuMzO5YOXtSQOCaHq51mVY7by3SUgcUBlK1y1VSZMmjGZrBtQkSp/TZBypwHA==
X-Received: by 2002:a05:6512:3d8b:: with SMTP id k11mr8170335lfv.599.1627463090867;
        Wed, 28 Jul 2021 02:04:50 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d9sm505495ljq.54.2021.07.28.02.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:04:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] pata: ixp4xx: Use IS_ENABLED() to determine endianness
Date:   Wed, 28 Jul 2021 11:02:39 +0200
Message-Id: <20210728090242.2758812-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728090242.2758812-1-linus.walleij@linaro.org>
References: <20210728090242.2758812-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Instead of an ARM-specific ifdef, use the global CPU config
and if (IS_ENABLED()).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

