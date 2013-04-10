From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: regarding your patch "AHCI: Support multiple MSIs"
Date: Wed, 10 Apr 2013 17:42:03 +0200
Message-ID: <20130410154202.GA2137@dhcp-26-207.brq.redhat.com>
References: <51659BDA02000078000CC288@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935753Ab3DJPhM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Apr 2013 11:37:12 -0400
Content-Disposition: inline
In-Reply-To: <51659BDA02000078000CC288@nat28.tlf.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-ide@vger.kernel.org

On Wed, Apr 10, 2013 at 04:05:30PM +0100, Jan Beulich wrote:
> Alexander,
> 
> I'm a bit puzzled by the way ahci_init_interrupts() works, when
> looking at a particular hardware implementation having 6 ports
> but allowing up to 16 MSIs - obviously, with one IRQ per port,
> obtaining 8 MSIs would be sufficient in this case, conserving on
> resources. Is there any reason this can't be done (i.e. by the
> caller of pci_enable_msi_block_auto() passing in the maximum
> desired number)?

There are few points here.

1. Some (all?) hardware implementations (i.e. Intel) have stupid
logic that falls back to single MSI mode as if MRSM bit was set,
in case # of allocated MSIs is less than # of available MSIs,
even though # of allocated MSIs >= # of ports. I did not find any
chips which could perform otherwise and stuck with this simpler
mode for now.

2. I did implement the approach you described - you can look at it
in my earlier versions of the patchset. But I withdrew the change,
since an update to the generic MSI code was needed, and it would be
hard to convince people to accept changes that nobody consumes.

3. If you aware of any hardware that is able sending multiple MSIs
while the condition holds true:
	# of ports <= # of allocated MSIs < # of available MSIs
...I can revive my changes and post it upstream.

> Besides that, would it be possible to tweak things so that
> /proc/interrupts could show distinct names for the individual
> IRQs?

I am not sure what do you mean here. Once a separate MSI vector is
allocated to a port (to anything in fact) it will show up in
/proc/interrupts as a distinct record.

> Thanks, Jan

HTH

> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
