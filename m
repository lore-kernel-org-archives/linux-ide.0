From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 26/30] Support for Marvell 7042 Chip
Date: Tue, 06 Mar 2007 08:10:02 -0500
Message-ID: <45ED682A.9040408@garzik.org>
References: <200703061038.l26AcBaO019542@shell0.pdx.osdl.net> <45ED5825.2000605@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54203 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934107AbXCFNKF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 08:10:05 -0500
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org

Morrison, Tom wrote:
> I have tested with generic 2.6.20.2 on on x86 (XEON)
> platform and a similiar (but not exactly same) 2.6.20.x 
> (git tree from Freescale) for my target CPU: MPC8548E
> 
> Its exactly the same SATA chip - the only difference
> between 7042 & 6042 is the PCI bridge interface.
> 
> In the case of 6042 - its a PCI to PCI Bridge
> In the case of 7042 - its a PCI to PCI Express Bridge
> 
> I do not believe there is any other difference - except
> the physical bus interface.
> 
> I should have 'said' this in the patch request...

Check the Marvell GPL driver and errata for the chip.  Grep for 'isPEX' 
to see all the PCI-Express-specific code and workarounds.  sata_mv does 
not have a lot of those, which was the reason why I only added the 6042 
PCI ID to the driver.

	Jeff



