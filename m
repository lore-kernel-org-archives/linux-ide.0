From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Sun, 16 May 2004 22:20:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405162220.23971.bzolnier@elka.pw.edu.pl>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl> <20040516195811.GH20505@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19688 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264736AbUEPUSa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 16:18:30 -0400
In-Reply-To: <20040516195811.GH20505@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jens Axboe <axboe@suse.de>

On Sunday 16 of May 2004 21:58, Alan Cox wrote:
> On Fri, May 14, 2004 at 01:58:58PM +0200, Rene Herman wrote:
> > Have again attached a 'rollup' patch against vanilla 2.6.6, including
> > this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of
> > spindle if rebooting" hack. Again, just in case anyone finds it useful.
>
> This reintroduces corruption on my thinkpad 600.

[ this corruption was fixed by kernel 2.6.6 ]

Please see if reverting changes to ide_device_shutdown() helps.

