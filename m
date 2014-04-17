From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Thu, 17 Apr 2014 15:07:32 +0200
Message-ID: <20140417130732.GB2293@dhcp-26-207.brq.redhat.com>
References: <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
 <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
 <20140416191454.GC22569@htj.dyndns.org>
 <20140417082934.GA30477@dhcp-26-207.brq.redhat.com>
 <20140417132942.GB15326@htj.dyndns.org>
 <20140417124436.GC2270@dhcp-26-207.brq.redhat.com>
 <20140417134543.GD15326@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaDQOFt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2014 10:05:49 -0400
Content-Disposition: inline
In-Reply-To: <20140417134543.GD15326@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 09:45:43AM -0400, Tejun Heo wrote:
> > 	if (pp)
> > 		rc = devm_request_threaded_irq(..., irq + i, ...)
> > 	else
> > 		disable_irq(irq + i);
> 
> Ah, was looking at the old code.  But again, we didn't even request
> the irq, why would we disable it?

The driver does not request IRQs for dummy ports, but it still requests
MSIs for them. The MSI framework initializes the resources for all MSIs
(IRQ #s, CPU interrupt vectors). Hence, although we do not request a
IRQ #, it still exists - just with no handler associated with the driver.
IOW - with a default handler, which would probably complain loudly once
an interrupt from a dummy port comes (I suppose David could check it).

So if we just disable dummy port's IRQ #s we should never hear from them.

> Thanks.
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
