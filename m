From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide: mark hpt34x host driver as BROKEN
Date: Sat, 21 Jun 2008 21:12:27 +0200
Message-ID: <200806212112.27748.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:56041 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYFUTWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:22:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so410881and.103
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 12:22:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Alan Cox has noticed some time ago that hpt34x is broken
(http://lkml.org/lkml/2007/7/3/257):

"No the old driver doesn't even do that. It starts up. It spuriously
adjusts some non writable PCI BAR registers, prints a message about
resources being in use already then exits."

Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -548,6 +548,7 @@ config BLK_DEV_CS5535
 
 config BLK_DEV_HPT34X
 	tristate "HPT34X chipset support"
+	depends on BROKEN
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds up to 4 more EIDE devices sharing a single
