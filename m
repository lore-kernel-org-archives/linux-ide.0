From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-passthrough problem.
Date: Sun, 13 Nov 2005 12:03:55 -0500
Message-ID: <437771FB.3020704@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <4376786F.2090503@pobox.com> <43767D75.6090204@rtr.ca> <43775815.2090204@superbug.demon.co.uk> <43777183.5030208@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090405090607020409020303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:26786 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964940AbVKMRDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2005 12:03:55 -0500
In-Reply-To: <43777183.5030208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405090607020409020303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And again, as an attachment, for people with modern mail clients.

Cheers

--------------090405090607020409020303
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
+	 * If slave is possible, enforce correct master/slave bit for this port:
+	 */
+	if (qc->ap->flags & ATA_FLAG_SLAVE_POSS)
+		tf->device = qc->dev->devno ?
+			tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
 
 	/*
 	 * Filter SET_FEATURES - XFER MODE command -- otherwise,

--------------090405090607020409020303--
