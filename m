From: Mark Lord <liml@rtr.ca>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Thu, 22 Jun 2006 08:16:42 -0400
Message-ID: <449A8A2A.2070102@rtr.ca>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com> <200606220916.18020.boac@wanadoo.nl> <449A47EA.90601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:27868 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030628AbWFVMQp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2006 08:16:45 -0400
In-Reply-To: <449A47EA.90601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: boac@wanadoo.nl, linux-ide@vger.kernel.org

Tejun Heo wrote:
>
> About the disabling on hardreset failure...  Maybe there is some room 
> for improvement - e.g. leave PHY status interrupts alive if it's not 
> causing interrupt storm, but I'm not sure whether the benefits would 
> outweigh the cost.
> 
> Leaving the port frozen (disabled & interrupts plugged) is a safety 
> measure libata implements.  The driver isn't sure in what state the 
> controller and the attached device are in as they are not responding 
> even to the 'hard' reset, so it assumes the worst and shuns the port.
> 
> As I wrote above, you can ask libata to retry by explicitly telling 
> libata to rescan the bus.  I thought that should be enough when I was 

MMm.. sounds like libata should do that periodic polling,
rather than relying on the end-user to do it.  Right?  :)

So the best of both approaches from above:  mask the interrupts
and leave them off, but periodically poll for phy status changes.

??
