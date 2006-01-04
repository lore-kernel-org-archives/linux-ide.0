From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Wed, 4 Jan 2006 08:36:55 +0100
Message-ID: <20060104073655.GJ3472@suse.de>
References: <87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp> <20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com> <20060103172649.GV2772@suse.de> <20060103190346.GY2772@suse.de> <20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com> <20060103200603.GA3472@suse.de> <20060103201312.GB3472@suse.de> <20060103130027.44bb8897.randy_d_dunlap@linux.intel.com> <20060103211608.GF3472@suse.de> <20060103140252.52ebd7d9.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:16720 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965224AbWADHf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2006 02:35:28 -0500
Content-Disposition: inline
In-Reply-To: <20060103140252.52ebd7d9.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: jhpark@tuhep.phys.tohoku.ac.jp, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, Jan 03 2006, Randy Dunlap wrote:
> On Tue, 3 Jan 2006 22:16:11 +0100
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > At least it shows that there is no _GTF at all for SATA devices,
> > > only for PATA (which my patch does not address).
> > 
> > Aren't they the same thing? Any plans on checking that as well, I think
> > there's a fair share of pata-on-sata laptops out there.
> 
> It certainly would be Good to have that supported.
> I'll take a look at the ACPI (3.0) spec to see what (more)
> is needed.

It's all very confusing. Is it just a questions of checking which _GTF's
to query? You can use ata_dev_knobble() to check whether this is an SATA
or PATA drive. The rest of the code should be the same.

> BTW, there's a different IDE-ACPI patch from
> Shaohua Li <shaohua.li@intel.com>.  Have you seen it?
> Has anyone here tested it?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113390716128790&w=2

I hadn't seen it before. I have no real pata + acpi suspending machines,
though.

-- 
Jens Axboe

