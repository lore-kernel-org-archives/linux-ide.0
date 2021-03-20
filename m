Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4122BC433C1
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FD26197F
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 03:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCTDlQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Mar 2021 23:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCTDkl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2021 23:40:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB26C061761
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so3820620ply.6
        for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2021 20:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X95aZVgNRGIwLqcQ8UA5WLNr+sNfsuVjI+l5mnSJwWA=;
        b=EerGc4l5obk9W416NNwM++d3y5fhgJ4WUMkDrMrATjhVW6IQ/e3+LSnqbkk+aGrdQo
         YPTUs7HALBNjxNPs/Fhvv26/BYSQXHXK9zv8CYpxJ7NpLf4tS0VPpB4kHp3doCTjNs1d
         ksQP4+cyZJdskZ7OiCvtDx4QMb5eVUv7RpCpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X95aZVgNRGIwLqcQ8UA5WLNr+sNfsuVjI+l5mnSJwWA=;
        b=qbtEZMLPPOcdNspXKanARAzNUDnxMgS16udljUyS4x70ehuShZTvfgN8LrnzM/piT/
         Ajqa8ASSn/O5ZpSpPWSYGiuaFwu9j4J+fUyiqQfNadlgTEvvso30ekUeNxFQD4gLDfSf
         j2LgkcyXhCnYq9SSI6P3/PXnXSghEXTyzi4uHFEBxQTkKakGAyzsJ3+vrAp3O4MoSXDd
         +PXPtJVwC7+6hYA/xre1Zkf0MfK0oIrw/zKRT3DGg+oqBGNrN8aRggewnl1wEx72JclM
         qxfu5x/oLhQUjtNNMf/QvOAmadAm5VqFLI9slquDYs6SBZRT0NmRuTsKwek+DyyEq/uM
         GSLw==
X-Gm-Message-State: AOAM5300sZ+jOkK7Yz4S5+aVw5slPShx3OYppNRGyOSqJ3MboBVHiVHj
        htARc/4vCc7PB8XElFwHh5y2Wg==
X-Google-Smtp-Source: ABdhPJzRG3a8JaRVv2usAVXD9RaBhgFBHRLC8ngjV1Z6GGG/mk1YHXtfBYEn8TKYbIqOWofBnlPb5A==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr1699092pji.103.1616211641238;
        Fri, 19 Mar 2021 20:40:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3471:4d7:22d:5963])
        by smtp.gmail.com with UTF8SMTPSA id i10sm11650541pjm.1.2021.03.19.20.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 20:40:40 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tj@kernel.org, linux-ide@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/2] driver: ahci: Disable DLPM on Fizz chromebox
Date:   Fri, 19 Mar 2021 20:40:33 -0700
Message-Id: <20210320034033.396854-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210320034033.396854-1-gwendal@chromium.org>
References: <20210320034033.396854-1-gwendal@chromium.org>
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

