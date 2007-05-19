From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pata_sil680: compile fix
Date: Sun, 20 May 2007 06:57:33 +1000
Message-ID: <1179608253.32247.481.camel@localhost.localdomain>
References: <464ED193.2020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57424 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758660AbXESU5l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 16:57:41 -0400
In-Reply-To: <464ED193.2020805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 2007-05-19 at 12:29 +0200, Tejun Heo wrote:
> Recent mmio change broke compilation if PM is turned on.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Oops.. sorry about that.

Cheers,
Ben.

> ---
>  pata_sil680.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 557a37b..89f59d1 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -431,7 +431,9 @@ use_ioports:
>  #ifdef CONFIG_PM
>  static int sil680_reinit_one(struct pci_dev *pdev)
>  {
> -	sil680_init_chip(pdev);
> +	int try_mmio;
> +
> +	sil680_init_chip(pdev, &try_mmio);
>  	return ata_pci_device_resume(pdev);
>  }
>  #endif

