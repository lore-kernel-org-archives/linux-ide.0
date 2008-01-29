From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Make_bad_sector
Date: Tue, 29 Jan 2008 10:39:21 -0500
Message-ID: <87f94c370801290739t39640bf5w960576ae4b273156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.250]:30748 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757762AbYA2PjY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 10:39:24 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1985842hsz.5
        for <linux-ide@vger.kernel.org>; Tue, 29 Jan 2008 07:39:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>, Philipp Thomas <pth@suse.de>
Cc: Gene Heskett <gene.heskett@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Jan 28, 2008 3:43 PM, Mark Lord <lkml@rtr.ca> wrote:
> Gene Heskett wrote:
> > On Monday 28 January 2008, Mark Lord wrote:
> >..
> >> Another way is to use the "make_bad_sector" utility that
> >> is included in the source tarball for hdparm-7.7, as follows:
> >>
> >>   make_bad_sector --readback /dev/sda 474507
> >>
> > Apparently not in the rpm, darnit.
> ..
>
> That's okay.  It should still be in the SRPM source file.
> And it's a tiny download from sourceforge.net:
>
> http://sourceforge.net/search/?type_of_search=soft&type_of_search=soft&words=hdparm
>
Mark,

I asked on the SUSE list and was informed by Philipp Thomas of Novell
(cc'ed) that the only mention of make_bad_sector in the hdparm-7.7
source is in a todo list.

Sounds like a useful tool, so I was hoping to encourage suse to
include it with future releases.

Thanks
Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
