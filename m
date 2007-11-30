From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 29 Nov 2007 20:03:31 -0500
Message-ID: <474F6163.3030500@rtr.ca>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com> <474EE5F8.1030409@gmail.com> <474F0B11.7000205@rtr.ca> <474F4294.9030203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3145 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760202AbXK3BDe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 20:03:34 -0500
In-Reply-To: <474F4294.9030203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Mark Lord wrote:
>> I'm split on this one.  For fast systems (typical notebook/desktop) it's
>> almost a non-issue either way.
>>
>> But a lot of media boxes will be using this code, and they tend to have
>> very low-power, slow-clockrate CPUs in the 200-800Mhz range, and so the
>> real-time hit there (from PIO) will have a much more significant impact.
>>
>> Using DMA as much as possible on those slower platforms is definitely
>> a plus towards avoiding non-jerky, skipped frames, or start-stoppy DVD
>> recording.
>>
>> Now the most intensive commands are still DMA under the proposed scheme,
>> so it's not those that one would be concerned with.  But dropping to PIO
>> even for a few uncommon commands will still peg a real-time hit or two
>> on a slower media processor.
>>
>> So..  ????
> 
> One thing I don't understand about this argument is that PIO cycle time
> is not determined by CPU power.  It's bound by PCI and ATA bus speed.
> If you put a faster CPU on the job, it just ends up wasting the same
> amount of time burning up more CPU cycles or am I misjudging power of
> those embedded CPUs?
...

Yes, it wastes the same amount of real (clock on the wall) time.

But since it is typically a much slower system to begin with,
it has little in the way of "excess" computing capability,
so those few hundred microseconds of PIO time mean a lot
more to it than they would to a GHz+ processor.

In other words, such devices are usually close to their real-time
limits to begin with, so a 200-300usec real-time delay is difficult
to "make up" afterwards.

For a 1.8GHz Pentium-M, no problem --> it can churn away about
2-3 thousand instructions per microsecond afterwards.

But an 800MHz geode would require 2-8X that amount of real time
to execute the same number of "catch up" instructions.

Which means latencies for other things will be that much longer.
Or at least that's how I see it.

* * *

If I were doing this, I'd probably just do PIO for all non bulk xfer
opcodes, same as you, for ease of maintainership.

But I'd also think really hard about some way to allow full DMA
for chipsets/drives that can be trusted.  Not a whitelist (like Alan,
I don't believe in those), but something..

Cheers
