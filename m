From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Thu, 13 May 2010 00:30:53 +0400
Message-ID: <4BEB0FFD.1090701@ru.mvista.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>	<4BE6910D.9070504@ru.mvista.com>	<4BE69C81.2070703@gmail.com>	<4BE6BA74.10200@mvista.com>	<4BE74EEE.5060307@gmail.com>	<4BE7D714.9010006@ru.mvista.com> <20100511105531.39670354@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57767 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757557Ab0ELUbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 16:31:39 -0400
In-Reply-To: <20100511105531.39670354@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Graeme Russ <graeme.russ@gmail.com>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>    As I said, we *can't* implement the driver methods at the board 
>> level. Especially if they involve messing with timings -- that's the 
>> point where the ATA driver stops being generic, like pata_platform, and 
>> there arises a need for the dedicated driver. Also, your patch would 
>> bring in disparity with the ide-platfrom driver (which should be 
>> interchangeable with pata_platfrom). For me, the need of a separate 
>> driver is clear now, so I'll remain opposed to your patch. Of course, 
>> the maintainer (Jeff Garzik) will decide but if I could veto this patch 
>> I would.
>>     
>
> I don't think ide-platform matters in this case.

   You've just supported a patch restoring feature parity between 
pata_platform and ide-platfrom WRT IRQ flags. ;-)

> You can certainly add
> the same support to the old ide_platform driver, but the old code can't
> be allowed to block progress with newer stuff. It's also trivial to add
>
> 	if (we have an xfer method) {
> 		printk("Oh poo");
> 		return -ENODEV;
> 	}
>
> to the IDE one so it simply refuses to bind to more featureful
> implementatins.
>   

   Yes, but this needs to be *done* too, preferrably by the author of 
the original patch and simultaneously with it. We can't accept a single 
patch that only touches pata_platform.

> I also don't see a problem with the transfer function needing to do
> arbitration, byte stuffing and other magic - that's quite common on
> embedded weirdnesses.
>   

   Agreed.

> The point it ceases to make sense is where you need to do mode setting.
> If the GPIO frobbing is managing the platform bus requirements then it
> makes sense as a platform function. If it's going to grow into full ATA
> set xfer mode support it probably turns into a new driver at some point.
>   

   In this case I do suspect we have fully programmable bus timings, and 
hence should be able to do mode setting. Partly because of that, I'd 
still like to see this case handled with a separate driver.

> Either way it makes sense to support overriding the data_xfer operation,
> and we've done something analogous for years with 8250 serial and it has
> been a *huge* success and saved us having about thirty similar
> platform serial drivers.
>   

   Well, with 8250 we still don't allow for overriding things at the 
board level, via the platform data callbacks.

> Alan
>   

WBR, Sergei


