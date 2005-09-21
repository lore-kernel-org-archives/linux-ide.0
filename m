From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Wed, 21 Sep 2005 17:57:08 +0100
Message-ID: <1127321829.18840.18.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:10150 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751130AbVIUQbD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2005 12:31:03 -0400
In-Reply-To: <1127319328.8542.57.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Mer, 2005-09-21 at 17:15 +0100, Richard Purdie wrote:
> As ide_cs only creates the block devices when a card is present, I think
> it shouldn't be set as removable. As a point of reference, the MMC
> system does not set the removable flag for exactly this reason (There is
> an email from Russell King explaining this -
> http://lkml.org/lkml/2005/1/8/165).

I can't comment on the MMC layer or its core requirements as I don't
know them well. IDE PCMCIA does however encompass removal devices. The
removable flag is set so that we get removable media behaviour - that is
the media can change under us and we must not cache partition data. The
current behavioiur in that sense is correct.

> 
> It is worth noting the MMC subsystem works with my evil udev script. If
> I apply the patch below (which removes the removable flag for flash
> devices), I don't see this loop.

But does MMC have a media change detect, and if not does the right thing
occur if you swap cards with partition tables ?

> 1. Can anyone provide details on what the bits in id->config really
> mean?  

ATA standards are all available for download.

> 2. Which other drivers exploit the "if (id->config & (1<<7))
> drive->removable = 1;" code? Is it just ide_cs?

It might be currently because the old IDE layer has no hotplug support
(not even for PCMCIA - it happens to work some days) but that wasn't
true in 2.4-ac or some 2.6-ac.

It sounds like something needs to be smarter about whether the media has
changed - could be kernel but it seems like a user space problem. I note
that the standard Gnome tools "just work" in this case so perhaps you
can see how they do it.

Alan

