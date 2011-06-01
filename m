From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: New driver mtipx2xx submission
Date: Wed, 01 Jun 2011 15:51:41 -0400
Message-ID: <x49ipsp9voy.fsf@segfault.boston.devel.redhat.com>
References: <22A973199D2C2F46933448F6E7990A300204F2BC@ntxboimbx31.micron.com>
	<20110428230605.78c55c70@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300204F728@ntxboimbx31.micron.com>
	<20110502184206.25907c5e@lxorguk.ukuu.org.uk>
	<22A973199D2C2F46933448F6E7990A300214B0D6@ntxboimbx31.micron.com>
	<20110511202013.075b07cc@lxorguk.ukuu.org.uk>
	<4DD722DB.8030303@micron.com>
	<x49lixuyhhs.fsf@segfault.boston.devel.redhat.com>
	<22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759089Ab1FATvz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2011 15:51:55 -0400
In-Reply-To: <22A973199D2C2F46933448F6E7990A300239EA77@ntxboimbx31.micron.com>
	(Asai Thambi Samymuthu Pattrayasamy's message of "Wed, 1 Jun 2011
	13:40:29 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

"Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
<asamymuthupa@micron.com> writes:

> On 5/25/2011 8:36 AM, Jeff Moyer wrote:
>> Asai Thambi S P<asamymuthupa@micron.com>  writes:
>>
>>> On 5/11/2011 1:20 PM, Alan Cox wrote:
>>>> So a bigger queue helped (at least in 2006). The AHCI driver can be
>>>> taught your bigger queue easily enough. The question is where with a
>>>> *current* kernel are any remaining bottlenecks if you do that and
> how do
>>>> we fix them.
>>>
>>> Attached image/table shows the performance numbers on current kernel.
>>>
>>> The main objectives of our new mtipx2xx driver are
>>> 	1.) highest performance (see attached image/table),
>>> 	2.) lowest CPU utilization, and
>>
>> Can you collect perf data to show why the ahci driver is taking up so
>> much more CPU for the random I/O case?
>>
>
> Collected the perf data for ahci driver. As the call graph is getting 
> distorted in the email, attaching the perf data call graph report.

Thanks, Asai!  I don't think cfq is the ideal I/O scheduler to be
testing.  Could you run again with deadline and/or noop and see how that
changes your throughput and perf report?  Also, just for completeness,
could you tell us which kernel you ran this against?

Thanks!
Jeff
