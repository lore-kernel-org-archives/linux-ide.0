From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 18:54:34 -0500
Message-ID: <437680BA.40707@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060400030307010508060203"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:22495 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964887AbVKLXyf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 18:54:35 -0500
In-Reply-To: <4376788E.9010503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400030307010508060203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch forces a correct master/slave unit bit
when sending libata commands via SCSI passthru.
The bit is left as-is for ports which do not
support slave devices.

Compiles, not tested.

Signed-off-by: Mark Lord <mlord@pobox.com>


--------------060400030307010508060203
Content-Type: text/x-patch;
 name="passthru.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="passthru.patch"

--- linux-2.6.15-rc1/drivers/scsi/libata-scsi.c.orig	2005-11-11 20:43:36.000000000 -0500
+++ linux/drivers/scsi/libata-scsi.c	2005-11-12 18:45:43.000000000 -0500
@@ -2276,6 +2276,12 @@
 		tf->device = scsicmd[8];
 		tf->command = scsicmd[9];
 	}
+	/*
+	 * If applicable, enforce a correct master/slave bit for this device:
+	 */
+	if ((qc->ap->flags & ATA_FLAG_SLAVE_POSS))
+		tf->command = qc->dev->devno ?
+			(tf->command | ATA_DEV1) : (tf->command & ~ATA_DEV1);
 
 	/*
 	 * Filter SET_FEATURES - XFER MODE command -- otherwise,

--------------060400030307010508060203--
