From: Tejun Heo <htejun@gmail.com>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 08:35:20 +0900
Message-ID: <43E145B8.6090404@gmail.com>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:6821 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423031AbWBAXfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 18:35:25 -0500
Received: by wproxy.gmail.com with SMTP id 69so478875wri
        for <linux-ide@vger.kernel.org>; Wed, 01 Feb 2006 15:35:25 -0800 (PST)
In-Reply-To: <20060201231911.GA5463@tentacle.sectorb.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:08:07AM +0900, Tejun Heo wrote:
> 
>>Vladimir B. Savkin wrote:
>>
>>>Hello!
>>>
>>>My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
>>>but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
>>>gaves error messages some minutes after boot.
>>>
>>>The messages are as following:
>>> ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
>>>where XX gets different values from time to time, 0x25 mostly.
>>>I/O to this controller halts after that.
>>>
>>>Attached are boot dmesg log and lspci output.
>>>
>>
>>How reproducible is the problem?  With how much certainty can you say 
>>the problem is introduced by newer kernels?  e.g. If the problem occurs 
>>most of the time with 2.5.15.1 but it stops happending after switching 
>>back to 2.6.13.3, you can be pretty sure.
> 
> 
> Highly reproducible: months vs. minutes of uptime.
> 
> 

Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
is saying that it's ready for the next command, yet interrupt handler of 
sata_via hasn't run and thus the timeout.  It looks like some kind of 
IRQ routing problem to me although I have no idea how the problem 
doesn't affect the boot process.

Can you try to boot with boot parameter pci=noacpi?

-- 
tejun
