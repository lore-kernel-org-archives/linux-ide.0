From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 22:11:09 -0500
Message-ID: <4376AECD.2040907@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca> <4376AD3C.2070105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:62862 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751099AbVKMDLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 22:11:10 -0500
In-Reply-To: <4376AD3C.2070105@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org


AGAIN, with *feeling*.
(I'm in the middle of a complete distro-upgrade on my machine here,
so my tools are only half functional now.  Fix any residual formatting
issues yourself, please.)

- fixed whitespace, fixed third instance of "s/command/device".

> Compiles, not tested.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- linux-2.6.15-rc1/drivers/scsi/libata-scsi.c.orig    2005-11-11 20:43:36.000000000 -0500
+++ linux/drivers/scsi/libata-scsi.c    2005-11-12 18:45:43.000000000 -0500
@@ -2276,6 +2276,12 @@
		tf->device = scsicmd[8];
		tf->command = scsicmd[9];
	}
+	/*
+	 * If slave is possible, enforce correct master/slave bit for this port:
+	 */
+	if ((qc->ap->flags & ATA_FLAG_SLAVE_POSS))
+	tf->device = qc->dev->devno ?
+		tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;

	/*
	 * Filter SET_FEATURES - XFER MODE command -- otherwise,

