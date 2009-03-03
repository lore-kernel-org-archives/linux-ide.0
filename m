From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA "target mode" (or "Channel-to-Channel" comm mode)
Date: Tue, 03 Mar 2009 11:12:09 -0500
Message-ID: <49AD56D9.60705@rtr.ca>
References: <49AD34F4.8090008@rtr.ca> <49AD3BA5.3080603@pobox.com> <49AD409F.6040102@rtr.ca> <49AD53EF.5060600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57071 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbZCCQMN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 11:12:13 -0500
In-Reply-To: <49AD53EF.5060600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
..
>>> The miscdev (i.e. chrdev) interface found in 
>>> drivers/scsi/scsi_tgt_if.c of repo [1] seems pretty generic, simple, 
>>> small and applicable to portions of the problem presented here...  
>>> The basic task in scsi_tgt_if's case is just shoveling packets 
>>> to/from userspace.
>> ..
>>
>> Except it's rather SCSI specific, and the userspace frontend even more so.
>> The code expects a SCSI command block, LUN, TAG, and other fields that
>> a SATA FIS won't have.  Seems clumsy, particularly when we (in theory)
>> are trying to decouple libata from SCSI.   But if that's the way,
>> then I can clumsily wrap each FIS in a fake ATA_16 header or something.
> 
> The kernel bits are not terribly SCSI-specific.  I'd ignore the userland 
> bits.
> 
> We just have to get the interface right.  Even if we "cp scsi_tgt_if.c 
> ata_tgt_if.c" and then go from there, we should make an effort to create 
> similar packet push/pull interfaces.
..

Yeah, that does look like a good starting point.
To begin with, I'll see if I can just wrap the SATA FIS+data
into something that scsi_tgt_if.c will pass through unmolested.

This will give us a way to play with it in the 2.6.30 time frame,
and we can fork it or tweak it as needed for later releases then.

> Creating something wildly different would be counterproductive.
..

Yes we definitely should re-use that stuff if possible.
I think it all feeds to/from netlink, too, though it's been
a month since I last tried to find my way through it all.

Patches in a week or so.

Cheers
