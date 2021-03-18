Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22267C433E9
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFA564F01
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCRIwO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhCRIv4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:51:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FFC06174A
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so2590632wmd.4
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dghe4e16SoJZePTTMhtOr9zN57JVN2TBb3j+pyrYZnI=;
        b=Vjptvur9A8fg9s/eoxmP7Ulmub4Ep9QpudaaWLCAfYjedBY84hELNAPgRRZ0vclPGq
         bZYj1i5znJ3n1+qkMIS+7EWfc3TkaW8D4he2a11w6PdcXmVc6anyErtgCoZC0dXMY57c
         I5ZwJACiZW1UyCCQrQScKEmBEteBPtaucq4g4YQG40ePt4zrj59kUKQurTyik5BfsKUb
         nWWUGXlabTfxvGDadFuiPy8A5xGQmnBu9dNPBSEmRjvsKkEWakZM9WOYcIMFaWm8YSn5
         fHGD80Ey5Aa2d1C69g3PEKMMC2jqk1AkjJC4n05cvNn9xqqglh9wY+aUZZ8psBc2gh8b
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dghe4e16SoJZePTTMhtOr9zN57JVN2TBb3j+pyrYZnI=;
        b=At0HIZtb8Ee6d4OzpJ9RpHYXeN8JnirvktpnmljRefV+hvML0/PPDACDPQC1OdzZEF
         pmYpltcjEI3dmE8Fk/EUUHjIsQySrofMBmtlptyZu4li4Q/acLK1h7cAO64JvKHr7M2O
         vn4pNrEfNTuYTKfugJbvZW4HWfKVdT7Xs7q8NpaXKB5YpUjAj6L1f4X4GzkFQWVy7131
         rk/FlDHIrfHnFATOWOXlCj7bl9Sfa8ye8+Ni5l5scT+X924HwjPuBDfJBnex2bzWthYj
         MLGlfqXMuIX+3rj1raJq65HqdFAznFLUmz4xa/tNJIDA7Urviqj9e1I3JYiWtjpj88Iz
         QNtQ==
X-Gm-Message-State: AOAM532bxsiHKBojCNeKzaa7JJH0ujKf3sc19ROo+dW1cZTmOP0gPIlz
        2cDIRUONHliX2Qy27APlmq1UzA==
X-Google-Smtp-Source: ABdhPJxV4SOmkvtOxdAg2Q9kzeDxw8pQQHQKkfLqG0n/47BzITWxw2YlmX/9vL/ntqDPgzeImTqpeA==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr2506388wmq.11.1616057514464;
        Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Red Hat <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 02/15] ata: pata_sil680: Add some missing function parameter docs
Date:   Thu, 18 Mar 2021 08:51:37 +0000
Message-Id: <20210318085150.3131936-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_sil680.c:68: warning: Function parameter or member 'adev' not described in 'sil680_seldev'
 drivers/ata/pata_sil680.c:254: warning: Function parameter or member 'try_mmio' not described in 'sil680_init_chip'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Red Hat <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sil680.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 7ab9aea3b6305..43215a664b960 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -57,6 +57,7 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
 /**
  *	sil680_seldev		-	return register base
  *	@ap: ATA interface
+ *	@adev: ATA device
  *	@r: config offset
  *
  *	Turn a config register offset into the right address in PCI space
@@ -244,6 +245,7 @@ static struct ata_port_operations sil680_port_ops = {
 /**
  *	sil680_init_chip		-	chip setup
  *	@pdev: PCI device
+ *	@try_mmio: Indicates to caller whether MMIO should be attempted
  *
  *	Perform all the chip setup which must be done both when the device
  *	is powered up on boot and when we resume in case we resumed from RAM.
-- 
2.27.0

