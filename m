From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] non-existant config in kernel source (CONFIG_AHCI)
Date: Fri, 5 Feb 2010 14:57:00 +0100
Message-ID: <201002051457.04135.elendil@planet.nl>
References: <20100205132959.GB6874@faui49.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:62574 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932621Ab0BEN5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2010 08:57:06 -0500
In-reply-To: <20100205132959.GB6874@faui49.informatik.uni-erlangen.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
Cc: jgarzik@pobox.com, knan-lkml@anduin.net, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de, alan@lxorguk.ukuu.org.uk

Christoph Egger wrote:
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -147,7 +147,7 @@ static int marvell_init_one (struct pci_dev *pdev,
> 	if (pdev->device == 0x6101)
>		ppi[1] = &ata_dummy_port_info;
> 
> -#if defined(CONFIG_AHCI) || defined(CONFIG_AHCI_MODULE)
> +#if defined(CONFIG_SATA_AHCI) || defined(SATA_CONFIG_AHCI_MODULE)

Shouldn't the last be CONFIG_SATA_AHCI_MODULE ?

Cheers,
FJP
