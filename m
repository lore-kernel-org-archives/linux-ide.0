From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 07/07] sata_mv add temporary 3 second init delay for SiliconImage
 PMs
Date: Wed, 16 Apr 2008 15:01:19 -0400
Message-ID: <48064CFF.4080106@rtr.ca>
References: <48064BCC.5070505@rtr.ca> <48064BF3.8010301@rtr.ca> <48064C15.9090109@rtr.ca> <48064C45.4070208@rtr.ca> <48064C7B.500@rtr.ca> <48064CC1.40203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2670 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYDPTBU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2008 15:01:20 -0400
In-Reply-To: <48064CC1.40203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

sata_mv does not yet fully support hotplug (coming soon, though).
This means that the driver may not find a Silicon Image port-multiplier
when first loaded, because those devices take in exceess of 3 seconds
to sync up the SATA PHY (most devices do this in mere microseconds).

So, as a short-term interim measure, here we insert a 3-second pause
on initial driver load, once per controller board (not once per port!),
to allow the Silicon Image port-multipliers to be detected later.

This will be removed again (soon!) once hotplug is fully implemented/working.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-16 11:53:35.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-16 11:51:47.000000000 -0400
@@ -2105,6 +2105,13 @@
 		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");
 		rc = 1;
 	}
+	/*
+	 * Temporary: wait 3 seconds before port-probing can happen,
+	 * so that we don't miss finding sleepy SilXXXX port-multipliers.
+	 * This can go away once hotplug is fully/correctly implemented.
+	 */
+	if (rc == 0)
+		msleep(3000);
 done:
 	return rc;
 }
