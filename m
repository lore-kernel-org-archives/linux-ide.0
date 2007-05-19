From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [Pkg-sysvinit-devel] [PATCH] libata: remove	libata.spindown_compat
Date: Sat, 19 May 2007 10:48:36 -0300
Message-ID: <20070519134836.GA3750@khazad-dum.debian.net>
References: <464C6A0E.7020601@gmail.com> <1179572779.23670.13.camel@localhost.localdomain> <464EDBFB.3050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48617 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757852AbXESNso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 09:48:44 -0400
Content-Disposition: inline
In-Reply-To: <464EDBFB.3050307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Daniel Drake <dsd@gentoo.org>, Francesco Pretto <ceztko@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, pkg-sysvinit-devel@lists.alioth.debian.org

On Sat, 19 May 2007, Tejun Heo wrote:
> > To fix this issue, halt(8) started issueing WIN_STANDBYNOW1 (0xE0) and
> > WIN_STANDBYNOW2 (0x94) ioctls before halt and poweroff, as that was more
> > reliable than "flush cache" and the effect was the same.
> 
> One culprit there is that, according to the spec, STANDBYNOW doesn't
> necessarily imply cache flush and AFAIK issuing STANDBYNOW to libata
> devices is to avoid emergency unload.  Can you comment on this Henrique?

Well, the reason I raised the ruckus in the first place was just the
emergency unload, yes.  I didn't know about any missing cache flushes (and
AFAIK we never had any reported to us).  We will have to fix that in halt(8)
IMHO, just in case.  And probably hdparm/sdparm should also know to not
standby or sleep disks without a cache flush, either.

I also don't know the history of halt(8), Miquel does... so I have not much
else to comment.

At least now it is clear what we need halt(8) to do (in Debian, anyway):

1. check if we have a responsible kernel or not through sysfs.

	1a: kernel is responsible, and can spin down disks at shutdown

		- if given -h on command line, use sysfs to tell kernel
		  to spin down *all* disk devices we can find in sysfs,
		  and don't send any taskfiles or IOCTLs to the disks.

	1b: kernel is missing this essential feature

		- keep doing what we are doing now, but issue a cache
		  flush before we send any standby commands.

2. push that to Debian unstable, and also to stable-proposed-updates, or at
the very least to backports.org.

This will give maximum compatibility with the kernel, and fix the
cache-not-flushed-before-spindown issue.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
