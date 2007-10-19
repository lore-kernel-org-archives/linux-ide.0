From: Tejun Heo <htejun@gmail.com>
Subject: Re: [stable] [PATCH -stable] libata: sync NCQ blacklist with	upstream
Date: Fri, 19 Oct 2007 11:33:57 +0900
Message-ID: <47181795.8030705@gmail.com>
References: <20071011015515.GQ12186@htj.dyndns.org> <20071011025734.GA30990@kroah.com> <470D96B3.3040405@gmail.com> <20071011033220.GA31225@kroah.com> <470D9B7A.10207@gmail.com> <20071011035553.GA31615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:30282 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763534AbXJSCeI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 22:34:08 -0400
Received: by wr-out-0506.google.com with SMTP id 36so321779wra
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 19:34:08 -0700 (PDT)
In-Reply-To: <20071011035553.GA31615@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

Greg KH wrote:
> On Thu, Oct 11, 2007 at 12:41:46PM +0900, Tejun Heo wrote:
>> Greg KH wrote:
>>> On Thu, Oct 11, 2007 at 12:21:23PM +0900, Tejun Heo wrote:
>>>> Greg KH wrote:
>>>>> On Thu, Oct 11, 2007 at 10:55:15AM +0900, Tejun Heo wrote:
>>>>>> Synchronize NCQ blacklist with the current upstream.
>>>>> Which -stable tree is this for, 2.6.22 or 2.6.23?
>>>> It's against 2.6.23.
>>> Ok, but things only go into -stable after they are already in Linus's
>>> tree, which hasn't happened yet...
>>>
>>> So what is considered "upstream" here?  Jeff's tree?
>> Yeah, except for one entry, all others are in libata-dev#upstream which
>> will be pulled when -rc1 opens.  I'll ping you back when they actually
>> get merged.
> 
> Thanks, that would help out a lot.

Alright, those changes are in Linus's tree now.

Thanks.

-- 
tejun
