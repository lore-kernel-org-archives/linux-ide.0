From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
 driver
Date: Fri, 30 Nov 2007 14:05:01 +0300
Message-ID: <474FEE5D.2030905@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de> <20071128154904.GA20722@localhost.localdomain> <474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina> <474FE332.8080103@ru.mvista.com> <20071130105849.GA10840@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13417 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757893AbXK3LEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 06:04:50 -0500
In-Reply-To: <20071130105849.GA10840@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: cbou@mail.ru, Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

Anton Vorontsov wrote:

>>>Remaining question: any preferred name for that property? pio-mode okay?
>>>It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.

>>   I've already suggested "generic". A name "simple" also comes to my mind.

> You've misread my question. I didn't ask about driver name, but pio-mode
> property.

    I'm OK with "pio-mode" then. Just don't think it makes much sense in the 
context of this driver which has no provision for the programming the mode 
timings (and if there were some provision, the *generic* platform driver 
couldn't handle it anyway).

> As for the driver name, it doesn't matter at all, as I've said already:
> it's Linux specific anyway, and another compatible properties could be
> added at any time, to a device tree and/or to the OF driver itself (if
> some real OpenFirmware will pass some meaningful compatible property
> that we'll have to match in that driver).

> "generic" name is also bad one, it's confusing wrt ata_generic.c
> driver (PCI).

    The "compatible" property doesn't have to contain the driver name, so 
there should be no confusion with the driver names. It's just different name 
spaces. :-)

> "simple" name doesn't tell anything at all. So, I'd rather stick with -platform name.

    Well, those two should be "generic-ata" and "simple-ata" of course. And it 
*does* tell that the driver just provides taskfile control, without the 
transfer timing control and other fancy stuff...

> Thanks,

MBR, Sergei
