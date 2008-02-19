From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-scsi: automatically use DMADIR if drive/bridge
 requires it
Date: Mon, 18 Feb 2008 19:41:06 -0500
Message-ID: <47BA25A2.8020407@rtr.ca>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca> <20080218222044.GA20041@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2472 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761039AbYBSAlI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 19:41:08 -0500
In-Reply-To: <20080218222044.GA20041@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Alan Cox wrote:
> On Mon, Feb 18, 2008 at 03:53:46PM -0500, Mark Lord wrote:
>> +		/* some SATA bridges need us to indicate data xfer direction 
>> */
>> +		if (atapi_dmadir || (dev->id[62] & 0x8000))
> 
> The rest of the code uses ata_ inlines/defines in ata.h for things like this
> and religiously checks validity bits and ATA versions.
..

Feel free.  I don't actually have a device like that here to test on,
so I'm not particularly motivated about doing more than the above right now.

Perhaps you or Albert may be, though.  :)

That particular bit has always been zero (reserved), from ATA1 through present,
except when used as a DMADIR bit, beginning somewhere around ATA7.

Cheers
