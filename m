From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Thu, 17 Jun 2010 13:23:27 +0200
Message-ID: <4C1A05AF.5010405@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-10-git-send-email-tj@kernel.org> <20100616204854.4b036f87@infradead.org> <4C19DA64.8000409@kernel.org> <alpine.LFD.2.00.1006171310560.4290@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35732 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701Ab0FQLYg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jun 2010 07:24:36 -0400
In-Reply-To: <alpine.LFD.2.00.1006171310560.4290@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 06/17/2010 01:12 PM, Thomas Gleixner wrote:
>> Hmmm.... oh, I see.  Wouldn't it be much better to use moving avg of
>> IRQ durations instead of letting the driver specify it?  Drivers are
>> most likely to just hard code it and It's never gonna be accurate.
> 
> Right, but that's probably more accurate than the core code heuristics
> ever will be.

Eh, not really.  For ATA at least, there will be three different
classes of devices.  SSDs, hard drives and optical devices and if we
get running avg w/ fairly large stability part, the numbers wouldn't
be too far off and there's no reliable way for the driver to tell
which type of device is on the other side of the cable.  So, I think
running avg would work much better.

Thanks.

-- 
tejun
