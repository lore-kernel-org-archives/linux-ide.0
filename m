Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD7C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiA1UpZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 15:45:25 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:37174 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiA1UpZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 15:45:25 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru AFA1B20A00A4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] libata: ata_{sff|std}_prereset() always return 0
Organization: Open Mobile Platform
Message-ID: <d63ddc77-ddc8-d15a-030f-592cece64742@omp.ru>
Date:   Fri, 28 Jan 2022 23:45:22 +0300
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

ata_std_prereset() always returns 0, hence the check in ata_sff_prereset()
is pointless and thus it also can return only 0 (however, we cannot change
the prototypes of ata_{sff|std}_prereset() as they implement the driver's
prereset() method).

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git' repo.

 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-sff.c  |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -3568,7 +3568,7 @@ EXPORT_SYMBOL_GPL(ata_wait_after_reset);
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
- *	0 on success, -errno otherwise.
+ *	0 on success.
  */
 int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 {
Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -1708,16 +1708,14 @@ EXPORT_SYMBOL_GPL(ata_sff_thaw);
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
- *	0 on success, -errno otherwise.
+ *	0 on success.
  */
 int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	int rc;
 
-	rc = ata_std_prereset(link, deadline);
-	if (rc)
-		return rc;
+	ata_std_prereset(link, deadline);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
