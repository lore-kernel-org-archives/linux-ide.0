From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: -rc3 regression (was Re: 2.6.25-rc2 + smartd = hang )
Date: Wed, 05 Mar 2008 11:51:38 +0100
Message-ID: <20080305105138.B140C93C87D@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <200803040133.07736.bzolnier@gmail.com> <20080304095701.DDF762DC027@tippex.mynet.homeunix.org> <200803042346.21403.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:47606 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159AbYCEKvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 05:51:49 -0500
In-reply-to: <200803042346.21403.bzolnier@gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Anders Eriksson <aeriksson@fastmail.fm>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


bzolnier@gmail.com said:
> and see if manually reverting only ide-taskfile.c change fixes the problem
> (so we know that we are looking at the right place). 

It does. Reverting the ide-taskfile.c change fixes it.



