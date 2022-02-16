Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8262C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 11:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiBPL3g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:29:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBPL3f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 06:29:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9DC2E49
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 03:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645010961; x=1676546961;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6Pi9faXXLdKFbZBss5nu6X52axtS0xEVYl0Kl8HLPOI=;
  b=hHqdFnv7yiJmbeZghqG5NCQVUxegEw3rKY3UPk5tkn0ctYy/T9zKtMr9
   saiM1BJHyGH9slY+Gy22bMKJDvmeEXS9zqTR9hCscLHhrpQb7qN6jKiOa
   Jy5Xx0CnOjw8WXT3OIT+L341wJ5d/GQcJotKmzfiqh6MZ04oP0lcjXna1
   KMKagvNFcE6H54shPddehMBUv77iX8FVm+x2wGpuc9eEA9UGsQuSksbjl
   XD4TN1MGGHsZnd9XVCT0vhy/Y46YAUT8uwSwcl7BaWymV8QAw5eemtQlM
   FiZXfY3l9LUJyeleGUtVGfxb4dbS0I8ZlAmspfIVNIrfWHcSLbHhFf8ZM
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="192023025"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 19:29:20 +0800
IronPort-SDR: eFbLWehpHAwerDr95/bSnPs+iNTSY9+ic42TKro92UmQTJsCUqQXiegpFmJczL8iH0MyeROQpy
 O+daaSozxtp1B8pdKD8nacxzDO3bwR2EzHxyNstIDRXatmbQZaXSsa5YkvXCWPLpWdAegwmdoO
 Hw/RUwkgR1HwKS/QGx6FvAzrx423UZpazp/0PGCgauLw6bR3oygOZx0isuZ81z4M47df/+g6WR
 V5d7rxhEvRYeWkD4IBWsKRzrFgEBJSnmDI2iNq9gLEYN7mX2borzbtKC6eTJlV6hy43/IV5OiN
 9vyYlS8Jn2ZXtUPcJGws+lWm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:01:00 -0800
IronPort-SDR: 3NHAz8aIk4wQ2aib2nwGKqTXCoZqA0qSGprMyphnUn7axNUKIbVg49h8LBfITm7EfSopm+2XtD
 538PVfRl19gn6vQAomkkcQGdw1YFW+7d6wmJHhIZRn4euUZoR6bO5Vz9kl+w7HMpGFGOCi0SXI
 IGXHPz6DBn81Soy5VuOi6Jx9T+NQ2DvDRwnxOYp7Kib1XHb6GwHI4OcyL3cBFMSV1kBk1Cqjg9
 UJPabPj9Id+YFI10PT8M6Gy2ISlHFobRWEnHRhJbNeunE9Hbt8wl6pufTPKmw+yGMETZwGbOSO
 hrY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 03:29:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzG283Gttz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2022 03:29:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645010960; x=1647602961; bh=6Pi9faXXLdKFbZBss5nu6X52axtS0xEVYl0
        Kl8HLPOI=; b=FebsP1i4bdrq1V2ti8GP/2f4Q0c1b4ukf80H0FyjXDQN5k5Ux5a
        XKXGibYAV9i/52fvxvv47BhqAQSkvgWMSef8B5sutnvRo6pXFrW+45eJjQGS1g0c
        L2o0vFp2wSRwTi5JNIjtF3O8uhI9l31KCv5xeGfjLJl4D/rE+jdPVGH98KJPOvn6
        Ri3lxjuvwvVFU6Wkn4r39waKxaT6MByvmI7dbdp9rPsqwMd24ykV3AG59uuVnorJ
        vf4VUtyHMQr2fZ3UXPUtOFtc4fpedGLsbs/F3oRx9aZR89BpLGOjc9q5vJSRZjdL
        CbKcUeg6PsRJwneHyCY1T3hYjHq2L0/LpUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XX-DRuT1dYPW for <linux-ide@vger.kernel.org>;
        Wed, 16 Feb 2022 03:29:20 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzG2755wSz1Rwrw;
        Wed, 16 Feb 2022 03:29:19 -0800 (PST)
Message-ID: <0303c512-9193-3d4d-3db7-6ecf391948de@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 20:29:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: merge mode setting methods
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4e5e9ea0-f7ac-025a-f94f-a4f0ee009420@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/16/22 20:24, Sergey Shtylyov wrote:
> After commit e0afcf140e6e ("ata: pata_hpt37x: disable fast interrupts in
> prereset() method") HPT370's and HPT372+'s PIO/DMA mode setting functions
> have become identical -- merge them.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/pata_hpt37x.c |   71 +++++++---------------------------------------
>  1 file changed, 11 insertions(+), 60 deletions(-)
> 
> Index: libata/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_hpt37x.c
> +++ libata/drivers/ata/pata_hpt37x.c
> @@ -23,7 +23,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"pata_hpt37x"
> -#define DRV_VERSION	"0.6.24"
> +#define DRV_VERSION	"0.6.25"
>  
>  struct hpt_clock {
>  	u8	xfer_speed;
> @@ -420,7 +420,7 @@ static int hpt37x_pre_reset(struct ata_l
>  	return ata_sff_prereset(link, deadline);
>  }
>  
> -static void hpt370_set_mode(struct ata_port *ap, struct ata_device *adev,
> +static void hpt37x_set_mode(struct ata_port *ap, struct ata_device *adev,
>  			    u8 mode)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> @@ -449,9 +449,9 @@ static void hpt370_set_mode(struct ata_p
>   *	Perform PIO mode setup.
>   */
>  
> -static void hpt370_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +static void hpt37x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  {
> -	hpt370_set_mode(ap, adev, adev->pio_mode);
> +	hpt37x_set_mode(ap, adev, adev->pio_mode);
>  }
>  
>  /**
> @@ -462,9 +462,9 @@ static void hpt370_set_piomode(struct at
>   *	Set up the channel for MWDMA or UDMA modes.
>   */
>  
> -static void hpt370_set_dmamode(struct ata_port *ap, struct ata_device *adev)
> +static void hpt37x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  {
> -	hpt370_set_mode(ap, adev, adev->dma_mode);
> +	hpt37x_set_mode(ap, adev, adev->dma_mode);
>  }
>  
>  /**
> @@ -504,54 +504,6 @@ static void hpt370_bmdma_stop(struct ata
>  	ata_bmdma_stop(qc);
>  }
>  
> -static void hpt372_set_mode(struct ata_port *ap, struct ata_device *adev,
> -			    u8 mode)
> -{
> -	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> -	int addr = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
> -	u32 reg, timing, mask;
> -
> -	/* Determine timing mask and find matching mode entry */
> -	if (mode < XFER_MW_DMA_0)
> -		mask = 0xcfc3ffff;
> -	else if (mode < XFER_UDMA_0)
> -		mask = 0x31c001ff;
> -	else
> -		mask = 0x303c0000;
> -
> -	timing = hpt37x_find_mode(ap, mode);
> -
> -	pci_read_config_dword(pdev, addr, &reg);
> -	reg = (reg & ~mask) | (timing & mask);
> -	pci_write_config_dword(pdev, addr, reg);
> -}
> -
> -/**
> - *	hpt372_set_piomode		-	PIO setup
> - *	@ap: ATA interface
> - *	@adev: device on the interface
> - *
> - *	Perform PIO mode setup.
> - */
> -
> -static void hpt372_set_piomode(struct ata_port *ap, struct ata_device *adev)
> -{
> -	hpt372_set_mode(ap, adev, adev->pio_mode);
> -}
> -
> -/**
> - *	hpt372_set_dmamode		-	DMA timing setup
> - *	@ap: ATA interface
> - *	@adev: Device being configured
> - *
> - *	Set up the channel for MWDMA or UDMA modes.
> - */
> -
> -static void hpt372_set_dmamode(struct ata_port *ap, struct ata_device *adev)
> -{
> -	hpt372_set_mode(ap, adev, adev->dma_mode);
> -}
> -
>  /**
>   *	hpt37x_bmdma_stop		-	DMA engine stop
>   *	@qc: ATA command
> @@ -589,8 +541,8 @@ static struct ata_port_operations hpt370
>  
>  	.mode_filter	= hpt370_filter,
>  	.cable_detect	= hpt37x_cable_detect,
> -	.set_piomode	= hpt370_set_piomode,
> -	.set_dmamode	= hpt370_set_dmamode,
> +	.set_piomode	= hpt37x_set_piomode,
> +	.set_dmamode	= hpt37x_set_dmamode,
>  	.prereset	= hpt37x_pre_reset,
>  };
>  
> @@ -604,8 +556,7 @@ static struct ata_port_operations hpt370
>  };
>  
>  /*
> - *	Configuration for HPT371 and HPT302. Slightly different PIO and DMA
> - *	mode setting functionality.
> + *	Configuration for HPT371 and HPT302.

Shouldn't this be HPT372 ?

>   */
>  
>  static struct ata_port_operations hpt302_port_ops = {
> @@ -614,8 +565,8 @@ static struct ata_port_operations hpt302
>  	.bmdma_stop	= hpt37x_bmdma_stop,
>  
>  	.cable_detect	= hpt37x_cable_detect,
> -	.set_piomode	= hpt372_set_piomode,
> -	.set_dmamode	= hpt372_set_dmamode,
> +	.set_piomode	= hpt37x_set_piomode,
> +	.set_dmamode	= hpt37x_set_dmamode,
>  	.prereset	= hpt37x_pre_reset,
>  };
>  


-- 
Damien Le Moal
Western Digital Research
