From: Tejun <htejun@gmail.com>
Subject: Re: irq-pio branch updated with Tejun's patches
Date: Thu, 09 Feb 2006 18:31:54 +0900
Message-ID: <43EB0C0A.5070408@gmail.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AFEF.4010909@gmail.com> <43EAB5BA.3050204@tw.ibm.com> <43EABDFB.8000505@gmail.com> <43EB0999.9060204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:18625 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030327AbWBIJcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:32:05 -0500
Received: by xproxy.gmail.com with SMTP id i30so85726wxd
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 01:32:05 -0800 (PST)
In-Reply-To: <43EB0999.9060204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Brian King <brking@us.ibm.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Hello, Albert.
>>
>> Albert Lee wrote:
>>
>>>>
>>>> This is sort of OT, but would it be possible to separate PIO
>>>> issuing/interrupt handling from ata_qc_issue_prot and ata_host_intr?
>>>>
>>>
>>> Isn't overriding the ->qc_issue() and ->irq_handle() in LLDD good 
>>> enough?
>>
>>
>>
>> The driver needs its own ->qc_issue() and ->irq_handler() but it also 
>> needs PIO support.  AFAICS, the current PIO implementation is rather 
>> strongly tied into ata_qc_issue_prot() and ata_host_intr() making it 
>> difficult to use PIO support in drivers which use private ->qc_issue() 
>> and ->irq_handler().  So, what I was asking was to separate out PIO 
>> handling from ata_qc_issue_prot() and ata_host_intr() such that other 
>> issue and intr routines can use PIO.
> 
> 
> What needs this separation?  initio?
> 

Yeah, it seems.  Its broken driver currently emulates BMDMA status to 
work with standard issue/intr functions, but it seems fragile.  In 
addition, for NCQ commands, the controller operates in different mode 
and the code will have to be distorted more than now.  So, I think it's 
better to use separate issue/intr handler and calling PIO helpers when 
needed.  Well, if that driver ever works, that is.  I'll contact Initio 
support again.  Hmmm.. I might even call them.  Heh heh. :-)

> 
>> Separating out traditional driving logic from libata-core.c would 
>> require another level of indirection such that traditional low level 
>> drivers still can mix & match different legacy operations.  I thought 
>> about it and wasn't really sure whether the added abstraction was 
>> worth the clean up.  We currently don't have too many controllers 
>> which are legacy-free, it seems.
> 
> IMO the solution is time.  Time and evolution will determine what's 
> best.  When a particular section of code get particularly large (PCI IDE 
> driver helper code), it certainly makes sense to split it out.  "Do what 
> you must, and no more" is the Linux maxim :)

Being a stupid over-designer, I'm sometimes a bit unconformtable with 
the approach but I guess I'll finally adapt.  I'll talk about this more 
in the thread regarding probe_reset component operatons.

Thanks.

-- 
tejun
