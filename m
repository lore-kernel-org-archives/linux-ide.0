Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F17C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 18 Feb 2022 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiBRLGT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiBRLGT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2022 06:06:19 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E82B4056
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2022 03:06:00 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 92A1C20EF8F4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-sff: fix reading uninitialized variable in
 ata_sff_lost_interrupt()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>
Organization: Open Mobile Platform
Message-ID: <5e02673b-57d2-40b1-ceba-55abfb251089@omp.ru>
Date:   Fri, 18 Feb 2022 14:05:57 +0300
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

Due to my sloppy coding in commit 2c75a451ecb0 ("ata: libata-sff: refactor
ata_sff_altstatus()"), in ata_sff_lost_interrupt() iff the device control
register doesn't exists, ata_port_warn() would print the 'status' variable
which never gets assigned.   Restore the original order of the statements,
wrapping the ata_sff_altstatus() call in WARN_ON_ONCE()...

While at it, fix crazy indentation in the ata_port_warn() call itself...

Fixes: 2c75a451ecb0 ("ata: libata-sff: refactor ata_sff_altstatus()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/ata/libata-sff.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -1644,13 +1644,14 @@ void ata_sff_lost_interrupt(struct ata_p
 		return;
 	/* See if the controller thinks it is still busy - if so the command
 	   isn't a lost IRQ but is still in progress */
-	if (ata_sff_altstatus(ap, &status) && (status & ATA_BUSY))
+	if (WARN_ON_ONCE(!ata_sff_altstatus(ap, &status)))
+		return;
+	if (status & ATA_BUSY)
 		return;
 
 	/* There was a command running, we are no longer busy and we have
 	   no interrupt. */
-	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n",
-								status);
+	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
 	/* Run the host interrupt logic as if the interrupt had not been
 	   lost */
 	ata_sff_port_intr(ap, qc);
