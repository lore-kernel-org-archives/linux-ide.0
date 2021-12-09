Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59117C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhLIAuE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:50:04 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23789 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLIAuD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639010791; x=1670546791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RnXmdvRuHkaRpOS7Akvc/xGGg9fhebdgPr8UvLc9rNo=;
  b=I6hiJyqXdmQwM4DPLgli9c3t00h/ynEUVX2+Sg93+FM7RUl8eb6T8Iv7
   HiUJF1ZQptVa03V1PYSQp61JLzSb9o6IhrcobbMDENKjD1zcNs0udh3wv
   PugbDrYtExESQhL2r5EXbwY2sG/8+QD6z05w2A/940RZStbp1OtMc9P78
   4UitOf78jph/X5rP/juOgvuHmvXRUy+RGEuzAuWwCoVIXggA4dmD3ArYl
   eiSI2oEjLFaN6YqBZZr8CXgDnzyCLq/yO0iRD8hyvGOFJjAz1/kpb8Wiy
   jRo1mCTYmddm/phSPj1lxh6ZMxU6IpkfKvcAld1COEEChUJX2tQettVQu
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="188801718"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:46:31 +0800
IronPort-SDR: hpho0PgCgFQFXzML7F+y772Q7zvwrcFdU5WDoEcoUq4+w2enfmWRY+pwtlYtDckUtq4pUgRHAd
 z4ttWtRh5GNu9+86AhJL+vPa/RsjqxHgoJzOYKdMvaYuOi6RdcnBncqNRuRt0kIAJTeaz7Acat
 PgJHS30UfxH7y98RbdXUrnIjvUJ7gFXRKuWfWreiH4s7DGZSuyOr5n2VBweVF7p9QjaFYXSzBd
 4WT7BP20+Iy4lNbWPb/7JmwMkyGWxKbroymQZMcEM9kN3dNtZK7gmKdifmLc7nLUzs1tiOFq0H
 eGHAbgA7DLs3kE+vkyVKKPeM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:21:04 -0800
IronPort-SDR: kqZpW90Di8SeZN1A2XS87lIYNGNfKvDRNILU8DQawpcjWsA/ikGlQddWn8a/W/feuleFUXnfwX
 Y/laDoLEbsDGvEHhNB6xYawrXPenUTaMZoOpj0E9kJccn6/WdsjAhdoM5ZGGG+Gx1mcINpleH5
 bFq4xAD/2r0UfrJdIduZm/tLhLUrlh6QwhA5czrvmN7WnvG3Y6tX2UQ7mjuVam+0UQOUZc5NLi
 zotk9hD1z4vZeZAKG/sPt67MUgwBH+Y7ralZF7L8sdBsf6J29A81tnjlVISnHNQhB2a3XHfwal
 eFk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:46:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8b2G2gvFz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:46:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639010789; x=1641602790; bh=RnXmdvRuHkaRpOS7Akvc/xGGg9fhebdgPr8
        UvLc9rNo=; b=XbD0bjbt7yeaOQOBUweel53qNC6be3voiZhVA+tgHwcZtZiLSxe
        Gl47dO+GOLaWLXFY7FMBcLdkCu1DFZAAa0IusgA1kdGvaCSJyA+gKqAQVmYO0n+T
        fHMFHwG/iWLW+wGE5YaamBxta4sp26HPRw0Pl+pX+Z8CJz0+PxpdU+HfbTkEbiTq
        2EIyydYLkAdsh8jr6rYJS1OKtnI7A2VN1mXuRye61nQHJHI71mUBoAOdaqojlJs6
        UYUVh6Awec5ruqrte9vpbIP483TXljmuT5WIlWiSRkWR4Wwf4HFOafukgDtcspV7
        zNe9wPh91Yp34h7QbCCjRHvwFdUTWhQTuUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L8MIS_J5gV2C for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:46:29 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8b2D6KByz1RtVG;
        Wed,  8 Dec 2021 16:46:28 -0800 (PST)
Message-ID: <19a676ed-da38-d058-f7d2-fee566aa1e95@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:46:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 10/73] libata: drop debugging statements for bus-master
 DMA
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-11-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Bus-master DMA is now logged with generic tracepoints, so we can
> drop the DPRINTK()/VPRINTK and dev_dbg() calls here.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Wouldn't it be better to merge this in the previous patch ?

> ---
>  drivers/ata/libata-sff.c        | 18 +-----------------
>  drivers/ata/pata_octeon_cf.c    | 10 ++--------
>  drivers/ata/pata_pdc202xx_old.c |  2 --
>  drivers/ata/pata_sil680.c       |  1 -
>  drivers/ata/sata_dwc_460ex.c    | 18 ++++--------------
>  drivers/ata/sata_rcar.c         |  2 --
>  6 files changed, 7 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 60ac93a0bafb..4c923820d4f9 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -409,12 +409,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
>  		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
>  		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
> -		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> -			tf->hob_feature,
> -			tf->hob_nsect,
> -			tf->hob_lbal,
> -			tf->hob_lbam,
> -			tf->hob_lbah);
>  	}
>  
>  	if (is_addr) {
> @@ -423,18 +417,10 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  		iowrite8(tf->lbal, ioaddr->lbal_addr);
>  		iowrite8(tf->lbam, ioaddr->lbam_addr);
>  		iowrite8(tf->lbah, ioaddr->lbah_addr);
> -		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
> -			tf->feature,
> -			tf->nsect,
> -			tf->lbal,
> -			tf->lbam,
> -			tf->lbah);
>  	}
>  
> -	if (tf->flags & ATA_TFLAG_DEVICE) {
> +	if (tf->flags & ATA_TFLAG_DEVICE)
>  		iowrite8(tf->device, ioaddr->device_addr);
> -		VPRINTK("device 0x%X\n", tf->device);
> -	}
>  
>  	ata_wait_idle(ap);
>  }
> @@ -494,8 +480,6 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
>   */
>  void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
>  }
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index cdc95eb2b2cb..06468a1f4807 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -514,20 +514,14 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
>  {
>  	/* The base of the registers is at ioaddr.data_addr. */
>  	void __iomem *base = ap->ioaddr.data_addr;
> -	u16 blob;
> +	u16 blob = 0;
>  
> -	if (tf->flags & ATA_TFLAG_DEVICE) {
> -		VPRINTK("device 0x%X\n", tf->device);
> +	if (tf->flags & ATA_TFLAG_DEVICE)
>  		blob = tf->device;
> -	} else {
> -		blob = 0;
> -	}
>  
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	blob |= (tf->command << 8);
>  	__raw_writew(blob, base + 6);
>  
> -
>  	ata_wait_idle(ap);
>  }
>  
> diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
> index 0c5cbcd28d0d..b99849095853 100644
> --- a/drivers/ata/pata_pdc202xx_old.c
> +++ b/drivers/ata/pata_pdc202xx_old.c
> @@ -38,8 +38,6 @@ static int pdc2026x_cable_detect(struct ata_port *ap)
>  static void pdc202xx_exec_command(struct ata_port *ap,
>  				  const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ndelay(400);
>  }
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 43215a664b96..81238e097fe2 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -212,7 +212,6 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  static void sil680_sff_exec_command(struct ata_port *ap,
>  				    const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
>  }
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 338c2e50f759..f5ef5ce5f758 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -980,9 +980,6 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
>  {
>  	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
>  
> -	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
> -		ata_get_cmd_descript(tf->command), tag);
> -
>  	hsdevp->cmd_issued[tag] = cmd_issued;
>  
>  	/*
> @@ -1005,12 +1002,9 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
>  {
>  	u8 tag = qc->hw_tag;
>  
> -	if (ata_is_ncq(qc->tf.protocol)) {
> -		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
> -			__func__, qc->ap->link.sactive, tag);
> -	} else {
> +	if (!ata_is_ncq(qc->tf.protocol))
>  		tag = 0;
> -	}
> +
>  	sata_dwc_bmdma_setup_by_tag(qc, tag);
>  }
>  
> @@ -1067,13 +1061,9 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
>  {
>  	u8 tag = qc->hw_tag;
>  
> -	if (ata_is_ncq(qc->tf.protocol)) {
> -		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
> -			__func__, qc->ap->link.sactive, tag);
> -	} else {
> +	if (!ata_is_ncq(qc->tf.protocol))
>  		tag = 0;
> -	}
> -	dev_dbg(qc->ap->dev, "%s\n", __func__);
> +
>  	sata_dwc_bmdma_start_by_tag(qc, tag);
>  }
>  
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 9005833ab02f..b4994d182eda 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -436,8 +436,6 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  static void sata_rcar_exec_command(struct ata_port *ap,
>  				   const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite32(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
>  }
> 


-- 
Damien Le Moal
Western Digital Research
