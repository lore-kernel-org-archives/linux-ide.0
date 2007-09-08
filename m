From: Tom Evans <tom@23palmer.net>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Sat, 08 Sep 2007 00:32:31 -0400
Message-ID: <46E225DF.6060309@23palmer.net>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:4713 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbXIHE43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 00:56:29 -0400
In-Reply-To: <46D64290.2010306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org


I decided to put the Norco 4618 card into the first PCI slot of my DS20.

It and the PMP support seem to like that location much better - I'm 
successfully creating an array at the moment (with not much apparent 
slowdown to the system).

I was able to move the graphics card to another slot (which for a period 
in the past was also limited to the first PCI slot).

Maybe this will make sense to some folks out there - thanks!

...tom


Jeff Garzik wrote:
> Tom Evans wrote:
>> Have you heard of such and issue with the 3124-2/4276 combination?
>> Is anyone else trying this driver on an Alpha?
>
> Alpha should not be operationally much different from other little 
> endian 64-bit platforms.
>
> The PCI swizzle might be weird (what is your Alpha platform?), is the 
> only Alpha-specific thing that comes to mind.
>
>
>> I have similar such behavior before when using drivers that generate 
>> many unaligned accesses - I only have seen 2 places they occur in 
>> sata_sil24 and have fixed them myself, but that made no difference.
>
> We definitely want to fix all these you find.  Please post more info...
>
> Also, if you are highly motivated, I would love to see if other SATA 
> cards have similar problems on Alpha...
>
>     Jeff
>
>
>
