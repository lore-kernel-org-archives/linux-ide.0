From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Date: Thu, 28 Apr 2005 22:41:00 +0200
Message-ID: <58cb370e05042813414af5bc1e@mail.gmail.com>
References: <1114703284.18809.208.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:43144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262127AbVD1UlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 16:41:05 -0400
Received: by wproxy.gmail.com with SMTP id 68so868636wra
        for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 13:41:00 -0700 (PDT)
In-Reply-To: <1114703284.18809.208.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ages ago we added an ide_default driver to clean up all the corner cases

s/clean up/hide/

> like spurious IRQs for a device with no matching driver (eg ide-cd and
> no CD driver) as well as ioctls and file access.
>  
> 2.6.12rc removes it. Unfortunately it also means that if your only IDE
> interface is one you hand configure you can no longer run Linux. It also
> changes other aspects of behaviour although they don't look problematic
> for most users. You can no longer
>         - Control the bus state of an interface
>         - Reset an interface
>         - Add an interface if none exist
>         - Issue raw commands
>         - Get an objects bios geometry
>         - Read the identify data by ioctl (its still in proc but may be stale)

Details please.

> without having a device specific driver loaded matching the media - and
> that only works if its already detected the device correctly.
> 
> I don't have the tools at the moment to generate spurious IRQ's for
> devices with no driver loaded but it does look like the code may well
> then crash. From the way the changes were done it appears the current
> IDE maintainers never appreciated that ide_default existed for far more
> than just cleaning up ide-proc but also to handle IRQ's, opening of
> empty slots, ioctls and power
> management ?

Maybe you should mail current maintainer before spreading FUD?

No functionality was removed AFAIK, see the patches.  I spend quite 
a bit of time making sure that nothing breaks up (I missed one special
case but somebody already posted patch to LKML fixing it).

These patches were posted at least two times to both linux-ide and
linux-kernel, they were in -mm for ages - were you hiding under the
rock?

> The ability to specify the IDE ports on the command line as needed for
> some Sony laptop installs have also become "obsolete" over time. They
> still appear to work but spew a warning that the user will soon be
> screwed.

This was discussed few times already.

Alan, seriously, what is your problem?

Bartlomiej
