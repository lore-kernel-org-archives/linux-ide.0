From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: 2.6.25-rc2 + smartd = hang
Date: Wed, 27 Feb 2008 08:53:46 +0100
Message-ID: <20080227075346.9D55D93C5CF@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <200802241654.49150.bzolnier@gmail.com> <20080226082056.7519C93C195@tippex.mynet.homeunix.org> <200802262054.12806.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:41950 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754235AbYB0Hyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 02:54:36 -0500
In-reply-to: <200802262054.12806.bzolnier@gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Anders Eriksson <aeriksson@fastmail.fm>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


bzolnier@gmail.com said:
> Thanks.
> Unfortunately nothing seems wrong with the patch... :(
> I'll take a closer look when I have some more time...
> Bart 


Just to make sure I didn't goofed up the bisection...

I bisected between v2.6.24 and v2.6.25-rc2. In the midst of the bisection, make
install decided to call the new version 2.6.24-rc7-gXXXX. Is that ok? I figured
rc7+delta was before 24-final, hence outside the bisection? After that event I
got the normal series of good god bad good... So I figured we were on the right
track anyway...

/A 

