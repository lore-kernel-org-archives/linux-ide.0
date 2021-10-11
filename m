Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C61C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B7860E0B
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 11:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhJKLux (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbhJKLux (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 07:50:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B36C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 04:48:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y3so22214894wrl.1
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ut6PyDN/+HTDx8/YjNkAhZJnDBE0vdBROKFvrEoclZ0=;
        b=UoXs5qkpkP43SDAuar87msUdi/6n7Eg3bWGhLk3c2syizCNezeBdtP6TsfusW9qWC1
         Smku8Jjv7xpZ1GJBenLwx1w3GpiG++shPEgoP2p/6hFRYELFdz+TQcMNr/3Pu4fkT6lU
         47i7hQj9ijpsvjSvpKORc1cCTUMuzcX9zdiU3fOBlL29fuQxPv7R2/6Sk8I0DSqHTL1r
         hSH7q/7+Z9c93pEsfMw+xIrqSBhawK3juYehzfuWUZrGc/ZBpGijzx+gSdG+42+zqXQw
         qcLmpnMi23tdiKOODKoFbRkE4JTHVNF0y5H7oI3K5IKUpwjzH3GDXJjAXEJ8jR8UrVWz
         yqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ut6PyDN/+HTDx8/YjNkAhZJnDBE0vdBROKFvrEoclZ0=;
        b=DPdFd10DNUruPELWrNb13nZJr11cSQINvdyR+CxfFl9Gun/6YGdTV1+4sCFZCvT0VI
         B4TkwrwcCsVVf7UKBiHkFgAVXyb3642YkNKGt6xyXPshk9kWP8JqwG3jJTFRXuFipz+q
         78WoJVvh+LVGPxmqDHLed3TX8K2fn4J7/NvRgVQUHW6OxS6BP3XropSihdBPwOVmzjy/
         stnou6vSl4o4Ee7fIk8+CFLXz+tdhVZLEVAizCcbVbBPaqVwNkiohJZ2rQ+FZ22XQJQz
         NK5BnUzJlEAvmc7vpqGIyrh/so/+kfFSpkvbFnkrg/XTJiREzq/pDf2jLsxYm0qCoRYf
         UFKg==
X-Gm-Message-State: AOAM533mvAs+evEXzNoJZPJSRCd7znvoHcqjjA0w4T1r/Iq9+p7pTYe4
        IbbuwEmzLlwzYfJcvxu6w1lkFZa5fdI=
X-Google-Smtp-Source: ABdhPJwCD3wzy6nFOzlRZ33X2mhz6bD6iqycQBEgAD3o8YCuEVcHhU5enKm4fWzjgCsnJ65g3eCVFg==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr13263424wma.75.1633952932024;
        Mon, 11 Oct 2021 04:48:52 -0700 (PDT)
Received: from hal9001.startit.hu (hal9001.startit.hu. [213.134.5.39])
        by smtp.googlemail.com with ESMTPSA id n17sm6602914wrq.11.2021.10.11.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 04:48:51 -0700 (PDT)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH] Add AHCI support for ASM1062+JBM575 cards
Date:   Mon, 11 Oct 2021 13:48:34 +0200
Message-Id: <20211011114834.30773-1-pongracz.istvan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: István Pongrácz <pongracz.istvan@gmail.com>
---
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

