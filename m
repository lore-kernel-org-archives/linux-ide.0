From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: How to cleanly setup legacy IDE irq ?
Date: Sun, 03 Oct 2004 21:27:10 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4160A6EE.1010804@pobox.com>
References: <1096602694.11460.29.camel@gaston>	 <200410032254.16900.bzolnier@elka.pw.edu.pl>	 <1096846969.9516.39.camel@gaston>	 <200410040227.14513.bzolnier@elka.pw.edu.pl> <1096851939.9516.53.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43905 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268300AbUJDB1c
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Oct 2004 21:27:32 -0400
In-Reply-To: <1096851939.9516.53.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2004-10-04 at 10:27, Bartlomiej Zolnierkiewicz wrote:
> 
> 
>>>Then you'll have a ton of
>>>
>>>#ifdef CONFIG_****
>>>	if (machine == blablabla)
>>>		irq = something;
>>>#endif
>>>#if CONFIG_****
>>>	irq = something else
>>>#endif
>>>
>>>and that sort of thing all over drivers... stinks as well.
>>
>>Actually it is fine with me.  I find it very informative. :)
>>Also host driver specific code is where is should belong.
> 
> 
> Ugh ? damn, that's a textboot example of crappy code ! You are
> putting interrupt routing platform knowledge in non-platform specific
> drivers, that is disgusting !

Yeah, I agree...  unless the driver is wholly platform specific (in 
which case no #ifdefs).



> Well, then what about my proposal above ?
> 
>   int ide_get_pci_legacy_irq(struct pci_dev *pdev, int channel);
> 
> (with eventually an #ifdef ARCH_HAS.....)
> 
> We could have it either called by the chipset drivers themselves, or by
> the generic code when the controller is in legacy mode.

How about a more generic, yet more specific pci_init_hwif()?

	Jeff



