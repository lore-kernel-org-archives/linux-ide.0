From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Tue, 30 Mar 2004 12:50:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <4069B376.9010104@pobox.com>
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de> <4069B6F8.1020506@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <4069B6F8.1020506@techsource.com>
To: Timothy Miller <miller@techsource.com>
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Jens Axboe wrote:
> 
>> - The optimal_sectors calculation is just an average of previous maximum
>>   with current maximum. The scheme has a number of break down points,
>>   for instance writes starving reads will give you a bad read execution
>>   time, further limiting ->optimal_sectors[READ]
> 
> 
> 
> I did look through your code a bit, but one thing to be concerned with 
> is that going only on max throughput might be fooled by cache hits on 
> the drive.


If you are taking your samples over time, that shouldn't matter...  if 
the system workload is such that you are hitting the drive cache the 
majority of the time, you're not being "fooled" by cache hits, the patch 
would be taking those cache hits into account.

If the system isn't hitting the drive cache the majority of the time, 
statistical sampling will automatically notice that too...

	Jeff
