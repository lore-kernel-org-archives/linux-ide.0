From: akpm@linux-foundation.org
Subject: [patch for 2.6.29? 1/4] drivers/ata/sata_sil.c needs dmi.h
Date: Wed, 11 Feb 2009 13:08:40 -0800
Message-ID: <200902112108.n1BL8epu005164@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55657 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754595AbZBKVJU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 16:09:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

alpha:

drivers/ata/sata_sil.c: In function 'sil_broken_system_poweroff':
drivers/ata/sata_sil.c:713: error: implicit declaration of function 'dmi_first_match'

Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_sil.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/ata/sata_sil.c~drivers-ata-sata_silc-needs-dmih drivers/ata/sata_sil.c
--- a/drivers/ata/sata_sil.c~drivers-ata-sata_silc-needs-dmih
+++ a/drivers/ata/sata_sil.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/dmi.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
_
