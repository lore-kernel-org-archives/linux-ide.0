From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBCVUc6IElOVHggaQ==?= =?utf-8?Q?s?= assered
 unexpectly when unload AHCI driver with MSIx support.
Date: Tue, 12 Jul 2016 13:30:03 -0400
Message-ID: <20160712173003.GM3190@htj.duckdns.org>
References: <HK2PR03MB173248BF420102DE4E54BD6EFC3A0@HK2PR03MB1732.apcprd03.prod.outlook.com>
 <20160706135236.GG3262@mtj.duckdns.org>
 <HK2PR03MB1732DE50EA9D44F23481968AFC3F0@HK2PR03MB1732.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35719 "EHLO
	mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbcGLRaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 13:30:11 -0400
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1732DE50EA9D44F23481968AFC3F0@HK2PR03MB1732.apcprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pang Raymond <Raymond_rule@hotmail.com>
Cc: linux ide <linux-ide@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>

Hello,

On Mon, Jul 11, 2016 at 05:16:00AM +0000, Pang Raymond wrote:
> static irqreturn_t  ahci_multi_irqs_intr_hard(int irq,
> void *dev_instance)
> {
>       //  omitting unconcerned codes here
>       //  ...
>            status = readl(port_mmio + PORT_IRQ_STAT);
>            writel(status, port_mmio + PORT_IRQ_STAT);
> 
>       // add patch code here.
> +         writel(1 << ap->port_no, ap->host->iomap + HOST_IRQ_STAT);
> 
>       // ...

I think it'd be better to avoid adding stuff to the hot path.  This
only matters when the device is shut down, right?  Can't it just be
cleared in the driver cleanup path?

Thanks.

-- 
tejun
