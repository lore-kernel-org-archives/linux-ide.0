From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Pkg-sysvinit-devel] [PATCH] libata: remove	libata.spindown_compat
Date: Sat, 19 May 2007 18:47:54 +0200
Message-ID: <464F2A3A.5060602@gmail.com>
References: <464C6A0E.7020601@gmail.com> <1179572779.23670.13.camel@localhost.localdomain> <464EDBFB.3050307@gmail.com> <20070519134836.GA3750@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:11127 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbXESQsN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 12:48:13 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1682653nza
        for <linux-ide@vger.kernel.org>; Sat, 19 May 2007 09:48:12 -0700 (PDT)
In-Reply-To: <20070519134836.GA3750@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Daniel Drake <dsd@gentoo.org>, Francesco Pretto <ceztko@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, pkg-sysvinit-devel@lists.alioth.debian.org

Henrique de Moraes Holschuh wrote:
> Well, the reason I raised the ruckus in the first place was just the
> emergency unload, yes.  I didn't know about any missing cache flushes (and
> AFAIK we never had any reported to us).  We will have to fix that in halt(8)
> IMHO, just in case.  And probably hdparm/sdparm should also know to not
> standby or sleep disks without a cache flush, either.
> 
> I also don't know the history of halt(8), Miquel does... so I have not much
> else to comment.

OIC, hmm.. STANDBYNOW for cache flushing.  Interesting.

> At least now it is clear what we need halt(8) to do (in Debian, anyway):
> 
> 1. check if we have a responsible kernel or not through sysfs.
> 
> 	1a: kernel is responsible, and can spin down disks at shutdown
> 
> 		- if given -h on command line, use sysfs to tell kernel
> 		  to spin down *all* disk devices we can find in sysfs,
> 		  and don't send any taskfiles or IOCTLs to the disks.
> 
> 	1b: kernel is missing this essential feature
> 
> 		- keep doing what we are doing now, but issue a cache
> 		  flush before we send any standby commands.
> 
> 2. push that to Debian unstable, and also to stable-proposed-updates, or at
> the very least to backports.org.
> 
> This will give maximum compatibility with the kernel, and fix the
> cache-not-flushed-before-spindown issue.

Yeap, right.  It would be great if you can push the updates upstream so
that other distros can use it too.  Also, some configurations might
prefer halt not touching the sysfs nodes so that the user can configure
mange_start_stop, but I guess that kind of stuff is up to distro.

Thanks.

-- 
tejun
