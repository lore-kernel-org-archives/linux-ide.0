From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Thu, 17 Apr 2014 10:29:35 +0200
Message-ID: <20140417082934.GA30477@dhcp-26-207.brq.redhat.com>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
 <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
 <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
 <20140416191454.GC22569@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbaDQI1w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2014 04:27:52 -0400
Content-Disposition: inline
In-Reply-To: <20140416191454.GC22569@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Wed, Apr 16, 2014 at 03:14:54PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 16, 2014 at 08:51:05PM +0200, Alexander Gordeev wrote:
> > The crash occured in ahci_hw_interrupt() which means multiple MSIs
> > were enabled. The fact driver does not request IRQ does not mean
> > the PCI device does not send an MSI interrupt (and it does as we're
> > observing the crash). So my question if the dummy port interrupt
> > does not end up in handle_bad_irq() or some?
> 
> My memory is kinda fuzzy now but several stray interrupts don't
> trigger anything.

Mine too :)
Just thought may be this way would be better:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e45b18e..9f1169a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1240,6 +1240,8 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
 						       irq + i, ahci_hw_interrupt,
 						       ahci_thread_fn, IRQF_SHARED,
 						       pp->irq_desc, host->ports[i]);
+		else
+			disable_irq(irq + i);
 		if (rc)
 			goto out_free_irqs;
 	}

> Thanks.
> 
> -- 
> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
