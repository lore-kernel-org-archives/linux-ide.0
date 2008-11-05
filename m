From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [git patches] libata hibernation fixes
Date: Tue, 04 Nov 2008 20:24:10 -0600
Message-ID: <491103CA.7090905@shaw.ca>
References: <fa.Ast7pgG6P20u1PcyOsfgzoaX5YA@ifi.uio.no> <fa.1+JQHm7yjIiZJxAzR0eBPn39a9M@ifi.uio.no> <fa.8GbzH83c2CAI53n9dyzVOFugmoc@ifi.uio.no> <fa.hGdpNHQGmXAR19JiGuHxSr9N9CA@ifi.uio.no> <4910E6CD.9090605@mail.usask.ca> <49110093.5090506@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:3369 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbYKECYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2008 21:24:14 -0500
In-Reply-To: <49110093.5090506@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> Robert Hancock wrote:
>>
>> IDLE IMMEDIATE just transitions the device to the Idle state, which is 
>> normally parked/unloaded and spun down.
> ..
> 
> No, you're confusing "IDLE" with "STANDBY".  IDLE just puts the drive
> electronics into a lower-power state than "ACTIVE", but normally leaves
> the platters spinning.
> 
> The "UNLOAD" enhancement causes it to also "unload" or "park" (drive's 
> option)
> the heads as part of this action.
> 
> "STANDBY" is the command set which parks heads and spins down the platters.

Right, STANDBY IMMEDIATE was the one I was thinking of.
