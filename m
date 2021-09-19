Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F2C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 09:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A14961074
	for <linux-ide@archiver.kernel.org>; Sun, 19 Sep 2021 09:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhISJoq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Sep 2021 05:44:46 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40720
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235817AbhISJoq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2021 05:44:46 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 610143F31E
        for <linux-ide@vger.kernel.org>; Sun, 19 Sep 2021 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632044600;
        bh=uaNs/xYVK85AxU1iGJvmG2bpbl9HxTnxXvUi2iolq6o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LDUfJFGExkVPACZTgAMKEKV+PSuYmFg1D3saFjGMNX1ia0IncFljFJQTVRuwmRRdb
         7k20aI81DWYcfZ15vASItwoZpJ9zKSb6piF6zrOikhU9VfT3iSw/GcIWGPNn1MrKN2
         I54JQF6OGpAmcziTUR6E3Z2Fe4hxcm0b4Q5dqiaQaQE+d8iTqRrv9cOdDv7V+Ocsiz
         /MlIBWKSd5p6YHscKE0378UH94UsD22ZyuXPtkD6aq81hkFyoR5wThq/QTwc41ytLj
         dXW9wJBmSJgoMFqjj95WFzCMde4pDlvyA2WUvp8NuwcfHbtk4RDHQeuu74zgw84jZh
         GS2A4tSm4bthg==
Received: by mail-ed1-f70.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso12167121ede.18
        for <linux-ide@vger.kernel.org>; Sun, 19 Sep 2021 02:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaNs/xYVK85AxU1iGJvmG2bpbl9HxTnxXvUi2iolq6o=;
        b=nbUN20CXhV6nG9wrlfq/qmiRlXWO7lvkP+VQLcCOxWz+bMnUIYZFhqcd/phxQuor3j
         ARP+ZrABJfWjRCDAoxahS7pIIbOudiLXPOEhyFGBeLojdEiYtH7jBtZ2WmgugsBzyH98
         +u3j/aNjXztJ1smkCQ9nKGDea0nXuJo5c0EsHHY8ozW9n5giX5MQXxDLn75wRL3hcpgp
         tMX/ce7BSX+Hx73688nrGyBflXn/bs+568O52FqhFsNZzhJyT1ULy0uOCoQET49nIb0R
         RASbC3fYe3QT67wCu3r/TjbMXIKMYjnqQWCNdl3XbP1B1gMFKhb2C2fcKz0x1uvaaUaX
         522g==
X-Gm-Message-State: AOAM530azR2xTerxYEGaOcxW5gFCBjCouCoT3+KdrFS48Hw7ji8Kq0HY
        hCbmI85XhHiSh222dF7FSuxBHEPT/jXI6hR3tmgW96YtxpuWpv9Dz7JKILCBASYBz8cvb6sWn4P
        ZEjYCUUkraggO8DAj7IK3AvDjwtPF4SExfIvzPg==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr22609923ejc.504.1632044600026;
        Sun, 19 Sep 2021 02:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGT4606JPYMwEU1a10XdgBbQ/KWQjrmYj4MW/2J+egl2qD355Htf5c2+iR0SHaiwij1MfkZA==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr22609908ejc.504.1632044599845;
        Sun, 19 Sep 2021 02:43:19 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c21sm4637015ejz.69.2021.09.19.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 02:43:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandra Yates <alexandra.yates@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2] ahci: remove duplicated PCI device IDs
Date:   Sun, 19 Sep 2021 11:43:13 +0200
Message-Id: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
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

Changes since v1:
1. Use still board_ahci_nosntf for 0x2822.
---
 drivers/ata/ahci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..63198ad95ed9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -258,7 +258,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
@@ -316,7 +316,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
+	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
@@ -358,8 +358,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
+	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg/Lewisburg AHCI*/
+	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x43d4), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d5), board_ahci }, /* Rocket Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x43d6), board_ahci }, /* Rocket Lake PCH-H RAID */
@@ -394,10 +394,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
-	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
-	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
-- 
2.30.2

