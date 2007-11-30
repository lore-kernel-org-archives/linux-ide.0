From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Fri, 30 Nov 2007 15:09:31 +0300
Message-ID: <20071130120931.GA11286@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de> <20071128154904.GA20722@localhost.localdomain> <474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina> <474FE332.8080103@ru.mvista.com> <20071130105849.GA10840@localhost.localdomain> <474FF776.1060803@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:15668 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752420AbXK3MFA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 07:05:00 -0500
Content-Disposition: inline
In-Reply-To: <474FF776.1060803@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: cbou@mail.ru, Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

On Fri, Nov 30, 2007 at 02:43:50PM +0300, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
> 
> >>>Remaining question: any preferred name for that property? pio-mode okay?
> >>>It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.
> 
> >>  I've already suggested "generic". A name "simple" also comes to my mind.
> 
> >You've misread my question. I didn't ask about driver name, but pio-mode
> >property.
> 
>    Probably "max-pio-mode" is a better variant.

Why? pio-mode in pata-platform context is just something highly
dependent on hardware, can not be touched. And we're passing
pio-mode information from the hardware dependent source --
device tree.

The only difference between pata-platform's max-pio-mode and
dedicated ata driver's pio-mode is that that for the first case
bus already configured for specified mode, and for the second
case dedicated driver should actually use this information
to configure hardware.

No need for max- prefix, I think.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
