Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA5C433E0
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0018A60233
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVIJO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCVIIp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2021 04:08:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5CC061762
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so7985046pjq.1
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceWIJkraNk4zg/iwScfPX26TgRjVfcMLFyh1eZXV7JM=;
        b=F02NqvEbBpYoGKlemzhDNLk9mqNsPvWGB9TA6POHCKFxPBRmHqbZO/hyACWUFXEMca
         DK8ysDpNm2HNfxe4Hb4d6QNWQZJPNnK90UFjGXokbvWWi/jKwnbFgoMu9VbTpie17ri/
         eKv6AcVz7tbsjehrxEgC54JVsXHUQjWJlx1FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceWIJkraNk4zg/iwScfPX26TgRjVfcMLFyh1eZXV7JM=;
        b=kov1XXwT82ZivTtYaCl72HtaxeGRjtlY6n+QjY1gf9LfJmAR2M9sKmikuWrZRRl8Hj
         tdeBZOQ7AqvxgJoZirWj7h3yqsnFwGPZ8320aDKdsA0gMI5M2ZxgMAUrpAdeWZyknwXe
         Mgbs7LJPyFuam8JxvMnEAmXwrWA/uLTt51wfIZ2OSisLUZ0P+6I6fKnAQct1rmPOqDBt
         HnSR8HONh6k5O14ShxJiO6dAv5sXi3MwnYaWO0OAqHCTkXz+y3ao9CenI4QFofIPFXrn
         dTDHojrpGpdHgFn5cox/Pl0AuBG+ITTeINAzwMRAJ7kwWb8v+NnKMqQiVxupajEt4tPT
         EeRQ==
X-Gm-Message-State: AOAM5317nvEGrdlPEAvsT3q8jG+2z28YHU89YNSwq3WJsD3clDvGd7aG
        i7AzJLcVxPDw++aKPO3PghwXXL5NRQP9cA==
X-Google-Smtp-Source: ABdhPJzDbk6X4pTI4NCXvkM612xhOhHrbwRVTIoCm/aTaD/AVaVovzaw3xdN0IxHMI2JiEMk5/b1gg==
X-Received: by 2002:a17:902:f20a:b029:e6:6d5b:88bf with SMTP id m10-20020a170902f20ab02900e66d5b88bfmr25942464plc.13.1616400524649;
        Mon, 22 Mar 2021 01:08:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id t1sm12960867pfc.173.2021.03.22.01.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:08:44 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/2] driver: ahci: Disable DLPM on Fizz chromebox
Date:   Mon, 22 Mar 2021 01:08:38 -0700
Message-Id: <20210322080838.1640805-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210322080838.1640805-1-gwendal@chromium.org>
References: <20210322080838.1640805-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Chromebox Fizz platform, (HP Chromebox G2, ASUS Chromebox 3, ...),
hard CPU freeze were observed when the SSD DLPM is engaged at
'min_power'.

Ensure we can not change the |link_power_management_policy| of the host
controller connected to the root SSD. (Operation not supported).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 No changes in v2.

 drivers/ata/ahci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9132201f1353e..4b932bb4ed570 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1270,6 +1270,12 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			 */
 			.driver_data = "20180310", /* 2.35 */
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR, "Google"),
+				DMI_MATCH(DMI_BOARD_NAME, "Fizz"),
+			},
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.31.0.291.g576ba9dcdaf-goog

