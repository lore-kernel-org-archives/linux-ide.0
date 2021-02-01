Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18653C433E6
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA88464DE1
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 15:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBAPdC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhBAOle (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2FC06121F
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so16864621wrx.4
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMe7a3VhppfmWxSaJ9lM7zaGZfgpPGsI1NmH6z3NMlY=;
        b=BcdbDpUnb48xUjDHyx+e2GZVxndB7U/KUWaPtWTaDHqFfJbSXUNkZHX++3YaFlDs1d
         v4DqOQnLLK8V3qLaJWQ8mfTuEJLc/FiVzS01Rgxw8mZdHae27NwDTTxbRCpnNJKTNzAZ
         Oe3naI2SbGdvzXzxewWpclopEeQe+VzbtaOSpOi0w2GZ+Q+wP6OLNMro9W1BnDqIXC71
         fHgWMMnQpBNVQnN0RTDJCbm8zSM0KPdM08gD8f07e52K4Tod8/nYPrcOqdqfo3C1djTc
         aU+oCj8RhJvWpun80Sg1GZRyIsl5fFCT4PzDE+m/S7OTTqLS9/dxVC+2GWDOWfCcmxvd
         kIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMe7a3VhppfmWxSaJ9lM7zaGZfgpPGsI1NmH6z3NMlY=;
        b=ro17x7soKcoSfWu9KD2YUi8clRsd1q7cMJUkMtwQ/7izcY5bZnTaxnWN0czezGIHHG
         cCUxDSzGrJFX/BQLVsYyqCLgSinWh5k67g4VTewM9h6QCQuJEHN5JK17lnVsEDnO9Azz
         FImpp0alRc+I6Xzsqd67SCq0fbIRUb4c0g+erR0a88Dako7K7IZyq2P+I2ldG7d3Lun1
         rLr6qXd1phsGHTodBMUpaTbmkqVpfYirmtdAdReQeca4hcWcF7Vaajg2qjSu7et3OojF
         y57AuwYkMYFZ4kJlVbW+DmsSldOq1cDEihPrsz0F2mRUCweCNNr7fapwHuIrwMDQhuQJ
         gh+Q==
X-Gm-Message-State: AOAM533+NCyadb132ITGYJ+giJ2ulKwAz2X4sw0SzAmzprwar/urZ6wH
        6qfLuXBCSwQY7LQoGyjSpOiscg==
X-Google-Smtp-Source: ABdhPJzeOP1pJu5xl/+NmIPMfTjbgeyKY82fMKBoQz6WDykeOZ8f2/+1+uXUaS6hiuxPKbwonPdTBA==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr6891636wrx.328.1612190397886;
        Mon, 01 Feb 2021 06:39:57 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        linux-ide@vger.kernel.org
Subject: [PATCH 13/20] ata: pata_artop: Repair possible copy/paste issue in 'artop_6210_qc_defer()'s header
Date:   Mon,  1 Feb 2021 14:39:33 +0000
Message-Id: <20210201143940.2070919-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_artop.c:278: warning: expecting prototype for artop_6210_qc_defer(). Prototype was for artop6210_qc_defer() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 02e4fd5e3b934..ad3c5808aaad6 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -268,7 +268,7 @@ static void artop6260_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	artop_6210_qc_defer	-	implement serialization
+ *	artop6210_qc_defer	-	implement serialization
  *	@qc: command
  *
  *	Issue commands per host on this chip.
-- 
2.25.1

