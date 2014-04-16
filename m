From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Wed, 16 Apr 2014 15:14:54 -0400
Message-ID: <20140416191454.GC22569@htj.dyndns.org>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
 <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
 <20140415182001.GF30990@htj.dyndns.org>
 <20140416073919.GB2349@dhcp-26-207.brq.redhat.com>
 <20140416151932.GF1257@htj.dyndns.org>
 <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:46765 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbaDPTO6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 15:14:58 -0400
Received: by mail-qg0-f49.google.com with SMTP id e89so3856577qgf.22
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2014 12:14:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140416185105.GA21640@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: David Milburn <dmilburn@redhat.com>, linux-ide@vger.kernel.org

Hello,

On Wed, Apr 16, 2014 at 08:51:05PM +0200, Alexander Gordeev wrote:
> The crash occured in ahci_hw_interrupt() which means multiple MSIs
> were enabled. The fact driver does not request IRQ does not mean
> the PCI device does not send an MSI interrupt (and it does as we're
> observing the crash). So my question if the dummy port interrupt
> does not end up in handle_bad_irq() or some?

My memory is kinda fuzzy now but several stray interrupts don't
trigger anything.

Thanks.

-- 
tejun
