From: Tejun Heo <htejun@gmail.com>
Subject: Re: error handling - DMA to PIO step down sequence
Date: Fri, 22 Sep 2006 01:58:53 +0900
Message-ID: <4512C4CD.80000@gmail.com>
References: <4511907F.1010104@emc.com> <4512AB17.7040907@gmail.com>	 <4512BD19.5010401@emc.com> <1158858264.11109.159.camel@localhost.localdomain> <4512C2C0.9010503@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:30052 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWIUQ7J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Sep 2006 12:59:09 -0400
Received: by nz-out-0102.google.com with SMTP id n1so428951nzf
        for <linux-ide@vger.kernel.org>; Thu, 21 Sep 2006 09:59:09 -0700 (PDT)
In-Reply-To: <4512C2C0.9010503@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>

Ric Wheeler wrote:
> Alan Cox wrote:
>> Ar Iau, 2006-09-21 am 12:26 -0400, ysgrifennodd Ric Wheeler:
>>
>>>>> Would this be a reasonable thing for a config option? Better to add 
>>>>> yet another blacklist for devices that might have a justified need 
>>>>> for this derating?
>>
>> I think so. I've got "Adding a set of flags to blacklist entries" on my
>> todo list so that we can indicate and deal with different kinds of
>> horkage.
> 
> That could be very useful - flag specific drives to disable NCQ 
> (regardless of the internal setting for drive queue depth) and so on.

Yeap, in general, we need a blacklist.  For example, some drives only do 
NCQ w/ only 16 or so commands or others have completely broken NCQ 
support.  But I don't think the broken read log page 10h needs a 
blacklist entry.  It can be easily handled by good default behavior.

-- 
tejun
