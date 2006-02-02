From: Tejun Heo <htejun@gmail.com>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 20:50:41 +0900
Message-ID: <43E1F211.8030507@gmail.com>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com> <20060202114429.GA3035@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:41005 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750753AbWBBLur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 06:50:47 -0500
Received: by wproxy.gmail.com with SMTP id 69so574601wri
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 03:50:46 -0800 (PST)
In-Reply-To: <20060202114429.GA3035@tentacle.sectorb.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:35:20AM +0900, Tejun Heo wrote:
> 
>>Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
>>is saying that it's ready for the next command, yet interrupt handler of 
>>sata_via hasn't run and thus the timeout.  It looks like some kind of 
>>IRQ routing problem to me although I have no idea how the problem 
>>doesn't affect the boot process.
>>
>>Can you try to boot with boot parameter pci=noacpi?
> 
> 
> That did not help.
> 
> And yes, irqbalance is running, as Kenneth suggested.
> 

Sadly, I'm pretty much ignorant with that part of the kernel.  However, 
if it's really because interrupts are lost when sent to one of the 
processors, one of the following should keep the system going while the 
other cause the problem immediately.

echo 1 > /proc/irq/your_IRQ_number/smp_affinity

or...

echo 2 > /proc/irq/your_IRQ_number/smp_affinity

-- 
tejun
