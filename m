From: Mark Lord <liml@rtr.ca>
Subject: Re: A question about NCQ
Date: Wed, 17 May 2006 10:31:50 -0400
Message-ID: <446B33D6.7040006@rtr.ca>
References: <1147773689.7273.88.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:12173 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932575AbWEQObv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 10:31:51 -0400
In-Reply-To: <1147773689.7273.88.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
..
> But initial test result of running iozone with O_DIRECT option turned on
> didn't show the visible performance gain with NCQ. In certain cases, NCQ
> even had a worse performance than without NCQ.
> 
> So my question is in what usage case can we observe the performance gain
> with NCQ?

That's something I've been wondering for a couple of years,
ever since implementing full NCQ/TCQ Linux drivers for several devices
(most notably the very fast qstor.c driver).

The observation with all of thses was that Linux already does a reasonably
good enough job of scheduling I/O that tagged-queuing rarely seems to help,
at least on any benchmark/test tools we've found to try (note that opposite
results are obtained when using non-Linux kernels, eg. winxp).

With some drives, the use of tagged commands triggers different firmware
algorithms, that adversely affect throughput in favour of better random
seek capability -- but since the disk scheduling already minimizes the
randomness of seeking (very few back-and-forth flurries), this combination
often ends up slower than without NCQ (on Linux).

Cheers
