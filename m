From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 18:31:10 +0400
Message-ID: <20080812143110.GA23961@oksana.dev.rtsoft.ru>
References: <48A05152.7020508@harris.com> <20080811151913.GA14690@oksana.dev.rtsoft.ru> <48A0676E.5020308@harris.com> <20080811170756.GA29827@oksana.dev.rtsoft.ru> <1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com> <20080812140457.GA9103@oksana.dev.rtsoft.ru> <48A19BC2.8060008@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:57802 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752337AbYHLObL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 10:31:11 -0400
Content-Disposition: inline
In-Reply-To: <48A19BC2.8060008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Steven A. Falco" <sfalco@harris.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks, Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>

On Tue, Aug 12, 2008 at 06:18:42PM +0400, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
>
>>>>> 1. IDE status read does not work. (But am I understand correctly
>>>>>   that IDE works well if IRQ is unspecified? Then this is hardly
>>>>>   an issue.)
>>>>> 2. IDE interrupt comes when it should not. I'd recommend to use
>>>>>   oscilloscope to find out what is happening there, that is, if
>>>>>   the drive actually deasserts its irq line after status read.
>>>>>   If so, than this could be a PIC problem.
>
>>>>> What is the platform on which you're observing the issue, btw?
>
>>>> Another possibility is that you got the wrong interrupt number
>>>> in the device-tree...
>
>>>> Ben.
>
>>> The platform is the AMCC Sequoia board.  We've built a little adapter to
>>> connect a compact flash card to the processor bus.  I believe the
>>> interrupt selection in the device tree is correct, and I've checked over
>>> the u-boot settings for the IRQ line (active high, level sensitive). 
>
>> IDE IRQs are active-low.
>
>    Only on the PCI and only in the native mode. Natively, the IDE INTRQ  
> signal is active-high, rising edge triggering, as on ISA. You seem to 
> have an invertor somewhere, if it's not a PCI chip...

Ugh. Right you are, as always. I've just looked into mpc8349emitx
schematics, there is indeed an inverter on the irq line.

CF in True IDE mode is active-high, sorry.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
