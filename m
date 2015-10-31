From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Sat, 31 Oct 2015 09:56:08 +0900
Message-ID: <20151031005608.GB3582@mtj.duckdns.org>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35937 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbJaA4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 20:56:14 -0400
Received: by pacfv9 with SMTP id fv9so92139194pac.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2015 17:56:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Oct 30, 2015 at 05:09:46PM -0400, Dan Williams wrote:
> For high frequency I/O the overhead of threaded interrupts impacts
> performance.  Add an option to make it configurable, with the default
> being hardirq.
> 
> A quick out-of-the-box test (i.e. no affinity tuning) shows ~10% random
> read performance at ~20% less cpu.  The cpu wins appear to be from
> reduced lock contention.

Do we need threaded irq at all?  Why not just switch to hardirq?

Thanks.

-- 
tejun
