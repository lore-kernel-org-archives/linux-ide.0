From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 12/23] ata: sata_dwc_460ex: correct HOSTDEV{P}_FROM_*() macros
Date: Tue, 26 Apr 2016 12:03:13 +0300
Message-ID: <1461661404-1952-13-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42965 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbcDZJDf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Apr 2016 05:03:35 -0400
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Here we refactor HOSTDEV{P}_FROM_*() macros to fit one line and fix the
definition of HSDEV_FROM_HSDEVP() where wrong name of the parameter waas used.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 24837d6..2258baf 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -168,18 +168,13 @@ struct sata_dwc_device_port {
 };
 
 /*
- * Commonly used DWC SATA driver Macros
+ * Commonly used DWC SATA driver macros
  */
-#define HSDEV_FROM_HOST(host)  ((struct sata_dwc_device *)\
-					(host)->private_data)
-#define HSDEV_FROM_AP(ap)  ((struct sata_dwc_device *)\
-					(ap)->host->private_data)
-#define HSDEVP_FROM_AP(ap)   ((struct sata_dwc_device_port *)\
-					(ap)->private_data)
-#define HSDEV_FROM_QC(qc)	((struct sata_dwc_device *)\
-					(qc)->ap->host->private_data)
-#define HSDEV_FROM_HSDEVP(p)	((struct sata_dwc_device *)\
-						(hsdevp)->hsdev)
+#define HSDEV_FROM_HOST(host)	((struct sata_dwc_device *)(host)->private_data)
+#define HSDEV_FROM_AP(ap)	((struct sata_dwc_device *)(ap)->host->private_data)
+#define HSDEVP_FROM_AP(ap)	((struct sata_dwc_device_port *)(ap)->private_data)
+#define HSDEV_FROM_QC(qc)	((struct sata_dwc_device *)(qc)->ap->host->private_data)
+#define HSDEV_FROM_HSDEVP(p)	((struct sata_dwc_device *)(p)->hsdev)
 
 enum {
 	SATA_DWC_CMD_ISSUED_NOT		= 0,
-- 
2.8.0.rc3

