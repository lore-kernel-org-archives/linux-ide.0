From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 01 Mar 2006 14:41:57 -0500
Message-ID: <4405F905.6060503@pobox.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <Pine.LNX.4.64.0603011405200.3177@p34> <4405F78D.7000005@rtr.ca> <Pine.LNX.4.64.0603011436300.2740@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:11226 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751844AbWCATmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 14:42:10 -0500
In-Reply-To: <Pine.LNX.4.64.0603011436300.2740@p34>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

Justin Piszcz wrote:
> 
> 
> On Wed, 1 Mar 2006, Mark Lord wrote:
> 
>> Justin Piszcz wrote:
>>
>>>
>>> Did you mean you wanted us to test it like we normally do, ie, copy 
>>> files/md5sum them on the disk and see if we can make it occur again, or?
>>
>>
>> Yes.  The S.M.A.R.T. stuff doesn't matter nearly as much as normal I/O.
>>
>> And Justin, can you get those S.M.A.R.T. errors to pop up on 2.6.15 as 
>> well?
>>
> 
> Have not tested, can test later if necessary, running some I/O tests to 
> the disk which is probably going to take quite a while to see if I can 
> get it to error again with 2.6.16-rc5-git4.

If there are FUA problems, it would be immediately apparent on the first 
write...

	Jeff


