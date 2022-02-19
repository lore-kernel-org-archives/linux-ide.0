Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7AC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Feb 2022 20:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiBSUE4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Feb 2022 15:04:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243099AbiBSUEz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Feb 2022 15:04:55 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044E64C6
        for <linux-ide@vger.kernel.org>; Sat, 19 Feb 2022 12:04:32 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 1E15520A2BCC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_hpt37x: fix PCI clock detection
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
Date:   Sat, 19 Feb 2022 23:04:29 +0300
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

The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
The bug was there from the very srart... :-(

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org

---
This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_hpt37x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/pata_hpt37x.c
===================================================================
--- libata.orig/drivers/ata/pata_hpt37x.c
+++ libata/drivers/ata/pata_hpt37x.c
@@ -950,14 +950,14 @@ static int hpt37x_init_one(struct pci_de
 
 	if ((freq >> 12) != 0xABCDE) {
 		int i;
-		u8 sr;
+		u16 sr;
 		u32 total = 0;
 
 		dev_warn(&dev->dev, "BIOS has not set timing clocks\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
-			pci_read_config_byte(dev, 0x78, &sr);
+			pci_read_config_word(dev, 0x78, &sr);
 			total += sr & 0x1FF;
 			udelay(15);
 		}

