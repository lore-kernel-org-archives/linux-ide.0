From: Saeed Bishara <saeed@marvell.com>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Mon, 11 Feb 2008 08:35:01 -0500
Message-ID: <47B04F05.4060505@marvell.com>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk> <alpine.DEB.1.00.0802080217070.16853@git.byronbradley.co.uk> <47ABDDBE.4060607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:19187 "EHLO
	il.marvell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbYBKLnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 06:43:55 -0500
In-Reply-To: <47ABDDBE.4060607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Byron Bradley <byron.bbradley@gmail.com>, jeff@garzik.org
Cc: linux-ide@vger.kernel.org, mlord@pobox.com

>>      host->private_data = hpriv;
>>      hpriv->n_ports = n_ports;
>>
>> -    host->iomap = NULL;
>>      hpriv->base = ioremap(res->start, res->end - res->start + 1);
>> +    host->iomap = &hpriv->base;
>>      hpriv->base -= MV_SATAHC0_REG_BASE;
>>
>>      rc = mv_create_dma_pools(hpriv, &pdev->dev);
> ..
> 
> Well, that's definitely one way to attack it.
the fix better be done by using the hpriv->base instead of iomap table:
                 void __iomem *hc_mmio = mv_hc_base_from_port(
-                               ap->host->iomap[MV_PRIMARY_BAR], hard_port);
+                                       mv_host_base(ap->host), hard_port);
                u32 hc_irq_cause, ipending;
 
> 
> The original problem being, for a non-PCI device, there is no iomap[]
> table.
> sata_mv only ever uses iomap[MV_PRIMARY_BAR=0], so the above patch should
> work around it just fine.
Jeff, do the libata upper drivers use the other BARs? if not, then we can use pci_iomap to map BAR0, this way we can remove the iomap[] table and use one iomem pointer for pci and none-pci devices. 

Saeed
