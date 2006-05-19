From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 7/7] sata_mv: version bump
Date: Fri, 19 May 2006 16:41:27 -0400
Message-ID: <200605191641.27557.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:37354 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964827AbWESUl2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:41:28 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Increment the version number inside sata_mv.c.

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:44:11.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:37:19.000000000 -0400
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.7"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
