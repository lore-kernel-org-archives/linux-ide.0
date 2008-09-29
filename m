From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/1] pata_sil680: convert CONFIG_PPC_MERGE to CONFIG_PPC
Date: Mon, 29 Sep 2008 00:34:12 -0400
Message-ID: <48E05AC4.40405@garzik.org>
References: <200809222147.m8MLlXSa031665@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40939 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYI2EeS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:18 -0400
In-Reply-To: <200809222147.m8MLlXSa031665@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, galak@kernel.crashing.org, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, paulus@samba.org

akpm@linux-foundation.org wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
> powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
> CONFIG_PPC instead.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_sil680.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/ata/pata_sil680.c~pata_sil680-convert-config_ppc_merge-to-config_ppc drivers/ata/pata_sil680.c
> --- a/drivers/ata/pata_sil680.c~pata_sil680-convert-config_ppc_merge-to-config_ppc
> +++ a/drivers/ata/pata_sil680.c
> @@ -230,7 +230,7 @@ static u8 sil680_init_chip(struct pci_de
>  		tmpbyte & 1, tmpbyte & 0x30);
>  
>  	*try_mmio = 0;
> -#ifdef CONFIG_PPC_MERGE
> +#ifdef CONFIG_PPC
>  	if (machine_is(cell))
>  		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
>  #endif

applied


