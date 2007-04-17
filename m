From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Tue, 17 Apr 2007 22:04:08 +0400
Message-ID: <46250C18.5070708@ru.mvista.com>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se> <462136AF.9060505@ru.mvista.com> <46215347.2000403@rtr.ca> <462368D9.8060407@ru.mvista.com> <46250AF3.6090105@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:52949 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1161276AbXDQSDN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 14:03:13 -0400
In-Reply-To: <46250AF3.6090105@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Mark Lord wrote:

>>>>>> - correct the chipset names (from CMDxxx to PCI-xxx)

>>>>> Please explain why this rename is a correction.

>>>>   Because the chips are officially named PCI064[036] and PCI-64[89].

>>> We normally name things with a combination of brand and chip number.
>>> Lots of companies could have chips with PCI in the name,
>>> but the CMD64x designator makes it quite clear what we're dealing 
>>> with here.

>>   Note that I'm only changing designator in the procfs output, i.e. 
>> not something important to end user.

> Err.. in this case, the procfs output *is* there for the end-user.

   Aha, that's why it was removed form the most IDE drivers I guess. :-)

> Using the name printed on the chip, which matches the cmdxxx.c driver name,
> is by far the least confusing way to do it here.

   And I'm using the name printed on the chip.

>>> In the machines I have here with these chips,
>>> they are clearly labelled as "CMD" and then "PCI646.."

>>   Although I've never seen the chip, I guess that should be logo, not 
>> the name.

> Then perhaps you should test the scheme against the real hardware
> before patching it.

   LOL. There's thing called remote testing -- I guess you never bothered to look at the patches themselves.

> Cheers

MBR, Sergei
