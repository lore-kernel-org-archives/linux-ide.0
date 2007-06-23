From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PROBLEM]: hdparm strange behaviour for 2.6.21 and later
Date: Sat, 23 Jun 2007 20:28:58 +0200
Message-ID: <200706232028.58193.bzolnier@gmail.com>
References: <200706161958.05313.djart@linux.gr> <4676E47E.5050209@rtr.ca> <200706201807.41646.djart@linux.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:46902 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbXFWSNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 14:13:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1021877ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 11:13:43 -0700 (PDT)
In-Reply-To: <200706201807.41646.djart@linux.gr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thanos Kyritsis <djart@linux.gr>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


Hi,

On Wednesday 20 June 2007, Thanos Kyritsis wrote:
> On Monday 18 June 2007, Mark Lord wrote:
> > Thanos Kyritsis wrote:
> [snip]
> > > /etc/rc.d/rc.local contains the following:
> > > /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hda
> > > /usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdb
> [snip]
> 
> > Sounds like a (kernel) timing issue.
> > The "-q" option gets rid of some intermediary printf's,
> > and nothing else.  So with -q, the ioctl() calls happen
> > much closer together in time.  Without -q, the intermediary
> > printf's likely cause a resched, giving the kernel more time
> > to complete anything left over from the earlier call.

It could be that some assumptions that I've taken when
fixing DMA tuning locking were wrong...

> > ????
> >
> > Any difference with a modern version of hdparm?
> 
> The same issue happens when using hdparm 7.4 as well as 7.5.

Adding a couple of printk-s to ide.c::set_using_dma() and
ide.c::ide_spin_wait_hwgroup() will for sure help in debugging
it further.

Also could you try running UP kernel without PREEMPT and see
if it makes difference?

Thanks,
Bart
