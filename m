Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A06C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A66760F22
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJKVHF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhJKVHF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 17:07:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A56C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 14:05:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so60284750wrg.5
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8yJ109S73YWS1wLz5VjzFs22SmxXmF54UQ6YZ5ZTiM=;
        b=Vch3yDVrw728z6iwxHekf5eqOZQqCEUhIj56fPRnxW/EzfXZz9isk1So1XPGf2B/mv
         jNI6QO5jNMXhFyiqBubuJ+1uZkVSCqL503Q93/X9JNH8y1OD1JaIVqk/cJVLowHhhl/e
         U1jdcSEi+qZ5yU0dcpl/YTFcJxAViGE6VPtPCoUtKem/FDo5HtoLckXblxihWl0MEu17
         xbLRXEOHyVqWdggX9mXHBmg+mJCEDoPNVTr5F8v1oxIUSJIF+0YmJbRNWocp0NPDfd/p
         +B50yfi5BZV/706A6z+dgOx3vv1pMPR9lONdmK8nIiV0B9akdSavbkkFqsaFsec9n0R7
         +Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T8yJ109S73YWS1wLz5VjzFs22SmxXmF54UQ6YZ5ZTiM=;
        b=nXVyRh/hymreGQyX1kAhbnXngM0avfZLfxfALrk/f4i44lHxCTozl7sSuzkpGEvuSz
         If0D8YFYXim6hRC7kNw1SOCDMSdW7cWMjNl8OVLWHvFKybHTF4KW0RAeFyntHn1VFK5i
         Dedk7aRhcADH4i0jL0wfJqjQ3EU2weW+Hf6JZr7LUrve02AxTw7exBXtxd6/bl587FU2
         ZijPpGM92PiK3DgsBqRsEroULD9fSA60OMcUzJP9kgsFgFGPpY75FqPJU1GLEsZp95az
         r41VFt697pvAqrnedSL7uTg9ZLORSUXJydZbx1UTU2EbMI4/rZQEwpml/IS+f5Qz66XK
         CNWQ==
X-Gm-Message-State: AOAM531Wp2OX7xZlZvae0YcsrI//0+zc5gNPo2WhVZi7uN8UMRT6xf69
        a1UCQwfK6ihhU15PtmIuIOWhx6Lu/es=
X-Google-Smtp-Source: ABdhPJx09M3HKrg6JaJOtKuy69KCwLHaCQy4dD2y13AOX1sLAjlGU/aYX/M8QnSfKLKapdS1QIqoTw==
X-Received: by 2002:a05:6000:1684:: with SMTP id y4mr27373922wrd.252.1633986303484;
        Mon, 11 Oct 2021 14:05:03 -0700 (PDT)
Received: from hal9001.startit.hu (hal9001.startit.hu. [213.134.5.39])
        by smtp.googlemail.com with ESMTPSA id p17sm8770883wro.34.2021.10.11.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:05:02 -0700 (PDT)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH v2] Add AHCI support for ASM1062+JBM575 cards
Date:   Mon, 11 Oct 2021 23:04:55 +0200
Message-Id: <20211011210455.3444-1-pongracz.istvan@gmail.com>
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
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)
 Changes from v1: rework commit message to meet syntax and content requirements.

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

