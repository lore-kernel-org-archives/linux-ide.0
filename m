From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Thu, 14 Feb 2008 11:24:42 -0500
Message-ID: <47B46B4A.80708@rtr.ca>
References: <47A3375F.80101@gmail.com> <47B2368D.9080408@gmail.com> <47B319C2.5030002@rtr.ca> <47B388B1.6050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4671 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbYBNQYo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 11:24:44 -0500
In-Reply-To: <47B388B1.6050203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> This patch implements libata.force module parameter which can
>>> selectively override ATA port, link and device configurations
>>> including cable type, SATA PHY SPD limit, transfer mode and NCQ.
>> ...
>>> +    libata.force=    [LIBATA] Force configurations.  The format is comma
>>> +            separated list of "[ID:]VAL" where ID is
>>> +            PORT[:DEVICE].  PORT and DEVICE are decimal numbers
>>> +            matching port, link or device.  Basically, it matches
>> ..
>>
>> Mmm.. not a NAK, but is there also a way to set/change these on the fly?
> 
> What do you mean by 'on the fly'?  While the system is running?  If so,
> I think that should be done through other interfaces - pass through,
> sysfs, etc...
..

Yes, that's the type of thing I had in mind.
Some way to accomplish similar forced settings *after* libata is loaded.

>> Now mind you, it's more likely the PCI layer that does the reverse
>> order thing, but the end result is that my drives/ports are numbered
>> differently depending upon which kernel I happen to boot with.
> 
> Heck... That's ugly.  libata.force is mainly conceived as debugging /
> installation helper, so using fixed PORT is good enough but maybe
> allowing bus_id as PORT is useful?  Something like [00:1f.2]:00?
..

It's just plain ugly the way it works, but livable (barely).
We might actually have a use here for something similar to "ide=reverse",
which was intended for exactly this kind of situation.

But such usability flags seem to be in disfavour nowadays.

Cheers! 

