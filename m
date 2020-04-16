Return-Path: <SRS0=eHQz=6A=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD397C2BA2B
	for <linux-ide@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DB6206D6
	for <linux-ide@archiver.kernel.org>; Thu, 16 Apr 2020 06:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408100AbgDPGf4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:35:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407924AbgDPGfv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2020 02:35:51 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jOy7l-000851-Dp; Thu, 16 Apr 2020 06:35:45 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     axboe@kernel.dk
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ahci: Add Intel Comet Lake PCH-U PCI ID
Date:   Thu, 16 Apr 2020 14:35:40 +0800
Message-Id: <20200416063540.30462-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Intel Comet Lake PCH-U PCI ID to the list of supported controllers.

Set default SATA LPM so the SoC can enter S0ix.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0101b65250cb..0c0a736eb861 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -410,6 +410,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
 	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
-- 
2.17.1

