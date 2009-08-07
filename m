From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Fri, 7 Aug 2009 19:46:07 +0200
Message-ID: <200908071946.07991.bzolnier@gmail.com>
References: <200908071355.21648.bzolnier@gmail.com> <200908071927.36367.bzolnier@gmail.com> <20090807.103610.209136140.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215]:48860 "EHLO
	mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbZHGRq5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 13:46:57 -0400
In-Reply-To: <20090807.103610.209136140.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 07 August 2009 19:36:10 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Fri, 7 Aug 2009 19:27:36 +0200
> 
> > Are you trying to tell me that after 6 weeks there is still no public
> > tree to hold future IDE changes?
> > 
> > If this is indeed a case here I hope that it will get addressed ASAP.
> 
> IDE is deep maintainence, we shouldn't be doing lots of changes,
> cleanups, and things of this nature.  So urgency and timeliness
> is on a sincerely different scale for it.

Nobody is saying anything about cleanups and things of this nature..

> On the other hand, if you've been looking, I've been applying
> networking patches to net-2.6 and net-next-2.6 by the truckload
> on a daily basis because it is in active development.

Excellence in one area doesn't magically translate to other areas,
especially when said area needs a completely different approach:

I've been looking and I've seen you pushing non-trivial IDE bug-fix
patches with almost no wider hardware coverage to upstream (i.e. one
of my own patches which has been _explicitly_ marked as needing more
linux-next exposure)..
