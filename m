From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 10:33:53 +0000
Message-ID: <43E1E011.6090701@projecthugo.co.uk>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com> <43E1C6E7.6090506@projecthugo.co.uk> <43E1DC3E.5090007@gmail.com>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.ifl.net ([213.18.248.106]:48612 "EHLO mx3.ifl.net")
	by vger.kernel.org with ESMTP id S1423449AbWBBKd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 05:33:57 -0500
Received: from [194.238.49.3] (beng-03.stn.ab2.ifl.net [194.238.49.3])
	by mx3.ifl.net (8.12.10/8.12.10) with ESMTP id k12AXr92008116
	for <linux-ide@vger.kernel.org>; Thu, 2 Feb 2006 10:33:55 GMT
In-Reply-To: <43E1DC3E.5090007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


>>
>>
>>
>> I have got 2.6.13 - 2.6.14 and 2.6.15 working on the a8v board in 
>> both 32 and 64bit mode.
>>
>> Matt
>>
>
> Are you also using dual core processor?  It seems like interrupts get 
> lost when routed to one of the processors.  Can you post your dmesg?
>
Sorry, I'm not. I missed that point. I'm using an AMD FX chip, not dual 
core.

Matt



