Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A4CEB8FAD
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjIFJXU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjIFJXT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 05:23:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C210D1
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 02:23:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500cd6261fdso5949134e87.3
        for <linux-ide@vger.kernel.org>; Wed, 06 Sep 2023 02:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992184; x=1694596984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4LbjxRBlqLs0xK/XsOMDRVVTvlb9+oOFd7QDsBPCng=;
        b=G55MxjZPaFwMtrLoNLpksyEu4euon3+SdLqgDuKXR06wEYcM8BX0jYaUUZK/Dtvyem
         Bir6sBjmnCBo+hkWKrD7RelRLazVQKweWXmIHtjBsM61SAy+dERWgarjQN6jA6dXT4Jc
         8uymjafLjC3V2HH1in1EbEy/80P8n8h7i03lTxOYrCewj+DCHp7saLEJy6WCDKTF4V5o
         NyOE6meuA4ga+7V0RuJq53f14qZ4yC2PfTTQiBbCW3EAtT1FufDFUJ5SQTk2pbk5UFxT
         zoBo42lqbiMdKTOeiOqE071ZmISjAo1tl3ekGXVaR2PScvUJ0vapMJD/UYaNfmOVTg/c
         K/4g==
X-Gm-Message-State: AOJu0YzlAJV0pS1yVDfzIN7pVssYGDuDLs7dsuiPisxPqbasZe3tDoG7
        WmyofvF+5k9ANxRMDDaMdKq74Y0rIZh0LA==
X-Google-Smtp-Source: AGHT+IENwHPKxbyHanqdLrGQiLXqjx+eQ5Haxdepoy8iMXCOYzU3W0PTeW90s7WWZg1V5YP1OPStWQ==
X-Received: by 2002:a19:380f:0:b0:4fb:9e1a:e592 with SMTP id f15-20020a19380f000000b004fb9e1ae592mr1734271lfa.4.1693992184088;
        Wed, 06 Sep 2023 02:23:04 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25109000000b00500c5d48b47sm2665493lfb.191.2023.09.06.02.23.03
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:23:03 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 0E53DB99B; Wed,  6 Sep 2023 11:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693992182; bh=0f6SsXg8k0sm4qdd8wA1Bc6LtvEsrM8chtq5XNP+sx8=;
        h=From:To:Cc:Subject:Date:From;
        b=ecNYcdhUaU/r2MQ5hSuWJvyxqahI6DpZqMSOSXbVJoBxRWnPe8JJFmqTwIiyu2Xol
         1+28FJnDbAxzjKS1s9DlAmxMUbRR7YVsNGtXMXVn62EHoVRo2ndR5cFVsWetAcT8we
         jIEp5c8G5CiNPEKNBVHKDuCk3VJvq92gbdDxAY54=
Received: from x1-carbon.wdc.com (unknown [129.253.182.56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 94AFAB981;
        Wed,  6 Sep 2023 11:22:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1693992170; bh=0f6SsXg8k0sm4qdd8wA1Bc6LtvEsrM8chtq5XNP+sx8=;
        h=From:To:Cc:Subject:Date:From;
        b=mRtmtR7l59hLUkHp53rapXVD2WKDBrvqSZtHn8NeaeiEn/fpW+HkGYnuENYd+LeM5
         koi3EutHbkdYqI4TPRLFyu8KAQch2y/Qpdj91/i/IbWf5DIVCAm3obKbqoow+zAnKG
         6zDbn/MmFCM7E3yLm9kP5oKybcBE4kzHW816TekM=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2] ata: ahci: print the lpm policy on boot
Date:   Wed,  6 Sep 2023 11:22:32 +0200
Message-ID: <20230906092232.3396200-1-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

The target LPM policy can be set using either a Kconfig or a kernel module
parameter.

However, if the board type is set to anything but board_ahci_low_power,
then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.

Additionally, if the default suspend is suspend to idle, depending on the
hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
ATA_LPM_MIN_POWER.

All this means that it is very hard to know which LPM policy a user will
actually be using on a given system.

In order to make it easier to debug LPM related issues, print the LPM
policy on boot.

One common LPM related issue is that the device fails to link up.
Because of that, we cannot add this print to ata_dev_configure(), as that
function is only called after a successful link up. Instead, add the info
using ata_port_desc(), with the help of a new ata_port_desc_misc() helper.
The port description is printed once per port during boot.

Before changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170

After changes:
ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170 lpm-pol 4
ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170 lpm-pol 4

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
V1 -> V2: Moved the lpm-pol print after the irq print. Added a new helper,
ata_port_desc_misc(), to help with this.

 drivers/ata/libahci.c     |  2 +-
 drivers/ata/libata-core.c |  2 +-
 drivers/ata/libata-sff.c  | 10 +++++-----
 drivers/ata/pata_cs5520.c |  2 +-
 include/linux/libata.h    |  5 +++++
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e2bacedf28ef..5354571a3105 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2719,7 +2719,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 
 		if (rc)
 			return rc;
-		ata_port_desc(host->ports[i], "irq %d", irq);
+		ata_port_desc_misc(host->ports[i], irq);
 	}
 
 	return ata_host_register(host, sht);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 74314311295f..715a8fb6c3e6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5923,7 +5923,7 @@ int ata_host_activate(struct ata_host *host, int irq,
 		return rc;
 
 	for (i = 0; i < host->n_ports; i++)
-		ata_port_desc(host->ports[i], "irq %d", irq);
+		ata_port_desc_misc(host->ports[i], irq);
 
 	rc = ata_host_register(host, sht);
 	/* if failed, just free the IRQ and leave ports alone */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 8fcc622fcb3d..95a19c4ef2a1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2316,7 +2316,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		for (i = 0; i < 2; i++) {
 			if (ata_port_is_dummy(host->ports[i]))
 				continue;
-			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
+			ata_port_desc_misc(host->ports[i], pdev->irq);
 		}
 	} else if (legacy_mode) {
 		if (!ata_port_is_dummy(host->ports[0])) {
@@ -2326,8 +2326,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 			if (rc)
 				goto out;
 
-			ata_port_desc(host->ports[0], "irq %d",
-				      ATA_PRIMARY_IRQ(pdev));
+			ata_port_desc_misc(host->ports[0],
+					   ATA_PRIMARY_IRQ(pdev));
 		}
 
 		if (!ata_port_is_dummy(host->ports[1])) {
@@ -2337,8 +2337,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 			if (rc)
 				goto out;
 
-			ata_port_desc(host->ports[1], "irq %d",
-				      ATA_SECONDARY_IRQ(pdev));
+			ata_port_desc_misc(host->ports[1],
+					   ATA_SECONDARY_IRQ(pdev));
 		}
 	}
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 422d42761a1d..38795508c2e9 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -212,7 +212,7 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		if (rc)
 			return rc;
 
-		ata_port_desc(ap, "irq %d", irq[i]);
+		ata_port_desc_misc(ap, irq[i]);
 	}
 
 	return ata_host_register(host, &cs5520_sht);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5ee..f7bfc87b34ff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1553,6 +1553,11 @@ void ata_port_desc(struct ata_port *ap, const char *fmt, ...);
 extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 			       const char *name);
 #endif
+static inline void ata_port_desc_misc(struct ata_port *ap, int irq)
+{
+	ata_port_desc(ap, "irq %d", irq);
+	ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
+}
 
 static inline bool ata_tag_internal(unsigned int tag)
 {
-- 
2.41.0

