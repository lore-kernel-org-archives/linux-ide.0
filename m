From: Paul Rolland <rol@as2917.net>
Subject: Re: 2.6.23-rc7 - _random_ IRQ23 : nobody cared
Date: Thu, 27 Sep 2007 08:05:51 +0200
Message-ID: <20070927080551.424e90b9@tux.DEF.witbe.net>
References: <20070924083336.7a08fd61@tux.DEF.witbe.net>
	<46F7C933.4080003@davidnewall.com>
	<20070925090057.5778aa2a@tux.DEF.witbe.net>
	<46FAFF7A.5070208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:52158 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbXI0GGE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 02:06:04 -0400
In-Reply-To: <46FAFF7A.5070208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: David Newall <david@davidnewall.com>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Hi Tejun,

On Thu, 27 Sep 2007 09:55:22 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Paul Rolland wrote:
> > Hi David,
> > 
> > On Mon, 24 Sep 2007 23:56:59 +0930
> > David Newall <david@davidnewall.com> wrote:
> > 
> >> Paul Rolland "(???????) wrote:
> >>> Hell, IRQ 23 is shared between libata and my modem !!!
> >>>   
> >> Tried using the modem?
> > 
> Can you change driver load order such that the driver for the modem is
> loaded first?

As I said, it's not possible, because :
 - the modem driver is an out-kernel one, so I have to wait the end of the
   boot process so that it can be loaded,
 - libata on IRQ23 is the one taking care of my disks, and I suspect it 
   quite hard to install a modem driver before having the disk driver
   installed.

I was thinking of delaying the disabling of the IRQ, which is basically the
other part of the problem (the first part being that spurious IRQ from the
modem). If it is possible to do that long enough for the modem driver to be
loaded, then the "IRQ xx : nobody cared" becomes an informational message
during the boot process, and then it vanishes, leaving a perfectly working
machine.
I suspect something in note_interrupt that would do (totally
untested, just thinking loudly) :

	/* Allow some delay to complete boot process before
	 * killing an IRQ. This allow some modules to be
	 * loaded before we decide the IRQ will not be handled.
	 */
	if (jiffies > 120*HZ) {
		/*
		 * Now kill the IRQ
		 */
		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
		desc->status |= IRQ_DISABLED;
		desc->depth = 1;
		desc->chip->disable(irq);
	}

I'll try that this week-end, but if someone has an opinion about it, I'll
be glad to know :)

Regards,
Paul

