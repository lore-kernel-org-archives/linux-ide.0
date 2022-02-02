Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CDEC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 20:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiBBUHw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:07:52 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:43014 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbiBBUHu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 15:07:50 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 01429209C642
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] libata: ata_{sff|std}_prereset() always return 0
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <b1d72683-d645-6ebc-bd66-f5dc1bc2ba02@omp.ru>
Date:   Wed, 2 Feb 2022 23:07:45 +0300
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

ata_std_prereset() always returns 0, hence the check in ata_sff_prereset()
is pointless and thus it also can return only 0 (however, we cannot change
the prototypes of ata_{sff|std}_prereset() as they implement the driver's
prereset() method).

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 3:
- added a comment to ata_std_prereset() call in ata_sff_prereset().

Changes in version 2:
- fixed up the 'kernel-doc' comments on the function results.

 drivers/ata/libata-core.c |    2 +-
 drivers/ata/libata-sff.c  |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -3568,7 +3568,7 @@ EXPORT_SYMBOL_GPL(ata_wait_after_reset);
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
- *	0 on success, -errno otherwise.
+ *	Always 0.
  */
 int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 {
Index: libata/drivers/ata/libata-sff.c
===================================================================
--- libata.orig/drivers/ata/libata-sff.c
+++ libata/drivers/ata/libata-sff.c
@@ -1708,16 +1708,15 @@ EXPORT_SYMBOL_GPL(ata_sff_thaw);
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
- *	0 on success, -errno otherwise.
+ *	Always 0.
  */
 int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	int rc;
 
-	rc = ata_std_prereset(link, deadline);
-	if (rc)
-		return rc;
+	/* The standard prereset is best-effort and always returns 0 */
+	ata_std_prereset(link, deadline);
 
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
