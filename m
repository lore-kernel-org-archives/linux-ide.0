From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 1/2] at91_ide: remove unused ide_mm_{outb,inb}
Date: Mon, 6 Apr 2009 23:41:59 -0400
Message-ID: <200904062341.59908.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:59310 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbZDFW24 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 18:28:56 -0400
Received: from r2aq169.net.upc.cz (stf_xl@wp.pl@[62.245.106.169])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 7 Apr 2009 00:28:48 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
Patch is against pata-2.6 .
 
 drivers/ide/at91_ide.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 4f3725d..c48dc61 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -174,16 +174,6 @@ static void at91_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
 	leave_16bit(chipselect, mode);
 }
 
-static u8 ide_mm_inb(unsigned long port)
-{
-	return readb((void __iomem *) port);
-}
-
-static void ide_mm_outb(u8 value, unsigned long port)
-{
-	writeb(value, (void __iomem *) port);
-}
-
 static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct ide_timing *timing;
-- 
1.4.4.4

