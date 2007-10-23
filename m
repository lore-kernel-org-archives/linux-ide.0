From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 06:13:49 -0400
Message-ID: <471DC95D.2060501@garzik.org>
References: <BLU112-W5125F6D8BEB3DF6359D53E29F0@phx.gbl>	<20071019195749.GK29903@austin.ibm.com> <471911BE.2000405@garzik.org>	<Pine.LNX.4.64.0710221555190.32497@iabervon.org>	<471D0ADC.7000005@garzik.org> <m3ejfmu3a5.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50778 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbXJWKN5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 06:13:57 -0400
In-Reply-To: <m3ejfmu3a5.fsf@maximus.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Linas Vepstas <linas@austin.ibm.com>, Shane Huang <chunhao.huang@hotmail.com>, davem@davemloft.net, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, Brice Goglin <brice@myri.com>

Krzysztof Halasa wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> Note that INTX_DISABLE is a recent addition to PCI.
> 
> It's PCI 2.3.

Yes.


>>  Older PCI devices
>> support neither MSI nor INTX-disable, so make sure such devices don't
>> creep into your sample.
> 
> MSI has been introduced by PCI 2.2 (and thus PCI-X 1.0) so there may
> be devices with MSI but without INTx-disable bit. I guess I have some
> early PCI-X hardware with MSI but I don't know if they have INTx-disable
> bit and I can't currently test that.
> And it probably doesn't matter.

Time will tell :)


>> In general it is documented that INTX_DISABLE should apply only to
>> INTx# so devices that disable MSI based on that bit are out of spec.
> 
> The wording is:
> 10: This bit disables the device from asserting INTx#. A value of 0
> enables the assertion of its INTx# signal. A value of 1 disables the
> assertion of its INTx# signal. This bit's state after RST# is 0. Refer
> to Section 6.8.1.3 for control of MSI.
> 
> So strictly speaking it mandates disabling/enabling INTx but says
> nothing about other things (e.g. MSI). Some common sense dictates
> it shouldn't disable MSI, I guess.
> 
> The "MSI Enable" description doesn't leave any doubt:
> 0: MSI Enable: If 1, the function is permitted to use MSI to request
> service and is prohibited from using its INTx# pin [...]

Right.  I was merely describing the end result, the union of that 
language as it applies to the kernel.

	Jeff


