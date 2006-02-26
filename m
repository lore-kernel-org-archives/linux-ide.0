From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code issues / 2.6.15.4
Date: Sun, 26 Feb 2006 17:13:07 +0000
Message-ID: <20060226171307.GA9682@gallifrey>
References: <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca> <4401BB85.7070407@superbug.co.uk> <4401DF6B.9010409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:20438 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751019AbWBZRNU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Feb 2006 12:13:20 -0500
Content-Disposition: inline
In-Reply-To: <4401DF6B.9010409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: James Courtier-Dutton <James@superbug.co.uk>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com

* Mark Lord (liml@rtr.ca) wrote:
> >>James Courtier-Dutton wrote:
> >>>
> >>>I have what looks like similar problems. The issue I have is that I 
> >>
> >>Nope.  Different issues.
> >I have changed the Subject line to indicate this so any future responses 
> >can be indicated.
> >
> >>
> >>>) #1 Sat Dec 3 18:47:19 GMT 2005
> >>>Dec 16 22:51:57 games kernel: hdc: dma_intr: status=0x51 { DriveReady 
> >>>SeekComplete Error }
> >>>Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x40 { 
> >>>UncorrectableError }, LBAsect=53058185, sector=53057951
> >>
> >>The disk really does have bad sectors in this case (above).
> >The disk has NO bad sectors. It has been checked using two different tests.
> 
> The *only* test that matters is to enable S.M.A.R.T.,
> and read out the error logs from it.

I have seen a set of drives that has reported UncorrectableErrors
and :
    * Shows the Uncorrectable error in the SMART log
    * Passes a full SMART test
    * Shows no remapped sectors
    * Passes the vendors drive test
    * Now fully passes a dd if=/dev/hdx of=/dev/null with no errors.

They were a set of 250GB SATA drives by the same vendor; I've taken
 them out one at a time as each did the same thing and replaced them
with another vendors drive.  They were all in use in RAID-1 MD 
configuration (under heavy load).

I do wonder about the 'uncorrectable error rate' that vendors report;
it doesn't seem very large - but I'll admit to not understanding its
units.  Are soft non-repeatable uncorrectable errors expected in
principal? (Pointers to a good explanation of what this actually
means would be appreciated).

I do wonder how often this happens to people and if the read succeeds
again they just blame it on software.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
