Return-Path: <SRS0=uYUo=3G=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74476C33CB3
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0CB22525
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jan 2020 23:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRd0o/BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgAQXxc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:53:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55587 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgAQXxb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jan 2020 18:53:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so3826796pjz.5;
        Fri, 17 Jan 2020 15:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0nxZ+DabtCHsVgmk3LUrqsYgSBh4hJ9Ryv1NTOJmYU=;
        b=rRd0o/BCHQXz++QFDkcKnQnZ99Er9EkHH9xl3DalpLKcpw3gH99rwXsfqFLCUFzefx
         NwL4onoseGR2Avs/B2RRbjlXXuS8V0HxcMxXNtouVP+8uk3Jq0AqXDgSMFBu/C4cUtvF
         UZ4cqCII1LRYcITNjqK/sTwucejM6t2FCmCkKtoPmz8piaPnceGroUSVOyDj3Bows3oS
         0yzXNMqlL4rsALZqhQY25lMuc1mHSFw1wAiioMi8kbHWtJUtuzgY6q8bUXzWuEqQ0UI/
         bqJqJGbdnMhD5LiP26tWB/cXd+MXF91Hlus+peLTDBcV5rcwxjICPH0iZm8QzAmq+6k6
         lpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/0nxZ+DabtCHsVgmk3LUrqsYgSBh4hJ9Ryv1NTOJmYU=;
        b=nstXOcHJqTVHXs/3kHZTBbOQVFbA7LFYbn3U2zq6tn2llVRqzSy9TEZyDF+fLALCGq
         zIMS1aY8u0cHNZx0YVo9IHewE+2XOde1iAAepZzSdmSqFJqaEHkVgAslAZ2oJR5VE236
         qyo404U9W1rkCyl+abZJ9rcn2u1aSDtN20YmpGCURV1IRC0ChaX9Qwi0S7N67DVP3Zbl
         Sma0j9LAwgD8fHpFx6CiPSZPITc5Eu7FWV9v0pKzA5stGaCBJz3zNnJW/iRoc0l8eI01
         BIwrXM8LpOzqWLsfmOKE0BTgW26aZ5bbumeIQ/8hFSwczm0pSoZRZga7H/FO/Wzh3mht
         fMNQ==
X-Gm-Message-State: APjAAAUz9luKuIkJPr6+LRQnhS618HEcqSnLSkmoQSE2iaDUuVc0XUk0
        rSzzlAbh3L+H93BMeeWiiCpo3AyY
X-Google-Smtp-Source: APXvYqwnHxGCYtBisZwz6gOdfIvFvYSOCLLNq6R5YSAmXTucWB93BNfVbjD+AcezIXgROGR8p7sXeg==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr1935640plo.90.1579305210361;
        Fri, 17 Jan 2020 15:53:30 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m19sm7544146pjv.10.2020.01.17.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:53:29 -0800 (PST)
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
Subject: [PATCH v4 2/2] ata: ahci_brcm: BCM7216 reset is self de-asserting
Date:   Fri, 17 Jan 2020 15:53:13 -0800
Message-Id: <20200117235313.14202-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117235313.14202-1-f.fainelli@gmail.com>
References: <20200117235313.14202-1-f.fainelli@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The BCM7216 reset controller line is self-deasserting, unlike other
platforms, so make use of reset_control_reset() instead of
reset_control_deassert().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index e32c8fe729ff..6853dbb4131d 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -352,7 +352,8 @@ static int brcm_ahci_suspend(struct device *dev)
 	else
 		ret = 0;
 
-	reset_control_assert(priv->rcdev);
+	if (priv->version != BRCM_SATA_BCM7216)
+		reset_control_assert(priv->rcdev);
 
 	return ret;
 }
@@ -364,7 +365,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	ret = reset_control_deassert(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216)
+		ret = reset_control_reset(priv->rcdev);
+	else
+		ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -475,7 +479,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	ret = reset_control_deassert(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216)
+		ret = reset_control_reset(priv->rcdev);
+	else
+		ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
@@ -520,7 +527,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	reset_control_assert(priv->rcdev);
+	if (priv->version != BRCM_SATA_BCM7216)
+		reset_control_assert(priv->rcdev);
 	return ret;
 }
 
-- 
2.17.1

