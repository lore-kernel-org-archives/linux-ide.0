From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 18:46:13 +0000
Message-ID: <20080129184613.16846ae5@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<1201539043.31293.7.camel@zem>
	<1201540830.6526.19.camel@localhost>
	<200801281230.32910.gene.heskett@gmail.com>
	<alpine.LNX.1.00.0801281248190.13593@iabervon.org>
	<479E1D9E.3000900@bobjweil.com>
	<20080129121201.2f727f5f@core>
	<alpine.LNX.1.00.0801291202550.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59739 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbYA2Suk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 13:50:40 -0500
In-Reply-To: <alpine.LNX.1.00.0801291202550.13593@iabervon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Richard Heck <rgheck@bobjweil.com>, Gene Heskett <gene.heskett@gmail.com>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

> The SCSI error reporting really ought to include a simple interpretation 
> of the error for end users ("The drive doesn't support this command" "A 
> sector's data got lost" "The drive timed out" "The drive failed" "The 
> drive is entirely gone"). There's too much similarity between the message 
> you get when you try a SMART test that doesn't apply to the drive and what 
> you get when the drive is broken.

That would be the SCSI verbose messages option. I think the Eric
Youngdale consortium added it about Linux 1.2. Nowdays its always built
that way.

> And it's possible that the error recovery is suboptimal in some cases. It 
> seems to like resetting drives too much; perhaps if it keeps seeing the 
> same problem and resetting the drive, it should decide that the drive's 
> error reporting is just bad and just ignore that error like the old IDE 
> did (but, in this case, after saying what it's doing).

Nothing like casually praying the users data hasn't gone for a walk is
there. If we don't act on them the users don't report them until
something really bad occurs so that isn't an option.

Alan
