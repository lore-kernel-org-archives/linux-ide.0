From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Store irq number in struct ahci_host_priv
Date: Wed, 27 May 2015 14:14:15 -0400
Message-ID: <20150527181415.GS7099@htj.duckdns.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
 <1432713693-4282-3-git-send-email-rric@kernel.org>
 <20150527161603.GW10428@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33485 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbE0SOU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2015 14:14:20 -0400
Content-Disposition: inline
In-Reply-To: <20150527161603.GW10428@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Robert Richter <rric@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Wed, May 27, 2015 at 06:16:03PM +0200, Robert Richter wrote:
> From b50a5e478b8fce17603a91a5d272bb49527239af Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@cavium.com>
> Date: Tue, 12 May 2015 13:57:27 +0200
> Subject: [PATCH] ahci: Store irq number in struct ahci_host_priv
> 

Currently, ahci supports only msi and intx; however, msix support is
planned for ....

> The irq number for msix devices is taken from msi_list instead of
> pci_dev. Thus, the irq number of a device needs to be stored in struct
> ahci_host_priv now.  Host controller can be activated then in a
> generic way.

The above paragraph doesn't really explain why it needs to be moved to
host_priv, does it?  Can you please elaborate a bit further?

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1add5baec584..1c99402a1017 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2344,7 +2344,7 @@ static int ahci_port_start(struct ata_port *ap)
>  	/*
>  	 * Switch to per-port locking in case each port has its own MSI vector.
>  	 */
> -	if ((hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
> +	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {

This sort of cleanups are fine but please mention them in the patch
description.

Thanks.

-- 
tejun
