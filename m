Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96209C33C9E
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF7620717
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP4YQAdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgAQXxb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:53:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47093 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgAQXxa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jan 2020 18:53:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so10474847pll.13;
        Fri, 17 Jan 2020 15:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PG/DpwgudfX9+wNQUUHhUWviyLZbkMRXOAK/nS3Dn8k=;
        b=CP4YQAdzrfFAhTYl0zjvup0HQhSkzf00ZY4Qpwm14ReJ2bsiieb4MnwKpb+J8TcmTE
         IbyxOa7WI+CjoeIyauvu/fBo5KA/sntsumqIHpemUo6vzlMZA4vz8juREvlfTAQ4Dzeh
         3MchTzOPeFIICgM/++z9KB0jW2QJtrlPRA2zgSpkeWHgVqMG6z3x8FwwMiGIM4fAmwqp
         wVp3DOzmNvY+BjVlwE1mbMzgLIkw+LKHOjbC5t2CbjUhuF34xWALeE+koolSB10LBvNh
         oB1EXQmMPQZFIkSZJsejm/ehBacV4uiQlPLQY/4Cpn6gahiDqhaXY5Ffy7DksdJ8lqxf
         EjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PG/DpwgudfX9+wNQUUHhUWviyLZbkMRXOAK/nS3Dn8k=;
        b=mbkx6zDk4v+8VsedwhbI6u3F00DfbME0HVGqUztMp9nXk+NhU/qKeaV/qWuhz3Y5cI
         MAcdqES2GygzW+iT+PoJJsXTO7LdSLolq3tvLppEupQ17tK7TFzVrFXgxCwkhlfDmIx8
         2bQuEaLMM1j81oBiXDN/QIF648KTCC6Aib4MLUKancy3ZoA22cH+FTk53EQEzHJz9/wU
         R8tlah2xo8tMtH2fjh97HpuXnL+U2fJ8U22o6gqbOHzHfmCuW4mxuwrhXUThbgxPNa2N
         CTGLbv94SkGeaE1MDz+oDSF+MTOglOmfwtFgbAm4NgOMaxPyf1QUdlmYvsHckovno0H2
         THLg==
X-Gm-Message-State: APjAAAUDBKWpuDOVQC1M/e2OCwIfR1eYfBYLhp8KvoIKY7528eBjpGqt
        g1r9loesn9rRsv7hN/uI4v/07gTX
X-Google-Smtp-Source: APXvYqz9K5vPWxghUnYWKbeptqEVQx8Bvkbr27YW3j8GAaY6Xvoys9kGd0wX6fuLVmFCyBekVbDUxg==
X-Received: by 2002:a17:902:ff07:: with SMTP id f7mr2005872plj.12.1579305209199;
        Fri, 17 Jan 2020 15:53:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m19sm7544146pjv.10.2020.01.17.15.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:53:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v4 1/2] ata: ahci_brcm: Perform reset after obtaining resources
Date:   Fri, 17 Jan 2020 15:53:12 -0800
Message-Id: <20200117235313.14202-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117235313.14202-1-f.fainelli@gmail.com>
References: <20200117235313.14202-1-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Resources such as clocks, PHYs, regulators are likely to get a probe
deferral return code, which could lead to the AHCI controller being
reset a few times until it gets successfully probed. Since this is
typically the most time consuming operation, move it after the resources
have been acquired.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 7ac1141c6ad0..e32c8fe729ff 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -456,13 +456,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rcdev))
 		return PTR_ERR(priv->rcdev);
 
-	reset_control_deassert(priv->rcdev);
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
-	if (IS_ERR(hpriv)) {
-		ret = PTR_ERR(hpriv);
-		goto out_reset;
-	}
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
 
 	hpriv->plat_data = priv;
 	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
@@ -479,6 +475,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ret = reset_control_deassert(priv->rcdev);
+	if (ret)
+		return ret;
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.17.1

