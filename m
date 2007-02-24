From: Kyle McMartin <kyle@canonical.com>
Subject: Re: [RFT] libata hpa support
Date: Sat, 24 Feb 2007 13:00:47 -0500
Message-ID: <20070224180047.GA6204@athena.road.mcmartin.ca>
References: <20070223170625.GA29931@athena.road.mcmartin.ca> <20070223181959.56502bf2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:36241 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933525AbXBXSAv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 13:00:51 -0500
Content-Disposition: inline
In-Reply-To: <20070223181959.56502bf2@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

On Fri, Feb 23, 2007 at 06:19:59PM +0000, Alan wrote:
> > A few questions are raised, libata SATA hasn't been resizing disks in the
> > past, should we only disable HPA on PATA only, a la drivers/ide? In any
> 
> drivers/ide disable HPA on SATA ports it manages too.
> 

Right, so we can leave the policy to be just disabling it by 40p/80p cable
type for now... Sigh.

> > event, supporting HPA lets people who had partitions which extend beyond
> > the protected area boot with libata PATA. Some policy decision needs to be
> > made too... Right now, I'm just disabling it unilaterally.
> 
> Last time we had a Red Hat bitching session about it the main thing the
> installer guys wanted was a way to find out what size the disk thought it
> was before we twiddled with it, so that they can make an intelligent
> attempt to handle partitioning in the case where for example a disk is
> unpartitioned. A partitioned disk isn't so much of a problem as the
> partitioning itself tells you the a lot about the state of disk and
> intended HPA.
> 

I suspect Fedora is getting fairly late in the F7 development cycle and this
kind of intrusive change to the installer, etc., would be frowned upon?

One thought I had was to read the native max size, stow it away somewhere,
and not resize the drive. [Disclaimer, I know almost nothing about the block
layer at this point...] Then, when a bio gets rejected by the drive because
the LBA is out of range, check if it's between the native capacity, and the
current capacity, if it is, disable HPA and re-submit.

That approach, while hackish, might be sufficient to keep people who've been
using drivers/ide from being unable to boot if they're got partitions
overlapping the HPA.

Cheers,
	Kyle M.
