From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4]: Resolve MSI vs. INTX_DISABLE quirks.
Date: Tue, 23 Oct 2007 22:06:22 -0700 (PDT)
Message-ID: <20071023.220622.68038077.davem@davemloft.net>
References: <20071023.195108.69018458.davem@davemloft.net>
	<Pine.LNX.4.64.0710240046220.32497@iabervon.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47041
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753956AbXJXFGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 01:06:38 -0400
In-Reply-To: <Pine.LNX.4.64.0710240046220.32497@iabervon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: barkalow@iabervon.org
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com

From: Daniel Barkalow <barkalow@iabervon.org>
Date: Wed, 24 Oct 2007 00:58:45 -0400 (EDT)

> I'm not sure all of the pci_intx() calls in msi.c should be skipped when 
> the quirk applies; I think some of them might be there so that the legacy 
> interrupt won't be delivered while MSI is turned off (since the handler 
> isn't listening for the legacy interrupts). I'd guess this would cause 
> people to have their MSI-capable device kill their non-MSI-capable device 
> when they restore their laptop (and the shared interrupt fires and gets 
> stuck at just the wrong time). No idea if this is a real concern, but I'm 
> pretty sure that not all of those calls are recent.

I don't think it's a real concern.

> There's a couple of ATA drivers that look like they might be trying to 
> work around the same bug, but it's a bit hard to tell. It might be good to 
> have them use the quirk (or set the flag) because it's cleaner.

I noticed these cases as well, and I would hope that Jeff would help
out here using the infrastructure my patches created.
