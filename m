Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A6C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Apr 2022 23:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiDLXU7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDLXUt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2022 19:20:49 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828152A26C
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 15:07:52 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru E4DAF20D7FB0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] ata: pata_via: fix sloppy typing in via_do_set_mode()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <e8d0b22b-9052-7cfc-4088-b407643c4bf8@omp.ru>
Date:   Tue, 12 Apr 2022 23:39:52 +0300
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

The local variables 'T' and 'UT' are needlessly declared as *unsigned*
*long* -- the corresponding parameters of ata_timing_compute() are both
declared as *int*.  While fixing up those declarations, also make the
'via_clock' and 'T' variables *const* as they are never re-assigned
after initialization -- the object code should remain the same as gcc
previously used copy propagation anyway...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 2:
- declared the 'T' and 'UT' variables as *int* instead of *unsigned long*;
- dropped *unsigned* from the 'via_clock' variable declaration;
- updated the patch description.

 drivers/ata/pata_via.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: libata/drivers/ata/pata_via.c
===================================================================
--- libata.orig/drivers/ata/pata_via.c
+++ libata/drivers/ata/pata_via.c
@@ -248,9 +248,9 @@ static void via_do_set_mode(struct ata_p
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_device *peer = ata_dev_pair(adev);
 	struct ata_timing t, p;
-	static int via_clock = 33333;	/* Bus clock in kHZ */
-	unsigned long T =  1000000000 / via_clock;
-	unsigned long UT = T;
+	const int via_clock = 33333;	/* Bus clock in kHz */
+	const int T = 1000000000 / via_clock;
+	int UT = T;
 	int ut;
 	int offset = 3 - (2*ap->port_no) - adev->devno;
 
