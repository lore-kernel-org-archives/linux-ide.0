Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A721C433E6
	for <linux-ide@archiver.kernel.org>; Fri, 12 Feb 2021 01:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE1C64DE0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Feb 2021 01:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBLBcM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Feb 2021 20:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBLBcK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Feb 2021 20:32:10 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7B4C061574
        for <linux-ide@vger.kernel.org>; Thu, 11 Feb 2021 17:31:30 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id e4so7058172ote.5
        for <linux-ide@vger.kernel.org>; Thu, 11 Feb 2021 17:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtJNBokog8aRz4uNWjyqFaoQbcCb/iElOv+L3xRge7c=;
        b=plEOzuH2z/ynQSjqyplN4B9tr7lPDvDmWL+ELkQqTxxFRveypi2YymnZ+4pFsj7LBU
         Ftfx6aiYH0lkCTdEcvBHCxriAhDjk0hU5LjrDgBEat/8zWhTc8AI2hINV4swJC3v5H85
         pBXWv6mVArS/2H2JIttB2HxSM8/3hkRkvrj01q6aq5XJLIKNbyE43vcAfCgnsd9EVb3R
         Z3KXH1YQdzRx3FYl+REXMxdPZ17woe28a/xkdiputj1kXjfVeOmGP/Ca9UAcauIwpATX
         8EMEqSatpGE9Hp5tHg18SslTwJzbdU9meuHffC2dgvoz8oCgrw31LwobpfdyG3RMRE47
         88+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtJNBokog8aRz4uNWjyqFaoQbcCb/iElOv+L3xRge7c=;
        b=AKSIkCDfd9Z5tCU2dzuxt/Zp/e0is80iauB8JHVn0jZ/CNyS27IdTM2pGH7pdoS8wx
         YgrR1lGgOSRuJ5R70TzfFTVGi3m/TKRSwrJzR8rUcxiViETBh/5dQDdtrJA+pjIOFFuU
         vzxoiVDU55T1Kzefztr0Ug5OdSOqCRxzkuR2LVl8aWhi9ZYgIuUJSuWcTlrpacCpIqgC
         niTU6ql0+WrdG7H5Xa+4u2yGHnQGGIK4C4IU4HelWOSP2t1iHT+WjfZ9OJRhXdX3HdWR
         sP+nrqCnnCsXYRpaI9mNAf3eu5sRvfYcX/Fjbs9DuaU4NwufeOwt3Og8r1NlkIohbqdn
         27Qg==
X-Gm-Message-State: AOAM5334Ejp1lKTUtsIEArSo15xHfF4QzQk7cO9EvEVU14kl2CtemkvS
        8npsQvGwYtAEMA5gY6Zxruk=
X-Google-Smtp-Source: ABdhPJz25PvuL8/cU9JO/LfghEc1jIjrPLLpuYD6gXO5NsoZ54zWIQNvCvNSVEaYILkCBJBMgvPoZQ==
X-Received: by 2002:a9d:7986:: with SMTP id h6mr515057otm.310.1613093489689;
        Thu, 11 Feb 2021 17:31:29 -0800 (PST)
Received: from localhost.localdomain (47-221-148-229.gtwncmta03.res.dyn.suddenlink.net. [47.221.148.229])
        by smtp.gmail.com with ESMTPSA id s18sm1355261oih.53.2021.02.11.17.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 17:31:29 -0800 (PST)
From:   Charles Rose <charles.e.rose@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, linux-ide@vger.kernel.org
Cc:     Charles Rose <charles.rose@dell.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Charles Rose <charles.e.rose@gmail.com>
Subject: [PATCH] ahci: Add support for Dell S140 and later
Date:   Thu, 11 Feb 2021 19:30:10 -0600
Message-Id: <20210212013010.322818-1-charles.e.rose@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Charles Rose <charles.rose@dell.com>

This patch enables support for Dell S140 and later sw-raid solutions 
that use Intel's PCHs configured as PCI_CLASS_STORAGE_RAID.

Reviewed-by: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Charles Rose <charles.e.rose@gmail.com>
---
 drivers/ata/ahci.c      | 4 ++++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 00ba8e5a1ccc..49cda9495d7e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -446,6 +446,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
 
+	/* Dell S140/S150 */
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
+
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
 	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d8156a5dbee8..ab906c7a1ad6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -630,6 +630,8 @@
 #define PCI_DEVICE_ID_DELL_RAC4		0x0012
 #define PCI_DEVICE_ID_DELL_PERC5	0x0015
 
+#define PCI_SUBVENDOR_ID_DELL		0x1028
+
 #define PCI_VENDOR_ID_MATROX		0x102B
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518
 #define PCI_DEVICE_ID_MATROX_MIL	0x0519
-- 
2.25.4

