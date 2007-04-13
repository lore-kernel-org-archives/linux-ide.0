From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_nv: Don't attempt using ADMA for (READ|SET)_MAX
 commands
Date: Fri, 13 Apr 2007 14:14:42 -0400
Message-ID: <461FC892.6020602@rtr.ca>
References: <20070413170831.GC27674@athena.road.mcmartin.ca> <20070413181935.6d60f230@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:3515 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbXDMSOp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 14:14:45 -0400
In-Reply-To: <20070413181935.6d60f230@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, jgarzik@pobox.com, bcollins@ubuntu.com

Alan Cox wrote:
> On Fri, 13 Apr 2007 13:08:31 -0400
> Kyle McMartin <kyle@canonical.com> wrote:
> 
>> READ_NATIVE_MAX and SET_MAX were causing timeouts on sata_nv controllers.
>> Disabling ADMA helped, but that is quite a large hammer to use. Reverting
>> 382a6652e91b34d5480cfc0ed840c196650493d4 also helped, but we might as well
>> fix it right, instead of disabling the performance gain on cache flushes
>> by using ADMA mode.
> 
> Probably not going to make any performance difference to blacklist all
> non-data commands or all but a few like cache-flush. 

I agree.  The Pacific Digital ADMA stuff had some quirks for various non-data
commands as well, and the sensible thing was to just not use ADMA for anything
other than READs/WRITEs and possible CACHE FLUSHes.

Cheers
