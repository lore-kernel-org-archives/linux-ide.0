Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E83CA0FE1
	for <linux-ide@archiver.kernel.org>; Fri,  1 Sep 2023 02:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348027AbjIACfJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjIACfJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 31 Aug 2023 22:35:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D228E6E
        for <linux-ide@vger.kernel.org>; Thu, 31 Aug 2023 19:35:06 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C6B241D35
        for <linux-ide@vger.kernel.org>; Fri,  1 Sep 2023 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693535704;
        bh=KPaC4A2ry5UvIkv/FQfxXalAs6HImVPpQxwXsKvbe60=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Fog9w3TRsePl8iqNeczaxBtpjp8ulGzstK4kcm96d+Nna60TVVMcbg9NcNWsAuTJP
         g3cd7t4tKKy2PGpIonUuQucqUlifnVa3vEc0P8gBYtlygpd71VlVZl+r7GU9KqQX8d
         y8Y3CxkZOcuenuiWrOkedcagwa+7ERkSGm1qA+MWt++0b/kYvE8oqwRombiANVb03Q
         sVCR4NfeSd3Za/zTT57CoH87RaDcJIKB07J6n8z3esDrSpXOMtpW9MWMO6W9Ugo7+c
         k6pSCK9L0v+D7U80k5WFIi99uMoW8Z7djvjhsdZ07onXruX+c7XFVH4AgY5DWPBc3C
         CT5kTEVS/7kVQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26d5970cbdbso1886539a91.0
        for <linux-ide@vger.kernel.org>; Thu, 31 Aug 2023 19:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693535701; x=1694140501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPaC4A2ry5UvIkv/FQfxXalAs6HImVPpQxwXsKvbe60=;
        b=SHe7DxzdgcxwHYNdr5/M7NhfO52mUCCqiRcZ5ehv4AZ8nVxcfuHAA+QLBYNkwZW9zr
         0OoL+yC0Rs0zXg1JxXCpQPOOTIRzxw82+fihsk+OxMPDhqZckXtQ0Nnfv8NMGGWBzn7M
         8L+1XWqRbr3DWoyaBd0Nz5EH+r23HL8L6fVHrW2h3yG2bifxtNRfK/Nl5lZjrW7Sehog
         CRET+Ps0PrdVOXB3nU6a9OjHFFe075G5yWQxS5PWUKwmdkv4LuDW/4wLrlRPkl8lS00a
         dO9MwnKnkaST7+W2CRuPR/RKDSZBbuMcVNn9vIsF2gu3fSq6y4UOH+ConyKpV6h8VGXW
         0OSA==
X-Gm-Message-State: AOJu0YzNE9md+3G+lSFZyEHHuWHJtGhef6xH1tLw1qfzRfz/dz2ugDhG
        NV+XfEMZCEBLIYbzqR1Dk91l3KTmP/6V+Z3inwU6FxUKv0J2Uk8cbr48pKwz43Lf0WzhW/t+PcL
        wfYKqd2bzBy3XY/Kt2zmYAyA6/hAJqCjr8DymKA==
X-Received: by 2002:a17:90a:ea83:b0:271:80f2:52c5 with SMTP id h3-20020a17090aea8300b0027180f252c5mr1178031pjz.25.1693535701466;
        Thu, 31 Aug 2023 19:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvLSwx8amXvyz7AGnjM7lxy/ffQrAg7E/2sM53jhjZFlXW7jOL17wOVox6QiOQpV+6KvraZQ==
X-Received: by 2002:a17:90a:ea83:b0:271:80f2:52c5 with SMTP id h3-20020a17090aea8300b0027180f252c5mr1178017pjz.25.1693535701016;
        Thu, 31 Aug 2023 19:35:01 -0700 (PDT)
Received: from canonical.com (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a195a00b0026f7554821csm2111129pjh.27.2023.08.31.19.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 19:35:00 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [V2] ata: libata: add workaround to flip LPM during suspend/resume
Date:   Fri,  1 Sep 2023 10:34:57 +0800
Message-Id: <20230901023457.8655-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Due to TigerLake/Adler Lake AHCI controller's LPM regression,
can't apply LPM on TigerLake/AdlerLake AHCI controller.

Add a workaround to flip LPM during suspend/resume.
When suspneding, apply LPM on TigerLake/AdlerLake AHCI.
Restore it to target_lpm_policy after resuming.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217775
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
V2: 
* remove the unused declarations
* add a condition for ATA_LFLAG_NO_LPM_RECOVER during suspned/resume
---
 drivers/ata/ahci.c      | 27 +++++++++++++++++++++++++++
 drivers/ata/libata-eh.c | 10 ++++++++++
 include/linux/libata.h  |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 02503e903e4a8..658fac695adf1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1025,6 +1025,30 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
 		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
 	}
 }
+/*
+ * Intel TGL/ADL workaround, when suspending, put port into LPM,
+ * recover to max power after resuming.
+ */
+static void ahci_intel_ahci_workaround(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	int i;
+	static const struct pci_device_id ids[] = {
+		{ PCI_VDEVICE(INTEL, 0xa0d3)}, /* Tiger Lake UP{3,4} AHCI */
+		{ PCI_VDEVICE(INTEL, 0x7ae2)}, /* Alder Lake AHCI*/
+		{}
+	};
+
+	dev_info(&pdev->dev, "enabling Intel AHCI workaround\n");
+
+	if (pci_match_id(ids, pdev)) {
+		for (i = 0; i < host->n_ports; i++) {
+			struct ata_port *ap = host->ports[i];
+
+			ap->flags |= ATA_LFLAG_NO_LPM_RECOVER;
+		}
+	}
+}
 
 /*
  * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID when
@@ -1905,6 +1929,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
 	ahci_p5wdh_workaround(host);
 
+	/* apply workaround for Intel AHCI */
+	ahci_intel_ahci_workaround(host);
+
 	/* apply gtf filter quirk */
 	ahci_gtf_filter_workaround(host);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 159ba6ba19ebb..0743a9986a5ac 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4000,6 +4000,12 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	int rc = 0;
 	struct ata_device *dev;
 
+	if (!!(ap->flags & ATA_LFLAG_NO_LPM_RECOVER))
+		ata_for_each_dev(dev, &ap->link, ENABLED) {
+			ata_eh_set_lpm(&ap->link, ATA_LPM_MED_POWER_WITH_DIPM, &dev);
+		}
+
+
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
@@ -4087,6 +4093,10 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	if (ap->ops->port_resume)
 		ap->ops->port_resume(ap);
 
+	if (!!(ap->flags & ATA_LFLAG_NO_LPM_RECOVER))
+		ata_for_each_dev(dev, &ap->link, ENABLED) {
+			ata_eh_set_lpm(&ap->link, ap->target_lpm_policy, &dev);
+		}
 	/* tell ACPI that we're resuming */
 	ata_acpi_on_resume(ap);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 52d58b13e5eee..e720fed6dbd7f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -147,6 +147,7 @@ enum {
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
 	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_LPM_RECOVER = (1 << 12), /* disable LPM on this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
2.25.1

