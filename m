From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA handling on ICH5R in 2.6.8rc2
Date: Wed, 4 Aug 2004 15:20:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040804192054.GB19224@havoc.gtf.org>
References: <20040804184504.21dcb386.ak@suse.de> <20040804172610.GA5978@suse.de> <20040804193608.0a330d1f.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:51148 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267386AbUHDTU5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2004 15:20:57 -0400
Content-Disposition: inline
In-Reply-To: <20040804193608.0a330d1f.ak@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jens Axboe <axboe@suse.de>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, jun.nakajima@intel.com

On Wed, Aug 04, 2004 at 07:36:08PM +0200, Andi Kleen wrote:
> On Wed, 4 Aug 2004 19:26:10 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> 
> > Can't you set it to enhanced mode in the bios, then shows up as a
> > seperate device id and just works. I had the same issue until Jeff
> > walked me through it :-)
> 
> If that really solves all problems why does quirk_intel_ide_combined
> not do that automatically? 

I would like to do that.

The problem is allocating and assigning PCI I/O ranges to one or two PCI
devices.  And the BIOS may configure into combined mode, and get
confused if the kernel prefers enhanced mode (untested).

	Jeff



