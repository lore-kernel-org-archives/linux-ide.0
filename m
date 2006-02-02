From: Tejun Heo <htejun@gmail.com>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 19:17:34 +0900
Message-ID: <43E1DC3E.5090007@gmail.com>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com> <43E1C6E7.6090506@projecthugo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:5596 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932453AbWBBKRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 05:17:39 -0500
Received: by wproxy.gmail.com with SMTP id i32so479365wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 02:17:38 -0800 (PST)
In-Reply-To: <43E1C6E7.6090506@projecthugo.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel-lists@projecthugo.co.uk
Cc: linux-ide@vger.kernel.org

Matt Darcy wrote:
> 
>>
>> Your BMDMA controller is reporting raised interrupt (0x4) and your 
>> drive is saying that it's ready for the next command, yet interrupt 
>> handler of sata_via hasn't run and thus the timeout.  It looks like 
>> some kind of IRQ routing problem to me although I have no idea how the 
>> problem doesn't affect the boot process.
>>
>> Can you try to boot with boot parameter pci=noacpi?
> 
> 
> 
> I have got 2.6.13 - 2.6.14 and 2.6.15 working on the a8v board in both 
> 32 and 64bit mode.
> 
> Matt
> 

Are you also using dual core processor?  It seems like interrupts get 
lost when routed to one of the processors.  Can you post your dmesg?

-- 
tejun
