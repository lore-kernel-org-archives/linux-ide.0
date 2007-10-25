From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: backport ATA_FLAG_NO_SRST and	ATA_FLAG_ASSUME_ATA
Date: Thu, 25 Oct 2007 16:36:01 +0900
Message-ID: <47204761.3030500@gmail.com>
References: <20071025065157.GH11853@htj.dyndns.org> <47204446.7070609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:9674 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbXJYHgM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 03:36:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so529851wah
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 00:36:11 -0700 (PDT)
In-Reply-To: <47204446.7070609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: stable@kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Backport ATA_FLAG_NO_SRST and ATA_FLAG_ASSUME_ATA.  These are
>> originally link flags (ATA_LFLAG_*) but link abstraction doesn't exist
>> on 2.6.23, so make it port flags.
>>
>> This is for the following workaround for ASUS P5W DH Deluxe.
>>
>> These new flags don't introduce any behavior change unless set and
>> nobody sets them yet.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> This and the next patch are a bit large for -stable but they don't
>> change anything for machines other than P5W DH and P5W DH users have
>> been suffering long enough, so I think it'll be nice to include these
>> patches in the next -stable release.  However, feel free to NACK if
>> you can see some danger in these patches.
>>
>> Jeff, what do you think?
>>
>>  drivers/ata/libata-eh.c |   32 ++++++++++++++++++++++++--------
>>  include/linux/libata.h  |    2 ++
>>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
> ACK from me, though I wonder if we shouldn't wait and get feedback once 
> this hits upstream (my next push to Andrew and Linus), before applying 
> to stable.  No special reason, just being conservative...

Agreed.  Let's give the upstream changes a few weeks before updating 
-stable.  I'll ping this thread after a few weeks.

Thanks.

-- 
tejun
