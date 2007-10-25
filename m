From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/4]: Resolve MSI vs. INTX_DISABLE quirks.
Date: Thu, 25 Oct 2007 01:37:47 -0400
Message-ID: <47202BAB.2040709@garzik.org>
References: <20071023.195108.69018458.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49546 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbXJYFhz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 01:37:55 -0400
In-Reply-To: <20071023.195108.69018458.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

David Miller wrote:
> The forthcoming patches are also available from:
> 
> 	kernel.org:/pub/scm/linux/kernel/git/davem/msiquirk-2.6.git
> 
> and clean up the handling of the common quirk wherein setting
> INTX_DISABLE will mistakedly disable MSI generation for some
> devices.
> 
> For devices without that problem, we want to keep the pci_intx() calls
> in drivers/pci/msi.c because those help protect against devices
> with the opposite problem.  Such devices always generate INTX
> interrupts even when MSI is enabled, unless INTX_DISABLE is set.
> 
> Michael, please pay special attention to patch #3.  I think I
> picked the correct PCI device IDs to match for the quirk
> (5714* and 5780*) but it's possible we might need more elaborate
> checks here.  It at least worked properly for the chips in my
> Niagara system.
> 
> In addition to the Tigon3 cases, I added quirk entries for the
> SB700/800 SATA chips and the IXP SB400 USB controllers.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

I'm happy with this patch series.  A quirk is better than a 
sledgehammer, and MSI-mode SATA is better than INTX-mode SATA :)

	Jeff



