Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1EC4332E
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D06164E56
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhBAOmd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBAOmC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:42:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7BC061224
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:40:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o5so3207830wmq.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZQZ2+RpbHKZWQO23K1r/ewrXGBIiSW5L8ZHxuWPrs8=;
        b=xmgCh16HvTuwSIDl5iaFrhej4lliLPb1/BAdCNM/4oGwvBx0dXS74eJ/pTA2+zLcKF
         YeGTByROdLeXKb8VBwPsQNK47AZB2dFO8HW9a270MFO9IEsEkkOY7S9YrC7YRLNoLGv4
         vnAAWpgX7ie714uBfKY1FzVEbgP1Az2DlMsVLzA2d0MuTmclo4A3D3MucgxrK8yXZ0cS
         0IT8ZbUp6D4pfkV9A1Bst3Oed1rx/MfN2RzzUdjP7KXf9+letuhvsGaLUPF97DhIePEl
         GMMON83O4v2QPudunlw7MkvT9u4t5DQaXDd/ivJcTFPkkTo5L8bbloek5K4Mhxb1lW+V
         SzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZQZ2+RpbHKZWQO23K1r/ewrXGBIiSW5L8ZHxuWPrs8=;
        b=fUX5eOD+ZiH8hMdsfBhOvtGXzomNH8WEM+O3Q4Xl2kZC6VGtJmH7w485QHy7iQzxau
         Q+e5AW05gfxx5uPKzP8vRnveTIcRAfWlakOFkijdvqbov07sJDYVfLcVTdvVapokpzub
         EL3ESa5WJ7ZihUZFs2IzSag4HH+OubCRb5S2tBvjBIjbQWeXKP76e/HJqaZ9QEDHjIV2
         AaF/vYKje+pNJ5a9PzMpWF1RqaigyR2EIjHse1iaQHFqT1aPF/E7i/32tN/b8pkEbrV0
         /zhyisHX8jYx4MD/ESzOawyjA0W+oUzkZ3SHJivmdvdA7sEQnZ6PuId4SWFf+/5UcSrZ
         HPIQ==
X-Gm-Message-State: AOAM532bNjwA30VV46sGL7+gyc3OujWehUzjmxNrVeZx8E/0XMCavbmF
        vxXhK0m1vyDfShvIZPPjWTUN2g==
X-Google-Smtp-Source: ABdhPJwZ0G6ijrnEYSz7NgxKOh/BkCcPUmv/6NSvL43tf/tSWGXYgq+H2fprAKcMsJcJ7tFRP9DRzw==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr15142721wmf.120.1612190400345;
        Mon, 01 Feb 2021 06:40:00 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 15/20] ata: pata_cs5520: Add a couple of missing param descriptions
Date:   Mon,  1 Feb 2021 14:39:35 +0000
Message-Id: <20210201143940.2070919-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_cs5520.c:61: warning: Function parameter or member 'pio' not described in 'cs5520_set_timings'
 drivers/ata/pata_cs5520.c:257: warning: Function parameter or member 'mesg' not described in 'cs5520_pci_device_suspend'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5520.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 9052148b306d9..d09d432d3c442 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -52,6 +52,7 @@ static const struct pio_clocks cs5520_pio_clocks[]={
  *	cs5520_set_timings	-	program PIO timings
  *	@ap: ATA port
  *	@adev: ATA device
+ *	@pio: PIO ID
  *
  *	Program the PIO mode timings for the controller according to the pio
  *	clocking table.
@@ -246,6 +247,7 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
 /**
  *	cs5520_pci_device_suspend	-	device suspend
  *	@pdev: PCI device
+ *	@mesg: PM event message
  *
  *	We have to cut and waste bits from the standard method because
  *	the 5520 is a bit odd and not just a pure ATA device. As a result
-- 
2.25.1

