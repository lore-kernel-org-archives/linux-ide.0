From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 21:58:54 -0700
Message-ID: <20070928215854.da085fa3.akpm@linux-foundation.org>
References: <1190521193410-git-send-email-htejun@gmail.com>
	<46F9BF3E.5050708@garzik.org>
	<46FA1B4E.8090103@gmail.com>
	<46FD079F.3010007@garzik.org>
	<46FD0D50.8030602@gmail.com>
	<20070928155703.490d7575@the-village.bc.nu>
	<46FD1BAD.8020506@garzik.org>
	<20070928164312.208b8c56@the-village.bc.nu>
	<46FD2071.2070608@garzik.org>
	<46FD5D55.4070706@rtr.ca>
	<46FDC6A8.3000306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56323 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbXI2E7S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 00:59:18 -0400
In-Reply-To: <46FDC6A8.3000306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, 28 Sep 2007 23:29:44 -0400 Jeff Garzik <jeff@garzik.org> wrote:

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

There's an easy fix...

The releases are slow because a) there's so much stuff in them and b) it
takes so long to stabilise it all.

If all developers were to be more careful in their work, and take more time
to review and test others' work, both problems get fixed: less code, higher
quality.

We don't know how to make this happen.  We haven't even tried.
