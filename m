From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] sata_svw: 0x0241 has 8 ports not 4
Date: Thu, 10 Apr 2008 11:21:38 +1000
Message-ID: <1207790498.12357.25.camel@pasglop>
References: <47FD6574.8020202@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56939 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbYDJBWA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Apr 2008 21:22:00 -0400
In-Reply-To: <47FD6574.8020202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, y_honda_@d1.dion.ne.jp


On Thu, 2008-04-10 at 09:55 +0900, Tejun Heo wrote:
> From: Yohei Honda <y_honda_@d1.dion.ne.jp>
> 
> 0x0241 has 8 ports not 4.
> 
> Reported by Yohei Honda on kernel bz 10424.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Benjamin, can you please verify this is correct?

I can't as I don't have any spec for these... All I can say is that the
Apple one has 4 ports and is is 0x0240.

So If you are reasonably confident the 0x0241 has 8, then feel free to
apply the patch.

Cheers,
Ben.

>  drivers/ata/sata_svw.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
> index 840d1c4..75c6853 100644
> --- a/drivers/ata/sata_svw.c
> +++ b/drivers/ata/sata_svw.c
> @@ -531,7 +531,7 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
>   * */
>  static const struct pci_device_id k2_sata_pci_tbl[] = {
>  	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
> -	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
> +	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
>  	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
>  	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
>  	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },

