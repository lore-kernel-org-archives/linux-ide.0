From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] libata: export ata_get_cmd_descript()
Date: Fri, 12 Dec 2014 17:16:31 +0200
Message-ID: <1418397391-13668-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2896 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933263AbaLLPRY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Dec 2014 10:17:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The driver sata_dwc_460ex is using this symbol. To build it as a module we have
to have the symbol exported. This patch adds EXPORT_SYMBOL() macro for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3dbec89..74fef87 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2389,6 +2389,7 @@ const char *ata_get_cmd_descript(u8 command)
 
 	return NULL;
 }
+EXPORT_SYMBOL(ata_get_cmd_descript);
 
 /**
  *	ata_eh_link_report - report error handling to user
-- 
2.1.3

