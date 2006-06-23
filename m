From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Fri, 23 Jun 2006 20:42:14 +0900
Message-ID: <449BD396.8010209@gmail.com>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com> <200606220916.18020.boac@wanadoo.nl> <449A47EA.90601@gmail.com> <449A8A2A.2070102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.198]:53654 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750725AbWFWLmF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jun 2006 07:42:05 -0400
Received: by wx-out-0102.google.com with SMTP id t5so18384wxc
        for <linux-ide@vger.kernel.org>; Fri, 23 Jun 2006 04:42:05 -0700 (PDT)
In-Reply-To: <449A8A2A.2070102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: boac@wanadoo.nl, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

[CC'ing Jeff. Hi!]

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> About the disabling on hardreset failure...  Maybe there is some room 
>> for improvement - e.g. leave PHY status interrupts alive if it's not 
>> causing interrupt storm, but I'm not sure whether the benefits would 
>> outweigh the cost.
>>
>> Leaving the port frozen (disabled & interrupts plugged) is a safety 
>> measure libata implements.  The driver isn't sure in what state the 
>> controller and the attached device are in as they are not responding 
>> even to the 'hard' reset, so it assumes the worst and shuns the port.
>>
>> As I wrote above, you can ask libata to retry by explicitly telling 
>> libata to rescan the bus.  I thought that should be enough when I was 
> 
> MMm.. sounds like libata should do that periodic polling,
> rather than relying on the end-user to do it.  Right?  :)
> 
> So the best of both approaches from above:  mask the interrupts
> and leave them off, but periodically poll for phy status changes.

Hmm... Polling.  Yeap, that's certainly a possibility.  It's definitely 
better than selectively enabling PHY status change IRQ.  Also, we can 
use the same facility to implement hotplug for ports which have SStatus 
but no PHY status changed IRQ.  PMP requires command issuance for 
SStatus polling but PMP gets detached when a port gets frozen & 
disabled, so it doesn't matter anyway.  I'll put this on my to-do list. 
  Thanks for the suggestion.

-- 
tejun
