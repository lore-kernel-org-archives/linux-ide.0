From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Fri, 30 Nov 2007 14:45:42 +0300
Message-ID: <20071130114541.GA11047@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de> <20071128154904.GA20722@localhost.localdomain> <474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina> <474FE332.8080103@ru.mvista.com> <20071130105849.GA10840@localhost.localdomain> <474FEE5D.2030905@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:15605 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S933515AbXK3LlN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 06:41:13 -0500
Content-Disposition: inline
In-Reply-To: <474FEE5D.2030905@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: cbou@mail.ru, Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

On Fri, Nov 30, 2007 at 02:05:01PM +0300, Sergei Shtylyov wrote:
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
>    I'm OK with "pio-mode" then. Just don't think it makes much sense in the 
> context of this driver which has no provision for the programming the mode 
> timings (and if there were some provision, the *generic* platform driver 
> couldn't handle it anyway).

What sense it makes then?.. We're specifying bus limitations wrt
PIO modes.

Oh, I think you meant that bus can't be reconfigured by generic
driver, that's true. But I didn't mean this as a purpose for
pio-mode property (though it still could be used for that
purpose by other drivers).

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
