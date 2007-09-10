From: Mark Lord <liml@rtr.ca>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 10 Sep 2007 08:18:47 -0400
Message-ID: <46E53627.20101@rtr.ca>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca> <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com> <46E03DF6.8090405@gmail.com> <46E1545A.5000404@rtr.ca> <46E24ADC.2000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4135 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756937AbXIJMSt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2007 08:18:49 -0400
In-Reply-To: <46E24ADC.2000500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Eddie Hung <eddie.hung@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Eddie Hung wrote:
>>>> However, I think we can conclude that ICH6M (which on the X41, has a
>>>> SATA-PATA bridge to connect a PATA drive) does not seem to support
>>>> MWDMA
>>> It isn't clear whether the fault is at the driver or the CF device.
>> It's probably the bridge chip --> we've run through that one before
>> just recently (early summer?) on this list.  A particular bridge that
>> doesn't work at all with MWDMA.
> 
> Hmmm... How do we solve this situation?  Till now, we've been
> blacklisting the device IDs but it doesn't work for broken bridges.
> Maybe we should default to not using MWDMA by default?

Alan has observed that we really need to have a way to identify the bridge chip.
But those seem to be mostly invisible to ordinary commands.  Perhaps somebody
at Marvell might give us the vendor-specific commands required to do this.

Failing that, we cannot do it automatically, so we really do need some kind
of boot/module/sysfs method for overriding libata's chosen transfer method.

Blacklisting doesn't work here, because we really need to blacklist
the invisible bridge chip, not the main chipset or the device.

Cheers

