From: Mark Lord <liml@rtr.ca>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 19:51:37 -0400
Message-ID: <4626AF09.8020307@rtr.ca>
References: <461D4E2C.6000704@redhat.com>	 <Pine.LNX.4.61.0704112315480.20436@yvahk01.tjqt.qr>	 <461D54AF.3060706@redhat.com> <414cba4e0704150907r215bf196n637070dd40bccc3b@mail.gmail.com> <46253F14.4020304@rtr.ca> <462540CD.9080406@redhat.com> <46254416.6090202@rtr.ca> <4625AF20.7050904@gmail.com> <4626AB77.20709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2357 "EHLO
	mail.rtr.ca" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S2993008AbXDRXvm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Apr 2007 19:51:42 -0400
In-Reply-To: <4626AB77.20709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Stephen.Clark@seclark.us

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> 1. shutdown(8) issues SYNCHRONIZE_CACHE followed by STANDBY_NOW
>> 2. kernel shutdown starts
>> 3. libata shutdown issues SYNCHRONIZE_CACHE
>> 4. power goes off
> 
> Okay, after some experimentatino, it's the STANDBY_NOW that
> is causing the Power-Off_Retract_Count to increment on my machine.
> 
> Tell me again why we think we need to issue that command ?

Arghh.. okay, removing that from the code has no effect on it either.
I just don't understand the problem any more, since I don't actually
have it here (I think).

Can somebody explain again what the issue was, when it began happening,
and whatever else?  And what Tejun's fix (2.6.22) does again?

I've lost all of the early postings.

Thanks
