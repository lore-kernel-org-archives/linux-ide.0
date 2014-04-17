From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Thu, 17 Apr 2014 10:09:32 -0400
Message-ID: <20140417140932.GG15326@htj.dyndns.org>
References: <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
 <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
 <20140416191454.GC22569@htj.dyndns.org>
 <20140417082934.GA30477@dhcp-26-207.brq.redhat.com>
 <20140417132942.GB15326@htj.dyndns.org>
 <20140417124436.GC2270@dhcp-26-207.brq.redhat.com>
 <20140417134543.GD15326@htj.dyndns.org>
 <20140417130732.GB2293@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:59979 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaDQOJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 10:09:36 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so457941qge.12
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2014 07:09:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140417130732.GB2293@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 03:07:32PM +0200, Alexander Gordeev wrote:
> On Thu, Apr 17, 2014 at 09:45:43AM -0400, Tejun Heo wrote:
> > > 	if (pp)
> > > 		rc = devm_request_threaded_irq(..., irq + i, ...)
> > > 	else
> > > 		disable_irq(irq + i);
> > 
> > Ah, was looking at the old code.  But again, we didn't even request
> > the irq, why would we disable it?
> 
> The driver does not request IRQs for dummy ports, but it still requests
> MSIs for them. The MSI framework initializes the resources for all MSIs
> (IRQ #s, CPU interrupt vectors). Hence, although we do not request a
> IRQ #, it still exists - just with no handler associated with the driver.
> IOW - with a default handler, which would probably complain loudly once
> an interrupt from a dummy port comes (I suppose David could check it).
> 
> So if we just disable dummy port's IRQ #s we should never hear from them.

Hmmm.... can you please prepare a proper patch with a comment
explaining what's going on?  I'll apply it once David verifies it.

Thanks.

-- 
tejun
