From: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] speed up SATA
Date: Tue, 30 Mar 2004 13:19:39 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4069BA3B.5050004@techsource.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de> <4069B6F8.1020506@techsource.com> <4069B376.9010104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kinesis.swishmail.com ([209.10.110.86]:51717 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263779AbUC3SAj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Mar 2004 13:00:39 -0500
In-Reply-To: <4069B376.9010104@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



Jeff Garzik wrote:
> 
>
> 
> If you are taking your samples over time, that shouldn't matter...  if 
> the system workload is such that you are hitting the drive cache the 
> majority of the time, you're not being "fooled" by cache hits, the patch 
> would be taking those cache hits into account.
> 
> If the system isn't hitting the drive cache the majority of the time, 
> statistical sampling will automatically notice that too...
> 


I completely agree, although Jens' patch seems to try to learn the 
drive's maximum speed and go based on that.  Maybe I misread the code. 
Anyhow, it's certainly excellent for a starting point... it's this sort 
of proof-of-concept that gets the ball rolling.  Plus, it's already 
better than Jens says it is.  :)


