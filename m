From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: typo fix
Date: Thu, 19 Oct 2006 14:44:53 +0900
Message-ID: <20061019054453.GE13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:33941 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030303AbWJSFqy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Oct 2006 01:46:54 -0400
Received: by nf-out-0910.google.com with SMTP id c2so922822nfe
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 22:46:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Typo fix in commment.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index d0a7ad5..b03d5a3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,7 +143,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
-	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* devied limited to non-NCQ mode */
+	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SUSPENDED	= (1 << 10), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
-- 
1.4.2.3

