From: Kyle McMartin <kyle@canonical.com>
Subject: Re: [PATCH] libata: HPA support
Date: Fri, 13 Apr 2007 12:47:56 -0400
Message-ID: <20070413164756.GB27674@athena.road.mcmartin.ca>
References: <20070411002313.29069ca5@the-village.bc.nu> <20070413153343.GA26304@athena.road.mcmartin.ca> <20070413154432.GC26304@athena.road.mcmartin.ca> <461FAEC2.6000705@pobox.com> <20070413163341.GA27674@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:58176 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbXDMQtl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 12:49:41 -0400
Content-Disposition: inline
In-Reply-To: <20070413163341.GA27674@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

[Adding Robert to the CC incase he doesn't follow linux-ide]

On Fri, Apr 13, 2007 at 12:33:41PM -0400, Kyle McMartin wrote:
> On Fri, Apr 13, 2007 at 12:24:34PM -0400, Jeff Garzik wrote:
> > Kyle McMartin wrote:
> > >Oddly, the command at least executes and doesn't MCE (but it's not at all
> > >happy either) if I use ATA_PROT_PIO. I wonder if ATA_PROT_NODATA is 
> > >buggered
> > >on this sata_nv chip (Asus A8N-E).
> > >
> > >Weird...
> > 
> > 
> > Try turning off ADMA using the module parameter, and see if 
> > ATA_PROT_NODATA magically works.
> > 
> > ADMA is an advanced command execution mode, and it may not be 
> > appropriate for certain non-data commands.
> > 
> 
> Thanks so much, Jeff! This did it. Think we should drop ADMA by default?
> Do you know off-hand if there's any other drivers this might bite us on?
> 

Seems to have been commit 382a6652e91b34d5480cfc0ed840c196650493d4 that
caused it (submitting NODATA commands using ADMA.)

Reverting that commit (or booting with sata_nv.adma=0) fixes HPA for me
here... Robert, is reverting that commit going to crush my little world, or
is it a safe course of action? I'd rather not disable ADMA (which turns off
NCQ, right?) wholesale, as the whizbang-gentoo crowd will hang me.

Cheers,
	Kyle
