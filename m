From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Wed, 30 Jan 2008 21:34:17 -0000 (UTC)
Message-ID: <50028.82.140.53.128.1201728857.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>         
    <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>         
    <479BC34D.2000007@gmail.com>      
    <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>   
    <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>   
    <479D2D3C.4050102@gmail.com>
    <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>
    <479DC4A4.30809@gmail.com>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:32873 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759961AbYA3VeX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 16:34:23 -0500
In-Reply-To: <479DC4A4.30809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: dusty@gmx.li, linux-ide@vger.kernel.org

>> Shuffling the drives did not change anything to the linkspeed of the 3
>> ports running with 1.5 Gbps. Looks like the problem is port-related.
>
> Hmm... Okay.  Maybe the signal traces or connectors have some problems.
> But 3.0Gbps on downstream port doesn't make any difference anyway so
> unless it leads to errors, it should be fine.
>
>> The first PSU (Multilane) offers (measured) 12,20 V on both lanes. This
>>  falls during read/write access on all drives attached down to 12,10 V.
>>
>
> That explains the PHY dropouts.  I've even seen drives to do hard reset
> accompanying emergency head unload due to voltage dropping when high IO
> load hits.  Of course, data in cache is lost.
>
>> The second PSU (Singlelane) offers (measured) 11,75 V. This doesn't
>> change during read/write access on all drives attached. I tested the
>> second PSU without anything attached and it still offered 11,75 V.
>
> 11.75 is still in spec and it doesn't fluctuate.  I like this power much
> better.
>
>> I will try to add another PSU this evening and remeasure.
>> Currently the whole machine needs about 350W.
>> The PSUs are Targan 500W (Multilane - 2x12V 10A)
>>
>
> Maybe one of the lane is only connected to video power connectors?
> IIRC, that was the idea of multilane power anyway.
>
>
> Please lemme know your test result.
>
Sorry for my late answer, but i had to sort this out first.
After replacing the first PSU with a new Corsair 650W the power no longer
fluctuated more than 0,01 V (and this only when booting up the drives...)
I did a full resync on both raid arrays and got no more errors or resets,
but there were some inconsitencies during sync and the xfs filesystem on
both arrays had to be repaired. Are these problems caused by the pm resets
?

Thanks for your patience.

