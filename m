From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Thu, 31 Jul 2008 09:00:10 +0800
Message-ID: <48910E9A.9060103@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com> <200807291713.29580.bzolnier@gmail.com> <488FBC6F.2080800@alcatel-lucent.com> <200807302143.37693.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 215.47.DSNET ([211.144.215.47]:46257 "EHLO
	cnshjsmin03.cn.alcatel-lucent.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751689AbYGaBVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 21:21:17 -0400
In-Reply-To: <200807302143.37693.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 30 July 2008, gshan wrote:
>
> [...]
>  
>   
>> The IRQ routing issue has been fixed. IRQ routing system
>> on my board is somewhat complicated: i8259->mlba (FPGA based
>> PCI device)->MV64460(system controller). I forgot to set MV64460
>> IRQ pin to level sensitive and edge sensitive was used, which caused
>> interrupt lost finally. After changing this to level sensitive, everything
>> seems fine. Now, the problem isn't interrupt lost, but suspending DMA
>> operations.
>>     
>
> Thanks for explaining this.
>
>   
>>> Also is the problem still present in 2.6.26 or 2.6.27-rc1?
>>>
>>> [ I don't see an information about the kernel version that is
>>>   being used in either of threads? ]
>>>   
>>>       
>> Sorry, I'm using 2.6.21 kernel.
>>     
>
> Would be great to try with some recent one, the issue may have been
> fixed already (which is quite likely given a number of bugfixes that
> went in recent kernels).
>   
I tried to searched in bugzilla.kernel.org and didn't find
there has fix on this issue. Yesterday, Jeff suggested me
to turn to ata driver for PIIX4. I tried this yesterday but still
have some problems to make PIIX4 workable under ata
driver. I will continue working on this today.

Gavin

> Thanks,
> Bart
>   

