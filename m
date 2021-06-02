Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29768C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BDA613BA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhFBKUj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhFBKT5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B3C061350
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j14so1721047wrq.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O++OUhPnombOqG4IjFy2Q1V542JLHmoGcDivLsFbcQs=;
        b=ENdVDcJ7hgcy5xRlPjOOnB5DPqcJ9+dvg90YDBjFZ75E0zsuv8ZJhzbszxzoZenlRN
         aPhKCc5jmqEX8LHBb9AlpT68BAP6QvNx7dHAmeZCV6ZQ359pjZCKd3hX3VG4LZJlxKTB
         rP/0NaUH/pCrN6WlSwuxr1cfUcJXyD/0L8KKdHFVsE9DfzyB1j3vermBVtvq8/RdUVDw
         MzJH011vXEgSYCfztXRxTW7KOB8CQ3cH2AEzhYPcTDFMeZSsvzLBDF6EBuAimORLzRhf
         tWzs0s8WMAtZPiTjejpmI3biH8RvRx8l+VVI8is54w6w7LAn8pmMhO2+qX9uBbPN/EuF
         AUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O++OUhPnombOqG4IjFy2Q1V542JLHmoGcDivLsFbcQs=;
        b=TUra11SUI5+yeftDoDvpIzB2p661wYghLK+H4xT43+oKiuiGNJK3Es9XcG4RnVxpOC
         MT9DmpUYkoEXTF7A0iycoFMbX0+7XUCIlUeg5ybpsJWN4qvQ05/upTTmnemjxQv+qR27
         ZSOySz/AhewN0o5QZzHfzqtac7EQRmpY/dxyvsVi5IrCqZuAlpLiZijTd2E23j4jBsO+
         js0uAeJd8KkFiDuAR30LGvaMDwpmAUk1VxIKK8mHxlIqSKaAaR/xC7MWzsKWpBBO29U3
         9VULdk9D7HUPl0n1GJnAdwBaUYxS4Gogu7OzeU0N89jLp9WOztLAReNYiZMvjc6tJ39l
         xaEg==
X-Gm-Message-State: AOAM5308xI7l6arXKXT8OEY6A5ITacD85GdEo2ZwY2V4v0HYkG+3iXT7
        Nh/lYaZJluyw9Yyt0Qka20xR6w==
X-Google-Smtp-Source: ABdhPJyw4df+1q/Wbu7sw08ZGjECOWBii9wPOGpX7cNc/QnKCMyFaE6vqJ3jJmo9DWrcbDVvM14ISQ==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr25857039wrc.142.1622629072927;
        Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 20/21] ide: ide-acpi: Provide missing description for param 'obj_loc'
Date:   Wed,  2 Jun 2021 11:17:21 +0100
Message-Id: <20210602101722.2276638-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-acpi.c:229: warning: Function parameter or member 'obj_loc' not described in 'do_drive_get_GTF'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 816ebbbf699b5..fd80789722bbe 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -214,6 +214,7 @@ static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
  * @drive: the drive for which the taskfile settings should be retrieved
  * @gtf_length: number of bytes of _GTF data returned at @gtf_address
  * @gtf_address: buffer containing _GTF taskfile arrays
+ * @obj_loc: placeholder for return data
  *
  * The _GTF method has no input parameters.
  * It returns a variable number of register set values (registers
-- 
2.31.1

