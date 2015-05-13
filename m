From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Wed, 13 May 2015 13:46:40 -0400
Message-ID: <20150513174640.GZ11388@htj.duckdns.org>
References: <20150513143353.GU11388@htj.duckdns.org>
 <20150513143906.GV11388@htj.duckdns.org>
 <20150513172828.GA8449@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34241 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbbEMRqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2015 13:46:44 -0400
Content-Disposition: inline
In-Reply-To: <20150513172828.GA8449@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexander Gordeev <agordeev@redhat.com>

Hello, Robert.

On Wed, May 13, 2015 at 07:28:28PM +0200, Robert Richter wrote:
> > > This looks not very useful to do. Since irq is used only a single
> > > time, there is no reason to store it in the host's data structure. It
> > 
> > Doesn't really matter tho.
> 
> Since ahci_host_activate() is EXPORT_SYMBOL_GPL I really have concerns
> changing the i/f. But I will send you a patch for this.

It doesn't matter.  Please go ahead and change it.

> > Let's start with why we're doing this in the first place.
> 
> Right, the sata controller is connected to a pci ecam controller, both
> are on an SoC together with the processor. There are no external pci
> ports for the connection of external devices. Since all pci devices on
> the chip support msi-x, the controller is only capable to handle this
> and not INTx nor MSI. So for enabling of the sata hc we need msix
> support.

I see.  If you can get hold of an ahci controller which actually can
do multi-irq msix, it'd be the best.  If not, let's make it super
clear that this is a special case and use it as the last resort (which
also clers up the warning issue).

Thanks.

-- 
tejun
