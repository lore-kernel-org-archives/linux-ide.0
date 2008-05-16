From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Fri, 16 May 2008 14:06:23 -0400
Message-ID: <482DCD1F.4090503@rtr.ca>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4037 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758497AbYEPSGZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 May 2008 14:06:25 -0400
In-Reply-To: <482DC41F.9080901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>
>> So I guess the questions are:
>>
>> 1. Where are these unexpected interrupts coming from?
..

Well, I'm still not sure of the source of the interrupt,
but I did just now find an ancient bug in sata_mv,
in it's internal handling of the port interrupt mask.

The DONE_IRQ bit gets enabled a tad early in the EH sequence,
enabling us to receive interrupts when we're not expecting them.

Looks like that mv_unexpected_intr() function was useful after all.  :)

Patches forthcoming to clean this up, once I study things a bit more.

Cheers
