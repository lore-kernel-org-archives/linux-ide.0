Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECFCA0FE2
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 16:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344350AbjIEQVC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbjIEC3W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2023 22:29:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CFCC6
        for <linux-ide@vger.kernel.org>; Mon,  4 Sep 2023 19:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E7E4CE0FBE
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 02:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F8AC433C8;
        Tue,  5 Sep 2023 02:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693880955;
        bh=gV6x/IK6A/XHXy35QuxNeoJfRxgv49bWbPzPDLXKliA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CNVaKw8MdbWLoNVXo9xuW8oWGNmKpYwmL4Bpry8w/fCphr/n2FOgBcgE7oPcEeC33
         uTW7+pWXXYGndWR5K7pE1YF5F8kusqHiOUhs7eBjw7AEaV7mSgA/+ECsG835b38Az5
         t0zH8P3RlGzXlCarsTjKktGrUU6h+hqaZDmoblRa69FPQS7c0sX7tUIHlBxveHo73A
         EU2aHO8xT6N4nFqTKvhcM/HvylqW+Zud8hB17z3s8wHZQMDYoMap1iZuuR1a3e/IPW
         ut5Oppmij58mdb610gO7pOgTby1TAarzZtqryg7l/FA6t+EE4v0y0EFmU2aLZgAzB/
         ql+HP72BPx55Q==
Message-ID: <f83f8d45-b506-118f-d038-507bc87eeeef@kernel.org>
Date:   Tue, 5 Sep 2023 11:29:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
To:     Niklas Cassel <nks@flawful.org>
Cc:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
References: <20230904204257.3296685-1-nks@flawful.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230904204257.3296685-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/5/23 05:42, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> In AHCI 1.3.1, the register description for CAP.SSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Slumber state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Slumber requests."
> 
> In AHCI 1.3.1, the register description for CAP.PSC:
> "When cleared to ‘0’, software must not allow the HBA to initiate
> transitions to the Partial state via agressive link power management nor
> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
> must be programmed to disallow device initiated Partial requests."
> 
> Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
> a device is not allowed to initiate transitions to power states which are
> unsupported by the HBA.
> 
> DevSleep is always initiated by the HBA, however, for completeness, set the
> corresponding bit in PxSCTL.IPM such that agressive link power management
> cannot transition to DevSleep if DevSleep is not supported.
> 
> sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
> However, only libahci has the ability to read the CAP/CAP2 register to see
> if these features are supported. Therefore, in order to not introduce any
> regressions on ata_piix or libata-pmp, create flags that indicate that the
> respective feature is NOT supported. This way, the behavior for ata_piix
> and libata-pmp should remain unchanged.
> 
> This change is based on a patch originally submitted by Runa Guo-oc.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Looks good, but don't we need a Fixes tag for this ?

> ---
>  drivers/ata/ahci.c        |  9 +++++++++
>  drivers/ata/libata-sata.c | 19 ++++++++++++++++---
>  include/linux/libata.h    |  4 ++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index abb5911c9d09..08745e7db820 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1883,6 +1883,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	else
>  		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");
>  
> +	if (!(hpriv->cap & HOST_CAP_PART))
> +		host->flags |= ATA_HOST_NO_PART;
> +
> +	if (!(hpriv->cap & HOST_CAP_SSC))
> +		host->flags |= ATA_HOST_NO_SSC;
> +
> +	if (!(hpriv->cap2 & HOST_CAP2_SDS))
> +		host->flags |= ATA_HOST_NO_DEVSLP;
> +
>  	if (pi.flags & ATA_FLAG_EM)
>  		ahci_reset_em(host);
>  
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 5d31c08be013..a701e1538482 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -396,10 +396,23 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  	case ATA_LPM_MED_POWER_WITH_DIPM:
>  	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
>  	case ATA_LPM_MIN_POWER:
> -		if (ata_link_nr_enabled(link) > 0)
> -			/* no restrictions on LPM transitions */
> +		if (ata_link_nr_enabled(link) > 0) {
> +			/* assume no restrictions on LPM transitions */
>  			scontrol &= ~(0x7 << 8);
> -		else {
> +
> +			/*
> +			 * If the controller does not support partial, slumber,
> +			 * or devsleep, then disallow these transitions.
> +			 */
> +			if (link->ap->host->flags & ATA_HOST_NO_PART)
> +				scontrol |= (0x1 << 8);
> +
> +			if (link->ap->host->flags & ATA_HOST_NO_SSC)
> +				scontrol |= (0x2 << 8);
> +
> +			if (link->ap->host->flags & ATA_HOST_NO_DEVSLP)
> +				scontrol |= (0x4 << 8);
> +		} else {
>  			/* empty port, power off */
>  			scontrol &= ~0xf;
>  			scontrol |= (0x1 << 2);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 52d58b13e5ee..bf4913f4d7ac 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -222,6 +222,10 @@ enum {
>  	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
>  	ATA_HOST_IGNORE_ATA	= (1 << 3),	/* Ignore ATA devices on this host. */
>  
> +	ATA_HOST_NO_PART	= (1 << 4), /* Host does not support partial */
> +	ATA_HOST_NO_SSC		= (1 << 5), /* Host does not support slumber */
> +	ATA_HOST_NO_DEVSLP	= (1 << 6), /* Host does not support devslp */
> +
>  	/* bits 24:31 of host->flags are reserved for LLD specific flags */
>  
>  	/* various lengths of time */

-- 
Damien Le Moal
Western Digital Research

