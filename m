Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F85BEB8FAD
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 06:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIFGsJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjIFGsJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 02:48:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329EE4F
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 23:48:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A924EC433C8;
        Wed,  6 Sep 2023 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693982884;
        bh=nSwfREI5tM6aQmLaLWEGeAv6ygt7PNOu9+0s9kLrl7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gWxrhCo6qBefbkQhUa4/aToanb4k9XNIZv9mWkMUmmA/FmugHAcGGApf3/cgP8wDu
         yyMG1SfG6XcnfVgEkJ3UbYeMG2TVK2pfUQcs/BPaaP7ESyujWyAZlBxWqxICD1BkKo
         v6ie9H8K3smwKJuCZAM7IHHvnCF2HDcAdh/WZ78fYFIkT5e4h24Kh3+0Ur/erXdfRh
         HHoZDAfiNr1iEzIoIW1C6zhp+iih5/SKl64+byRhOp60Hl+urxymVALciS3/V7Sb+i
         2d43AOjMPM/y0lvfL3D/33eUHsfxnBWGgim9kbmQYy++aRSuIqtrYvR6cVpqsFy7GB
         6Ud+0haF8NJpw==
Message-ID: <be820ba7-7aa8-6338-7bee-201443aae5c1@kernel.org>
Date:   Wed, 6 Sep 2023 15:48:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: ahci: print the lpm policy on boot
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
References: <20230905124909.3334046-1-nks@flawful.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230905124909.3334046-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/5/23 21:49, Niklas Cassel wrote:
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
> using ata_port_desc(). The port description is printed once during boot.
> 
> Before changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
> 
> After changes:
> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 lpm-pol 4 irq 170
> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 lpm-pol 4 irq 170

Looks good, but maybe print the lpm-pol value at the end, after the IRQ number,
to preserve the beginning of the message as it was before.

Or even better: why not print the LPM modes supported by the port and the target
lpm policy (lpm-pol) as a new ata_port_info() message right after the port desc
message ?

> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index abb5911c9d09..541f6ec7f395 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1898,6 +1898,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  			ap->em_message_type = hpriv->em_msg_type;
>  
>  		ahci_update_initial_lpm_policy(ap, hpriv);
> +		ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
>  
>  		/* disabled/not-implemented port */
>  		if (!(hpriv->port_map & (1 << i)))

-- 
Damien Le Moal
Western Digital Research

