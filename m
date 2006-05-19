From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 01/14] libata-hp-prep: add flags and eh_info/context fields
 for hotplug
Date: Sat, 20 May 2006 00:17:29 +0900
Message-ID: <446DE189.8080307@gmail.com>
References: <11480445833575-git-send-email-htejun@gmail.com> <446DDD32.30702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:46882 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932344AbWESPRg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:17:36 -0400
Received: by py-out-1112.google.com with SMTP id z59so956520pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:17:36 -0700 (PDT)
In-Reply-To: <446DDD32.30702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Add hotplug related flags and eh_info/context fields.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  include/linux/libata.h |   19 ++++++++++++++++++-
>>  1 files changed, 18 insertions(+), 1 deletions(-)
>>
>> 95c2d43950709c541509bbedd692e984dc67b474
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 2803ab8..3fb6dc3 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -131,6 +131,9 @@ enum {
>>  
>>      ATA_DFLAG_PIO        = (1 << 8), /* device currently in PIO mode */
>>  
>> +    ATA_DFLAG_DETACH    = (1 << 16),
>> +    ATA_DFLAG_DETACHED    = (1 << 17),
>> +
>>      ATA_DEV_UNKNOWN        = 0,    /* unknown device */
>>      ATA_DEV_ATA        = 1,    /* ATA device */
>>      ATA_DEV_ATA_UNSUP    = 2,    /* ATA device (unsupported) */
>> @@ -153,6 +156,9 @@ enum {
>>      ATA_FLAG_PIO_POLLING    = (1 << 10), /* use polling PIO if LLD
>>                            * doesn't handle PIO interrupts */
>>      ATA_FLAG_NCQ        = (1 << 11), /* host supports NCQ */
>> +    ATA_FLAG_HRST_TO_RESUME    = (1 << 12), /* hardreset to resume 
>> phy */
>> +    ATA_FLAG_CANT_WAIT_FIS34 = (1 << 13), /* can't wait for the first 
>> D2H
>> +                           * Register FIS clearing BSY */
> 
> FIS34 is an awful name.  I hereby ban it from libata :)
> 
> Also those names are getting long.  Consider shortening CANT_WAIT, 
> perhaps to NOWAIT.  And perhaps s/HRST_TO_RESUME/HRST_RESUMES/.
> 
> ACK everything else in this patch.

Yeah I hate FIS34 too.  Can you suggest a name which can also signify 
that the wait is for hotplug probing?  ATA_FLAG_CANT_WAIT_HP?

-- 
tejun
