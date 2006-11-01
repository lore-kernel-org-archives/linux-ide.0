From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] hotplug polling, take 5
Date: Wed, 01 Nov 2006 12:02:29 +0900
Message-ID: <45480E45.1050802@gmail.com>
References: <11609518461142-git-send-email-htejun@gmail.com> <45480158.2030501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:39259 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946042AbWKADCi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 22:02:38 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1629570ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 19:02:37 -0800 (PST)
In-Reply-To: <45480158.2030501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> This is the fifth take of hotplug polling patchset.  This take doesn't
>> contain any real change than rebasing over the current upstream[U].
>> PMP patchset will be posted soon on top of this patchset and I wanted
>> to avoid confusion by posting patchsets in order.
>>
>> As the name implies, this patchset implements hotplug by polling.
>> hp-poll is used to
>>
>> * Monitor ports EH gave up.  When EH gives up on a port, it freezes
>>   the port to protect the rest of the system from it.  The user used
>>   to have to issue manual scan to retry the port.  hp-poll can monitor
>>   such port and retry it when hotplug event is detected.  This is also
>>   used by PMP support.
>>
>> * Support hotplug on controllers which can report hotplug conditions
>>   but cannot raise interrupt.
> 
> Patchset seems sane.  I'll need to re-read patch #1 in depth, but I give 
> everything a tentative ACK for now.
> 
> My biggest concern is power usage.  On laptops for example, the 99% 
> common case is that the user will never hot[un]plug a drive, so we 
> shouldn't waste power bothering with poking disabled ports.

Link powersave patchset should handle that together but I'm still not 
sure what to do w/ user interface (which sysfs node to use).  Also, 
controllers which are used on laptops && use hp-poll by default are 
sata_nv (old ones) and some variant of sata_sil used in ati chipset. 
So, it shouldn't cause trouble for most laptop users.

-- 
tejun
