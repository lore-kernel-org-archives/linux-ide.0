Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F0C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  1 Mar 2022 14:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiCAOP7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiCAOP4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Mar 2022 09:15:56 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E9B82D0A
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646144115; x=1677680115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3g6eocEvwM/SZQuy0tditVfU8hMIWb2DcnPeQGqJviE=;
  b=D7pB4bfv1v7FUDTDrZvXIad5JmLqWVgvj9jgDxmuOOQmJgbBCn6ywu69
   QuVBEHIBhl8+LLSFiRzsTvIkAjzQfgu17yl79t8AcdXM6LxFWiBcHGhln
   hDnjeR5LW+FHZBvKSsryiZ+qMVCAbgMxUwXVuMhicDqfp5rotoMm294RR
   uQ3JoZ2p2iMsIiiz1wGNDYL1iJ5sESQ3w8N9K9bmEigniXGDU5OoXZeoP
   NOOCbcIMEMkbxZCc+1OeoGTm7Rfqmfmjpen7Eu/QPV/SciETRn1T7GM80
   sx0PLYmnJ55vkVJjJ+226cRyicMTR1025YNbtWnXqfSIgUXXHttRNRDKV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="193127225"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 22:15:14 +0800
IronPort-SDR: OeWc5sgEQ8FsTY4bvH676CLwsn2kpZX6KOy94a9Wz/XNRUsqVmGyS6mxMYfbzJlwXbhJnBROIf
 85pePZ/HhEEC4uG40UQ4BxosICR0FBAFH0+l7UUaoxtbcp5lfDVh+WmjQ9DCuJCogT8TgvDm5o
 vCCk7HhFw+fG2XT+9Q9fKOt57Zl8IGu8+JwMn92qvKHYZRxM2hqZUFiJDQdaeG7affS/7+zSk+
 afN/VZvkQT/d3//GNIb9Lr/CeTI2Wy2lzVoVzDRURFVYQ5LCIzonNbvBK8kSfGOg8An6qBoyNz
 6PqC8JUVU9FSLn51F5aE1FSH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:46:38 -0800
IronPort-SDR: tHDA9vQiQfZA7xavi0/PQL5DGfUxxbxPPccocbrKoDArchbZzsTifp9s2rzPixXmDkR/9bnepD
 KTEKf75dTPRb3cDN4aatjJuvm2OuFhB3QrrvZ6vMUyjNja/TCjVkdvCtB858sBKswpNJctuWOO
 ylAMnaXjdg0gNjeTfVK+5FInPZvwZzIf+K55L9z0zRMV0jClzWdSKEOKCQjbzgQj6K0hxnvBsD
 wpMAoyExQIXlIJMv0F1qdSiv0iuUlvsrLuSjiUi96VvXD+Ny+A5i4mVbW1X8036TLZ8fp4p/uj
 LHg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:15:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7K5Y3fFVz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  1 Mar 2022 06:15:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646144113; x=1648736114; bh=3g6eocEvwM/SZQuy0tditVfU8hMIWb2DcnP
        eQGqJviE=; b=rHvBtNKTJoa7w2DKPDeeiqUfa37f0gxLanjn6h1E7MVHhx4LUy8
        rwGFux9BBvfd3Gq1lX6Nfh26Anqbq7GBWf2mPxnkJ+Ibxn5RcSBI4A9S5jO0DssD
        7gCgUWeCKjbOhe3yJzN9VD67o0kVfxpb7k/DubUHvluzv1OEsf+UjQga990TmKHb
        6Paddtl6VuKBjd98PZEPPMjFa0JAvSUwrK4ocw0FdqzGq6cEagfI4t4Wvp/MVJ3/
        eXdaTUTluyQ1BM4LFuRnVysW45uEW+y2B/QC8oTBgrkfF9fHuFY7/gSaxqcdZDMr
        RP6TzReuiwfWs9a0cEAK0Fn3ecBQGtK79dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PtnGpAzqEoYV for <linux-ide@vger.kernel.org>;
        Tue,  1 Mar 2022 06:15:13 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7K5W6wKDz1Rvlx;
        Tue,  1 Mar 2022 06:15:11 -0800 (PST)
Message-ID: <925e48e5-87ab-09b1-3524-4b9914f0b88d@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 16:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] ata: ahci: Protect users from setting policies their
 drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
 <20220228213302.2915071-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220228213302.2915071-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/28 23:33, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policies
> dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
> disk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from RFC v1 -> PATCH v1:
> * Move the warning and protection from drives that don't support slumber further
>   into the calling path.
>  drivers/ata/libahci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 0ed484e04fd6..9dee721ed1fe 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -785,7 +785,15 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>  		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
>  		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  
> -		sata_link_scr_lpm(link, policy, false);
> +		if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +		   !(hpriv->cap & HOST_CAP_SSC)) {

Wouldn't it be safer to have the HOST_CAP_SSC check inside sata_link_scr_lpm() ?
There are other caller sites...

> +			struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +
> +			dev_warn(&pdev->dev,
> +				 "This drive doesn't support slumber; ignoring SATA policy\n"> +		} else {
> +			sata_link_scr_lpm(link, policy, false);
> +		}
>  	}
>  
>  	if (hpriv->cap & HOST_CAP_ALPM) {


-- 
Damien Le Moal
Western Digital Research
