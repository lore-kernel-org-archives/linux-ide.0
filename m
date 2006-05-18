From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
Date: Thu, 18 May 2006 17:07:35 -0400
Message-ID: <446CE217.2070703@pobox.com>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29581 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751218AbWERVHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 17:07:41 -0400
In-Reply-To: <446CDE26.8090504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Zang Roy-r61911 <tie-fei.zang@freescale.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> ..
>>>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>>>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
>>> *mmio)
>>>>  {
>>>>       u32 tmp;
>>>> -
>>>> +#ifndef CONFIG_PPC
>>>>       writel(0, mmio + MV_GPIO_PORT_CTL);
>>>> +#endif
>>>
>>> You'll have to do better here too... I don't wee why when compiled on
>>> PPC, this driver should "magically" not clear those bits... At the very
>>> least, you should test the machine type if you want to do something
>>> specific to your platform, but first, you'll have to convince Jeff why
>>> this change has to be done in the first place and if there is a better
>>> way to handle it.
>>
>> Correct...  it does seem some bugs were found, but #ifdef powerpc is 
>> certainly out of the question.  We want the driver to work without 
>> ifdefs on all platforms.
> 
> Yup.  I have a powerpc platform here with PCI-X, and a PCI-X Marvell card
> to try in it.  So I'll pick up these changes and try to integrate them a
> little more nicely in my internal updated driver, and then pass it on to 

When will this happen?  I'm getting worried that useful stuff is 
disappearing into the Mark Lord ether, with no changes appearing on the 
other side.  Haven't seen patches from you in weeks.

I'm happy that you have an updated internal driver, but that helps no 
one else.

	Jeff



