Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD1C2BA83
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80208206B6
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702912;
	bh=tKutHQzqUEtlGwZgT4t3m5DF0mw5khkEEf3otkXuA88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cb36sCipcpUsbwEaqKUTiREEq32WU9dVvwubD94wgomCqbTeLkQweVDkfj7CGH6rL
	 3uVsBL0RBq6ZGT6ryLcuVa29hOojEk4SqXCsQtQs1HuGL8m7bZaIIovElfB3FGmC+2
	 GDG6wm2okL5KP2WDGDOlb4JhgBmpPfu8Bx7oXkIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbgBNRzH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbgBNP5v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4181206D7;
        Fri, 14 Feb 2020 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695870;
        bh=tKutHQzqUEtlGwZgT4t3m5DF0mw5khkEEf3otkXuA88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyQQmQ+5+xjl5KWpSo3Y1huCcrgy801zUxo+XB1peLuO3QT87a27UNHIpnYVfVHsh
         PE6gtJUgCQjAlxU5sMAASZSxC/KxlD0voBIUODpDCyY5U8L49TG/ceSOUpGqBEMAGi
         Ru6iFR7dSPGLH+CsAIb38rqt+Qn3qpMpNiceLM5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 416/542] ide: serverworks: potential overflow in svwks_set_pio_mode()
Date:   Fri, 14 Feb 2020 10:46:48 -0500
Message-Id: <20200214154854.6746-416-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ce1f31b4c0b9551dd51874dd5364654ed4ca13ae ]

The "drive->dn" variable is a u8 controlled by root.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/serverworks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ide/serverworks.c b/drivers/ide/serverworks.c
index ac6fc3fffa0de..458e72e034b09 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -115,6 +115,9 @@ static void svwks_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci))
+		return;
+
 	pci_write_config_byte(dev, drive_pci[drive->dn], pio_modes[pio]);
 
 	if (svwks_csb_check(dev)) {
@@ -141,6 +144,9 @@ static void svwks_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci2))
+		return;
+
 	pci_read_config_byte(dev, (0x56|hwif->channel), &ultra_timing);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
-- 
2.20.1

