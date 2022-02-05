Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C5C433EF
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380851AbiBESPi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 13:15:38 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:59376 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiBESPh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 13:15:37 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 0E28120606C4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] pata_hpt3x2n: check channel enable bits
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <66e64122-6201-4ae6-3c20-002ec929d5be@omp.ru>
Date:   Sat, 5 Feb 2022 21:15:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The dirver's prereset() method still doesn't check the channel enable bits.
The bug was there for the entire time the driver has existed. :-/

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_hpt3x2n.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: libata/drivers/ata/pata_hpt3x2n.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt3x2n.c
+++ libata/drivers/ata/pata_hpt3x2n.c
@@ -168,6 +168,13 @@ static int hpt3x2n_pre_reset(struct ata_
 {
 	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	static const struct pci_bits hpt3x2n_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
+
+	if (!pci_test_config_bits(pdev, &hpt3x2n_enable_bits[ap->port_no]))
+		return -ENOENT;
 
 	/* Reset the state machine */
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
