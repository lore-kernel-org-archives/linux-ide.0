From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH UPDATED] libata: add support for ATA_16 on ATAPI
Date: Thu, 02 Aug 2007 08:01:12 -0400
Message-ID: <46B1C788.3060201@rtr.ca>
References: <20070801075624.GD13674@htj.dyndns.org> <46B091F4.5070704@garzik.org> <46B09494.4080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3868 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbXHBMBO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 08:01:14 -0400
In-Reply-To: <46B09494.4080206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff, Mark, are you guys okay with the modified version?
>> Close!  Thanks for revising!
>>
>> My only comment now is that I dislike atapi_scmd85.  That means nothing
>> to me.
>>
>> I liked the old name better.  Or maybe use atapi_passthru16.
> 
> The problem with ata16_passthru is that it suggests the opposite of what
> it does.  The default value 0 allows ATA_16 passthrough command while
> setting it to 1 disallows ATA_16 passthrough and passes through SCSI
> Command 0x85 which shares command byte with ATA_16.  Maybe it's because
> I'm not a native speaker but the last sentence is pretty difficult to
> digest.  So, IMHO, atapi_scmd85 is slightly better in that it means
> nothing rather than suggesting the opposite.

Thanks for plugging away at this one, Tejun.

And I do agree that ata16_passthru sounds backwards of what it really does.
There's got to be a nicer name for this thing.

In practice, I doubt that anyone will ever use the parameter,
so it really doesn't matter a whole lot what we call it.

But something sensible would be nice.
There's got to be a shorter version of "atapi_pass_opcode_0x85_to_device=1".

Perhaps "atapi_op_85_passthru=1" or "atapi_passthru_op_85=1" ??

Also, this is an example of something that is really a "per device"
parameter, rather than a global.  But we haven't yet cracked a good way
to do that yet in libata.

Cheers
