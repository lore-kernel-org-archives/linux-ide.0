Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD023C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED3660F3A
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhJKVOh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhJKVOg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 17:14:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45265C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 14:12:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so60255818wrg.6
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDZqSN/CqsJYVbQfLmgspXe5Wc0uVqvXHnzhvKQviq4=;
        b=mVcyalE0QCoH5QnKcDmBtNteNH9NXoBaj7NWTGyOtRC2FeAVtGqupUI4YO1SK/Obtc
         94n43vP9ylirx7Mxxa/7p+fphKlyW5uRcOaeAXnJy089jwWOECvk3EoD/W5eGj4zCskE
         OQlUwXbpEt1Rf2L7bkAky/iaQPDWV2OSOjw9pBkx4hc6Hw+3GaKBVDoaCmdsXahsjppT
         Arkyokena60WbAOCq75MgW2/lhMgjCqh/5Cesny8LfSClp2j/woQAxyr0LAaZvG33LEz
         UyHYPiZA91KWAoJy1UUYVz+I42wYrX+gAAP2XCM8rgUSW9CxTQC4OERylWIwbTT4rTte
         WQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDZqSN/CqsJYVbQfLmgspXe5Wc0uVqvXHnzhvKQviq4=;
        b=hv7gbySrbLkBMjSycJWtIm4Zq8LJV4WoZ4oAWva+r+/wJcYeuyZ/lA7xMxwDx1BxQD
         G5rTYwMTFhkN0GlPXC0a+IjWiU8EAa5ejrd160uk1uVLrcMIBvS6pzilQ95fbnaAG1Q6
         nm3Rb6ZVlFfVzUav8u9nxhS8cWk5IGQbdMB1ML7faoZ9ks7BsQd1CcIAFT2v1JKsy5dH
         5daFvNR6qci80a7yMU7yHYzwsEMFDuGOfR9m5/GvOrkZhkF42zkd/8qNV08v26uc9baK
         Mcx4jb+/wA+vndbmbF1dEx9TZyTobEehNeB8UuoiFIQHZhZJf6fiPliC7o+pIcC+ahDH
         yAWg==
X-Gm-Message-State: AOAM532VmP4VkFuewbJ6TkJDOikp2d74q+KqhBrCYxfhANr7fgGKlSm5
        eCLdVJpcHuU5XSNLWBiAHOQV9JRuKoc=
X-Google-Smtp-Source: ABdhPJwGxyp2kYCsWpoFgopzNDN4O5N2psgC0HSXKkoMoC4y+sY+kLQxhgPwUPMtE4fa7zIKGF9F1w==
X-Received: by 2002:a05:6000:11:: with SMTP id h17mr5806709wrx.278.1633986754844;
        Mon, 11 Oct 2021 14:12:34 -0700 (PDT)
Received: from hal9001.startit.hu (hal9001.startit.hu. [213.134.5.39])
        by smtp.googlemail.com with ESMTPSA id q7sm9111271wrs.73.2021.10.11.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:12:34 -0700 (PDT)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH v3] Add AHCI support for ASM1062+JBM575 cards
Date:   Mon, 11 Oct 2021 23:12:27 +0200
Message-Id: <20211011211227.7020-1-pongracz.istvan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add support for PCIe SATA expander cards based on ASMedia 1062 + JBM575
controllers.
These cards can provide up to 10 or more SATA ports on one PCIe card.

Signed-off-by: István Pongrácz <pongracz.istvan@gmail.com>
---
 Changes from v1: rework commit message to meet syntax and content requirements.
 Changes from v2: format changelog

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..97fd96b67731 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-- 
2.20.1

