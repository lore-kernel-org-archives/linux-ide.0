From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: Gigabyte GA-MA69VM-S2 can't do 64bit DMA
Date: Fri, 18 Sep 2009 09:17:37 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30010861B7@sshaexmb1.amd.com>
References: <4AAE8252.8000206@web.de> <4AAFE66D.8050807@gmail.com> <4AB0ADB2.8090009@web.de> <4AB0C2AD.6020503@gmail.com> <4AB2B463.4010408@web.de> <4AB2D7A1.8060909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:57701 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZIRBRw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 21:17:52 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4AB2D7A1.8060909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Holger Hasselmann <hhasselm@web.de>
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] 
> > 
> > ahci 0000:00:12.0: version 3.0_
> > ahci 0000:00:12.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> > ahci 0000:00:12.0: Fujitsu-Siemens AMILO Pa 2510: this 
> board can't do 64bit
> > DMA, forcing 32bit
> > ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
> > ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
> 0xf impl SATA mode
> > ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pmp pio slum part
> > It's correct now.
> 
> Cool, patch posted with the id string shortened.


Just some small questions about this topic:

What is the actual impact of 64-bit DMA not being available?
How important is it to have this enabled?

In other words, will the performance be improved significantly
after it is enabled? Do you have any experimental data for it? :-)


Thanks
Shane

