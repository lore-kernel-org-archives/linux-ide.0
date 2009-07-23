From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 13:40:07 +0800
Message-ID: <20090723054007.GA7473@sli10-desk.sh.intel.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48771 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbZGWFkI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jul 2009 01:40:08 -0400
Content-Disposition: inline
In-Reply-To: <4A67E00F.40808@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>

On Thu, Jul 23, 2009 at 11:59:11AM +0800, Jeff Garzik wrote:
> Shaohua Li wrote:
> > hi,
> > The SATA spec defines DMA setup FIS auto-activate optimization for FPDMA
> > transfers. I had an attempt to add it, though my test doesn't show obvious
> > performance improvement (not worse too), I wonder why not add this feature?
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> I agree, we should turn it on -- but doesn't this also have a controller 
> dependency?
> 
> IIRC, not all NCQ-capable controllers support this feature...  SATA 1.0 
> hardware may not behave properly in response, no?
It appears the AHCI spec doesn't define a HBA capability about this
feature, but I'm likely wrong as I'm not quite familar with SATA.

Thanks,
Shaohua
