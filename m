From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
Date: Mon, 03 Jan 2011 19:33:17 +0300
Message-ID: <4D21FA4D.3030506@mvista.com>
References: <201101031445.47922.roman.fietze@telemotive.de>	<20110103135929.GO18831@htj.dyndns.org>	<4D21DD55.2000000@ru.mvista.com> <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com> <4D21EAF1.2010504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44562 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab1ACQeY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 11:34:24 -0500
Received: by ewy5 with SMTP id 5so6119667ewy.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 08:34:22 -0800 (PST)
In-Reply-To: <4D21EAF1.2010504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello.

On 03-01-2011 18:27, Sergei Shtylyov wrote:

>>>> The commit you bisected to contains all those conversions too. Take a
>>>> look at a similar driver and look at how it has been converted
>>>> recently. Even better, just send the driver upstream. :-)

>>> It's already there...

>> Ouch, did I forget to convert

> It probably wasn't obvious as this driver had lived in non-BMDMA section of
> Kconfig before the recent patch:

> http://marc.info/?l=linux-ide&m=129303304605907

>> it or was it a merge timing problem?
>> Anyways, sorry about that. Please go ahead and fix it. :-)

    Looks like the commit that added DMA support should be thanked for the 
mischief:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6b61e69e7bc1cfe80ab54c6321f19061f9487ed3

WBR, Sergei
