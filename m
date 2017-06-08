From: Christoph Hellwig <hch@infradead.org>
Subject: Re: ZBC_IN command translation
Date: Wed, 7 Jun 2017 23:55:54 -0700
Message-ID: <20170608065553.GA14568@infradead.org>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
 <20170607090751.GA29487@infradead.org>
 <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
 <20170607132443.GA3501@infradead.org>
 <8b223c09-81ff-19dd-fe32-63711c79b9cb@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdFHGzy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2017 02:55:54 -0400
Content-Disposition: inline
In-Reply-To: <8b223c09-81ff-19dd-fe32-63711c79b9cb@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Thu, Jun 08, 2017 at 09:18:39AM +0900, Damien Le Moal wrote:
> So I am limiting support in target to the passthrough SCSI (pscsi)
> backstore type (and will also add a user emulation backstore). Fixes
> needed in pscsi are rather trivial, but the block layer is not involved
> at the highest level as scsi commands are simply passed along through
> requests. Hence the ZBC/ZAC translation problem showing up.

Bah, don't do that.  Passthrough backends are a nightmare in so many
ways and I really prefer to not see them spread.

> 
> I could work on completing support for ZBC at the block layer API:
> 1) Add REQ_OP_ZONE_OPEN/CLOSE/FINISH, with corresponding
> blkdev_issue_xxx functions

Or just emulate them.

> 2) Add more queue attributes and corresponding files in sysfs for the
> zoned block device characteristics
> 3) Fix sd.c to support the new REQ_OP_ZONE_xxx
> 4) Add corresponding user ioctls for OPEN/CLOSE/FINISH

What is the practical use cae for that?
