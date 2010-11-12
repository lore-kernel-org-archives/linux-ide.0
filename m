From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] pata_legacy: fix CONFIG_PATA_WINBOND_VLB_MODULE
 test
Date: Fri, 12 Nov 2010 12:01:41 +0100
Message-ID: <4CDD1E95.60402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50564 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413Ab0KLLCT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Nov 2010 06:02:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Robert P. J. Day" <rpjday@crashcourse.ca>

pata_legacy is incorrectly testing PATA_WINBOND_VLB_MODULE instead of
CONFIG_PATA_WINBOND_VLB_MODULE.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Robert P. J. Day" <rpjday@crashcourse.ca>
---
 drivers/ata/pata_legacy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index eaf1941..6bd9425 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -142,7 +142,7 @@ static int autospeed;		/* Chip present which snoops speed changes */
 static int pio_mask = ATA_PIO4;	/* PIO range for autospeed devices */
 static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */

-#ifdef PATA_WINBOND_VLB_MODULE
+#ifdef CONFIG_PATA_WINBOND_VLB_MODULE
 static int winbond = 1;		/* Set to probe Winbond controllers,
 					give I/O port if non standard */
 #else
