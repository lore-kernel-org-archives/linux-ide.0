From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Wed, 04 Apr 2012 09:39:24 +0200
Message-ID: <4F7BFAAC.9060307@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F0020698409E29@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:35034 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab2DDHje (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2012 03:39:34 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409E29@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On 2012-04-03 20:25, H Hartley Sweeten wrote:
>> +     /* allocate host */
>> +     host = ata_host_alloc(&pdev->dev, 1);
>> +     if (!host) {
>> +             err = -ENXIO;
>> +             goto err_rel_dma;
>> +     }
>> +
>> +     ep93xx_pata_clear_regs(ide_base);
>> +
>> +     host->n_ports = 1;
> 
> Just a question. Does the single port handle both devices that the ep93xx ide
> interface supports?

Yes, single port should handle both master and slave devices on one cable,
provided that ATA_FLAG_SLAVE_POSS is set in port flags:

>> +     host->private_data = drv_data;
>> +
>> +     ap = host->ports[0];
>> +     ap->dev = &pdev->dev;
>> +     ap->ops = &ep93xx_pata_port_ops;
>> +     ap->flags |= ATA_FLAG_SLAVE_POSS;

Btw, I noticed that host->n_ports is already set in ata_host_alloc, so I'll
remove unneeded line from the driver.

I just tested two disks on one cable, and it works correctly (my previous tests
were limited to only one disk or CF card).

Thanks,
RP
