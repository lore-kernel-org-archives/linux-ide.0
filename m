From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: BUG: INTx is assered unexpectly when unload AHCI driver with
 MSIx support.
Date: Wed, 6 Jul 2016 09:52:36 -0400
Message-ID: <20160706135236.GG3262@mtj.duckdns.org>
References: <HK2PR03MB173248BF420102DE4E54BD6EFC3A0@HK2PR03MB1732.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35308 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbcGFNwj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2016 09:52:39 -0400
Content-Disposition: inline
In-Reply-To: <HK2PR03MB173248BF420102DE4E54BD6EFC3A0@HK2PR03MB1732.apcprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pang Raymond <Raymond_rule@hotmail.com>
Cc: linux ide <linux-ide@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>

Hello,

(Can you please flow the text a bit below 80 column when you reply?)

On Wed, Jul 06, 2016 at 02:51:47AM +0000, Pang Raymond wrote:
> Why does the phenomenon appear?
> 	Two factors cause this problem.
> 		1. In MSIx's irq handler
> 		   (ahci_multi_irqs_intr_hard()), we do not clear
> 		   GHC.IS register which presents which ports need
> 		   interrupt service.  static irqreturn_t
> 		   ahci_multi_irqs_intr_hard(int irq, void
> 		   *dev_instance)
> 			{
> 				//  omitting unconcerned codes here
> 				// ...				
> 				// here we just clear PxIS register, not clear GHC.IS
> 				status = readl(port_mmio + PORT_IRQ_STAT);
> 				writel(status, port_mmio + PORT_IRQ_STAT);
> 				// ...
> 			}
> 		2. In PCI subsystem, after Disable MSIx, INTx is
>		   enabled automatically.
> 			void pci_msix_shutdown(struct pci_dev *dev)
> 			{
> 				// omitting unconcerned codes here
> 				// ...				
> 				// after Disable MSIx, enable INTx imediately
> 				pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> 				pci_intx_for_msi(dev, 1);
> 				dev->msix_enabled = 0;
> 				pcibios_alloc_irq(dev);
> 			}
>
> When Kernel enables INTx(I mean clearing PCI configure space
> Rx04.bit10), controller will find GHC.IS is not Zero (because driver
> haven't cleared GHC.IS after servicing MSIx interrupt), so it
> believes some SATA ports need interrupt servicing and asserts INTx
> interrupt.

Looks like you debugged the problem.  Care to write up and test a
patch?

Thanks a lot!

-- 
tejun
