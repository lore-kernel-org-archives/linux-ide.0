Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A17C433E6
	for <linux-ide@archiver.kernel.org>; Fri, 29 Jan 2021 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E63564E0A
	for <linux-ide@archiver.kernel.org>; Fri, 29 Jan 2021 18:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhA2Saa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhA2S3j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2021 13:29:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113FC061573;
        Fri, 29 Jan 2021 10:28:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p15so6236352pjv.3;
        Fri, 29 Jan 2021 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiEDkLsa4ylrHTtz0oYTVB6w9VLBYVLSPFL7BL952vg=;
        b=JBvY/E/goAIn2FYCpn7Z4uZAvQnZjLm4hb0dGMzxw54kjH4LoxeQHczyzS6Ttmtz78
         rOcDkOyK+9Cr0+WCljcGPyJYGb6vO0MtxsWo3bTZxf91KSKRTcrSwX4HHcgh0jJLS3cx
         ZxemVImxeYzDSzTrgggaetQF+V9iXv1sgHtugcA1mfvCRbwo5QEH+DPxtNR/bYuQOWC+
         FScwxkWJ9f+50eIt4c6xI9HVGIXJdIGG1WVOgKFMGMIZh8mYxxxeq/6yHoNwPkfcJ4bv
         G+QTrgrlYalC4dn10vvirCJWem0LbZMBmYeYSJaej2ryBhA1UQx4rcxTo3oCjeIH1Gtt
         4C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiEDkLsa4ylrHTtz0oYTVB6w9VLBYVLSPFL7BL952vg=;
        b=OaaKGwQcT1rKuEg67/xTFK+EWgtiD8moK5Y58ty/RWhXv5v9l8eWDWNB8UBHWbghDW
         /yVWPSpSWAZ6qXj9m2i3smjSnWw0uuQgcRnvBHAfTuweKxcvXJdJmSUDORLMOl1CpYgj
         x6rC4K+b91M3RkQ8h9wMfozddUt399DZ93gB2iSevqscBBWuMMDs//oHHoxCvSvHK0c2
         I1WmTcfwGtJdQIxpnZVuw3iJjeEsv6yYn8T1nWlOdiA0QNPoWqjdUmr0Lr3TRY6IYa6E
         NJycPsDnUHCuOtokqAIH0jxg5G8rtvw8zoq8Wwxeo2olYN0p38Gdt1ltf8xrO3nLurB+
         t7kg==
X-Gm-Message-State: AOAM531oMlwBGZch1ZK/2/3QZrYSIT+qLzl7ARLNRbCwacIPj1Cq8TFL
        hhs2AoinEqrZ4+gqYUCZlZvzgWGAFT4=
X-Google-Smtp-Source: ABdhPJwmbhNgdoAnfwCB91O25ltFuXDclzbu0LDKuveryGbcxSBOjP4/4AhBzxmmRn7rwSsiStzu0w==
X-Received: by 2002:a17:902:e84e:b029:de:45bf:1296 with SMTP id t14-20020a170902e84eb02900de45bf1296mr5420245plg.49.1611944938770;
        Fri, 29 Jan 2021 10:28:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w66sm9458236pfd.48.2021.01.29.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:28:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers))
Subject: [PATCH RESEND] ata: ahci_brcm: Add back regulators management
Date:   Fri, 29 Jan 2021 10:28:45 -0800
Message-Id: <20210129182846.1944699-1-f.fainelli@gmail.com>
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

