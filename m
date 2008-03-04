From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re: -rc3 regression (was Re: 2.6.25-rc2 + smartd = hang )
Date: Tue, 04 Mar 2008 16:25:32 +0100
Message-ID: <20080304152532.C06932DC027@tippex.mynet.homeunix.org>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <20080228143854.6350093C855@tippex.mynet.homeunix.org> <200803040116.42764.bzolnier@gmail.com> <200803040133.07736.bzolnier@gmail.com> <20080304095701.DDF762DC027@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:51810 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764846AbYCDP0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Mar 2008 10:26:25 -0500
In-reply-to: <20080304095701.DDF762DC027@tippex.mynet.homeunix.org> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>


aeriksson@fastmail.fm said:
>> I need some sleep...  this patch is not going to help (though disabling
>> PREEMPT may be worth a try).  Sorry for the confusion.

> Ok, I'll drop the patch and, recompile without PREEMPT. 

Tested with PREEMPT_NONE. No change.

/A


