From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 2/5] ata: ahci_imx: avoid reprobing ahci_imx driver
	when using DT
Date: Thu, 17 Apr 2014 19:37:59 +0100
Message-ID: <20140417183759.GR24070@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk> <E1WaLRK-0002yJ-T1@rmk-PC.arm.linux.org.uk> <20140417084543.GB22160@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:38830 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751110AbaDQSiq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 14:38:46 -0400
Content-Disposition: inline
In-Reply-To: <20140417084543.GB22160@dragon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 04:45:44PM +0800, Shawn Guo wrote:
> On Wed, Apr 16, 2014 at 09:43:30AM +0100, Russell King wrote:
> > Avoid matching our child platform device, which can happen as we copy the
> > DT node to the child device.  This allows the child platform device to be
> > matched against the ahci-imx driver and should this happen, it will cause
> > another platform device to be allocated, resulting in failure.
> 
> This is not the case anymore, since commit 90870d7 (ahci-imx: Port to
> library-ised ahci_platform) is merged into v3.15-rc1.

Thanks, I've moved this patch.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
