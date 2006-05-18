From: Tejun Heo <htejun@gmail.com>
Subject: Re: A question about NCQ
Date: Thu, 18 May 2006 10:56:50 +0900
Message-ID: <446BD462.9030606@gmail.com>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com> <446B33D6.7040006@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:57770 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWERCum (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 22:50:42 -0400
Received: by ug-out-1314.google.com with SMTP id a2so382842ugf
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 19:50:41 -0700 (PDT)
In-Reply-To: <446B33D6.7040006@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> zhao, forrest wrote:
> ..
>> But initial test result of running iozone with O_DIRECT option turned on
>> didn't show the visible performance gain with NCQ. In certain cases, NCQ
>> even had a worse performance than without NCQ.
>>
>> So my question is in what usage case can we observe the performance gain
>> with NCQ?
> 
> That's something I've been wondering for a couple of years,
> ever since implementing full NCQ/TCQ Linux drivers for several devices
> (most notably the very fast qstor.c driver).
> 
> The observation with all of thses was that Linux already does a reasonably
> good enough job of scheduling I/O that tagged-queuing rarely seems to help,
> at least on any benchmark/test tools we've found to try (note that opposite
> results are obtained when using non-Linux kernels, eg. winxp).
> 
> With some drives, the use of tagged commands triggers different firmware
> algorithms, that adversely affect throughput in favour of better random
> seek capability -- but since the disk scheduling already minimizes the
> randomness of seeking (very few back-and-forth flurries), this combination
> often ends up slower than without NCQ (on Linux).

At this point, NCQ doesn't look that attractive as it shows _worse_ 
performance on many cases.  Maybe libata shouldn't enable it 
automatically for the time being but I think if drives handle NCQ 
reasonably well, there are things to be gained from NCQ by making IO 
schedulers more aware of queued devices.  Things that come to my mind are...

* Control the movement of head closely but send adjacent requests 
together to allow the drive optimize at smaller scale.

* Reduce plugging/wait latency.  As we can send more than one command at 
a time, we don't have to wait for adjacent requests which might arrive 
soon.  If it's once determined that the head can move to certain area, 
issue the command ASAP.  If adjacent requests arrive, we can merge them 
while the head is moving thus reducing latency.

-- 
tejun
