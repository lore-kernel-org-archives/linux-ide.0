From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]libata: optimize the ncq tag search
Date: Wed, 2 Sep 2009 10:19:24 +0800
Message-ID: <20090902021924.GA23381@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbZIBCTc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 22:19:32 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

the bitop API should be a little faster than the loop.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/ata/libata-core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux/drivers/ata/libata-core.c
===================================================================
--- linux.orig/drivers/ata/libata-core.c	2009-09-02 10:06:47.000000000 +0800
+++ linux/drivers/ata/libata-core.c	2009-09-02 10:07:47.000000000 +0800
@@ -4842,11 +4842,15 @@ static struct ata_queued_cmd *ata_qc_new
 		return NULL;
 
 	/* the last tag is reserved for internal command. */
-	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
+	while (1) {
+		i = find_first_zero_bit(&ap->qc_allocated, ATA_MAX_QUEUE - 1);
+		if (i >= ATA_MAX_QUEUE - 1)
+			break;
 		if (!test_and_set_bit(i, &ap->qc_allocated)) {
 			qc = __ata_qc_from_tag(ap, i);
 			break;
 		}
+	}
 
 	if (qc)
 		qc->tag = i;
