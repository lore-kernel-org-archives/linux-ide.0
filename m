From: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] speed up SATA
Date: Tue, 30 Mar 2004 10:54:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40699843.7030005@techsource.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040330110928.GR24370@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrea Arcangeli <andrea@suse.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org



Jens Axboe wrote:

> 
> 
> Here's a quickly done patch that attempts to adjust the value based on a
> previous range of completed requests. It changes ->max_sectors to be a
> hardware limit, adding ->optimal_sectors to be our max issued io target.
> It is split on READ and WRITE. The target is to keep request execution
> time under BLK_IORATE_TARGET, which is 50ms in this patch. read-ahead
> max window is kept within a single request in size.
> 
[snip]

Awesome patch!

One question I have is about how you are determining optimal request 
size.  You are basing this on the _maximum_ performance of the device, 
but there could be huge differences between min and max performance. 
Would it be better to compute optimal based on worst-case performance? 
Or averaged over time?

Idealy, we'd have a running average where one hit of worst-case will 
have an impact, but if that happens only once, it'll drop out of the 
average, and best-case events will be considered but tempered as well.

If we're going for real-time, then we want to avoid any latency over 
50ms.  In that case, we'd want to go based on worst-case, although it 
would still be good to let, say, an occasional hardware glitch which had 
slow response to not have permanent impact.
