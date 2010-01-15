From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Sat, 16 Jan 2010 06:45:50 +0900
Message-ID: <4B50E20E.2030003@kernel.org>
References: <4B4ECCCD.1040902@kernel.org> <4B4ECD81.8020205@kernel.org> <4B4F113B.30400@ru.mvista.com> <4B4FE377.5090302@kernel.org> <4B504221.6060107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35809 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab0AOVkV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jan 2010 16:40:21 -0500
In-Reply-To: <4B504221.6060107@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

On 01/15/2010 07:23 PM, Sergei Shtylyov wrote:
>> Because different controllers have different mechanisms for detecting
>> pending IRQ?
> 
>   All SFF-8038i (BMIDE) controllers have the same mechanism. They may
> have some additional interrupt bits though, reflecting the interrupt
> status in both PIO and DMA mode though.

Oh, yeah, I was thinking about modern piixs where the bit works as a
true IRQ pending bit regardless of command state (it works while even
idle).  I don't think the original BMIDE IRQ pending bit would be too
useful for spurious IRQ detection.  It's interlocked with DMA transfer
protocol and unless the controller is horribly broken it won't be too
useful for spurious IRQ detection.

Thanks.

-- 
tejun
