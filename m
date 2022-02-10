Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06569C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiBJKcw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiBJKcv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 05:32:51 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A6BD2
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 02:32:47 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru DF3F720DAAF8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: sata_rcar: drop unused #define's
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <328ce96c-1212-33bc-5d13-4aec88384485@omp.ru>
Date:   Thu, 10 Feb 2022 13:32:42 +0300
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

This driver has never used the SH-Navi2G/ATAPI-ATA compatible taskfile
registers (the driver uses the taskfile registers in another location
anyway), so drop their #define's...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/sata_rcar.c |    4 ----
 1 file changed, 4 deletions(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -18,10 +18,6 @@
 
 #define DRV_NAME "sata_rcar"
 
-/* SH-Navi2G/ATAPI-ATA compatible task registers */
-#define DATA_REG			0x100
-#define SDEVCON_REG			0x138
-
 /* SH-Navi2G/ATAPI module compatible control registers */
 #define ATAPI_CONTROL1_REG		0x180
 #define ATAPI_STATUS_REG		0x184
