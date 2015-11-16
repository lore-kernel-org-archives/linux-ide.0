From: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Mon, 16 Nov 2015 08:52:35 -0500
Message-ID: <5649DFA3.9080002@start.ca>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151031005608.GB3582@mtj.duckdns.org>
 <CAPcyv4iTwDXfDb1=kA6oNPmMJS1WbwPqdkB8LtbT6-=JV+h+7Q@mail.gmail.com>
 <20151031020115.GI3582@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:59312 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbbKPNwn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2015 08:52:43 -0500
In-Reply-To: <20151031020115.GI3582@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 15-10-30 10:01 PM, Tejun Heo wrote:
> On Fri, Oct 30, 2015 at 06:59:14PM -0700, Dan Williams wrote:
>> On Fri, Oct 30, 2015 at 5:56 PM, Tejun Heo <tj@kernel.org> wrote:
>>> On Fri, Oct 30, 2015 at 05:09:46PM -0400, Dan Williams wrote:
>>>> For high frequency I/O the overhead of threaded interrupts impacts
>>>> performance.  Add an option to make it configurable, with the default
>>>> being hardirq.
>>>>
>>>> A quick out-of-the-box test (i.e. no affinity tuning) shows ~10% random
>>>> read performance at ~20% less cpu.  The cpu wins appear to be from
>>>> reduced lock contention.
>>>
>>> Do we need threaded irq at all?  Why not just switch to hardirq?
>>>
>>
>> I can't imagine anyone doing high iops storage to also rely on the
>> ability to preempt the irq handler.  I'm assuming if someone notices
>> it missing they can scream, but otherwise hardirq seems all around
>> better.
>>
>> NVMe also has this optional via module parameter, but talking to Keith
>> he does not know of anyone using it.
>
> Let's remove it for now and do the conditional thing if anybody misses
> it.  No need to keep around dead code proactively.

Aren't threaded IRQs there to improve overall system real-time response?
If so, it would seem a step backwards to remove them completely,
especially considering the low cost of maintaining them here.

Cheers


