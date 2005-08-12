From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 12 Aug 2005 11:38:00 +0900
Message-ID: <42FC0B88.4060404@gmail.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <20050805040105.GA18466@htj.dyndns.org> <42FBB14E.5040002@pobox.com> <42FBF22D.5090009@gmail.com> <42FC07EF.9060506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:5198 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750740AbVHLCiH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 22:38:07 -0400
Received: by wproxy.gmail.com with SMTP id i20so329062wra
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 19:38:06 -0700 (PDT)
In-Reply-To: <42FC07EF.9060506@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Mark Lord wrote:
> Tejun Heo wrote:
> 
>>
>>  * _All_ errors are handled in EH thread.
>>  * Once any error has occurred, all normal processing stops until 
>> error condition is cleared by EH.
> 
> 
> Do you mean "all normal processing" for that channel stops,
> or *ALL* processing on all libata channels stops?
> 
> Obviously the former, I presume.
> 
> Cheers

  Yeah, the former of course.  ;-)  Error state is indicated by one of 
the followings.

  * ATA_FLAG_ERROR	: one or more errors have occurred and EH is
			  scheduled to run.
  * ATA_FLAG_RECOVERY	: EH in progress

  When either of above flags is set, only commands w/ ATA_QCFLAG_PREEMPT 
flag set gets to run and complete.  So, currently, sense requesting and 
NCQ log page reading are done w/ the flag set.

-- 
tejun
