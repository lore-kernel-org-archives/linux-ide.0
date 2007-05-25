From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Fri, 25 May 2007 15:20:28 +0100
Message-ID: <20070525152028.05b79c83@the-village.bc.nu>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	<1179209697.32247.153.camel@localhost.localdomain>
	<20070523144217.5abd9fdf@the-village.bc.nu>
	<1179960518.32247.948.camel@localhost.localdomain>
	<20070524003123.77b9c81c@the-village.bc.nu>
	<1179963820.32247.996.camel@localhost.localdomain>
	<20070524001302.GA18571@devserv.devel.redhat.com>
	<1179978137.32247.1035.camel@localhost.localdomain>
	<20070524105407.64514929@the-village.bc.nu>
	<46556E5D.3070203@pobox.com>
	<20070524120915.40b594a8@the-village.bc.nu>
	<46562E03.3020503@garzik.org>
	<20070525014027.3feabe50@the-village.bc.nu>
	<4656330E.2000604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45843 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbXEYOPd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 10:15:33 -0400
In-Reply-To: <4656330E.2000604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 24 May 2007 20:51:26 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> >> #define DELAY400NS  { pio_inbyte( CB_ASTAT ); pio_inbyte( CB_ASTAT );  \
> >>                        pio_inbyte( CB_ASTAT ); pio_inbyte( CB_ASTAT ); }
> >>
> >>
> > 
> > Totally unrelated. Hal is using the cycle time of the four I/O reads to
> > do the 400nS delay. Its a neat way to do the delay on boxes without
> > modern CPUs and nice timing features and perhaps one we should use on
> > those boxes but its not relevant to the question of how you post an MMIO
> > command write.
> 
> It illustrates (as well as our experience to date) that AltStatus use 
> for the delay is just fine.

Correct, but it is also extremely slow. No point discussing fast paths
for odd if() tests through the code when you burn 100nS unneccessarily
every time you issue a command via PIO is there.

Alan
