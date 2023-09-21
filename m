Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D47E7D0A2
	for <linux-ide@archiver.kernel.org>; Thu, 21 Sep 2023 17:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIURv1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIURvN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Sep 2023 13:51:13 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74276E58
        for <linux-ide@vger.kernel.org>; Thu, 21 Sep 2023 09:57:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65636207df5so6089326d6.2
        for <linux-ide@vger.kernel.org>; Thu, 21 Sep 2023 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315452; x=1695920252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InjavFcfZn5dRVSB9YmW8wKkCMSRPil5AEMl1AlEhHs=;
        b=NjDxI5PzIHqJ5sZrQcfYDK378uB7d6EkUEufcPo81V9MqptQK4uwk7TTSS6tJOUoqD
         fKhdJA6M2lebVwLuBm6iWaZcLREZsGfnUkPwNmHHckgg6ho2pbZkkehTyBTaJyj9IKM+
         Blsj7A5a4Lz96DKioZlj21Wx173GglkzSugDoQ666gThlpk8I/dDuy0aO9Otw6xskNTf
         MxjVi+RqqQAdTbKaWCirVUGFAaPuvdUfMKOuxnC97ocNihKnJlb0Czl/YooQlvec0ZGr
         C9m7qKcLQCO785osd8TeYDQJk6s19sAuOaxW9h+dFArW3d/RV3+6vmFnW850PbpF6xdD
         tblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315452; x=1695920252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InjavFcfZn5dRVSB9YmW8wKkCMSRPil5AEMl1AlEhHs=;
        b=AY8oGejnlkI/oBpNtKogUdksXfK/HnXKZEtoGVDNBbIS4YEwTva6pdJ0ezwdJsl/dG
         clCnPdxLMG0sxh7nwvnjPCVJgjCp1e5XTE98cvZ/Iyh0ku7tl4ze+erzDls6X7Z+QE5K
         e3lMAAvP5bg2Ncl4pJo/wQgVPIRGHgE6S5hVek0mCgPrMJyTtj46rTpeQBxrMVJ9mbnt
         ZDtNc9qa+09wE16Xp2ccU7RvDgcoobqqRQRx/C+4N2RMxzlbZRShnhdyB11FRDKDA90y
         ZkRN7KqD30fgjljSImTd7cssgFSXMiVECxda6qKD13rhjGSzAPeytrt7G2CaDtHf3IoZ
         7XKA==
X-Gm-Message-State: AOJu0YxWzFGuirOxeRO5KKUq5zLJQ1kpgv0UPVKgVE+W4+LRa5/ihnI2
        c5A2aaSkOejn2sjjnC8977xrolyQLrc=
X-Google-Smtp-Source: AGHT+IG9s5soowfseCQkgXtC7RJn/RjY8MWkxMrnT0TIWQQk6RlLd7Zi3ItzbY1pmwKh4JECEb0Lgg==
X-Received: by 2002:a17:902:82c4:b0:1b9:e8a5:3699 with SMTP id u4-20020a17090282c400b001b9e8a53699mr3823879plz.21.1695288837488;
        Thu, 21 Sep 2023 02:33:57 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090282c200b001bc445e2497sm992820plz.79.2023.09.21.02.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:33:57 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: [PATCH] ahci: add identifiers for ASM2116 series devices.
Date:   Thu, 21 Sep 2023 17:33:51 +0800
Message-Id: <20230921093351.14403-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add support for PCIe SATA expander cards based on Asmedia 2116 controllers.
These cards can provide up to 10 or more SATA port on PCIe card

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
 drivers/ata/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 08745e7db820..99b3d3e60774 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -604,6 +604,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
+	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1165), board_ahci },   /* ASM1165 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1166), board_ahci },   /* ASM1166 */

 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
--
2.39.2

