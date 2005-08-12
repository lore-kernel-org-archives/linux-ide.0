From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 12 Aug 2005 11:41:53 +0900
Message-ID: <42FC0C71.4000805@gmail.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <20050805040105.GA18466@htj.dyndns.org> <42FBB14E.5040002@pobox.com> <42FBF22D.5090009@gmail.com> <42FC07EF.9060506@pobox.com> <42FC0B88.4060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:39925 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751136AbVHLCmC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 22:42:02 -0400
Received: by zproxy.gmail.com with SMTP id r28so356170nza
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 19:42:01 -0700 (PDT)
In-Reply-To: <42FC0B88.4060404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Tejun Heo wrote:
> Mark Lord wrote:
> 
>> Tejun Heo wrote:
>>
>>>
>>>  * _All_ errors are handled in EH thread.
>>>  * Once any error has occurred, all normal processing stops until 
>>> error condition is cleared by EH.
>>
>>
>>
>> Do you mean "all normal processing" for that channel stops,
>> or *ALL* processing on all libata channels stops?
>>
>> Obviously the former, I presume.
>>
>> Cheers
> 
> 
>  Yeah, the former of course.  ;-)  Error state is indicated by one of 
> the followings.
       ^ following ata per-port flags.
> 
>  * ATA_FLAG_ERROR    : one or more errors have occurred and EH is
>       	        scheduled to run.
                                        ^ on the ata port
>  * ATA_FLAG_RECOVERY    : EH in progress
                                            ^ on the ata port
> 
>  When either of above flags is set, only commands w/ ATA_QCFLAG_PREEMPT 
> flag set gets to run and complete.  So, currently, sense requesting and 
                                    ^ on the ata port
> NCQ log page reading are done w/ the flag set.

  Just to be clearer.  ;-)

-- 
tejun
