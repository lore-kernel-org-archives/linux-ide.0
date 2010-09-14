From: David Miller <davem@davemloft.net>
Subject: Re: WARNINGs because of ide-proc handling
Date: Mon, 13 Sep 2010 21:17:56 -0700 (PDT)
Message-ID: <20100913.211756.191403182.davem@davemloft.net>
References: <20100903.053437.68134749.davem@davemloft.net>
	<20100903.073503.191401190.davem@davemloft.net>
	<20100903185934.GA27291@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37457
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834Ab0INERi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2010 00:17:38 -0400
In-Reply-To: <20100903185934.GA27291@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Fri, 3 Sep 2010 20:59:34 +0200

> Checking my debug-output again, I assume that the hard-disk has the entries,
> because it is the first user of ide-gd, so that driver still needs to be
> requested. Maybe this is enough delay for the directories to appear? Wild
> guess...

The issue has to do with the order of module initialization.

I've never seen this since on machines where IDE is actually used I
tend to build everything statically into the tree.

In such a configuration, the ide-cd, ide-gd, etc. drivers come at the
end of the link, based upon the ordering listed in the file
drivers/ide/Makefile.

Therefore, their probe functions are invoked last, long after core IDE
and the individual IDE host controller drivers register.

The individual IDE host controller probes will therefore happen first.

As we discussed, things work if ide_proc_port_register_devices()
executes before ide_proc_register_driver() is called.

And this is satisfied by the "all of IDE built-in" configuration
because the event sequence is:

1) IDE host controller driver registers, probes and finds ideX
2) ide_host_register(ideX, ...)
3) ide_proc_port_register_devices(ideX)

... some time passes ...

4) ide-gd driver registers
5) generic_ide_probe(hdX)
6) ide_gd_probe()
7) disk_ops->setup()
8) ide_disk_setup()
9) ide_proc_register_driver(hdX)

etc.

At ide_host_register() time, hwif_register_devices() created all of
the IDE devices on the ide_bus_type bus, but since ide-gd et al.  were
not registered yet, these device instances don't get matched and
probed at hwif_register_devices() time.

However, if the various IDE core driver bits are modules and are
loaded already, then the ide-cs driver subsequently loads, or an
ide-cs device hot plugs, then we get into the situation you've
discovered where we invoke the PROCFS init functions in the wrong
order.

Anyways, I just wanted to let you know that I figured out why it does
work in some circumstances, and I will now go back and do a final
audit of your patch before applying it.

Thanks.
