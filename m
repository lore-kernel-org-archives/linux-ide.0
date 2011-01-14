From: Jeff Garzik <jeff@garzik.org>
Subject: Re: IRQ enable/disable BUG in IDE w/shared IRQs
Date: Fri, 14 Jan 2011 13:44:17 -0500
Message-ID: <4D309981.5030107@garzik.org>
References: <20110113.233259.157492570.davem@davemloft.net> <alpine.LFD.2.00.1101141031320.2678@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62848 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1ANSoW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2011 13:44:22 -0500
In-Reply-To: <alpine.LFD.2.00.1101141031320.2678@localhost6.localdomain6>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, marvin@mydatex.cz

On 01/14/2011 05:30 AM, Thomas Gleixner wrote:
> On Thu, 13 Jan 2011, David Miller wrote:
>> I have a hard time believing we've gotten away with this for so long.
>> Maybe it really is that rare to share the IDE interrupts with other
>> stuff?
>
> IIRC, the legacy IDE interrupts were 14/15 and those were never shared.

Yes, non-shared 14/15 were the 95% common case for the longest time. 
Sharing IDE interrupts within old-IDE worked FSVO "working", but the 
interrupt probes were written for a non-shared interrupt, then hacking 
into working for shared interrupts when PCI first starting showing up on 
the scene.

	Jeff


