From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Sat, 29 Sep 2007 12:51:51 -0400
Message-ID: <87f94c370709290951vcd97161se7fceda3b00e939e@mail.gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>
	 <46FA1B4E.8090103@gmail.com> <46FD079F.3010007@garzik.org>
	 <46FD0D50.8030602@gmail.com>
	 <20070928155703.490d7575@the-village.bc.nu>
	 <46FD1BAD.8020506@garzik.org>
	 <20070928164312.208b8c56@the-village.bc.nu>
	 <46FD2071.2070608@garzik.org> <46FD5D55.4070706@rtr.ca>
	 <46FDC6A8.3000306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:1997 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbXI2Qvw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 12:51:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so498829and
        for <linux-ide@vger.kernel.org>; Sat, 29 Sep 2007 09:51:51 -0700 (PDT)
In-Reply-To: <46FDC6A8.3000306@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 9/28/07, Jeff Garzik <jeff@garzik.org> wrote:
> (my last response only addressed -mm)
>
> Mark Lord wrote:
> > I believe the point was that getting things into libata is glacial
>
> IMHO would say that there are two causes of that:
> 1) I am sometimes slow in merging, part of which is my own fault, and I
> can only promise to try and do better there.  Part of which is a result
> of stuff being dependent on -mm (which requires plenty of time
> hand-merging) rather than libata-dev.git#upstream.
>
> 2) I have been intentionally staging major libata behavior changes
> between Linux releases.  Luckily most of these are behind us, but, in
> several cases with things like ACPI on/off (hopefully 'on' in 2.6.24),
> probing changes (switchover to new EH for probing via hotplug, etc.),
> interrupt handling changes.
>
> I dislike getting "too much" into a single release, because of the
> difficulty of getting large scale feedback without a major kernel release.
>
> So far I think the kernel releases have been pretty darn successful in
> "not breaking everybody" but that clearly conflicts with desired
> development speed, given the glacial pace of each kernel release.  If
> each kernel release were 1-2 months apart, we would have many more
> testing points, and I think you guys and I would both be happy.  But
> that's not the reality today, with 3+ month kernel release cycles (ugh!!).
>
> I'm very much interested in hearing suggestions and comments.
>
>         Jeff

Perhaps you could more fully leverage the various distro
alpha/beta/rcs/release kernels.

Specific to the PMP patches, they went into the openSUSE beta/rc
kernels (2.6.23 based) in early Aug. I think.  So they have already
been through a significant set of Novell internal and community
testing.  Likely similar testing to what it would get in -mm.

I believe they are part of the OpenSUSE 10.3 (2.6.23 based) full
release that is set for Thursday (Oct. 4) and thus will see a huge
amount of public testing.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
