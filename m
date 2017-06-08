From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: ZBC_IN command translation
Date: Thu, 8 Jun 2017 09:18:39 +0900
Message-ID: <8b223c09-81ff-19dd-fe32-63711c79b9cb@wdc.com>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
 <20170607090751.GA29487@infradead.org>
 <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
 <20170607132443.GA3501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47553 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdFHASm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2017 20:18:42 -0400
In-Reply-To: <20170607132443.GA3501@infradead.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>

Christoph,

(+CC Jens and Martin)

On 6/7/17 22:24, Christoph Hellwig wrote:
> On Wed, Jun 07, 2017 at 06:11:33PM +0900, Damien Le Moal wrote:
>> Sure, that is one solution. However, not a ideal one as that would
>> prevent ZBC/ZAC drives working with target/iscsi.
>> There are a few problems there that I am fixing right now, but that
>> translation error is stopping all effort.
> 
> The normal way to use the target code is through the block layer.

A block backstore in target indeed is great as any block device, not
just physical ones, can be exported. The problem is that for a zoned
block device the block layer API lacks functions and information to
fully emulate the corresponding ZBC SCSI device in target: no
open/close/finish zone functions (no REQ_OP_xx for that), and the
information from the zoned block device characteristics VPD page 0xB6 is
not available.

So I am limiting support in target to the passthrough SCSI (pscsi)
backstore type (and will also add a user emulation backstore). Fixes
needed in pscsi are rather trivial, but the block layer is not involved
at the highest level as scsi commands are simply passed along through
requests. Hence the ZBC/ZAC translation problem showing up.

I could work on completing support for ZBC at the block layer API:
1) Add REQ_OP_ZONE_OPEN/CLOSE/FINISH, with corresponding
blkdev_issue_xxx functions
2) Add more queue attributes and corresponding files in sysfs for the
zoned block device characteristics
3) Fix sd.c to support the new REQ_OP_ZONE_xxx
4) Add corresponding user ioctls for OPEN/CLOSE/FINISH

That's a lot of work for mostly just being used in the target code as
none of the other areas in the kernel supporting zoned block devices
don't really need these features (dm, f2fs, and on-going btrfs). But if
you think that is OK to add all this, I will. And fix target ZBC support
using that.

Best regards.

-- 
Damien Le Moal,
Western Digital
