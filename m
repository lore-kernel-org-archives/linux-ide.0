From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_svw: 0x0241 has 8 ports not 4
Date: Fri, 11 Apr 2008 18:24:31 -0400
Message-ID: <47FFE51F.3000906@garzik.org>
References: <47FD6574.8020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45219 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756233AbYDKWYf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Apr 2008 18:24:35 -0400
In-Reply-To: <47FD6574.8020202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, y_honda_@d1.dion.ne.jp, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Anantha Subramanyam <ananth@broadcom.com>

Tejun Heo wrote:
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
> 
> drivers/ata/sata_svw.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
> index 840d1c4..75c6853 100644
> --- a/drivers/ata/sata_svw.c
> +++ b/drivers/ata/sata_svw.c
> @@ -531,7 +531,7 @@ static int k2_sata_init_one(struct pci_dev *pdev, 
> const struct pci_device_id *en
>  * */
> static const struct pci_device_id k2_sata_pci_tbl[] = {
>     { PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
> -    { PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
> +    { PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
>     { PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
>     { PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
>     { PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },

This is wrong according to my docs.

Anantha, can you provide a definitive answer?

Does PCI ID 0x241 support 4 ports or 8 ports?

Thanks,

	Jeff



