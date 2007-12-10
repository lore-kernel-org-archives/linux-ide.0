From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SAS v SATA interface performance
Date: Mon, 10 Dec 2007 08:50:18 -0600
Message-ID: <1197298218.5169.4.camel@localhost.localdomain>
References: <47506237.3000406@clear.net.nz>
	 <47507F9A.3080109@msgid.tls.msk.ru>  <475CEBBA.3050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-76-243-235-52.dsl.chcgil.sbcglobal.net ([76.243.235.52]:57529
	"EHLO accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751818AbXLJO60 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 09:58:26 -0500
In-Reply-To: <475CEBBA.3050409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Richard Scobie <r.scobie@clear.net.nz>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Mon, 2007-12-10 at 16:33 +0900, Tejun Heo wrote:
> There's one thing we can do to improve the situation tho.  Several
> drives including raptors and 7200.11s suffer serious performance hit if
> sequential transfer is performed by multiple NCQ commands.  My 7200.11
> can do > 100MB/s if non-NCQ command is used or only upto two NCQ
> commands are issued; however, if all 31 (maximum currently supported by
> libata) are used, the transfer rate drops to miserable 70MB/s.
> 
> It seems that what we need to do is not issuing too many commands to one
> sequential stream.  In fact, there isn't much to gain by issuing more
> than two commands to one sequential stream.

You're entering an area of perennial debate even for SCSI drives.  What
we know is that for drives whose firmware elevator doesn't perform very
well is that a lower TCQ depth (2-4) is better than a high one, the only
use tags have being to saturate the transport.  For high end arrays and
better performing firmware drives, the situation is much more murky.  It
boils down to whose elevator do you trust, the drive/array's or the
kernel's.  If the latter, then you want a depth of around 4 and if the
former, you want a depth as high as possible (arrays like 64-128).

Given the way IDE drives are made, I'd bet they fall into the category
of firmware elevator that doesn't perform very well, so you probably
want a low NCQ depth with them (just sufficient to saturate the
transport, but not high enough to allow the drive to make too many head
scheduling decisions).

James


