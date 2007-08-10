From: akpm@linux-foundation.org
Subject: [patch 17/25] libata: correct IORDY handling
Date: Fri, 10 Aug 2007 13:59:44 -0700
Message-ID: <200708102059.l7AKxjLQ008617@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49286 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932204AbXHJVQf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:16:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com, sshtylyov@ru.mvista.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Debugging a report of a problem with an ancient solid state disk showed up
some problems in the IORDY handling

1.	We check the wrong bit to see if the device has IORDY
2.	Even then some ancient creaking piles of crap don't support
	SETXFER at all.

I think this should go via -mm for a bit.  The cases it fixes are obscure
and the risk of side effects is slight but possible.  This also moves us
slightly closer to supporting original MFM/RLL disks with libata but before
Jeff panics I have no plans to do that....

Signed-off-by: Alan Cox <alan@redhat.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    6 +++++-
 include/linux/ata.h       |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-correct-iordy-handling drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-correct-iordy-handling
+++ a/drivers/ata/libata-core.c
@@ -2770,7 +2770,11 @@ static int ata_dev_set_mode(struct ata_d
 	/* Old CFA may refuse this command, which is just fine */
 	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
         	err_mask &= ~AC_ERR_DEV;
-
+	/* Some very old devices and some bad newer ones fail any kind of
+	   SET_XFERMODE request but support PIO0-2 timings and no IORDY */
+	if (dev->xfer_shift == ATA_SHIFT_PIO && !ata_id_has_iordy(dev->id) &&
+			dev->pio_mode <= XFER_PIO_2)
+		err_mask &= ~AC_ERR_DEV;
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
diff -puN include/linux/ata.h~libata-correct-iordy-handling include/linux/ata.h
--- a/include/linux/ata.h~libata-correct-iordy-handling
+++ a/include/linux/ata.h
@@ -345,7 +345,7 @@ struct ata_taskfile {
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
 #define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
 #define ata_id_iordy_disable(id) ((id)[49] & (1 << 10))
-#define ata_id_has_iordy(id) ((id)[49] & (1 << 9))
+#define ata_id_has_iordy(id) ((id)[49] & (1 << 11))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
_
