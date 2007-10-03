From: "Martin K. Petersen" <mkp@mkp.net>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 03 Oct 2007 18:32:01 -0400
Message-ID: <yq1tzp7de3i.fsf@sermon.lab.mkp.net>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
	<20071003203118.GA2916@cosmic.amd.com>
	<20071003215937.123c95ee@the-village.bc.nu>
	<20071003211856.GB2916@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:37631 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbXJCWcD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 18:32:03 -0400
In-Reply-To: <20071003211856.GB2916@cosmic.amd.com> (Jordan Crouse's message of "Wed\, 3 Oct 2007 15\:18\:56 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>>>>> "Jordan" == Jordan Crouse <jordan.crouse@amd.com> writes:

Jordan> That should work on any AMD VSA derivatives.  There are some
Jordan> who may have rolled their own, and they don't support the same
Jordan> virtual registers.  in that case, you can check if SMIs are
Jordan> enabled - that would be a reasonable indication that there is
Jordan> something VSAish out there.

I'll try this later and see what comes up.  But I'm not sure I see the
advantage of having two ways to configure the 5536.

I was simply interested in getting things configured correctly.  I
agree that ideally all platforms would simply Do The Right Thing.
However, I took the pragmatic/safe approach and used the MSRs to
configure the beast.  The only reason I even tried is that this is a
setup issue exclusively.  Had the actual I/O interface been hiding in
a similar fashion I wouldn't have bothered.

Early on I also had some funny results with PIO so another reason I
wrote pata_cs5536 was to use the values specified in the databook.  It
seemed cleaner to have a tiny separate driver than to wedge another
set of timings into pata_amd.c.

I agree that it would be silly to have two drivers if there was actual
functionality lurking in them.  But as it stands most of the pata_*
drivers are simply configuration templates and nothing more.

Anyway.  That's my personal take on it.  If there's a general
consensus that the timings should be in pata_amd.c then so be it.


Jordan> But you bring up another point - I'm not sure that Martin
Jordan> _doesn't_ have VSA.  He is initializing this as a PCI driver,
Jordan> so he has something out there listening to CF8/CFC, or he's
Jordan> emulating the OLPC spoof mechanism [1]. 

The board I'm using has a BIOS which exposes the IDE registers in PCI
space but doesn't appear to listen when they are written to.  I'm
hoping that will get fixed eventually.


PS. So what's the story wrt. a PRD length of 0?

-- 
Martin K. Petersen      http://mkp.net/
