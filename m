From: Darren Stevens <darren@stevens-zone.net>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Tue, 28 Mar 2017 09:24:42 +0100 (BST)
Message-ID: <49cdecb0846.6a8a0888@auth.smtp.1and1.co.uk>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <20170327175550.GB13353@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbdC1IcU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 04:32:20 -0400
In-Reply-To: <20170327175550.GB13353@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Markku Pesonen <tourula@gmail.com>, linux-ide@vger.kernel.org

Hello Tejun

On 27/03/2017, Tejun Heo wrote:
> From a431ecd2d459da3c91a612061f09eb422ffe78e2 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 27 Mar 2017 13:52:00 -0400
> Subject: [PATCH] Revert "pata_atiixp: Don't use unconnected secondary
>  port on SB600/SB700"
>
> This reverts commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8.
>
> The original commit's assumption that the secondary port is
> unconnected turns out to be false.

Not entirely. I based my patch on information in AMD's document
43366_sb7xx_bdg_pub_1.00.p



> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Markku Pesonen <tourula@gmail.com>
> Fixes: 5946fdaee4ba ("pata_atiixp: Don't use unconnected secondary port
> on SB600/SB700") Cc: Darren Stevens <darren@stevens-zone.net>
> ---
>  drivers/ata/pata_atiixp.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 6c9aa95..49d705c 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -278,11 +278,6 @@ static int atiixp_init_one(struct pci_dev *pdev,
>  const struct pci_device_id *id)  };
>   const struct ata_port_info *ppi[] = { &info, &info };
>  
> - /* SB600/700 don't have secondary port wired */
> - if ((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
> -     (pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
> -     ppi[1] = &ata_dummy_port_info;
> -
>   return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
>                     ATA_HOST_PARALLEL_SCAN);
>  }
Regards

