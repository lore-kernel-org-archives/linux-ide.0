Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404CEE14C3
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 21:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbjIFVSd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjIFVSa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 17:18:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259539C
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 14:18:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD36C433C7;
        Wed,  6 Sep 2023 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694035106;
        bh=ZteqX/Rd6siPGcxIApGcEIniu+yYh6Bv1BLBKGKWPMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aLravx5UDpK2Lx1wg+qoNy89aehgR9Bm9elnvhHVEPNNCIo4wehXSPl9bjJXaj5mx
         CtgeB7UNRYCY+eXTfJPlPbp7xVXc2OluMKSLoQu2hPF4mrwZ24keTsrMnJDsg0RPrR
         5F0lTVxeAwbw1W6fS1HhXOzzWF/UCLI6Vcu+x6kOZyYWhxvZWodMal2t3IX+WwHHTM
         UhwGFcsHwCrFrMdzBKkYGwGPLQJONWDI9y1M6ahlggDTgXoYoKsmfj7ESUG+htBWvC
         dfKRvLSkmDbYDTyPWtS/wSf85df0Bqivj7ZxmTkBU5QUeaHM0kcGQj1FB3eo4OwELG
         Qf1umsIWWBsfA==
Message-ID: <8413f930-6fac-d4ae-903b-570d9acc9dcf@kernel.org>
Date:   Thu, 7 Sep 2023 06:18:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ata: ahci: print the lpm policy on boot
To:     Niklas Cassel <nks@flawful.org>
Cc:     linux-ide@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230906092232.3396200-1-nks@flawful.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230906092232.3396200-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/6/23 18:22, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The target LPM policy can be set using either a Kconfig or a kernel module
> parameter.
> 
> However, if the board type is set to anything but board_ahci_low_power,
> then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
> 
> Additionally, if the default suspend is suspend to idle, depending on the
> hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
> override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
> ATA_LPM_MIN_POWER.
> 
> All this means that it is very hard to know which LPM policy a user will
> actually be using on a given system.
> 
> In order to make it easier to debug LPM related issues, print the LPM
> policy on boot.
> 
> One common LPM related issue is that the device fails to link up.
> Because of that, we cannot add this print to ata_dev_configure(), as that
> function is only called after a successful link up. Instead, add the info
> using ata_port_desc(), with the help of a new ata_port_desc_misc() helper.
> The port description is printed once per port during boot.
> 
> Before changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> 
> After changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170 lpm-pol 4
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170 lpm-pol 4
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

I am confused... Why not simply:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cfb5e6bd03f7..194cf4fcb9bb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5945,6 +5945,7 @@ int ata_host_register(struct ata_host *host, const struct
scsi_host_template *sh
                                              ap->udma_mask);

                if (!ata_port_is_dummy(ap)) {
+                       ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
                        ata_port_info(ap, "%cATA max %s %s\n",
                                      (ap->flags & ATA_FLAG_SATA) ? 'S' : 'P',
                                      ata_mode_string(xfer_mask),

?

> ---
> V1 -> V2: Moved the lpm-pol print after the irq print. Added a new helper,
> ata_port_desc_misc(), to help with this.
> 
>  drivers/ata/libahci.c     |  2 +-
>  drivers/ata/libata-core.c |  2 +-
>  drivers/ata/libata-sff.c  | 10 +++++-----
>  drivers/ata/pata_cs5520.c |  2 +-
>  include/linux/libata.h    |  5 +++++
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index e2bacedf28ef..5354571a3105 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2719,7 +2719,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
>  
>  		if (rc)
>  			return rc;
> -		ata_port_desc(host->ports[i], "irq %d", irq);
> +		ata_port_desc_misc(host->ports[i], irq);
>  	}
>  
>  	return ata_host_register(host, sht);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 74314311295f..715a8fb6c3e6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5923,7 +5923,7 @@ int ata_host_activate(struct ata_host *host, int irq,
>  		return rc;
>  
>  	for (i = 0; i < host->n_ports; i++)
> -		ata_port_desc(host->ports[i], "irq %d", irq);
> +		ata_port_desc_misc(host->ports[i], irq);
>  
>  	rc = ata_host_register(host, sht);
>  	/* if failed, just free the IRQ and leave ports alone */
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 8fcc622fcb3d..95a19c4ef2a1 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2316,7 +2316,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
>  		for (i = 0; i < 2; i++) {
>  			if (ata_port_is_dummy(host->ports[i]))
>  				continue;
> -			ata_port_desc(host->ports[i], "irq %d", pdev->irq);
> +			ata_port_desc_misc(host->ports[i], pdev->irq);
>  		}
>  	} else if (legacy_mode) {
>  		if (!ata_port_is_dummy(host->ports[0])) {
> @@ -2326,8 +2326,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
>  			if (rc)
>  				goto out;
>  
> -			ata_port_desc(host->ports[0], "irq %d",
> -				      ATA_PRIMARY_IRQ(pdev));
> +			ata_port_desc_misc(host->ports[0],
> +					   ATA_PRIMARY_IRQ(pdev));
>  		}
>  
>  		if (!ata_port_is_dummy(host->ports[1])) {
> @@ -2337,8 +2337,8 @@ int ata_pci_sff_activate_host(struct ata_host *host,
>  			if (rc)
>  				goto out;
>  
> -			ata_port_desc(host->ports[1], "irq %d",
> -				      ATA_SECONDARY_IRQ(pdev));
> +			ata_port_desc_misc(host->ports[1],
> +					   ATA_SECONDARY_IRQ(pdev));
>  		}
>  	}
>  
> diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
> index 422d42761a1d..38795508c2e9 100644
> --- a/drivers/ata/pata_cs5520.c
> +++ b/drivers/ata/pata_cs5520.c
> @@ -212,7 +212,7 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  		if (rc)
>  			return rc;
>  
> -		ata_port_desc(ap, "irq %d", irq[i]);
> +		ata_port_desc_misc(ap, irq[i]);
>  	}
>  
>  	return ata_host_register(host, &cs5520_sht);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 52d58b13e5ee..f7bfc87b34ff 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1553,6 +1553,11 @@ void ata_port_desc(struct ata_port *ap, const char *fmt, ...);
>  extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
>  			       const char *name);
>  #endif
> +static inline void ata_port_desc_misc(struct ata_port *ap, int irq)
> +{
> +	ata_port_desc(ap, "irq %d", irq);
> +	ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
> +}
>  
>  static inline bool ata_tag_internal(unsigned int tag)
>  {

-- 
Damien Le Moal
Western Digital Research

