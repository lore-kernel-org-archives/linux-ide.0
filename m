From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Tue, 30 Mar 2004 11:20:07 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40699E37.2020403@pobox.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263731AbUC3QU0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Mar 2004 11:20:26 -0500
In-Reply-To: <20040330110928.GR24370@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jens Axboe wrote:
> Here's a quickly done patch that attempts to adjust the value based on a
> previous range of completed requests. It changes ->max_sectors to be a
> hardware limit, adding ->optimal_sectors to be our max issued io target.
> It is split on READ and WRITE. The target is to keep request execution
> time under BLK_IORATE_TARGET, which is 50ms in this patch. read-ahead
> max window is kept within a single request in size.
> 
> So this is pretty half-assed, but it gets the point across. Things that
> should be looked at (meaning - should be done, but I didn't want to
> waste time on them now):
> 
> - I added the hook to see how many in-drive queued requests you have, so
>   there's the possibility to add tcq knowledge as well.
> 
> - The optimal_sectors calculation is just an average of previous maximum
>   with current maximum. The scheme has a number of break down points,
>   for instance writes starving reads will give you a bad read execution
>   time, further limiting ->optimal_sectors[READ]


Makes me pretty happy... :)

	Jeff



