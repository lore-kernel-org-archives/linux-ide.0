From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: pdc20575 and driver 1.04
Date: Mon, 22 May 2006 13:10:49 -0400
Message-ID: <4471F099.4060109@pobox.com>
References: <44718312.9090900@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50327 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751002AbWEVRKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 13:10:53 -0400
In-Reply-To: <44718312.9090900@ipom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: viet@mandriva.com, linux-ide@vger.kernel.org

Phil Dibowitz wrote:
> jgarzik@pobox.com wrote:
>> viet@mandriva.com wrote:
>>> Hi Jeff,
>>>
>>> We've briefly met at Deauville while you were working with mandriva
>>> I hope everything is fine with you - I myself have just been laid
>> off, just about \
>>> six years after joining mandrake ...
>>> Anyway, back to business.
>>> I have a Promise sataII TX2+ cards, with a pdc 20575.
>>>
>>> I have just tried stock 2.6.17-rc4 and applied
>>> 2.6.17-rc4-git2-libata1.patch.bz2
>>> I am only detecting the two sata lines.
>>> the motherboard is smp, and has pdc20265 onboard. there are 4 drives
>> attached to \
>>> the TX2+ (two sata, two pata)
>>> If I am not mistaken, driver version 1.04 is the latest one you have > ?
>> Promise PATA-on-SATA-cards support lives in
>> libata-dev.git#promise-sata-pata, until someone cleans it up.
>>
>> This is not found in 2.6.17-rc4 nor 2.6.17-rc4-git2-libata1.  It is
>> found in Andrew Morton's -mm tree, though.
> 
> It's not in 2.6.17-rc4-git2-libata1?

No.  -libata1 only contains #upstream, not other useful for-testing 
changes such as #promise-sata-pata.


> Did you remove that support from the libata patches at
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/ ?
> 
> 2.6.15-libata1.patch added Promise PATA-on-SATA for my PC20378 (see my
> email from earlier today)...
> 
> In fact, back on 09/09/05, Matt (Reuther?) pointed me to your patches
> (and CC'd the list) for exactly that reason:
> http://marc.theaimsgroup.com/?l=linux-ide&m=112629381132249&w=2
> 
> I'm confused...

Just simply that 2.6.17-rc4-git2-libata1 patch didn't include "other 
stuff", unlike the other patches.

	Jeff


