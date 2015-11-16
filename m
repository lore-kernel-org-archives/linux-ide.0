From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt handling
Date: Mon, 16 Nov 2015 08:29:45 -0800
Message-ID: <CAPcyv4jaFvkZguN6+h5CBU+OfcHEsCpL7G==yQcUx0_=13TDug@mail.gmail.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151031005608.GB3582@mtj.duckdns.org>
	<CAPcyv4iTwDXfDb1=kA6oNPmMJS1WbwPqdkB8LtbT6-=JV+h+7Q@mail.gmail.com>
	<20151031020115.GI3582@mtj.duckdns.org>
	<5649DFA3.9080002@start.ca>
	<20151116153327.GB18894@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35436 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbKPQ3q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 11:29:46 -0500
Received: by wmdw130 with SMTP id w130so118726939wmd.0
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2015 08:29:45 -0800 (PST)
In-Reply-To: <20151116153327.GB18894@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <kernel@start.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Nov 16, 2015 at 7:33 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Mark.
>
> On Mon, Nov 16, 2015 at 08:52:35AM -0500, Mark Lord wrote:
>> >Let's remove it for now and do the conditional thing if anybody misses
>> >it.  No need to keep around dead code proactively.
>>
>> Aren't threaded IRQs there to improve overall system real-time response?
>> If so, it would seem a step backwards to remove them completely,
>> especially considering the low cost of maintaining them here.
>
> For ahci, it was added without any justification.  It just came with
> the MSI changes.  If there's any data indicating that this makes any
> noticeable difference, it's easy to restore.
>

Also, the non-mult-msi case has been living without threaded
interrupts since forever.  If they were needed I expect the
functionality would have been ported over by now.  As is this provides
a noticeable throughput improvement.
