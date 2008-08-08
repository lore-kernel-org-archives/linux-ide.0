From: Mark Lord <liml@rtr.ca>
Subject: Re: bad sectors, suspicious behaviour
Date: Fri, 08 Aug 2008 09:50:33 -0400
Message-ID: <489C4F29.6020007@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41891 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbYHHNub (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 09:50:31 -0400
In-Reply-To: <489C4B6E.9070306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Artem Bokhan wrote:
> ..
>> I'm trying to emulate OS behaviour when something goes wrong with sata 
>> hard drive, for example, unrecoverable "bad blocks". By some reason I 
>> do not want to use any sw/hw raid.
> ..
> 
> Note that you can create/remove *real* bad sectors on most drives
> by using "hdparm --make-bad-sector" and "hdparm --repair-sector".
> 
>> I took new hard drive, because it should contain (and it contains) 
>> unreadable (not reallocated yet) sectros, and did
>>
>> 'dd if=/dev/sda of=/dev/null bs=1M'.
>>
>> first run dd log (errors1.txt) looks OK, drive recovers, as I suppose, 
>> approximately at time
>>
>> cat
>> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout 
>>
>> 30
>>
>> but when running dd second time, log looks strange (errors2.txt)
> ..
>> [75702.039300] ata5.00: NCQ disabled due to excessive errors
>> [75702.039382]          res 41/00:08:00:a8:36/00:00:01:00:00/40 Emask 
>> 0x1 (device error)
>> [75702.039452]          res 41/00:00:01:00:00/00:00:01:00:00/40 Emask 
>> 0x1 (device error)
>> [75702.039522] ata5: hard resetting link
>> [75702.936061] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [75702.996080] ata5.00: max_sectors limited to 256 for NCQ
>> [75703.296058] ata5.00: max_sectors limited to 256 for NCQ
>> [75703.296061] ata5.00: configured for UDMA/133
>> [75703.296069] ata5: EH complete
>> [75703.296098] ------------[ cut here ]------------
>> [75703.296100] WARNING: at drivers/ata/libata-core.c:4732 ata_qc_issue+0x1ca/0x230 [libata]()
..
That line is this one (linux-2.6.26.2):

        WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));

So this should trigger only when link->active_tag is valid, which doesn't normally happen.
But the convoluted traceback shows that this code path came from the EH,
so something in libata EH is likely neglecting to clear link->active_tag
before issuing a new command.  

Tejun?


