From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 17:39:22 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A507055D91AE@sshaexmb1.amd.com>
References: <Pine.LNX.4.64.0710221555190.32497@iabervon.org>
 <471D0ADC.7000005@garzik.org>
 <Pine.LNX.4.64.0710221700120.32497@iabervon.org>
 <20071022.171318.104036671.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:39316 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574AbXJWJsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 05:48:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20071022.171318.104036671.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, barkalow@iabervon.org
Cc: jeff@garzik.org, linas@austin.ibm.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, Shane Huang <Shane.Huang@amd.com>

Hi David:

> I think this pretty much sums up the situation accurately.
> 
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

This quirk seems good to me. Waiting for your final decision....

This SB700 SATA controller MSI/INTx problem has been reported to our
hardware team. I will forward the update information or response to
you when I get any from HW team.


Thanks
Shane



