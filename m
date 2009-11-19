From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 16:45:29 +0100
Message-ID: <200911191645.29885.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911191550.25476.bzolnier@gmail.com> <20091119152245.479dc38d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44169 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbZKSPql (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 10:46:41 -0500
In-Reply-To: <20091119152245.479dc38d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 19 November 2009 16:22:45 Alan Cox wrote:
> > If you know about other drivers still using ->pre_reset for cable detection
> > please let us know because they need fixing ASAP.
> > 
> > ->cable_detect method is there for a reason,
> 
> Given that I added it I may know more about it than you do. In fact from
> the rubbish you spout below it seems I do.

lol, I always heard that debugging other people's code is harder than
writing it in the first place..

> > already have a buggy cable detection (since ->pre_reset ignores the mandatory
> 
> Wrong.

You cannot know it unless you know how chip operates internally.  That's it.

You are taking chances that the controller does what most of similar hardware
do.  Unfortunately we have seen so many counterexamples of this in the past
(i.e. I wouldn't be so surprised if some hosts just snoop IDENTIFY data to get
their cable info) that I prefer to stick to safe approaches.

Especially since it cost us nothing and provides additional benefit of having
coherent API.

> > by spec part of cable detection which is probing slave before master) and
> 
> Have a free hint. If the host detects the cable type then we don't ask
> the drive. See the standard if you don't understand why. Even if we
> didn't the code would still be correct because we properly evaluate
> the speed configuration from all the data sources.

Please spare your 'free hints' and preaching tone.   You've completely failed
over four years span to out do the messy code even with like ~1.5 year handicap
to finalize the hostile takeover.

I'm completely fed up with the process and I'm simply fixing up your mess now,
50+ patches and counting.  Turns out to be order of magnitude more productive
than even trying to discuss things with you and/or your influential friends.

-- 
Bartlomiej Zolnierkiewicz
