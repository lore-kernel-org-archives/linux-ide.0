From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Sat, 17 May 2008 23:21:21 +0900
Message-ID: <482EE9E1.5000805@gmail.com>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:5956 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbYEQOV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 10:21:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so591413wfd.4
        for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 07:21:28 -0700 (PDT)
In-Reply-To: <482DCD1F.4090503@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>>
>>> So I guess the questions are:
>>>
>>> 1. Where are these unexpected interrupts coming from?
> ..
> 
> Well, I'm still not sure of the source of the interrupt,
> but I did just now find an ancient bug in sata_mv,
> in it's internal handling of the port interrupt mask.
> 
> The DONE_IRQ bit gets enabled a tad early in the EH sequence,
> enabling us to receive interrupts when we're not expecting them.
> 
> Looks like that mv_unexpected_intr() function was useful after all.  :)
> 
> Patches forthcoming to clean this up, once I study things a bit more.

I've been studying things for last two days and discovered a number of 
things.  I'll soon post patch series.  Thanks a lot for digging into PMP 
stuff.  It's great to have someone else's eyes on this stuff.

-- 
tejun
