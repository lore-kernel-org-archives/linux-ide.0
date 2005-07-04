From: =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>
Subject: Re: [git patches] IDE update
Date: Tue, 05 Jul 2005 01:25:33 +0200
Message-ID: <42C9C56D.7040701@tomt.net>
References: <200507042033.XAA19724@raad.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.skjellin.no ([80.239.42.67]:43936 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261731AbVGDXZh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 19:25:37 -0400
In-Reply-To: <200507042033.XAA19724@raad.intranet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
Cc: 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, 'Ondrej Zary' <linux@rainbow-software.org>, 'Linus Torvalds' <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Al Boldi wrote:
> Bartlomiej Zolnierkiewicz wrote: {
> 
>>>>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
>>>>Hdparm -tT gives 38mb/s in 2.4.31
>>>>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
>>>>
>>>>Hdparm -tT gives 28mb/s in 2.6.12
>>>>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT

The "hdparm doesn't get as high scores as in 2.4" is a old discussed to 
death "problem" on LKML. So far nobody has been able to show it affects 
anything  but that pretty useless quasi-benchmark.

>>>>It feels like DMA is not being applied properly in 2.6.12.
>>>
>>>Same on 2.6.10,11,12.
>>>No errors though, only sluggish system.

Really sluggish or just "benchmark-sluggish"? If the former, try 
selecting a different IO elevator/sheduler. If the latter it doesn't 
matter much, at least not with the very simple hdparm test :-)

>> 
>> What about earlier kernels?
>> Please try to narrow down the problem to a specific kernel version.
>> }
> 
> Don't know about 2.6.0-2.6.9, but 2.4.31 is ok.
> 
> Bartlomiej,
> When you compare 2.4.31 with 2.6.12 don't you see this problem on your
> machine?
> If you have a fast system the slowdown won't show, but your IOWAIT will be
> higher anyway!

Nothing wrong with 73% iowait, I'd even consider it very low while 
putting load on a harddrive. Its just time spent waiting for data to be 
returned from disk, and thus I usually expect no lower than ~98-99% 
while stressing any disk. Harddisks are _slow as snails_ compared to cpu 
cycles ;-)

Beware 2.4 didn't export that statistic at all to userspace, so 0% 
iowait gets reported from most 2.6-ready reporting tools on 2.4.

