From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 22:04:28 -0500
Message-ID: <4376AD3C.2070105@pobox.com>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from thorn.pobox.com ([208.210.124.75]:5523 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751133AbVKMDEc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 22:04:32 -0500
In-Reply-To: <437680BA.40707@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> This patch forces a correct master/slave unit bit
> when sending libata commands via SCSI passthru.
> The bit is left as-is for ports which do not
> support slave devices.

Revised version: apply bitfix to tf->device (duh!),
and nuke extra parens.

Compiles, not tested.

Signed-off-by: Mark Lord <mlord@pobox.com>


  ------------------------------------------------------------------------

--- linux-2.6.15-rc1/drivers/scsi/libata-scsi.c.orig	2005-11-11 20:43:36.000000000 -0500
+++ linux/drivers/scsi/libata-scsi.c	2005-11-12 18:45:43.000000000 -0500
@@ -2276,6 +2276,12 @@
  		tf->device = scsicmd[8];
  		tf->command = scsicmd[9];
  	}
+	/*
+	 * If slave is possible, enforce correct master/slave bit for this port:
+	 */
+	if ((qc->ap->flags & ATA_FLAG_SLAVE_POSS))
+		tf->device = qc->dev->devno ?
+			tf->device | ATA_DEV1 : tf->command & ~ATA_DEV1;

  	/*
  	 * Filter SET_FEATURES - XFER MODE command -- otherwise,

