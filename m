From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
 driver
Date: Wed, 28 Nov 2007 19:29:12 +0300
Message-ID: <474D9758.9070200@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain>	<20071127153908.GB14183@localhost.localdomain>	<20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56216 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759004AbXK1Q27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 11:28:59 -0500
In-Reply-To: <200711272233.00456.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org

Hello.

Arnd Bergmann wrote:

>>>This driver nicely wraps around pata_platform library functions,
>>>and provides OF platform bus bindings to the PATA devices.

>>>+static struct of_device_id pata_of_platform_match[] = {
>>>+     { .compatible = "pata-platform", },
>>>+};

>>"pata-platform" really means nothing outside of linux. A more
>>generic label would be useful.

> Maybe the name of the standards it supports? Could be
> "ata-4", "ata-5" and the like,

    It's not clear what info this would provide.

> or the exact transfer mode, like
> "pata-udma-5", "pata-pio-3", "sata-150", etc.

    I think this info should follow from the compatible property value 
implicitly, or maybe this info should be conveyed in some optional properties. 
It doesn't make sense to the generic platform driver anyway since it has no 
notion about the mode programming specifics. I think that as the device being 
driven is assumed to be a generic IDE device, the "compatible" property should 
contain "generic" or something alike (as well as usual board's and chip's names).

> 	Arnd <><

MBR, Sergei
