From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Date: Wed, 23 Jun 2004 16:20:39 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040623232039.GA27989@bougret.hpl.hp.com>
References: <20040623220557.GA26199@bougret.hpl.hp.com> <20040623225640.GE3072@pclin040.win.tue.nl>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:55436 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262328AbUFWXUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jun 2004 19:20:41 -0400
Content-Disposition: inline
In-Reply-To: <20040623225640.GE3072@pclin040.win.tue.nl>
List-Id: linux-ide@vger.kernel.org
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On Thu, Jun 24, 2004 at 12:56:40AM +0200, Andries Brouwer wrote:
> On Wed, Jun 23, 2004 at 03:05:57PM -0700, Jean Tourrilhes wrote:
> 
> > 	Playing with 2.6.7 on my laptop. I realised Lilo did not work
> > anymore. Look further, and the partition table was all screwed up.
> 
> Not so pessimistic.

	Sorry, I should have said "the partition table display".

> Old situation:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> New situation:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> 
> Nothing wrong with that partition table.

	Yep.

> Maybe you get unhappy because of the fdisk output, but that only
> shows that you have an old fdisk. Also there nothing wrong.

	Ok.

> Ah - so the only wrong thing must be the fact that lilo stopped working.
> I suppose things will improve if you give it the "linear" (or "lba32") flag.

	None of these helped. I guess I should update LILO as
well. I'll try to do that.

> What changed is that the kernel no longer attempts at guessing a geometry.
> If such guessing is required, user space must do so itself.
> 
> Andries

	Thanks very much for the quick answer, very helpful !

	Jean
