Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E044C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 20:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiDKUge (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiDKUgd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 16:36:33 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F166318
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 13:34:13 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 2800F20F1B9B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: pata_via: fix sloppy typing in via_do_set_mode()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <009887e0-8c99-928e-06d0-e2e5882cf6ad@omp.ru>
Date:   Mon, 11 Apr 2022 23:34:10 +0300
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

The *unsigned long* variable 'T' is initialized with an *int* value
(luckily always positive) -- to avoid that, declare the 'via_clock'
variable as *unsigned int* and make the divisible constant *unsigned*
too.  While at it, make the 'via_clock' and 'T' variables *const* as
they are never re-assigned after initialization -- the object code
remains the same as gcc previously used copy propagation anyway...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

 drivers/ata/pata_via.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: libata/drivers/ata/pata_via.c
===================================================================
--- libata.orig/drivers/ata/pata_via.c
+++ libata/drivers/ata/pata_via.c
@@ -248,8 +248,8 @@ static void via_do_set_mode(struct ata_p
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	struct ata_device *peer = ata_dev_pair(adev);
 	struct ata_timing t, p;
-	static int via_clock = 33333;	/* Bus clock in kHZ */
-	unsigned long T =  1000000000 / via_clock;
+	const unsigned int via_clock = 33333;	/* Bus clock in kHz */
+	const unsigned long T = 1000000000U / via_clock;
 	unsigned long UT = T;
 	int ut;
 	int offset = 3 - (2*ap->port_no) - adev->devno;
