From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Tue, 25 Jan 2011 04:32:59 +0100
Message-ID: <20110125033259.GC24024@MAIL.13thfloor.at>
References: <20110125030410.GA24024@MAIL.13thfloor.at> <yq14o8x3c8t.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:34649 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1AYDdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 22:33:00 -0500
Content-Disposition: inline
In-Reply-To: <yq14o8x3c8t.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 24, 2011 at 10:15:14PM -0500, Martin K. Petersen wrote:
> >>>>> "Herbert" == Herbert Poetzl <herbert@13thfloor.at> writes:

> Herbert>  - the drive doesn't report 4k sectors at all, not
> Herbert>    even as physical sector size.

> There have been numerous threads on this list about EARS not 
> reporting block sizes correctly. Check the archives.

really? well, they probably use strange subjects or the search
function on the archives is broken ...

I did a search on the archives, and I get a totla of 30 threads
containing EARS (in linux-ide) and most of them talk about
something completely different (like rabbit ears :)

> Herbert> My question now is, how can I tell the kernel that this drive
> Herbert> actually has 4k physical sectors and that it would be a smart
> Herbert> thing to send requests in some kind of 4k I/O chunks?

> Align your partitions on a 4K boundary.

While this will ensure that the drive performance is better
than without doing so (I'm not using a partition table on that
drive anyways, but I get what you mean), this doesn't inform
the kernel about proper I/O sizes and for sure doesn't prevent
unnecessary read-change-write operations for the disc ...

best,
Herbert

> -- 
> Martin K. Petersen	Oracle Linux Engineering
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
