From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: BUG: INTx is assered unexpectly when unload AHCI driver with
 MSIx support.
Date: Mon, 18 Jul 2016 18:28:03 -0400
Message-ID: <20160718222803.GK3078@mtj.duckdns.org>
References: <HK2PR03MB173248BF420102DE4E54BD6EFC3A0@HK2PR03MB1732.apcprd03.prod.outlook.com>
 <20160706135236.GG3262@mtj.duckdns.org>
 <HK2PR03MB1732DE50EA9D44F23481968AFC3F0@HK2PR03MB1732.apcprd03.prod.outlook.com>
 <20160712173003.GM3190@htj.duckdns.org>
 <HK2PR03MB1732E094DCB79C7EF0F5C1B4FC330@HK2PR03MB1732.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35810 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcGRW2S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2016 18:28:18 -0400
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1732E094DCB79C7EF0F5C1B4FC330@HK2PR03MB1732.apcprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pang Raymond <Raymond_rule@hotmail.com>
Cc: linux ide <linux-ide@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>

Hello, Pang.

On Fri, Jul 15, 2016 at 12:39:59PM +0000, Pang Raymond wrote:
> Hi Tejun,
> 
> 
> Yes! It only happens when the device is shutdown.
> 
> I think you're right. It's more wiser to add clearing operation to driver
> 
> clean up path.
> 
> So we can add it to ahci_port_stop()
> 
> 
> libahci.c is got from Kernel 4.6.3 stable
> 
> ============================================================
> 
> --- drivers/ata/libahci.c.old 2016-07-15 13:33:47.489620405 +0800
> +++ drivers/ata/libahci.c 2016-07-15 14:01:33.081574586 +0800
> @@ -2392,12 +2392,18 @@
> static void ahci_port_stop(struct ata_port *ap)
> {
>   const char *emsg = NULL;
> + struct ahci_host_priv *hpriv = ap->host->private_data;
> + void __iomem *host_mmio = hpriv->mmio;
>   int rc;
> 
>   /* de-initialize port */
>   rc = ahci_deinit_port(ap, &emsg);
>   if (rc)
>    ata_port_warn(ap, "%s (%d)\n", emsg, rc);
> +
> + /* Clear GHC.IS in case of asserting INTx after disable MSIx and re-enable INTx */
> + writel(1 << ap->port_no, host_mmio + HOST_IRQ_STAT);
> +
> }

Yeah, this looks good to me.  Can you please format the patch
properly, add description and Signed-off-by?

  https://www.kernel.org/doc/Documentation/SubmittingPatches

Thanks.

-- 
tejun
