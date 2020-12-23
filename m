Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38998C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 22:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CC2225AC
	for <linux-ide@archiver.kernel.org>; Wed, 23 Dec 2020 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgLWWmP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Dec 2020 17:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgLWWmP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Dec 2020 17:42:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F6C061794;
        Wed, 23 Dec 2020 14:41:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w1so1649493pjc.0;
        Wed, 23 Dec 2020 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Msip++nkQ0FZP94oH0SYYzhTbESqBONuQZ4tD6/1B0k=;
        b=PwtWnK+YRPuAJKA6q7gu0yXF8jA5ENlK091YO2d2WcXeb5zbgTvWhdA7i4Qo1zY0cB
         SqCvEVILLeA+q1KN5Q1ZgMXuw+aWDzI+ysOAZ5nhYpssAhwIxqYUCL946cwqd/bJDpar
         kLQCIxow19mpbeh00Ll83rOP9PW1jj24JzDS//nzJGYh+ZTmd09zFbQr29+6PHvq79cI
         K4sLrA0d1NqIVR6mZkaUE9ro5HWBseJ9NbEZCyS6E9t65CRk+MjNo58hSDjkkYQEBtJJ
         a0EeSyxPmIATwWnvPnAlkSMAjWQJIm2+JOVFmwDzMZ55D/Hi5kCSV1NfnHmvjaKy0Now
         qqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Msip++nkQ0FZP94oH0SYYzhTbESqBONuQZ4tD6/1B0k=;
        b=dUbmwCmXdPZ5xzT5tv5VDlMSqMPOYf3/g/QRzWllaQ+gpXeqO0JjsCNG7dWls6cbM6
         qoghNKk+JnRM5VehUkDFcKmU9cw6Op033Y8uAf2t7nwTWJYdoL6yJWjH3pQv9UMMSi9a
         G3t5CQS4VkIioYXGF8V4Da9UhYlSIO/g+HUSFPluFCaPKTGJaDJF5iDSyZx9n4LmhDEh
         ay35SWZXO+RJExw3GTlqGaUn2jCiOJR5Tqsfj8cZc/iPDk52u22kUyxgNONFhAuYRzvU
         d4fWdIaFkBC86+kZVscqM6gp8KC1Qxy1EQcHe5Z0gVtfMWRtzNrtXcVQU3XloAlDSllI
         AIpQ==
X-Gm-Message-State: AOAM532G/cZbcRPTGAK2tnm/SlfjgHTESwLfrCZATCLhZHlPXLhPfSP6
        xM8YVPAnnvIP51yiCUDNU572xHiM91U=
X-Google-Smtp-Source: ABdhPJw13avGLpd+7qE4y91F5leyZPzbGTi6a7oRuCaAlzUmLhTwRjsyyqS+Jng0IEj4ad1C8/FkoA==
X-Received: by 2002:a17:90a:f0ce:: with SMTP id fa14mr1585054pjb.156.1608763294217;
        Wed, 23 Dec 2020 14:41:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k14sm23615437pfp.132.2020.12.23.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 14:41:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers))
Subject: [PATCH] ata: ahci_brcm: Add back regulators management
Date:   Wed, 23 Dec 2020 14:41:29 -0800
Message-Id: <20201223224130.738590-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While reworking the resources management and departing from using
ahci_platform_enable_resources() which did not allow a proper step
separation like we need, we unfortunately lost the ability to control
AHCI regulators. This broke some Broadcom STB systems that do expect
regulators to be turned on to link up with attached hard drives.

Fixes: c0cdf2ac4b5b ("ata: ahci_brcm: Fix AHCI resources management")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Jens,

This is based on your for-next branch, let me know if you need me to
rebase to a different branch. Thanks!

 drivers/ata/ahci_brcm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 49f7acbfcf01..5b32df5d33ad 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -377,6 +377,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = ahci_platform_enable_regulators(hpriv);
+	if (ret)
+		goto out_disable_clks;
+
 	brcm_sata_init(priv);
 	brcm_sata_phys_enable(priv);
 	brcm_sata_alpm_init(hpriv);
@@ -406,6 +410,8 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	ahci_platform_disable_phys(hpriv);
 out_disable_phys:
 	brcm_sata_phys_disable(priv);
+	ahci_platform_disable_regulators(hpriv);
+out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 	return ret;
 }
@@ -490,6 +496,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_reset;
 
+	ret = ahci_platform_enable_regulators(hpriv);
+	if (ret)
+		goto out_disable_clks;
+
 	/* Must be first so as to configure endianness including that
 	 * of the standard AHCI register space.
 	 */
@@ -499,7 +509,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	priv->port_mask = brcm_ahci_get_portmask(hpriv, priv);
 	if (!priv->port_mask) {
 		ret = -ENODEV;
-		goto out_disable_clks;
+		goto out_disable_regulators;
 	}
 
 	/* Must be done before ahci_platform_enable_phys() */
@@ -524,6 +534,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	ahci_platform_disable_phys(hpriv);
 out_disable_phys:
 	brcm_sata_phys_disable(priv);
+out_disable_regulators:
+	ahci_platform_disable_regulators(hpriv);
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-- 
2.25.1

