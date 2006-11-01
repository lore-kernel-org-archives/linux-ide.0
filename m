From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] hotplug polling, take 5
Date: Tue, 31 Oct 2006 22:22:19 -0500
Message-ID: <454812EB.2050907@pobox.com>
References: <11609518461142-git-send-email-htejun@gmail.com> <45480158.2030501@pobox.com> <45480E45.1050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18136 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423931AbWKADWY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 22:22:24 -0500
In-Reply-To: <45480E45.1050802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Hello, all.
>>>
>>> This is the fifth take of hotplug polling patchset.  This take doesn't
>>> contain any real change than rebasing over the current upstream[U].
>>> PMP patchset will be posted soon on top of this patchset and I wanted
>>> to avoid confusion by posting patchsets in order.
>>>
>>> As the name implies, this patchset implements hotplug by polling.
>>> hp-poll is used to
>>>
>>> * Monitor ports EH gave up.  When EH gives up on a port, it freezes
>>>   the port to protect the rest of the system from it.  The user used
>>>   to have to issue manual scan to retry the port.  hp-poll can monitor
>>>   such port and retry it when hotplug event is detected.  This is also
>>>   used by PMP support.
>>>
>>> * Support hotplug on controllers which can report hotplug conditions
>>>   but cannot raise interrupt.
>>
>> Patchset seems sane.  I'll need to re-read patch #1 in depth, but I 
>> give everything a tentative ACK for now.
>>
>> My biggest concern is power usage.  On laptops for example, the 99% 
>> common case is that the user will never hot[un]plug a drive, so we 
>> shouldn't waste power bothering with poking disabled ports.
> 
> Link powersave patchset should handle that together but I'm still not 
> sure what to do w/ user interface (which sysfs node to use).  Also, 
> controllers which are used on laptops && use hp-poll by default are 
> sata_nv (old ones) and some variant of sata_sil used in ati chipset. So, 
> it shouldn't cause trouble for most laptop users.

I'm not saying it causes trouble.  Just saying that polling unused ports 
is practically guaranteed to require more power than never doing so.

It shouldn't be hard to figure out where to poke stuff into sysfs...

	Jeff



