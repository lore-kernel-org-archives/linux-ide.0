From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: skip suppress reporting if ATA_EHI_QUIET
Date: Tue, 9 Oct 2007 14:57:56 +0900
Message-ID: <20071009055756.GG12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:8843 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXJIF60 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 01:58:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1917476wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 22:58:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ATA_EHI_NO_AUTOPSY and ATA_EHI_QUIET are used during initial probing
to skip exception analysis and reporting.  Usually, there's nothing to
report but on some allowed but rare corner cases (e.g. phy status
changed interrupt when IRQ is enabled on frozen port - this happens if
IRQ pending status isn't cleared in the IRQ router or controller)
exception messages get printed.

Skip reporting if ATA_EHI_QUIET is set.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0bd3898..866ac9d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1868,6 +1868,9 @@ static void ata_eh_link_report(struct ata_link *link)
 	char tries_buf[6];
 	int tag, nr_failed = 0;
 
+	if (ehc->i.flags & ATA_EHI_QUIET)
+		return;
+
 	desc = NULL;
 	if (ehc->i.desc[0] != '\0')
 		desc = ehc->i.desc;
-- 
1.5.0.3

