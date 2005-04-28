From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Date: Fri, 29 Apr 2005 00:43:27 +0100
Message-ID: <1114731804.24687.259.camel@localhost.localdomain>
References: <1114703284.18809.208.camel@localhost.localdomain>
	 <58cb370e05042813414af5bc1e@mail.gmail.com>
	 <1114727522.18355.242.camel@localhost.localdomain>
	 <58cb370e05042816003c2ca4be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:61650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262235AbVD1Xon
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 19:44:43 -0400
In-Reply-To: <58cb370e05042816003c2ca4be@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Gwe, 2005-04-29 at 00:00, Bartlomiej Zolnierkiewicz wrote:
> > why. You've disabled open() of a device with no bound driver.
> 
> Guess what open() for ide-default was doing in 2.6?
> 
> return -ENXIO;
> 
> and no it wasn't my change - it was the effect of fixing
> locking of the higher layers.

Yes so it needed fixing and without all the kref, kmalloc, unique object
structure per ide driver code spew too.

> > The fact that the IDE layer appears to be getting worse not better,
> > which given the starting point is a remarkable achievement.
> 
> Personal insults are easy, get technical facts.

I consider that a technical fact. The last IDE code I maintained fully
in 2.4 had mostly working locking, drive hotplug, open for unbound
drivers, didnt oops on spurious irqs and wasn't losing all sorts of
useful boot options. I had hoped that I wouldnt have to totally fork the
2.6 IDE code in order to get back to where 2.4-ac was and get the
locking working so you can't oops it via /proc

Alan


