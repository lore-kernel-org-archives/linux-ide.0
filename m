From: Tom Evans <tom@23palmer.net>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Thu, 30 Aug 2007 00:42:18 -0400
Message-ID: <46D64AAA.7090808@23palmer.net>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:28326 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXH3EmY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 00:42:24 -0400
In-Reply-To: <46D64290.2010306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Thanks for the response Jeff !

Jeff Garzik wrote:
>
> Alpha should not be operationally much different from other little 
> endian 64-bit platforms.
>
> The PCI swizzle might be weird (what is your Alpha platform?), is the 
> only Alpha-specific thing that comes to mind.
>
I am using a DS20  (Tsunami / Goldrush).
>
>> I have similar such behavior before when using drivers that generate 
>> many unaligned accesses - I only have seen 2 places they occur in 
>> sata_sil24 and have fixed them myself, but that made no difference.
>
> We definitely want to fix all these you find.  Please post more info...
>
In sil24_config_port, the writel's for /* zero error counters */ should 
be writew's - they are 16bit control registers.
Only PORT_DECODE_ERR_THRESH and PORT_CRC_ERR_THRESH appear to be 
unaligned, but why risk a stl when a stw (on platforms that support it) 
can be used.
> Also, if you are highly motivated, I would love to see if other SATA 
> cards have similar problems on Alpha...
>
I'll need to find a computer store with a decent return policy, but I 
would consider doing it ....

...tom
