From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Wed, 30 Apr 2008 17:40:13 -0400
Message-ID: <4818E73D.9070201@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4618 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbYD3VkO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Apr 2008 17:40:14 -0400
In-Reply-To: <4818E5B2.1040801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
..
>> w00t w00t I thought about that when I wrote NCQ EH.  All you have to 
>> do is to export ata_eh_analyze_ncq_error() can call it right after 
>> error_handler starts and put the controller into a working state (so 
>> that SCR accesses work again).  After it finishes, call the generic 
>> handler.  The second time around ata_eh_analyze_ncq_error() will be 
>> no-op and you should get what you want.
> ..
> 
> Tejun, I've implemented this, and it sort of works now.
> 
> But libata-eh is interfering in a different way.
> It reads the SCR_ERROR register for the PMP link,
> notices that the SERR_COMM_RECOVERED bit is set,
> and then decides to perform a full reset.
> 
> This bit seems to be always set whenever sata_mv tries
> to report device-errors (media errors) in NCQ for a pmp.
> 
> I'll have to dig some more, but it's probably just leftover
> from the initial probe/reset time or something.
> This is a Marvell PM.
> 
> My understanding was, that this particular bit is supposed
> to be for information purposes only, letting us know that
> the hardware has automatically recovered from a soft error.
> 
> So why are we taking a hammer to things there?
..

FWIW, this patch fixes it for me (and fixes a misleading printk).
Or I could just clear that bit from sata_mv before invoking EH.
(??)


----------------- SNIP ------------------

Prevent libata-eh from taking too drastic an action in response
to a simple SATA "Recovered Communication Error".
Fix a misleading (port vs. link) printk while we're at it.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- upstream/drivers/ata/libata-eh.c	2008-04-30 17:35:36.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2008-04-30 17:35:45.000000000 -0400
@@ -1312,8 +1312,7 @@
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_RESET;
 	}
-	if (serror &
-	    (SERR_DATA_RECOVERED | SERR_COMM_RECOVERED | SERR_DATA)) {
+	if (serror & (SERR_DATA_RECOVERED | SERR_DATA)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_RESET;
 	}
@@ -1924,7 +1923,7 @@
 	}
 
 	if (ehc->i.serror)
-		ata_port_printk(ap, KERN_ERR,
+		ata_link_printk(link, KERN_ERR,
 		  "SError: { %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
 		  ehc->i.serror & SERR_DATA_RECOVERED ? "RecovData " : "",
 		  ehc->i.serror & SERR_COMM_RECOVERED ? "RecovComm " : "",
