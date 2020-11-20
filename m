Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,
	SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F2C63798
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D9122201
	for <linux-ide@archiver.kernel.org>; Fri, 20 Nov 2020 20:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZQVzmYJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgKTUiu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbgKTUiu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2020 15:38:50 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FDC0613CF
        for <linux-ide@vger.kernel.org>; Fri, 20 Nov 2020 12:38:49 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so8275605pgg.13
        for <linux-ide@vger.kernel.org>; Fri, 20 Nov 2020 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mbSdN3eggVr4Z4kNEOK/lmtmEvAGNP/ePDTi+gor+9g=;
        b=ZQVzmYJzMNvAjDjQR89LuXJTbHANBNdoSzu62O6G1lAYXSDWC3g71pXH1FFCabJVLr
         GGR+I/LN6X0NabNctqqRm3NrOUJH9+LYW7ULtD/SsKyRpEKAnfzQJ9bc498u5te0/5Xx
         n7ycTKveqSXk2ENAQKsZQ69iYxFfjDtr73Z0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mbSdN3eggVr4Z4kNEOK/lmtmEvAGNP/ePDTi+gor+9g=;
        b=WQBWf2gmgmpQ+xaz6u5C91BXAiihlNSc43VcNbyg2cEBCqOsHqCTIvFgsOT47ftVeu
         ORzNCl6Jz5ilfw1rGdOunyCqikL4hIxHpVilFsqyXnuGIt11r6et8RSen1Zag4QIjW5t
         bqWhYFBsjNYFZLZiX4mxbZGf885UHhN8NVhIaS3QLZP9U4lZ7LAluF3YPbyjDKegDAv6
         92twXQt63CbQvp30vp+dNVAMYAj12MkvKJC57ByauqOQG3NMAsh6i1Pk3V/hOjlgfJWQ
         6rmKXnbEzBBxOznTsjWrtzZLSodCclgXT08XbJgH+oXetyfgq0J28AdpUljlYD5XkvUw
         qQAw==
X-Gm-Message-State: AOAM530ZG5AUxRN/dUkNB3HW9+03qxs+PgAlwuwl4l4O3jgMfWPJPiAj
        n9NWoikpiryD1aPrZWmIrb6pS0ptEF8y+Q==
X-Google-Smtp-Source: ABdhPJxYYDT/hBQ9ouf40YSxJ2eozRDy/6CMRz+JfnrrmWLaY8J8LAhthcgYzokcFvbMrC4cfYtAwg==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr12396525pjj.206.1605904729471;
        Fri, 20 Nov 2020 12:38:49 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id gx24sm4838688pjb.38.2020.11.20.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:38:48 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jquinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 20 Nov 2020 15:38:38 -0500
Message-Id: <20201120203840.35139-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120203840.35139-1-james.quinlan@broadcom.com>
References: <20201120203840.35139-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f620f805b48fd4ed"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

--000000000000f620f805b48fd4ed

From: Jim Quinlan <jquinlan@broadcom.com>

This driver may use one of two resets controllers.  Keep them in separate
variables to keep things simple.  The reset controller "rescal" is shared
between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
devm_reset_control_get_optional_shared() to handle this sharing.

Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 49f7acbfcf01..bad455fb6ab8 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -86,7 +86,8 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
-	struct reset_control *rcdev;
+	struct reset_control *rcdev_rescal;
+	struct reset_control *rcdev_ahci;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -352,8 +353,8 @@ static int brcm_ahci_suspend(struct device *dev)
 	else
 		ret = 0;
 
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 
 	return ret;
 }
@@ -365,10 +366,10 @@ static int __maybe_unused brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev_ahci);
+	if (ret)
+		return ret;
+	ret = reset_control_reset(priv->rcdev_rescal);
 	if (ret)
 		return ret;
 
@@ -428,7 +429,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -450,15 +450,15 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	/* Reset is optional depending on platform and named differently */
-	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
-	else
-		reset_name = "ahci";
-
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
-	if (IS_ERR(priv->rcdev))
-		return PTR_ERR(priv->rcdev);
+	if (priv->version == BRCM_SATA_BCM7216) {
+		priv->rcdev_rescal = devm_reset_control_get_optional_shared(
+			&pdev->dev, "rescal");
+		if (IS_ERR(priv->rcdev_rescal))
+			return PTR_ERR(priv->rcdev_rescal);
+	}
+	priv->rcdev_ahci = devm_reset_control_get_optional(&pdev->dev, "ahci");
+	if (IS_ERR(priv->rcdev_ahci))
+		return PTR_ERR(priv->rcdev_ahci);
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
@@ -479,10 +479,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_reset(priv->rcdev_rescal);
+	if (ret)
+		return ret;
+	ret = reset_control_deassert(priv->rcdev_ahci);
 	if (ret)
 		return ret;
 
@@ -527,8 +527,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 out_disable_clks:
 	ahci_platform_disable_clks(hpriv);
 out_reset:
-	if (priv->version != BRCM_SATA_BCM7216)
-		reset_control_assert(priv->rcdev);
+	reset_control_assert(priv->rcdev_ahci);
+	reset_control_rearm(priv->rcdev_rescal);
 	return ret;
 }
 
-- 
2.17.1


--000000000000f620f805b48fd4ed
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEW/NPvgw+X9
EAWOVctLFdTb+H0d/ni25OYNYS4Jgsy7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyMDIwMzg0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqsSzSQnjchHhFBnhRMJAeMAlSvSS9
AWgGKC5DPZAumzJsCHzAHdABQdSGH75AB7hgagoAKikZT2oBYLknWPcPe4fQ39sPbLI7FqpApQff
5AkRMSrmRhcW8K+PB5Qe1ZsN9VHdEtUysQGYygVngnYXEd7ASTqFKcztHc/3CRclvxUJNFpI7n2j
1K3VNKKjZN4/7AqIIE02lQebcb2M6u1UzuPNCSqg8F0cRL2iJTrXqdYLeGcbzDQnJwrm/IK56V20
TfCtC2B9gZpxM3sBaRBdTiBfcrbcTrAsn8RgJfvrJtDjD7rWdC96WI8EIE6SwIwnk/xRWdA9m42U
RCnhe4sn
--000000000000f620f805b48fd4ed--
