From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 14:02:52 -0800
Message-ID: <20060103140252.52ebd7d9.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<20060103200603.GA3472@suse.de>
	<20060103201312.GB3472@suse.de>
	<20060103130027.44bb8897.randy_d_dunlap@linux.intel.com>
	<20060103211608.GF3472@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:50602 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751017AbWACWCR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 17:02:17 -0500
In-Reply-To: <20060103211608.GF3472@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jhpark@tuhep.phys.tohoku.ac.jp, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, 3 Jan 2006 22:16:11 +0100
Jens Axboe <axboe@suse.de> wrote:

> > At least it shows that there is no _GTF at all for SATA devices,
> > only for PATA (which my patch does not address).
> 
> Aren't they the same thing? Any plans on checking that as well, I think
> there's a fair share of pata-on-sata laptops out there.

It certainly would be Good to have that supported.
I'll take a look at the ACPI (3.0) spec to see what (more)
is needed.

BTW, there's a different IDE-ACPI patch from
Shaohua Li <shaohua.li@intel.com>.  Have you seen it?
Has anyone here tested it?
http://marc.theaimsgroup.com/?l=linux-kernel&m=113390716128790&w=2

Thanks,
---
~Randy
