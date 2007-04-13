From: ROBERT HANCOCK <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: HPA support
Date: Fri, 13 Apr 2007 15:06:57 -0600
Message-ID: <ce928434137b3.461f9c91@shaw.ca>
References: <20070411002313.29069ca5@the-village.bc.nu>
 <20070413153343.GA26304@athena.road.mcmartin.ca>
 <20070413154432.GC26304@athena.road.mcmartin.ca> <461FAEC2.6000705@pobox.com>
 <20070413163341.GA27674@athena.road.mcmartin.ca>
 <20070413164756.GB27674@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30192 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030295AbXDMVIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 17:08:25 -0400
Received: from pd2mr2so.prod.shaw.ca
 (pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JGG004CNFZNPM30@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Apr 2007 15:06:59 -0600 (MDT)
Received: from pd2ms4so.prod.shaw.ca ([10.0.122.125])
 by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JGG00E06FZMW1E0@pd2mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 13 Apr 2007 15:06:59 -0600 (MDT)
Received: from shaw.ca (pd2ms4so-con.prod.shaw.ca [10.0.122.111])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JGG003TUFZL2H00@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Apr 2007 15:06:58 -0600 (MDT)
In-reply-to: <20070413164756.GB27674@athena.road.mcmartin.ca>
Content-language: en
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

----- Original Message -----
From: Kyle McMartin <kyle@canonical.com>
Date: Friday, April 13, 2007 10:47 am
Subject: Re: [PATCH] libata: HPA support

> [Adding Robert to the CC incase he doesn't follow linux-ide]
> 
> On Fri, Apr 13, 2007 at 12:33:41PM -0400, Kyle McMartin wrote:
> > On Fri, Apr 13, 2007 at 12:24:34PM -0400, Jeff Garzik wrote:
> > > Kyle McMartin wrote:
> > > >Oddly, the command at least executes and doesn't MCE (but 
> it's not at all
> > > >happy either) if I use ATA_PROT_PIO. I wonder if 
> ATA_PROT_NODATA is 
> > > >buggered
> > > >on this sata_nv chip (Asus A8N-E).
> > > >
> > > >Weird...
> > > 
> > > 
> > > Try turning off ADMA using the module parameter, and see if 
> > > ATA_PROT_NODATA magically works.
> > > 
> > > ADMA is an advanced command execution mode, and it may not be 
> > > appropriate for certain non-data commands.
> > > 
> > 
> > Thanks so much, Jeff! This did it. Think we should drop ADMA by 
> default?> Do you know off-hand if there's any other drivers this 
> might bite us on?
> > 
> 
> Seems to have been commit 382a6652e91b34d5480cfc0ed840c196650493d4 
> thatcaused it (submitting NODATA commands using ADMA.)
> 
> Reverting that commit (or booting with sata_nv.adma=0) fixes HPA 
> for me
> here... Robert, is reverting that commit going to crush my little 
> world, or
> is it a safe course of action? I'd rather not disable ADMA (which 
> turns off
> NCQ, right?) wholesale, as the whizbang-gentoo crowd will hang me.

There is already a patch in libata-dev that will fix this, assuming those commands are marked as requiring a result taskfile in the command flags, which they should be:

http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=eb20a5742d230c67b9af4efd71b8b6b680ca3a09

ADMA should only be used for NODATA commands which don't require any result taskfile, such as cache flushes.
