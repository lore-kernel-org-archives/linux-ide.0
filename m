From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Thu, 15 Feb 2007 19:09:25 +0100
Message-ID: <200702151909.26082.arnd@arndb.de>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp> <200702151141.49708.jens@de.ibm.com> <20070215171414.GU923@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51720 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030425AbXBOSKh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Feb 2007 13:10:37 -0500
In-Reply-To: <20070215171414.GU923@austin.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <jens@de.ibm.com>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>, alan@lxorguk.ukuu.org.uk, James K Lewis <jim@jklewis.com>

On Thursday 15 February 2007 18:14, Linas Vepstas wrote:
> > Linas has done a pretty good job on improving the driver in the last half
> > year or so and he also has access to all the necessary hardware so I think
> > he would be the right person for the job.
> 
> It seems I've been nominated twice. Since I'm expecting future activity
> to drop to zero, how hard can this be? :-)

I fear that the hardest part is yet to come, when we integrate the
driver for the the PS3 (currently called gelic_net) into spidernet.
The trouble is that the hardware is sufficiently similar to share
all the high-level mechanisms like the DMA data structures and
descriptor chains, but the low-level mechanisms are hidden in the
hypervisor on the PS3. Someone will have to invest a significant
amount of time coordinating this so we don't break celleb and qs20
in the process.

I also think that you'd do a good job doing this, but it may be
more that what you are willing to do without official funding of the
time you spend on it. Of course the actual amount of work will
depend a lot on the quality of the spidernet patches coming from
Sony to the spidernet maintainer.

	Arnd <><
