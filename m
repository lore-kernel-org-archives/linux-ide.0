From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH UPDATED] libata: add support for ATA_16 on ATAPI
Date: Wed, 01 Aug 2007 23:11:32 +0900
Message-ID: <46B09494.4080206@gmail.com>
References: <20070801075624.GD13674@htj.dyndns.org> <46B091F4.5070704@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:3861 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbXHAOLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:11:39 -0400
Received: by qb-out-0506.google.com with SMTP id e11so211427qbe
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 07:11:38 -0700 (PDT)
In-Reply-To: <46B091F4.5070704@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Jeff Garzik wrote:
> Tejun Heo wrote:
>> From: Mark Lord <liml@rtr.ca>
>>
>> Add support for issuing ATA_16 passthru commands to ATAPI devices
>> managed by libata.  It requires the previous CDB length fix patch.
>>
>> A boot/module parameter, "atapi_scmd85=1" can be used to globally
>> disable this feature, if ever desired.
>>
>> tj: renamed ata16_passthru module param to atapi_scmd85 to reduce
>>     confusion
>>
>> tj: restructured __ata_scsi_queuecmd() according to Jeff's suggestion.
>>
>> Signed-off-by: Mark Lord <liml@rtr.ca>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> Jeff, Mark, are you guys okay with the modified version?
> 
> Close!  Thanks for revising!
> 
> My only comment now is that I dislike atapi_scmd85.  That means nothing
> to me.
> 
> I liked the old name better.  Or maybe use atapi_passthru16.

The problem with ata16_passthru is that it suggests the opposite of what
it does.  The default value 0 allows ATA_16 passthrough command while
setting it to 1 disallows ATA_16 passthrough and passes through SCSI
Command 0x85 which shares command byte with ATA_16.  Maybe it's because
I'm not a native speaker but the last sentence is pretty difficult to
digest.  So, IMHO, atapi_scmd85 is slightly better in that it means
nothing rather than suggesting the opposite.

How about keeping the old name (or use atapi_passthru16) but flipping
the meaning so that it defaults to 1.  It just makes hell lot of sense
that "ata16_passthru=1" means allowing ATA_16 passthrough not the other
way around.

Thanks.

-- 
tejun
