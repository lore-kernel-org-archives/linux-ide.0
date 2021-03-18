Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B78C4360C
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6224864F3B
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCRIwR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCRIwC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 04:52:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB9C06175F
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2849920wmj.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LSRu3B7vTOehIF+pPi+UNH/SrfnJ26bQ8jJ9MYE7/g=;
        b=PNjjaiEovLZUonRxnIGR3ImVloNSF8ldt8dyaCxBC28aqjKAs/a5DKAZ+N59fzdauZ
         y6m3IBNONcOWwWtX8Fby+/P2l/Pzh0OFUZeiiW9CQH1yr4WlbgVD2vCa+Dja8GFVkU5p
         i6TPratcgwrM0szQJuHbqAxm/n6prU8nimMjbSp9CZGAmS01oZIGuqpqtIdZWAlKPRy6
         9Q9zfsRROdM6T+jFl/dKas9kSn8n9Ugn2zLgJixA80jYp8fQ6Cwl4fwSyfuY13hn7KxS
         4U37PDUXSpSvP28vQm+1lAUpqPoi4abMoRdlD5DfjR2SgkNTDxq49dyIulJT2pzIsi95
         l23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LSRu3B7vTOehIF+pPi+UNH/SrfnJ26bQ8jJ9MYE7/g=;
        b=IuejPGyjyaCrUYP1prDfQKnqqy/FUId1QNSZr7kqDJ3dL9U8tByAs+h/+d0gEtC2Aj
         lONILk2nub12wGQit6W1H7uprnN4t7InzlxJVfDHzEwnwuGy79e8gYjxN38O6DH4IwW2
         Sxa0P7igZBZ3Fza9asLINDx3G8z7+AXqF0MuDtMs3x6aDWkSfRc+iLV22LWb23TVR9/1
         +Gpu8bdknl1pw37+vnGMRQmvKEblz55kV3B8ops8tkvTuxKjBWju72/jrHVKpk8S1Tfp
         /Lb+Q6mSE7bphFJU95VpAqkVpdBqg5yiRYSLK7p5MPIG8e2COMtzSTkcEHKX5Fqhf1c+
         T3XQ==
X-Gm-Message-State: AOAM533LCUcFKKxOUFR6Z1Wfgv5AyQnU23P276YRGT2x6SKWMjsnUWZh
        pRHJpQffis+fI1f1jOI2FhqztdjbkAZWmQ==
X-Google-Smtp-Source: ABdhPJwxfsmQo8LTvurXnGpxqnAHfbVwXbRto0zZJmZy7QI/jBR+MV+eJWV7QIMprPIybvud/h50pQ==
X-Received: by 2002:a05:600c:4ca9:: with SMTP id g41mr2556836wmp.150.1616057520550;
        Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jaromir Koutek <miri@punknet.cz>, Jan Harkes <jaharkes@cwi.nl>,
        Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/15] ata: pata_opti: Fix spelling issue of 'val' in 'opti_write_reg()'
Date:   Thu, 18 Mar 2021 08:51:44 +0000
Message-Id: <20210318085150.3131936-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_opti.c:82: warning: Function parameter or member 'val' not described in 'opti_write_reg'
 drivers/ata/pata_opti.c:82: warning: Excess function parameter 'value' description in 'opti_write_reg'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jaromir Koutek <miri@punknet.cz>
Cc: Jan Harkes <jaharkes@cwi.nl>
Cc: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_opti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 06a800a3b0706..01976c4e40330 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -69,7 +69,7 @@ static int opti_pre_reset(struct ata_link *link, unsigned long deadline)
 /**
  *	opti_write_reg		-	control register setup
  *	@ap: ATA port
- *	@value: value
+ *	@val: value
  *	@reg: control register number
  *
  *	The Opti uses magic 'trapdoor' register accesses to do configuration
-- 
2.27.0

