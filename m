From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata-dev-2.6-ncq: lengthen COMMRESET delay
Date: Sun, 26 Jun 2005 23:27:19 +0900
Message-ID: <20050626142719.GA24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:58765 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261233AbVFZO1Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 10:27:25 -0400
Received: by zproxy.gmail.com with SMTP id i11so108055nzi
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 07:27:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, linux-ide@vger.kernel.org

 Hello, Jeff.
 Hello, Jens.

 This is the first patch of a series of updates to the ncq head of
libata-dev-2.6 tree.  The first six patches (including this one) are
independent misc updates/fixes, so I'm posting each of those patches
as a separate mail.  After the six patches, a patchset consisted of 8
patches follows which moves most of NCQ completion/error-handling to
libata-core layer and implements proper error-handling.

 This patch lengthens the delay between DET setting and clearing for
COMMRESET from 400us to 1ms.  I couldn't find any requiremen regarding
the duration of COMMRESET in SATA I/II specs but AHCI-1.1 10.4.2
states that it should be at least 1ms.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-26 20:59:05.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-26 21:06:01.000000000 +0900
@@ -1444,7 +1444,9 @@ void __sata_phy_reset(struct ata_port *a
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		/* issue phy wake/reset */
 		scr_write_flush(ap, SCR_CONTROL, 0x301);
-		udelay(400);			/* FIXME: a guess */
+		/* Couldn't find anything in SATA I/II specs, but
+		 * AHCI-1.1 10.4.2 says at least 1 ms. */
+		msleep(1);
 	}
 	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
