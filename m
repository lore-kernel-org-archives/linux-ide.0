From: Weksler Izik <weksler@elta.co.il>
Subject: RE: Fwd: Re: libata pmp support
Date: Mon, 27 Aug 2007 12:34:38 +0200
Message-ID: <0E3B1CAFCEB8484D8071762F8538E90320D12E@ELTIMAIL.elta.co.il>
References: <46D229B1.4070409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout4.netvision.net.il ([194.90.9.27]:52759 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbXH0Jcm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2007 05:32:42 -0400
Received: from elta.co.il ([207.232.27.5]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with SMTP id <0JNF00DPBEIGKCD0@mxout4.netvision.net.il> for
 linux-ide@vger.kernel.org; Mon, 27 Aug 2007 12:32:40 +0300 (IDT)
In-reply-to: <46D229B1.4070409@gmail.com>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun,

I did it yesterday with the 2.6.22.5 vanilla from kernel.org. It works.
I don't have the dmesg output here - I'll send it to you in the evening.
Generally:
It defines ATA2 as Config disk but doesn't wait for device ID and doesn't perform several resets - no delay during the boot. Which actually has been the target of the fix.
Otherwise the kernel boots OK and performs well.

Do you want more info besides the dmesg? What other test do you want me to run with the new kernel?
As a matter of fact with this kernel looks like many things work faster. Is it because of the performance improvements or because it is without SUSE patches?

Isaac

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Monday, August 27, 2007 3:33 AM
To: iweksler@bezeqint.net
Cc: linux-ide@vger.kernel.org
Subject: Re: Fwd: Re: libata pmp support

Izik Weksler wrote:
> 
>  >>>On Saturday 25 August 2007, Tejun Heo wrote:
>> Izik Weksler wrote:
>>> ----------  Forwarded Message  ----------
>>>
>>> Subject: Re: libata pmp support
>>> Date: Thursday 23 August 2007
>>> From: Izik Weksler <iweksler@bezeqint.net>
>>> To: Tejun Heo <htejun@gmail.com>
>>>
>>>  >>>On Thursday 23 August 2007, you wrote:
>>>> Izik Weksler wrote:
>>>>> Tejun,
>>>>>
>>>>> If you're sending the patch please send it to this address.
>>>> Okay, please test the attached patch and please cc 
>>>> linux-ide@vger.kernel.org when replying.  Thanks.
>>> Tejun,
>>>
>>> The patch failed. It sais:
>> Against which version?  The patch will apply to 2.6.22.5 & 2.6.23-rcX 
>> w/o the PMP patches.
> 
> Yeah. I realized that it applies to a version that doesn't contain pmp 
> support. I tried to apply it to the 2.6.22.2-3 that goes with the SUSE 
> 10.3 and of course it failed because it is pmp patched.
> So you suggest that I use the 2.6.22.5 vanilla from the 
> www.kernel.org? If not please send me a link to the applicable version.

Yeap, please apply against vanilla kernels.  Thanks.

--
tejun

 The information contained in this communication is proprietary to Israel Aerospace Industries Ltd. 
and/or third parties, may contain confidential or privileged information, and is intended only for 
the use of the intended addressee thereof. If you are not the intended addressee, please be aware 
that any use, disclosure, distribution and/or copying of this communication is strictly prohibited.
If you receive this communication in error, please notify the sender immediately and delete it from 
your computer. Thank you. 


This message is processed by the PrivaWall Email Security Server. 



