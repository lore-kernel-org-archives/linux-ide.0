Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC1BC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCDA61029
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 10:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbhIQK0n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Sep 2021 06:26:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50788
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241064AbhIQK0n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2021 06:26:43 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA5EA3F338
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2021 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631874319;
        bh=2xQ1/AEURoJyQBP257GxvnHNKDEHX4wx3ObYTWar7oY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ACSWJA8nr4k+/12OR3MTUUcPWRf2TJnIXxIUjlXsNkJdSh5YQVOgsPG1kN62CvIEU
         4+gUEP8dJuXkVTfudJTVymItyJ92d65wpjJEsseUvD1rfPHybDFKr9DVVE9DXxGlMq
         Lk3SK5M9BlWap93d/Rzrca4q56zJGgr17O74L8yqmQZPQXBxbqI5Mo7K5pXQQCniph
         kjgQnhaFQQlxk+NvIfdfwt3R7+HVHMhdvNo3DRR5u0UC6gzuPFkx5dr6rPlsZxlHzP
         hcWUhnUmUkzTvWLhTFKF6bg9OFHgNpGrSxMlxmVLWtuY6dXQUsxhhwLYN9MpovzU4R
         73Ki2XdBpCmGg==
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so4427560wmc.9
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xQ1/AEURoJyQBP257GxvnHNKDEHX4wx3ObYTWar7oY=;
        b=Ot3VmECO06mHac0N9lLPEejl/rbwzfHxHty2zuISsdHBRTLQAjlWdffBanPDZIB7Xh
         QczsYj62AzFjIAixrv6UpMcWrPO1+b3PCfZSayA29Jzbsod/XJpcp3X1gh6/zoYbPWfi
         dePDK4wsgho7XYadIiO37dnt3lbEOuFVYYsC3Y0JseqF8Ypdv1WoHARLIEUX/mcgCveD
         WPxkyDLcQwhmHkuarF2YgS1ks4DU/3qeoVqktwUJ2Go2AvUyjZt2JrDGRsnBffZufeG+
         jwqiFdNn7qcy1j+3HGkEZIWAcBxchm6cC4nfHMUxWviQxtcg9YRueJd8ccXt5poIFmO3
         7Y9g==
X-Gm-Message-State: AOAM532O1/B0DGty+gTne9NYu1y4srUZWqilGdDPmORRPdpDmWxPGpyS
        ejolmMum9a8fG4Nn9Y+SzmqbWTPuq1gVjlun+6ozub0uZEFEBukLZ0NNJhOq/z7levBcLUudJe1
        lSyYpY9l5G+v3dvksZ/xYhMUfmL0WIJ7FS8IbZw==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr9516521wme.71.1631874319222;
        Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6BP6x1Dwi4163Sx4CfX5t+shARUqdLVM7Pj2bw2k5ASK7V0D5yK04rjbrHOAQzRUa1BAn0g==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr9516509wme.71.1631874319074;
        Fri, 17 Sep 2021 03:25:19 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h16sm6256944wre.52.2021.09.17.03.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 03:25:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] ahci: remove duplicated PCI device IDs
Date:   Fri, 17 Sep 2021 12:24:42 +0200
Message-Id: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
has board_ahci_nosntf (for ICH8).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Not tested.
---
 drivers/ata/ahci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..5f257064fcd8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -258,7 +258,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
@@ -316,7 +315,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
@@ -358,8 +356,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
@@ -395,9 +391,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
-- 
2.30.2

