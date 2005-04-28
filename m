From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Date: Thu, 28 Apr 2005 23:32:03 +0100
Message-ID: <1114727522.18355.242.camel@localhost.localdomain>
References: <1114703284.18809.208.camel@localhost.localdomain>
	 <58cb370e05042813414af5bc1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:29137 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262298AbVD1WdW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 18:33:22 -0400
In-Reply-To: <58cb370e05042813414af5bc1e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Iau, 2005-04-28 at 21:41, Bartlomiej Zolnierkiewicz wrote:
> On 4/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Ages ago we added an ide_default driver to clean up all the corner cases
> 
> s/clean up/hide/

Matter of opinion.

> > for most users. You can no longer
> >         - Control the bus state of an interface
> >         - Reset an interface
> >         - Add an interface if none exist
> >         - Issue raw commands
> >         - Get an objects bios geometry
> >         - Read the identify data by ioctl (its still in proc but may be stale)
> 
> Details please.

If you need details you shouldn't be maintaining that code. Its obvious
why. You've disabled open() of a device with no bound driver.

> No functionality was removed AFAIK, see the patches.  I spend quite 
> a bit of time making sure that nothing breaks up (I missed one special
> case but somebody already posted patch to LKML fixing it).

Build a kernel without ide-cd. Now try and issue ioctls on it. Doesn't
work any more does it.

> 
> These patches were posted at least two times to both linux-ide and
> linux-kernel, they were in -mm for ages - were you hiding under the
> rock?

No, just doing an MBA thesis, a job, learning a second language and
trying to beat sense into our politicians. Now I come back to look at
the ide layer ready for a 2.6.12 merge and its all a bit messy. The open
code was clean and is now duplicated. Copies of subtly different per
driver gendisk/disk layer open routines have appeared that should be
shared. The default driver handling has been removed and half the
options for obscure systems have been marked obsolete in some Gnome like
purge of functionality that might scare small children.

> > The ability to specify the IDE ports on the command line as needed for
> > some Sony laptop installs have also become "obsolete" over time. They
> > still appear to work but spew a warning that the user will soon be
> > screwed.
> 
> This was discussed few times already.

And the discussion lead to no fixes

> Alan, seriously, what is your problem?

The fact that the IDE layer appears to be getting worse not better,
which given the starting point is a remarkable achievement. 

Alan

