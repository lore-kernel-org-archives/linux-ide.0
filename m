Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003DC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C1C206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mufY1rWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA3LoW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:44:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35306 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgA3LoW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:44:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130114420euoutp02242aaf3c54b2f438ccb22b9fbd71165f~up3m5ntlA0277702777euoutp02L
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:44:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130114420euoutp02242aaf3c54b2f438ccb22b9fbd71165f~up3m5ntlA0277702777euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580384660;
        bh=WHENN4M7+fzvHpCXUj6X/GACNNl1P88HCzR010ZbxVc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mufY1rWzJ6kyHbkOeHgJqWWIaGTCuY48dRu9UOisf8M6bKdT8vomo8frvWdxXoxy8
         IpV+EoE5OGbYb7HvKaMmFYh/kakGJbPX+bPFbt/odg4dEoRI8qc1KOFostSKpQq7a3
         3FMztTuBT3GOh6OcCZNrcGjj+gGZZg0yMu5/mgFw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130114420eucas1p28014ed0a219f2c03a88899967a389cbd~up3mwwJjr2960329603eucas1p2K;
        Thu, 30 Jan 2020 11:44:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DE.21.61286.491C23E5; Thu, 30
        Jan 2020 11:44:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130114419eucas1p1b186389ea0aa7847d9e12eda64f72f2b~up3mV2hH40889608896eucas1p1t;
        Thu, 30 Jan 2020 11:44:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130114419eusmtrp1b6d121792e8af92d09e324be87859a74~up3mVNXHx1567015670eusmtrp1m;
        Thu, 30 Jan 2020 11:44:19 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4a-5e32c19499cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5C.A6.08375.391C23E5; Thu, 30
        Jan 2020 11:44:19 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130114419eusmtip191581816e38b545dfc6d54b88dbabf6b~up3l_YWju1263912639eusmtip1I;
        Thu, 30 Jan 2020 11:44:19 +0000 (GMT)
Subject: Re: [PATCH 18/24] libata: add 'link' argument to ata_dev_classify()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5cc65e7e-7bcd-4428-1f09-97054a499f8b@samsung.com>
Date:   Thu, 30 Jan 2020 12:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-30-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87pTDhrFGazr47dYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mu1OOshc8
        Cal49mMKawPjQpcuRk4OCQETiatrlzB1MXJxCAmsYJQ429PCAuF8YZRouDEFyvnMKDGnrZkV
        puXGwc+MEInljBLtE/6zQjhvGSU2vLoAViUs4CPx5eN1NhBbREBJ4mP7IXYQm1kgTqLpyl0w
        m03ASmJi+yqgSRwcvAJ2Eu9aq0HCLAKqErtv3GcGsUUFIiQ+PTgMNpJXQFDi5MwnLCA2p4Cx
        RGfLeRaIkeISt57MZ4Kw5SW2v53DDHHodHaJP3cTIGwXiYlvL7BD2MISr45vgbJlJE5P7gH7
        UkJgHaPE344XzBDOdkaJ5ZP/sUFUWUvcOfeLDeRQZgFNifW79CHCjhI/H58CC0sI8EnceCsI
        cQOfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUg+m4Xkm1lIvpmFsHcBI8sqRvHU
        0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwLRy+t/xTzsYv15KOsQowMGoxMOrscEoTog1say4
        MvcQowQHs5IIr6irYZwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotg
        skwcnFINjPNEBXdqPJTdu8Dw+PI+0UoPIQajRQv6Jm32OfqnIvLZgxgj1ukME86k2r99Vbmj
        6IsI0+WTLDntH7zPqwo/kbu1pVkzvEagmcv1p2eo9dpb5+8u673Zd67/zMlopqWRnO/vrU5n
        uHJrg9WVmZ+2ncsTSbj3hPvLTt6pdtZLWj9eDenq/l8QMleJpTgj0VCLuag4EQCDgFvzJwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qTDxrFGbR+N7BYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mu1OOshc8Cal49mMKawPjQpcuRk4OCQET
        iRsHPzN2MXJxCAksZZS4/2gpexcjB1BCRuL4+jKIGmGJP9e62CBqXjNKPJu0ihkkISzgI/Hl
        43U2EFtEQEniY/shdhCbWSBO4l/fbiaIhnWMEqt3rQUrYhOwkpjYvooRZAGvgJ3Eu9ZqkDCL
        gKrE7hv3wWaKCkRIHN4xixHE5hUQlDg58wkLiM0pYCzR2XKeBWK+usSfeZeYIWxxiVtP5jNB
        2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAc
        bTv2c/MOxksbgw8xCnAwKvHwamwwihNiTSwrrsw9xCjBwawkwivqahgnxJuSWFmVWpQfX1Sa
        k1p8iNEU6LmJzFKiyfnAGM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPH
        xMEp1cAY5q/L6ZppsmBiWUHmCk+2NS+Cu49VZScvPL3n8OfJKVKX1/nVPzjwcfPB63op79/a
        SUcu+xuh/LBt023v45KM6Xe/R6pYBi9euextKdONm1Z1R9ke3796qK/YVmf15tZTV4Iqvi+Q
        t5qkpTWr0E5AzNvZJZ25Mjonrl6+RCio0nrSl+WTL25VYinOSDTUYi4qTgQAjoMwGbkCAAA=
X-CMS-MailID: 20200130114419eucas1p1b186389ea0aa7847d9e12eda64f72f2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104753epcas1p1732188e6d1b66d18bc4e3f53cc0a12ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104753epcas1p1732188e6d1b66d18bc4e3f53cc0a12ce
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104753epcas1p1732188e6d1b66d18bc4e3f53cc0a12ce@epcas1p1.samsung.com>
        <20181213104716.31930-30-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Add a 'link' argument to ata_dev_classify() so that we can call
> ata_link_dbg() with the correct device and drop the DPRINTK usage.

This patch also:

- does actual ata_dev_classify() conversion to not use DPRINTK()

- adds printing of unknown signatures in ata_dev_classify()

- removes DPRINTK() instance from sata_fsl_softreset()

Please document above changes in the patch description.

Also please:

- preserve __func__ printing in the DPRINTK() conversion

- use dev_dbg() directly instead of ata_link_dbg()

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/ahci.c            |  2 +-
>  drivers/ata/ahci.h            |  2 +-
>  drivers/ata/libahci.c         |  9 +++++----
>  drivers/ata/libata-core.c     | 18 +++++++++++-------
>  drivers/ata/libata-sff.c      |  2 +-
>  drivers/ata/sata_fsl.c        | 11 +++++------
>  drivers/ata/sata_inic162x.c   |  2 +-
>  drivers/ata/sata_sil24.c      |  2 +-
>  drivers/scsi/libsas/sas_ata.c |  3 ++-
>  include/linux/libata.h        |  3 ++-
>  10 files changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 89d9980f3de4..cda9cdd2495b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -826,7 +826,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	hpriv->start_engine(ap);
>  
>  	if (online)
> -		*class = ahci_dev_classify(ap);
> +		*class = ahci_dev_classify(link);
>  
>  	ata_link_dbg(link, "EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index ef356e70e6de..65df818e5e09 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -403,7 +403,7 @@ extern struct ata_port_operations ahci_ops;
>  extern struct ata_port_operations ahci_platform_ops;
>  extern struct ata_port_operations ahci_pmp_retry_srst_ops;
>  
> -unsigned int ahci_dev_classify(struct ata_port *ap);
> +unsigned int ahci_dev_classify(struct ata_link *link);
>  void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
>  			u32 opts);
>  void ahci_save_initial_config(struct device *dev,
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index d6c93ce83504..421a40731ed3 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1281,8 +1281,9 @@ static void ahci_dev_config(struct ata_device *dev)
>  	}
>  }
>  
> -unsigned int ahci_dev_classify(struct ata_port *ap)
> +unsigned int ahci_dev_classify(struct ata_link *link)
>  {
> +	struct ata_port *ap = link->ap;
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	struct ata_taskfile tf;
>  	u32 tmp;
> @@ -1293,7 +1294,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>  	tf.lbal		= (tmp >> 8)	& 0xff;
>  	tf.nsect	= (tmp)		& 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_dev_classify(link, &tf);
>  }
>  EXPORT_SYMBOL_GPL(ahci_dev_classify);
>  
> @@ -1464,7 +1465,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
>  		reason = "device not ready";
>  		goto fail;
>  	} else
> -		*class = ahci_dev_classify(ap);
> +		*class = ahci_dev_classify(link);
>  
>  	/* re-enable FBS if disabled before */
>  	if (fbs_disabled)
> @@ -1574,7 +1575,7 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	hpriv->start_engine(ap);
>  
>  	if (*online)
> -		*class = ahci_dev_classify(ap);
> +		*class = ahci_dev_classify(link);
>  
>  	ata_link_dbg(link, "%s: EXIT, rc=%d, class=%u\n", __func__, rc, *class);
>  	return rc;
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index f4b5a61b1c63..a36f24de399b 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1046,6 +1046,7 @@ const char *sata_spd_string(unsigned int spd)
>  
>  /**
>   *	ata_dev_classify - determine device type based on ATA-spec signature
> + *	@link: ATA device link for the device to be identified
>   *	@tf: ATA taskfile register set for device to be identified
>   *
>   *	Determine from taskfile register contents whether a device is
> @@ -1059,7 +1060,8 @@ const char *sata_spd_string(unsigned int spd)
>   *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
>   *	%ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
>   */
> -unsigned int ata_dev_classify(const struct ata_taskfile *tf)
> +unsigned int ata_dev_classify(struct ata_link *link,
> +			      const struct ata_taskfile *tf)
>  {
>  	/* Apple's open source Darwin code hints that some devices only
>  	 * put a proper signature into the LBA mid/high registers,
> @@ -1083,31 +1085,33 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>  	 * ata_dev_read_id().
>  	 */
>  	if ((tf->lbam == 0) && (tf->lbah == 0)) {
> -		DPRINTK("found ATA device by sig\n");
> +		ata_link_dbg(link, "found ATA device by sig\n");
>  		return ATA_DEV_ATA;
>  	}
>  
>  	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
> -		DPRINTK("found ATAPI device by sig\n");
> +		ata_link_dbg(link, "found ATAPI device by sig\n");
>  		return ATA_DEV_ATAPI;
>  	}
>  
>  	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
> -		DPRINTK("found PMP device by sig\n");
> +		ata_link_dbg(link, "found PMP device by sig\n");
>  		return ATA_DEV_PMP;
>  	}
>  
>  	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
> -		DPRINTK("found SEMB device by sig (could be ATA device)\n");
> +		ata_link_dbg(link,
> +			     "found SEMB device by sig (could be ATA device)\n");
>  		return ATA_DEV_SEMB;
>  	}
>  
>  	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab)) {
> -		DPRINTK("found ZAC device by sig\n");
> +		ata_link_dbg(link, "found ZAC device by sig\n");
>  		return ATA_DEV_ZAC;
>  	}
>  
> -	DPRINTK("unknown device\n");
> +	ata_link_dbg(link, "unknown device signature %02x %02x\n",
> +		     tf->lbam, tf->lbah);
>  	return ATA_DEV_UNKNOWN;
>  }
>  
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 3326c3b02c61..48b27f4e52fe 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1850,7 +1850,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
>  		return ATA_DEV_NONE;
>  
>  	/* determine if device is ATA or ATAPI */
> -	class = ata_dev_classify(&tf);
> +	class = ata_dev_classify(dev->link, &tf);
>  
>  	if (class == ATA_DEV_UNKNOWN) {
>  		/* If the device failed diagnostic, it's likely to
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 8bb129c87a3f..6260ea9e180f 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -797,9 +797,9 @@ static void sata_fsl_port_stop(struct ata_port *ap)
>  	kfree(pp);
>  }
>  
> -static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
> +static unsigned int sata_fsl_dev_classify(struct ata_link *link)
>  {
> -	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
> +	struct sata_fsl_host_priv *host_priv = link->ap->host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
>  	struct ata_taskfile tf;
>  	u32 temp;
> @@ -815,7 +815,7 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
>  	tf.lbal = (temp >> 8) & 0xff;
>  	tf.nsect = temp & 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_dev_classify(link, &tf);
>  }
>  
>  static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
> @@ -917,7 +917,7 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>  	} else {
>  		ata_port_info(ap, "Signature Update detected @ %d msecs\n",
>  			      jiffies_to_msecs(jiffies - start_jiffies));
> -		*class = sata_fsl_dev_classify(ap);
> +		*class = sata_fsl_dev_classify(link);
>  		return 0;
>  	}
>  
> @@ -1050,9 +1050,8 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
>  		 * would have been updated
>  		 */
>  
> -		*class = sata_fsl_dev_classify(ap);
> +		*class = sata_fsl_dev_classify(link);
>  
> -		ata_link_dbg(link, "class = %d\n", *class);
>  		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
>  		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
>  	}
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index e0bcf9b2dab0..3b2c38623b57 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -649,7 +649,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
>  		}
>  
>  		inic_tf_read(ap, &tf);
> -		*class = ata_dev_classify(&tf);
> +		*class = ata_dev_classify(link, &tf);
>  	}
>  
>  	return 0;
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 4b00dce151eb..f041f00342c4 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -687,7 +687,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	}
>  
>  	sil24_read_tf(ap, 0, &tf);
> -	*class = ata_dev_classify(&tf);
> +	*class = ata_dev_classify(link, &tf);
>  
>  	ata_link_dbg(link, "%s: EXIT, class=%u\n", __func__, *class);
>  	return 0;
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 4f6cdf53e913..06736b2c7a97 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -620,6 +620,7 @@ void sas_ata_task_abort(struct sas_task *task)
>  
>  static int sas_get_ata_command_set(struct domain_device *dev)
>  {
> +	struct ata_port *ap = dev->sata_dev.ap;
>  	struct dev_to_host_fis *fis =
>  		(struct dev_to_host_fis *) dev->frame_rcvd;
>  	struct ata_taskfile tf;
> @@ -629,7 +630,7 @@ static int sas_get_ata_command_set(struct domain_device *dev)
>  
>  	ata_tf_from_fis((const u8 *)fis, &tf);
>  
> -	return ata_dev_classify(&tf);
> +	return ata_dev_classify(&ap->link, &tf);
>  }
>  
>  void sas_probe_sata(struct asd_sas_port *port)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 7b2f039d3d21..808a96a8cb1d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1180,7 +1180,8 @@ extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
>  extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
>  extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
>  		 unsigned int n_elem);
> -extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
> +extern unsigned int ata_dev_classify(struct ata_link *link,
> +				     const struct ata_taskfile *tf);
>  extern void ata_dev_disable(struct ata_device *adev);
>  extern void ata_id_string(const u16 *id, unsigned char *s,
>  			  unsigned int ofs, unsigned int len);
> 
