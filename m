From: Tejun Heo <htejun@gmail.com>
Subject: Re: Dreaded PDC irq nobody cared
Date: Thu, 06 Oct 2005 15:09:56 +0900
Message-ID: <4344BFB4.4080600@gmail.com>
References: <1128079936.6097.16.camel@localhost.localdomain>	 <1128329273.4237.9.camel@localhost.localdomain> <1128506696.4964.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:4975 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751237AbVJFGKC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 02:10:02 -0400
Received: by wproxy.gmail.com with SMTP id 57so178344wri
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 23:10:01 -0700 (PDT)
In-Reply-To: <1128506696.4964.28.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Erik Slagter wrote:
> On Mon, 2005-10-03 at 10:47 +0200, Erik Slagter wrote:
> 
>>> - is there any chance booting with noapic would make a difference? I
>>>must say my apic is a bit flaky (according to the logs)
>>
>>BTW I tried noapic, it did seem to work for two days, but then again
>>crashed with the same problem :-(
> 
> 
> I have played around a little more and found these interesting results.
> 
>  - The difference between having or having not the stuck interrupt seems
> to be the forced cooling of the attached harddisks; I find this also
> very hard to believe, but it is very reproducable; so to anyone having
> problems with the promise sata controllers I'd recommend buying
> dedicated harddisk coolers.
>  - I did a test run with disabling of "stuck" interrupts disabled and I
> can say: the interrupt is really stuck, it's no kernel bug; after some
> time I rebooted and the controller (or harddisk) still was in a confused
> state (no booting possible at all), only after an hour it started
> working again; indeed looks like a heat problem.

  Sounds like you got a faulty drive or really bad ventilation in your case.

-- 
tejun
