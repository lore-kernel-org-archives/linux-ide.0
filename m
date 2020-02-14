Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CAC2BA83
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3C20656
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699822;
	bh=rjrhQW09Vso9tajVY7leCL9tNge/xnc21nLf2tfe578=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HKEYqdoUiA4IuTejxW9K8WxgxdDMgOuPqRHTNCL5jRfGr5cRX9eYbZf/yNv8u6PsB
	 CeGiJYvTuRb+Lww9OGDYZTJ6TxsMNMVM+oRZEhgJHb3fh8HfWYIO/yYcyG4eoEmN4x
	 Aw5gH3wEhs71nO28A3IhSo7VpN9/e2wYk0Mg6ZeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbgBNRDj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403985AbgBNQPv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7BA246E0;
        Fri, 14 Feb 2020 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696951;
        bh=rjrhQW09Vso9tajVY7leCL9tNge/xnc21nLf2tfe578=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeVKP67ZGAPKIT+Yu0AEXcpaNH3dkTXjFg4vBZZM34Oiv5tO2vUJaxDlQT6U5G26H
         vOpnlyTlLVK2F+dl08uC4H7sbnpDWHCFsqejN6qDySpF3dVf3j8xW9GtS5ic13uNFS
         zbMpJ2KwMcaQq4yJkx4N7bkSRQqj7PW3R4WsCq/E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 192/252] ide: serverworks: potential overflow in svwks_set_pio_mode()
Date:   Fri, 14 Feb 2020 11:10:47 -0500
Message-Id: <20200214161147.15842-192-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
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
index a97affca18abe..0f57d45484d1d 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -114,6 +114,9 @@ static void svwks_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	const u8 pio = drive->pio_mode - XFER_PIO_0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci))
+		return;
+
 	pci_write_config_byte(dev, drive_pci[drive->dn], pio_modes[pio]);
 
 	if (svwks_csb_check(dev)) {
@@ -140,6 +143,9 @@ static void svwks_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
 
+	if (drive->dn >= ARRAY_SIZE(drive_pci2))
+		return;
+
 	pci_read_config_byte(dev, (0x56|hwif->channel), &ultra_timing);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
-- 
2.20.1

