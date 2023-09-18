Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE6CD37B0
	for <linux-ide@archiver.kernel.org>; Mon, 18 Sep 2023 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjIRUZR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIRUZQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2023 16:25:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF626114
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2023 13:25:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50325ce89e9so1085928e87.0
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2023 13:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068707; x=1695673507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fyf1MByTyYIqOV14i5n7qtJNDGQcO9Hg7V0y6z/yas=;
        b=edC/eJjIe5kDprh35dDJn8sjuXOtP3fdc/ElaqyKMpS95nXbjOI0q3qiDzbm1NjHfg
         IFEApFAn6pNXeERft8Y7DH62ZwwJgP+tYqo7VKNp7ke+HW1JBKiLz+m5hXj3ag2EOsPF
         3/RODDecRGnyVaAbVOiLQ6g0QJYij59Z4mcZpSMsUGNWXPEz0CAGq5arEaTzzpLs8IyE
         N+hjQJJ1weEmF8Jfv8qD8vEvek8cUOTywfzyADl1Pd8rDDsVrNX2w5B4Q1fhONq+F5jm
         3/KDXeB3fS4YWlWKcVh7fU1rI1TlZKmkq5S9tSJ/+UQoHbL9axidB9PJ1bSqHoBrCA6u
         PylA==
X-Gm-Message-State: AOJu0Yym6QuwtuChD6tzZV5vbAJ/Y37armcbTiSmHWcBECjbJe+0Pbsc
        nurafliAuibmuveF9SD5phYy8wIb0gY=
X-Google-Smtp-Source: AGHT+IE9xNrw8C7H8F9oss9XM3S7yFmTd9QPwf+IYRJ+hFZtamwXExXLXAlUChwHQrL++PdqH83IlQ==
X-Received: by 2002:a05:6512:3144:b0:500:bbd4:970f with SMTP id s4-20020a056512314400b00500bbd4970fmr8076895lfi.5.1695068706533;
        Mon, 18 Sep 2023 13:25:06 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id a28-20020ac2521c000000b005008cd93961sm1943302lfl.192.2023.09.18.13.25.04
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:25:05 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 48EC5B9ED; Mon, 18 Sep 2023 22:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1695068703; bh=ZttXkeYTvpHUObuSkg6+y978YO6qRJEBoOKcoOCDzUs=;
        h=From:To:Cc:Subject:Date:From;
        b=sFWPysnhC/tK/WHkj9+EQPwEvr1mJzgwC2Q/Ruy04dh77LmOP8GKDbhtaerobm5vX
         HDF2zcuokwz2HHQ4D9RE7z2jk8Tax4qTmjdPt++aumv4bc/RdAK+pNLykKfpDfUeu2
         /JTx+Tnj44B47/YzV5xKiMUolkhyeZTpAZIV+5hk=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id EB1FDB98B;
        Mon, 18 Sep 2023 22:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1695068698; bh=ZttXkeYTvpHUObuSkg6+y978YO6qRJEBoOKcoOCDzUs=;
        h=From:To:Cc:Subject:Date:From;
        b=XQk/4fTOYkSJUNZrxgUyiJvkxnukIs6n5GYfD3ft/ShJmP0FF2Mf4hpCx4UvvW/C1
         HjWsoV9enw4wOBSNGBj84qmuaR9Wh5yIdYkyctF3inNWTH9QM1m1/q2PQVcS8rqQF4
         jJRsm1hvOCLtBeEJxHHBj6P8kBdOiZHCyJcBZs6o=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES
Date:   Mon, 18 Sep 2023 22:24:50 +0200
Message-ID: <20230918202450.19635-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

For REPORT SUPPORTED OPERATION CODES command, the service action field is
defined as bits 0-4 in the second byte in the CDB. Bits 5-7 in the second
byte are reserved.

Only look at the service action field in the second byte when determining
if the MAINTENANCE IN opcode is a REPORT SUPPORTED OPERATION CODES command.

This matches how we only look at the service action field in the second
byte when determining if the SERVICE ACTION IN(16) opcode is a READ
CAPACITY(16) command (reserved bits 5-7 in the second byte are ignored).

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d3f28b82c97b..fb73c145b49a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4312,7 +4312,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-- 
2.41.0

