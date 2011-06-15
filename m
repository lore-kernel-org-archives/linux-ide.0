From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 15 Jun 2011 10:43:56 -0400
Message-ID: <x49ips75f4j.fsf@segfault.boston.devel.redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab1FOOoK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Jun 2011 10:44:10 -0400
In-Reply-To: <4DF80ADE.8020206@micron.com> (Asai Thambi S. P.'s message of
	"Tue, 14 Jun 2011 19:29:02 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: asamymuthupa@micron.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Asai Thambi S P <asamymuthupa@micron.com> writes:

> On 6/1/2011 2:21 PM, Alan Cox wrote:
>>> Thanks, Asai!  I don't think cfq is the ideal I/O scheduler to be
>>> testing.  Could you run again with deadline and/or noop and see how that
>>> changes your throughput and perf report?  Also, just for completeness,
>>> could you tell us which kernel you ran this against?
>
> kernel 2.6.38.6

>> How many processors is this system, just looking at the lock contention
>> which is pretty horrible.
>
> 8 processors (2 quad-core CPUs)
> Intel(R) Xeon(R) CPU           X5672  @ 3.20GHz
>
[...]
> On looking into the data in below links, lock and block queue are
> consuming more time when running with ahci driver. Correct me if I
> missing something.

2.6.39 introduced the on-stack plugging work from Jens, the intent of
which is to reduce queue lock contention.  It would be great if you
could run with that kernel and noop to see if we make up some of the
performance gap (which looks to be just north of 10%).

Asai, thanks for running these tests and providing all of this data!

-Jeff
