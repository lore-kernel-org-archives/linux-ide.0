Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56BFC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 14:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiBGOdk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbiBGO0U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 09:26:20 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553FC0401C2
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 06:26:17 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru E3077238A533
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] pata_hpt3x2n: check channel enable bits
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <062c3834-da7e-273e-177b-d7aea4b1ba81@omp.ru>
Date:   Mon, 7 Feb 2022 17:26:13 +0300
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

The driver's prereset() method still doesn't check the channel enable bits.
The bug was there for the entire time the driver has existed. :-/

Alan Cox fixed the HPT37x driver in commit b5bf24b94c65 ("[PATCH] hpt37x:
Check the enablebits") but forgot to check the HPT3x2N driver which has
the same bug. :-/

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 3:
- added a passage to the patch description about Alan Cox missing to fix
  the driver back in 2006.

Changes in version 2:
- updated #define DRV_VERSION;
- fixed typo in the patch description.

 drivers/ata/pata_hpt3x2n.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: libata/drivers/ata/pata_hpt3x2n.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt3x2n.c
+++ libata/drivers/ata/pata_hpt3x2n.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.15"
+#define DRV_VERSION	"0.3.16"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
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
