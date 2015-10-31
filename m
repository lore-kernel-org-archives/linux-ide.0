From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt handling
Date: Fri, 30 Oct 2015 18:59:14 -0700
Message-ID: <CAPcyv4iTwDXfDb1=kA6oNPmMJS1WbwPqdkB8LtbT6-=JV+h+7Q@mail.gmail.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151031005608.GB3582@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34090 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbJaB7Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 21:59:16 -0400
Received: by wikq8 with SMTP id q8so21334675wik.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2015 18:59:15 -0700 (PDT)
In-Reply-To: <20151031005608.GB3582@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Oct 30, 2015 at 5:56 PM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Oct 30, 2015 at 05:09:46PM -0400, Dan Williams wrote:
>> For high frequency I/O the overhead of threaded interrupts impacts
>> performance.  Add an option to make it configurable, with the default
>> being hardirq.
>>
>> A quick out-of-the-box test (i.e. no affinity tuning) shows ~10% random
>> read performance at ~20% less cpu.  The cpu wins appear to be from
>> reduced lock contention.
>
> Do we need threaded irq at all?  Why not just switch to hardirq?
>

I can't imagine anyone doing high iops storage to also rely on the
ability to preempt the irq handler.  I'm assuming if someone notices
it missing they can scream, but otherwise hardirq seems all around
better.

NVMe also has this optional via module parameter, but talking to Keith
he does not know of anyone using it.
