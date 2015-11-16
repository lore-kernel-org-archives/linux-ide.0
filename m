From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] ahci: switch from 'threaded' to 'hardirq'
 interrupt handling
Date: Mon, 16 Nov 2015 11:29:53 -0500
Message-ID: <20151116162953.GH18894@mtj.duckdns.org>
References: <20151112002727.37012.65672.stgit@dwillia2-desk3.jf.intel.com>
 <20151112002738.37012.56239.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36398 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbKPQ34 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 11:29:56 -0500
Received: by ykdr82 with SMTP id r82so247381372ykd.3
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2015 08:29:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151112002738.37012.56239.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Wed, Nov 11, 2015 at 04:27:38PM -0800, Dan Williams wrote:
> For high frequency I/O the overhead of threaded interrupts impacts
> performance.  A quick out-of-the-box test (i.e. no affinity tuning)
> shows ~10% random read performance at ~20% less cpu.  The cpu wins
> appear to be from reduced lock contention.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied 1-2 to libata/for-4.5.

Thanks.

-- 
tejun
