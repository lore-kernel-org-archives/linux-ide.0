Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CBEC433EF
	for <linux-ide@archiver.kernel.org>; Sat,  9 Apr 2022 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiDITQN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 9 Apr 2022 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiDITQM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 9 Apr 2022 15:16:12 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C9236BBA
        for <linux-ide@vger.kernel.org>; Sat,  9 Apr 2022 12:14:00 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 7421920D19E7
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: fix parameter type in ata_xfer_mode2shift()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <e028feca-f049-c3e5-ac4c-ec071a4e2972@omp.ru>
Date:   Sat, 9 Apr 2022 22:13:56 +0300
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

The data transfer mode that corresponds to the 'xfer_mode' parameter for
ata_xfer_mode2shift() is a 8-bit *unsigned* value.  Using *unsigned long*
to declare the parameter leads to a problematic implicit *int* to *unsigned
long* cast and was most probably a result of a copy/paste mistake -- use
the 'u8' type instead, as in ata_xfer_mode2mask()...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/libata-core.c |    2 +-
 include/linux/libata.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -898,7 +898,7 @@ EXPORT_SYMBOL_GPL(ata_xfer_mode2mask);
  *	RETURNS:
  *	Matching xfer_shift, -1 if no match found.
  */
-int ata_xfer_mode2shift(unsigned long xfer_mode)
+int ata_xfer_mode2shift(u8 xfer_mode)
 {
 	const struct ata_xfer_ent *ent;
 
Index: libata/include/linux/libata.h
===================================================================
--- libata.orig/include/linux/libata.h
+++ libata/include/linux/libata.h
@@ -1111,7 +1111,7 @@ extern void ata_unpack_xfermask(unsigned
 			unsigned long *udma_mask);
 extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
 extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
-extern int ata_xfer_mode2shift(unsigned long xfer_mode);
+extern int ata_xfer_mode2shift(u8 xfer_mode);
 extern const char *ata_mode_string(unsigned long xfer_mask);
 extern unsigned long ata_id_xfermask(const u16 *id);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
