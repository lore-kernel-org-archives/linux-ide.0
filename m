From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Fri, 05 Oct 2007 02:05:52 -0400
Message-ID: <yq1bqbe85a7.fsf@sermon.lab.mkp.net>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:51690 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbXJEGFx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Oct 2007 02:05:53 -0400
In-Reply-To: <20071004160834.GA28667@cosmic.amd.com> (Jordan Crouse's message of "Thu\, 4 Oct 2007 10\:08\:34 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

>>>>> "Jordan" == Jordan Crouse <jordan.crouse@amd.com> writes:

Jordan> Agreed.  It sounds like there is still breakage in the BIOS -
Jordan> since the reference VSA code accounts for accesses of
Jordan> different alignments, but its probably not worth going back
Jordan> and forth about it.  Like I said, if Alan and Jeff are game,
Jordan> we should go with the 5536 driver, and now that we've debated
Jordan> it extensively, I'm fine with the MSR accesses - I'm satisfied
Jordan> that we at least considered the alternative and dismissed it
Jordan> for technically sound reasons.

I'm going to post two patches.  One using MSR accesses and one using
PCI.

Mixing the two access methods was the third option but I think that's
more of an academic exercise.  MSR will always work so why try poking
holes in PCI config space first?  The BIOS I have now exhibits one
problem.  The one from last week had another.  Instead of trying to
work around bug-du-jour I'd rather not depend on the BIOS getting
things right.  And it's less than a handful of register writes we're
talking about here.  Hardly worth it to come up with fallback
heuristics for something that trivial.

But both patches are working with the BIOS from yesterday.  Pick your
poison :)

-- 
Martin K. Petersen      http://mkp.net/
