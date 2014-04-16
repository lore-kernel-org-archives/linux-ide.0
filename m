From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Wed, 16 Apr 2014 20:51:05 +0200
Message-ID: <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
 <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbaDPStW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Apr 2014 14:49:22 -0400
Content-Disposition: inline
In-Reply-To: <20140416151932.GF1257@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

On Wed, Apr 16, 2014 at 11:19:32AM -0400, Tejun Heo wrote:
> > Also, we're not going to see complains on spurious interrupts, aren't we?
> 
> The irq isn't even requested, it won't reach the kernel at all.

The crash occured in ahci_hw_interrupt() which means multiple MSIs
were enabled. The fact driver does not request IRQ does not mean
the PCI device does not send an MSI interrupt (and it does as we're
observing the crash). So my question if the dummy port interrupt
does not end up in handle_bad_irq() or some?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
