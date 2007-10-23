From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 06:01:17 -0400
Message-ID: <471DC66D.6000909@garzik.org>
References: <Pine.LNX.4.64.0710221555190.32497@iabervon.org>	<471D0ADC.7000005@garzik.org>	<Pine.LNX.4.64.0710221700120.32497@iabervon.org> <20071022.171318.104036671.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55479 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbXJWKB1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 06:01:27 -0400
In-Reply-To: <20071022.171318.104036671.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com

David Miller wrote:
> My suggestion is:
> 
> 1) Leave the pci_intx() twiddling code in drivers/pci/msi.c
> 
> 2) Add quirks for "INTX_DISABLE turns off MSI too", this sets
>    a flag in the pci_dev.
> 
> 3) The pci_intx() calls in drivers/pci/msi.c are skipped if this
>    flag from #2 is set.
> 
> 4) Add quirk entries for drivers/net/tg3.c chips and these SATA
>    devices we are learning about here, as well as any others we
>    are aware of right now.
> 
> 5) Remove the pci_intx() workaround code from drivers/net/tg3.c
>    and elsewhere.


Sounds good to me also.

	Jeff


