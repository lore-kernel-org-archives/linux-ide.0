From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: hpt366: fix constant cast warning
Date: Wed, 20 May 2015 13:18:47 +0200
Message-ID: <1603711.yg6aGn68IJ@amdc1976>
References: <2549322.XbiTlcDvMS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42834 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbbETLTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2015 07:19:43 -0400
In-reply-to: <2549322.XbiTlcDvMS@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi,

On Tuesday, May 19, 2015 04:34:05 PM Arnd Bergmann wrote:
> gcc-5.x warns about a preexisting problem in the hpt36x pata driver:
> 
> drivers/ata/pata_hpt366.c: In function 'hpt36x_init_one':
> drivers/ata/pata_hpt366.c:376:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-array-qualifiers]
> 
> Other ata drivers have the same problem, as ata_pci_bmdma_init_one
> takes a non-const pointer, and they solve it by using a cast to
> turn that pointer into a normal non-const pointer.
> 
> I also tried to change the ata core code to make host->private_data
> a const pointer, but that quickly got out of hand, as some other
> drivers expect it to be writable, so I ended up using the same
> hack as the others here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Your patch looks fine to me, thanks.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
> index cbc3de793d1d..0038dc4c06c7 100644
> --- a/drivers/ata/pata_hpt366.c
> +++ b/drivers/ata/pata_hpt366.c
> @@ -352,7 +352,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  	};
>  	const struct ata_port_info *ppi[] = { &info_hpt366, NULL };
>  
> -	void *hpriv = NULL;
> +	const void *hpriv = NULL;
>  	u32 reg1;
>  	int rc;
>  
> @@ -383,7 +383,7 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		break;
>  	}
>  	/* Now kick off ATA set up */
> -	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, hpriv, 0);
> +	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, (void *)hpriv, 0);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

