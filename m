From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] ahci: switch from 'threaded' to 'hardirq' interrupt
 handling
Date: Mon, 16 Nov 2015 10:33:27 -0500
Message-ID: <20151116153327.GB18894@mtj.duckdns.org>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151030210946.8538.26203.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151031005608.GB3582@mtj.duckdns.org>
 <CAPcyv4iTwDXfDb1=kA6oNPmMJS1WbwPqdkB8LtbT6-=JV+h+7Q@mail.gmail.com>
 <20151031020115.GI3582@mtj.duckdns.org>
 <5649DFA3.9080002@start.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34970 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbbKPPda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 10:33:30 -0500
Received: by ykba77 with SMTP id a77so243677534ykb.2
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2015 07:33:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5649DFA3.9080002@start.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@start.ca>
Cc: Dan Williams <dan.j.williams@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

On Mon, Nov 16, 2015 at 08:52:35AM -0500, Mark Lord wrote:
> >Let's remove it for now and do the conditional thing if anybody misses
> >it.  No need to keep around dead code proactively.
> 
> Aren't threaded IRQs there to improve overall system real-time response?
> If so, it would seem a step backwards to remove them completely,
> especially considering the low cost of maintaining them here.

For ahci, it was added without any justification.  It just came with
the MSI changes.  If there's any data indicating that this makes any
noticeable difference, it's easy to restore.

Thanks.

-- 
tejun
