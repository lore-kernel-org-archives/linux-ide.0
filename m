From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv: problems using it as a platform_driver
Date: Tue, 12 Feb 2008 10:31:24 +0900
Message-ID: <47B0F6EC.90301@gmail.com>
References: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk> <alpine.DEB.1.00.0802080217070.16853@git.byronbradley.co.uk> <47ABDDBE.4060607@rtr.ca> <47B04F05.4060505@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:7042 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbYBLBbf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 20:31:35 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4965690wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 17:31:34 -0800 (PST)
In-Reply-To: <47B04F05.4060505@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: Mark Lord <liml@rtr.ca>, Byron Bradley <byron.bbradley@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, mlord@pobox.com

Saeed Bishara wrote:
>>>      host->private_data = hpriv;
>>>      hpriv->n_ports = n_ports;
>>>
>>> -    host->iomap = NULL;
>>>      hpriv->base = ioremap(res->start, res->end - res->start + 1);
>>> +    host->iomap = &hpriv->base;
>>>      hpriv->base -= MV_SATAHC0_REG_BASE;
>>>
>>>      rc = mv_create_dma_pools(hpriv, &pdev->dev);
>> ..
>>
>> Well, that's definitely one way to attack it.
> the fix better be done by using the hpriv->base instead of iomap table:
>                  void __iomem *hc_mmio = mv_hc_base_from_port(
> -                               ap->host->iomap[MV_PRIMARY_BAR], hard_port);
> +                                       mv_host_base(ap->host), hard_port);
>                 u32 hc_irq_cause, ipending;

Yeah, that's the right thing to do.

>> The original problem being, for a non-PCI device, there is no iomap[]
>> table.
>> sata_mv only ever uses iomap[MV_PRIMARY_BAR=0], so the above patch should
>> work around it just fine.
> Jeff, do the libata upper drivers use the other BARs? if not, then we can use pci_iomap to map BAR0, this way we can remove the iomap[] table and use one iomem pointer for pci and none-pci devices. 

libata core layer _never_ touches those device specific stuff.  Using
iomap directly is just a convenient way to access the address without
adding host private data for PCI controllers.  If it doesn't fit, the
correct thing to do is to add proper host private data.

Thanks.

-- 
tejun
