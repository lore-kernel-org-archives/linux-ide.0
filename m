From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata FUA revisited
Date: Fri, 16 Feb 2007 13:14:56 -0500
Message-ID: <45D5F4A0.4050000@garzik.org>
References: <45CFDE27.5030607@shaw.ca> <45D025CB.6070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39837 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946180AbXBPSPA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Feb 2007 13:15:00 -0500
In-Reply-To: <45D025CB.6070205@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, edmudama@gmail.com, Nicolas.Mailhot@LaPoste.net

Tejun Heo wrote:
> Hello,
> 
> Robert Hancock wrote:
> [--correct summary snipped--]
>> Given the above, what I'm proposing to do is:
>>
>> -Remove the blacklisting of Maxtor BANC1G10 firmware for FUA. If we 
>> need to FUA-blacklist any drives this should likely be added to the 
>> existing "horkage" mechanism we now have. However, at this point I 
>> don't think that's needed, considering that I've seen no conclusive 
>> evidence that any drive has ever been established to have broken FUA.
> 
> Agreed.
> 
>> -Add a new port flag ATA_FLAG_NO_FUA to indicate that a controller 
>> can't handle FUA commands, and add that flag to sata_sil. Force FUA 
>> off on any drive connected to a controller with this bit set.
>>
>> There was some talk that sata_mv might have this problem, but I 
>> believe the conclusion was that it didn't. The only controllers that 
>> would are ones that actually try to interpret the ATA command codes 
>> and don't know about WRITE DMA FUA.
> 
> I think it would be better to add ATA_FLAG_FUA instead of ATA_FLAG_NO_FUA.

This is an interesting (if small) problem.  I would propose a third 
option:  add ATA_FLAG_NO_FUA to applicable /SATA/ drivers, but leave 
those without ATA_FLAG_SATA alone.

	Jeff


