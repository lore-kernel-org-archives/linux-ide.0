From: Alan Cox <alan@redhat.com>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Mon, 17 May 2004 12:52:35 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040517165235.GD15849@devserv.devel.redhat.com>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl> <20040516195811.GH20505@devserv.devel.redhat.com> <200405162220.23971.bzolnier@elka.pw.edu.pl> <40A7D9E6.1090900@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:2965 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261597AbUEQQw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2004 12:52:56 -0400
Content-Disposition: inline
In-Reply-To: <40A7D9E6.1090900@keyaccess.nl>
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jens Axboe <axboe@suse.de>

On Sun, May 16, 2004 at 11:15:18PM +0200, Rene Herman wrote:
> Alan, if you know, that drive fails ide_id_has_flush_cache()?

It does. I'm getting confusing results so I need to work out what
is up.

> Note, very aware I don't know what the fuck I'm doing here (and equally 
> aware I don't _want_ to be here :-) Having the drive spin down on each 
> reboot is totally unacceptable though. Not only does spinning up again 
> take significant time and noise, it's also actively bad for the drive.

I'd guess that the laptop may power off the drive during the reboot
cycle. If so then your suggestion makes sense
