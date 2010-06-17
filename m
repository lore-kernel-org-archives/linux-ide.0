From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Thu, 17 Jun 2010 12:43:43 +0100
Message-ID: <20100617124343.5889067c@lxorguk.ukuu.org.uk>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
	<1276443098-20653-10-git-send-email-tj@kernel.org>
	<20100616204854.4b036f87@infradead.org>
	<4C19DA64.8000409@kernel.org>
	<alpine.LFD.2.00.1006171310560.4290@localhost.localdomain>
	<4C1A05AF.5010405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45900 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752553Ab0FQLmW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jun 2010 07:42:22 -0400
In-Reply-To: <4C1A05AF.5010405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On Thu, 17 Jun 2010 13:23:27 +0200
Tejun Heo <tj@kernel.org> wrote:

> On 06/17/2010 01:12 PM, Thomas Gleixner wrote:
> >> Hmmm.... oh, I see.  Wouldn't it be much better to use moving avg of
> >> IRQ durations instead of letting the driver specify it?  Drivers are
> >> most likely to just hard code it and It's never gonna be accurate.
> > 
> > Right, but that's probably more accurate than the core code heuristics
> > ever will be.
> 
> Eh, not really.  For ATA at least, there will be three different
> classes of devices.  SSDs, hard drives and optical devices

At least four: It may also be battery backed RAM.

Alan


