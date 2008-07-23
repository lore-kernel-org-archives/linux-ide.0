From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: non functional pata dvd drive under 2.6.25.6
Date: Wed, 23 Jul 2008 22:01:07 +0100
Message-ID: <20080723220107.3d26e30a@lxorguk.ukuu.org.uk>
References: <vi85j5-uig.ln1@scorpion77.cjb.net>
	<4880237A.7070002@kernel.org>
	<200807232219.47760.jeroen@scorpion77.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41133 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753946AbYGWVSc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 17:18:32 -0400
In-Reply-To: <200807232219.47760.jeroen@scorpion77.cjb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Beerstra <jeroen@scorpion77.cjb.net>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, 23 Jul 2008 22:19:47 +0200
Jeroen Beerstra <jeroen@scorpion77.cjb.net> wrote:

> Hello Tejun,
> 
> Op Friday 18 July 2008 07:00:42 schreef u:
> > Hello, Jeroen.
> >
> > [cc'ing linux-ide]
> >
> > Hmmm... the problem could be caused by hald polling for media presence.
> >  Does "hal-disable-polling /dev/srX" make any difference?
> > hal-disable-polling setting is persistent so if your drive goes bonkers
> > quickly after boot, you can disable polling, reboot and see whether
> > anything is different.  Also, please post the result of "lspci -nn" and
> > "hdparm -I /dev/srX" && please try 2.6.26.
> >
> > Thanks.
> 
> I'm pretty sure about that since the hald process I'm refering to points to 
> the 'faulty' drive. However simply booting with noapic seems to fix all of my 
> problems.

There are lots of similar reports. I don't know what broke the APIC code
but it doesn't appear any of these are libata bugs.

Alan
