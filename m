From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: check cdb len per dev instead of per host
Date: Thu, 01 Feb 2007 12:28:57 -0500
Message-ID: <45C22359.8060701@rtr.ca>
References: <45C21C21.2060800@rtr.ca> <20070201171613.72091b81@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3667 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbXBAR27 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Feb 2007 12:28:59 -0500
In-Reply-To: <20070201171613.72091b81@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan wrote:
> On Thu, 01 Feb 2007 11:58:09 -0500
> Mark Lord <liml@rtr.ca> wrote:
> 
>> Fix libata to perform CDB len validation per device
>> rather than per host.  This way, validation still works
>> when we have a mix of 12-byte and 16-byte devices on
>> a common host interface.#
> 
> Users can pass 16byte commands in the "safe" list of commands so can spam
> the log via the printk

That's nothing new.
We can do that already today with the original existing printk().

This patch (below) gets rid of the offending printk(),
replacing it instead with DPRINTK.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/libata-scsi.c.orig	2007-02-01 12:26:03.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-02-01 12:26:54.000000000 -0500
@@ -2762,8 +2762,7 @@
 		max_len = dev->cdb_len;
  
 	if (unlikely(!scmd->cmd_len || scmd->cmd_len > max_len)) {
- 		ata_dev_printk(dev, KERN_WARNING,
- 			"WARNING: bad CDB len=%u, max=%u\n",
+ 		DPRINTK("bad CDB len=%u, max=%u\n",
  			scmd->cmd_len, max_len);
 		scmd->result = DID_ERROR << 16;
 		done(scmd);
