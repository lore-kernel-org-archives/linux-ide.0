Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA32C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7252960EBD
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhJKJD4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 05:03:56 -0400
Received: from hal9001.startit.hu ([213.134.5.39]:40466 "EHLO
        hal9001.startit.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbhJKJDz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 05:03:55 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 05:03:55 EDT
Received: by hal9001.startit.hu (Postfix, from userid 0)
        id BAEB8A5D2E; Mon, 11 Oct 2021 10:56:32 +0200 (CEST)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH] Add AHCI support for (noname) PCIe sata cards based on ASM1062+JBM575 cards, usually 10 SATA ports or more. DeviceID: 0624 (rev 01)
Date:   Mon, 11 Oct 2021 10:56:29 +0200
Message-Id: <20211011085629.3891-1-pongracz.istvan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..f8199f021ed4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASMedia Technology Inc. Device 0624 (rev 01) based PCIe port multiplier cards (ex. 10 ports card with 1 x ASM1062 + 2 x JMB575 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-- 
2.20.1

