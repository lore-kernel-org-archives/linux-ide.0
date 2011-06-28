From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: New driver mtipx2xx submission
Date: Tue, 28 Jun 2011 11:18:43 -0400
Message-ID: <x49boxirnl8.fsf@segfault.boston.devel.redhat.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>
	<4DD722DB.8030303@micron.com>
	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
	<x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
	<20110601212129.11534c55@lxorguk.ukuu.org.uk>
	<4DF80ADE.8020206@micron.com>
	<x49ips75f4j.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A3002697E77@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758544Ab1F1PS6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2011 11:18:58 -0400
In-Reply-To: <22A973199D2C2F46933448F6E7990A3002697E77@ntxboimbx31.micron.com>
	(Asai Thambi Samymuthu Pattrayasamy's message of "Mon, 27 Jun 2011
	17:38:48 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

"Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
<asamymuthupa@micron.com> writes:

>> 2.6.39 introduced the on-stack plugging work from Jens, the intent of
>> which is to reduce queue lock contention.  It would be great if you
>> could run with that kernel and noop to see if we make up some of the
>> performance gap (which looks to be just north of 10%).
>> 
>> Asai, thanks for running these tests and providing all of this data!
>> 
>> -Jeff
>
> At least with noop and deadline for ahci driver, now queue lock is not
> the top offender. With the new change in plugging, seems noop and
> deadline are spending more time in processing I/O similar to Micron
> block driver.
>
> With the current test results with 2.6.39.1 (new optimization for
> plugging) and application queue depth of 32, 
>      * Micron block driver exhibits 43% better IOPS than ahci driver
> with noop
>      * Micron block driver slightly better in CPU utilization.
>
> With application queue depth of 256, Micron block driver is able to
> leverage the device capability, and hence performance increases more
> than 225%.
>

>From the perf report, I would have guessed that the CPU utilization for
the ahci test case would have been lower than the Micron block driver.
Odd, I wonder what I'm missing.  Asai, did you notice if any of the CPUs
was completely pegged during testing with ahci?  You're using a NUMA
box, right?  I also wonder what the irq distribution looked like, and
whether rq_affinity is hurting performance for the ahci case.  Also,
does the Micron driver do any sort of interrupt coalescing that maybe
the ahci driver isn't doing?

Anywho, a 40% difference is pretty significant (though NUMA can have
that sort of impact).  Alan, what do you think?  I was never clear on
how exactly the ahci driver would handle a queue depth larger than 32
(if it can't, then clearly we'd need a block driver for this hardware).

Cheers,
Jeff
