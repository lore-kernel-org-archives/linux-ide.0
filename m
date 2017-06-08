From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: ZBC_IN command translation
Date: Thu, 8 Jun 2017 17:27:17 +0900
Message-ID: <4b696fea-8137-6c62-9b0b-593c092791c2@wdc.com>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
 <20170607090751.GA29487@infradead.org>
 <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
 <20170607132443.GA3501@infradead.org>
 <8b223c09-81ff-19dd-fe32-63711c79b9cb@wdc.com>
 <20170608065553.GA14568@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65070 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdFHI1T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2017 04:27:19 -0400
In-Reply-To: <20170608065553.GA14568@infradead.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>



On 6/8/17 15:55, Christoph Hellwig wrote:
> On Thu, Jun 08, 2017 at 09:18:39AM +0900, Damien Le Moal wrote:
>> So I am limiting support in target to the passthrough SCSI (pscsi)
>> backstore type (and will also add a user emulation backstore). Fixes
>> needed in pscsi are rather trivial, but the block layer is not involved
>> at the highest level as scsi commands are simply passed along through
>> requests. Hence the ZBC/ZAC translation problem showing up.
> 
> Bah, don't do that.  Passthrough backends are a nightmare in so many
> ways and I really prefer to not see them spread.

I found out this morning how hard it is... And that was just with report
zones. Sending a large report zone for instance triggers warnings all
over the place, including block and scsi layer. Handling of incoming
requests sgl seem to be very deficient.

>> I could work on completing support for ZBC at the block layer API:
>> 1) Add REQ_OP_ZONE_OPEN/CLOSE/FINISH, with corresponding
>> blkdev_issue_xxx functions
> 
> Or just emulate them.

That would mean maintaining the condition of all zones in memory to
override the condition reported by report zone. And doing so without
knowing the actual disk limit on the maximum number of open zones.

Doable I guess. Need to think more about it. Also wondering if the
emulated zone condition can be volatile...

>> 2) Add more queue attributes and corresponding files in sysfs for the
>> zoned block device characteristics
>> 3) Fix sd.c to support the new REQ_OP_ZONE_xxx
>> 4) Add corresponding user ioctls for OPEN/CLOSE/FINISH
> 
> What is the practical use cae for that?

The only one that I can see would be to simplify the above mentioned
emulation. With this support in place, no zone condition emulation is
necessary as zones can be fully managed. The emulation is reduced to
conversion from SCSI command to block layer calls.

Apart from that, I do not see any compelling use case for
open/close/finish. f2fs does not use it, on-going btrfs work does not
need it either, same for the device mapper support.

So that would be a lot of work for just the target block backstore.

-- 
Damien Le Moal,
Western Digital
