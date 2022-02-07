Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0730C4321E
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiBGUrw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbiBGUcY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2022 15:32:24 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2CEC0401DA
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 12:32:23 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru D3CA9209A3F3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] pata_hpt3x2n: fix writing to wrong register in
 hpt3x2n_bmdma_stop()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <2ce292b5-d49f-740e-1445-be7375963a58@omp.ru>
Date:   Mon, 7 Feb 2022 23:32:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The driver's bmdma_stop() method writes to the wrong PCI config register
(0x52 intead of 0x54) when trying to clear the state machine on secondary
channel -- "luckily", the write falls on a read-only part of the primary
channel MISC. control 1 register, so no collateral damage is done...

Alan Cox fixed the HPT37x driver in commit 6929da4427b4 ("[PATCH] hpt37x:
Two important bug fixes") but forgot to check the HPT3x2N driver which has
the same bug. :-/

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_hpt3x2n.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/pata_hpt3x2n.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt3x2n.c
+++ libata/drivers/ata/pata_hpt3x2n.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.16"
+#define DRV_VERSION	"0.3.17"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -251,7 +251,7 @@ static void hpt3x2n_bmdma_stop(struct at
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int mscreg = 0x50 + 2 * ap->port_no;
+	int mscreg = 0x50 + 4 * ap->port_no;
 	u8 bwsr_stat, msc_stat;
 
 	pci_read_config_byte(pdev, 0x6A, &bwsr_stat);
