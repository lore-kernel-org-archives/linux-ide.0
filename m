From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 06:15:03 -0400
Message-ID: <471DC9A7.3080105@garzik.org>
References: <BLU112-W5125F6D8BEB3DF6359D53E29F0@phx.gbl> <20071019195749.GK29903@austin.ibm.com> <471911BE.2000405@garzik.org> <Pine.LNX.4.64.0710221555190.32497@iabervon.org> <471D0ADC.7000005@garzik.org> <Pine.LNX.4.64.0710221700120.32497@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50810 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbXJWKPN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 06:15:13 -0400
In-Reply-To: <Pine.LNX.4.64.0710221700120.32497@iabervon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, Shane Huang <chunhao.huang@hotmail.com>, davem@davemloft.net, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, Brice Goglin <brice@myri.com>

Daniel Barkalow wrote:
> I have a device that supports MSI and INTX-disable, and, with MSI on (and 
> delivering interrupts successfully) also sends legacy interrupts (on 
> the IRQ that is no longer associated with the device) unless INTX is 
> disabled. Without the intx_disable(), the kernel disables the IRQ 
> entirely and breaks a random other device in my system.


That sort of behavior is an example of why I wrote pci_intx() in the 
first place, and employed it by default throughout the ATA drivers 
(before it migrated into PCI core).

	Jeff


