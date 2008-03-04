From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: -rc3 regression (was Re: 2.6.25-rc2 + smartd = hang )
Date: Tue, 4 Mar 2008 01:33:07 +0100
Message-ID: <200803040133.07736.bzolnier@gmail.com>
References: <20080222165122.8D2BB93C12F@tippex.mynet.homeunix.org> <20080228143854.6350093C855@tippex.mynet.homeunix.org> <200803040116.42764.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:39838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbYCDASh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 19:18:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2347495ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2008 16:18:35 -0800 (PST)
In-Reply-To: <200803040116.42764.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>

On Tuesday 04 March 2008, Bartlomiej Zolnierkiewicz wrote:

> Untested patch which may help in case that set_pio_mode() raced with
> the queueing of the special request and block layer doesn't call
> ->request_fn_proc again if we were preempted previously (if PREEMPT=y).

I need some sleep...  this patch is not going to help (though disabling
PREEMPT may be worth a try).  Sorry for the confusion.

Bart
