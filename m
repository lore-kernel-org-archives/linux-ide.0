Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0551C83F2C
	for <linux-ide@archiver.kernel.org>; Mon,  4 Sep 2023 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjIDUnq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Sep 2023 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjIDUnq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2023 16:43:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7F12A
        for <linux-ide@vger.kernel.org>; Mon,  4 Sep 2023 13:43:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5007616b756so3067402e87.3
        for <linux-ide@vger.kernel.org>; Mon, 04 Sep 2023 13:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693860220; x=1694465020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGZWJXE6EwWx0JQ7nRmbmIK/cR0YzVu67e/Fejiy4qY=;
        b=i9TZPgFFiraEqncqstpZjTmLxKNvDeNkJ5vj2hwkOQ8TaDjDzCItJOR/7YlZ2zomrQ
         QErpEZiJjEIzNz/QWIGvl0pwXQQp0OL3aq1yWdpJHBkUPFfLirgUY6sFTDwLiWIB2f0Q
         XANyqBgDza53SYDcapbJ+KVKjjw1cd4xrmWsvOTuUY5c8HEn3Y0WtKsD/3000fB8gPaq
         vC6rI2FaHOpr/LjBdxUW0JX/oNKF9Ix1bHoddJbzcEbT1itdjQYmCwXNJH6a+Y0huSnC
         XEIaqFPCfAO+drbPuwkGLuWf8pbfvbrMoa8kuAP1LFCqLVwYD+TWXy4yPoA5CdJxIhDd
         EeKg==
X-Gm-Message-State: AOJu0YxTSzOjN8bf6SSUors3999afFgxVHgFDWWRbTHcMNiUmkOHOso6
        RtAOm0BdRqH6AoPBXvV8winXB3RKWzs=
X-Google-Smtp-Source: AGHT+IHgwf24R79JrHw+rjTtCyA2mk6W/VmYjcZ+WG1R70X7UOxD4PQuvGSd6ErocMaRyMvrS13lRQ==
X-Received: by 2002:a05:6512:3d28:b0:500:adbd:43e9 with SMTP id d40-20020a0565123d2800b00500adbd43e9mr8673916lfv.15.1693860219973;
        Mon, 04 Sep 2023 13:43:39 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id q9-20020a19a409000000b004ff8f448343sm1892414lfc.33.2023.09.04.13.43.39
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 13:43:39 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 2EF56B97D; Mon,  4 Sep 2023 22:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693860218; bh=uSmMMB3SDC3z1Pb/HZlVyIfqGPTK173Dg+13JVF9t9s=;
        h=From:To:Cc:Subject:Date:From;
        b=m4gtuixO2Bnhn22eJutXd7Gpkntn0vGOfNgoXThSEnjEGzKQYEQZTMfc+usqOLt4c
         0dORdeb57jFh8vWH28EV9urS9QGXn9h+RlZ/3IYOpPg7Pt+6veMGEg/x55bKWzkS+u
         JBZDkR/SwqbgxAPSoxTXxLPa0/13a3Fvk4uInQTQ=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 08215B96C;
        Mon,  4 Sep 2023 22:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693860203; bh=uSmMMB3SDC3z1Pb/HZlVyIfqGPTK173Dg+13JVF9t9s=;
        h=From:To:Cc:Subject:Date:From;
        b=LJ9cVNxl04sbWivdTxuH5qD64IMJeqX2/hbCEq8HAy1b+2Np3bhY9MLjzFsJ97xt7
         lS7ZpIGv2j/pkueD6+66DtH2koxrhCnc8ePAbPWZDhzSvZ/xsmwSOCN3X2Jlz260Yl
         sDoYGSnCXTzEzE39S5eluuDNLf6QFBG/K7EOwJDY=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: disallow dev-initiated LPM transitions to unsupported states
Date:   Mon,  4 Sep 2023 22:42:56 +0200
Message-ID: <20230904204257.3296685-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

In AHCI 1.3.1, the register description for CAP.SSC:
"When cleared to ‘0’, software must not allow the HBA to initiate
transitions to the Slumber state via agressive link power management nor
the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
must be programmed to disallow device initiated Slumber requests."

In AHCI 1.3.1, the register description for CAP.PSC:
"When cleared to ‘0’, software must not allow the HBA to initiate
transitions to the Partial state via agressive link power management nor
the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
must be programmed to disallow device initiated Partial requests."

Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
a device is not allowed to initiate transitions to power states which are
unsupported by the HBA.

DevSleep is always initiated by the HBA, however, for completeness, set the
corresponding bit in PxSCTL.IPM such that agressive link power management
cannot transition to DevSleep if DevSleep is not supported.

sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
However, only libahci has the ability to read the CAP/CAP2 register to see
if these features are supported. Therefore, in order to not introduce any
regressions on ata_piix or libata-pmp, create flags that indicate that the
respective feature is NOT supported. This way, the behavior for ata_piix
and libata-pmp should remain unchanged.

This change is based on a patch originally submitted by Runa Guo-oc.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/ahci.c        |  9 +++++++++
 drivers/ata/libata-sata.c | 19 ++++++++++++++++---
 include/linux/libata.h    |  4 ++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index abb5911c9d09..08745e7db820 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1883,6 +1883,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else
 		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
 
+	if (!(hpriv->cap & HOST_CAP_PART))
+		host->flags |= ATA_HOST_NO_PART;
+
+	if (!(hpriv->cap & HOST_CAP_SSC))
+		host->flags |= ATA_HOST_NO_SSC;
+
+	if (!(hpriv->cap2 & HOST_CAP2_SDS))
+		host->flags |= ATA_HOST_NO_DEVSLP;
+
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5d31c08be013..a701e1538482 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -396,10 +396,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	case ATA_LPM_MED_POWER_WITH_DIPM:
 	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
-			/* no restrictions on LPM transitions */
+		if (ata_link_nr_enabled(link) > 0) {
+			/* assume no restrictions on LPM transitions */
 			scontrol &= ~(0x7 << 8);
-		else {
+
+			/*
+			 * If the controller does not support partial, slumber,
+			 * or devsleep, then disallow these transitions.
+			 */
+			if (link->ap->host->flags & ATA_HOST_NO_PART)
+				scontrol |= (0x1 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_SSC)
+				scontrol |= (0x2 << 8);
+
+			if (link->ap->host->flags & ATA_HOST_NO_DEVSLP)
+				scontrol |= (0x4 << 8);
+		} else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
 			scontrol |= (0x1 << 2);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5ee..bf4913f4d7ac 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -222,6 +222,10 @@ enum {
 	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
 	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
 
+	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
+	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
+	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
+
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
 	/* various lengths of time */
-- 
2.41.0

