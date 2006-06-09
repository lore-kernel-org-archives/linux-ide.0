From: Jens Axboe <axboe@suse.de>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Fri, 9 Jun 2006 13:49:19 +0200
Message-ID: <20060609114918.GG31913@suse.de>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com> <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488EB4A.4050501@pobox.com> <4488EE69.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:17181 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965240AbWFILtM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jun 2006 07:49:12 -0400
Content-Disposition: inline
In-Reply-To: <4488EE69.7050907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

On Fri, Jun 09 2006, Tejun Heo wrote:
> Jeff Garzik wrote:
> 
> >I'm still not sure I follow you?
> >
> >When AHCI runs out of commands to execute, it transitions from H:Idle to 
> >Ccc:SetIS.
> >
> >IMPORTANT NOTE:  In order for CCC to be effective on AHCI, ahci.c and 
> >libata (and sata_sil24) must be updated to support queuing a list of 
> >non-NCQ commands onto the controller, and recovering from errors in the 
> >case where a command list full of non-NCQ commands is present.
> 
> I thought about it but am not really sure whether it's worth the 
> trouble.  We'll be saving on inter-command latency and interrupt 
> handling which is great but not so sure how noticeable the improvement 
> would be.  NCQ is already all around.  How about doing CCC only during 
> NCQ command phase?

Fully agree, doing CCC on non-ncq sounds like a very silly thing to do.
Ugly complexity for very little (and questionable) gain.

I'm not a big fan of CCC in generel, to me it seems to have bigger
potential to cause you latency than save you interrupt processing time.
I'm not saying there aren't cases where CCC would be a win, but I see a
lot more cases where it definitely wont be. And it's a classic case of
having to implement policy, so it's surely get it wrong here and there.

-- 
Jens Axboe

