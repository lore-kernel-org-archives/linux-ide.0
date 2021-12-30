Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ACEC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 05:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhL3FNB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 00:13:01 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:16189 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229448AbhL3FNB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 00:13:01 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPby45kLHz1RtVc
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2021 21:13:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640841180; x=1643433181; bh=G3fETHTi4GycvrSWN1iCE+Ellu099umJfVj
        Ipm5113g=; b=VQ5BpYCtE18lKQphMRpHClbOZxMGDQ6Y+gTlEUQQtOjNLWQSPub
        DkUuMmHm+esWMjgcxLLz0W6r+meFo6AXBlSfhoseZPQ9V/qKJAssa5pcU3OVCfD/
        HBhkXDMAqL9oIom+coKm5q+/MKRKWg4SvlxHvqlIrxhYx/vDCveHrqFIqKi/lqME
        0ZvRHyGMWQ00qjAo7EpkX64Fy76QPOw/W6Fjxvg6RWXJ1FUuj1oMy9D11G9eRSbE
        1zNNLxfTYJkgjy20wpsUf0V1gEc0aFb+XwcvkvbpUDbdGXxKhVxpTLRTcw7KWgnR
        e7sFyTxPbl+SjeJymSCADJPILiIglyim5aA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vz0cmdFlui2Q for <linux-ide@vger.kernel.org>;
        Wed, 29 Dec 2021 21:13:00 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPby35K4Mz1RtVG;
        Wed, 29 Dec 2021 21:12:59 -0800 (PST)
Message-ID: <d32fb9d0-46d2-57fc-9815-aeb231c5b0e2@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 14:12:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 03/68] libata: Add ata_port_classify() helper
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-4-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221072131.46673-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/21/21 16:20, Hannes Reinecke wrote:
> Add an ata_port_classify() helper to print out the results from
> the device classification and remove the debugging statements
> from ata_dev_classify().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libahci.c          |  2 +-
>  drivers/ata/libata-core.c      | 21 +++++----------------
>  drivers/ata/libata-sff.c       |  2 +-
>  drivers/ata/libata-transport.c | 27 +++++++++++++++++++++++++++
>  drivers/ata/sata_fsl.c         |  2 +-
>  drivers/ata/sata_inic162x.c    |  2 +-
>  drivers/ata/sata_sil24.c       |  2 +-
>  include/linux/libata.h         |  2 ++
>  8 files changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 94edbc89a48c..b7b460560a92 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1300,7 +1300,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>  	tf.lbal		= (tmp >> 8)	& 0xff;
>  	tf.nsect	= (tmp)		& 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  EXPORT_SYMBOL_GPL(ahci_dev_classify);
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 72f56c32fe83..296cca54017a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1007,32 +1007,21 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
>  	 * SEMB signature.  This is worked around in
>  	 * ata_dev_read_id().
>  	 */
> -	if ((tf->lbam == 0) && (tf->lbah == 0)) {
> -		DPRINTK("found ATA device by sig\n");
> +	if ((tf->lbam == 0) && (tf->lbah == 0))
>  		return ATA_DEV_ATA;
> -	}
>  
> -	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
> -		DPRINTK("found ATAPI device by sig\n");
> +	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb))
>  		return ATA_DEV_ATAPI;
> -	}
>  
> -	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
> -		DPRINTK("found PMP device by sig\n");
> +	if ((tf->lbam == 0x69) && (tf->lbah == 0x96))
>  		return ATA_DEV_PMP;
> -	}
>  
> -	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3)) {
> -		DPRINTK("found SEMB device by sig (could be ATA device)\n");
> +	if ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))
>  		return ATA_DEV_SEMB;
> -	}
>  
> -	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab)) {
> -		DPRINTK("found ZAC device by sig\n");
> +	if ((tf->lbam == 0xcd) && (tf->lbah == 0xab))
>  		return ATA_DEV_ZAC;
> -	}

When applying, I dropped the unnecessary extra inner brackets in the
conditions.

>  
> -	DPRINTK("unknown device\n");
>  	return ATA_DEV_UNKNOWN;
>  }
>  EXPORT_SYMBOL_GPL(ata_dev_classify);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 39c026f3948c..a119fabe0919 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1853,7 +1853,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
>  		return ATA_DEV_NONE;
>  
>  	/* determine if device is ATA or ATAPI */
> -	class = ata_dev_classify(&tf);
> +	class = ata_port_classify(ap, &tf);
>  
>  	if (class == ATA_DEV_UNKNOWN) {
>  		/* If the device failed diagnostic, it's likely to
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 4162d625fc92..8f44ad772a0e 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -321,6 +321,33 @@ int ata_tport_add(struct device *parent,
>  	return error;
>  }
>  
> +/**
> + *     ata_port_classify - determine device type based on ATA-spec signature
> + *     @ap: ATA port device on which the classification should be run
> + *     @tf: ATA taskfile register set for device to be identified
> + *
> + *     A wrapper around ata_dev_classify() to provide additional logging
> + *
> + *     RETURNS:
> + *     Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
> + *     %ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
> + */
> +unsigned int ata_port_classify(struct ata_port *ap,
> +			       const struct ata_taskfile *tf)
> +{
> +	int i;
> +	unsigned int class = ata_dev_classify(tf);
> +
> +	/* Start with index '1' to skip the 'unknown' entry */
> +	for (i = 1; i < ARRAY_SIZE(ata_class_names); i++) {
> +		if (ata_class_names[i].value == class)
> +			ata_port_dbg(ap, "found %s device by sig\n",
> +				     ata_class_names[i].name);

This needs a "return class;" here. Otherwise, the following message is
always printed.

> +	}
> +	ata_port_info(ap, "found unknown device (class %u)\n", class);
> +	return class;
> +}
> +EXPORT_SYMBOL_GPL(ata_port_classify);
>  
>  /*
>   * ATA link attributes
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index ec52511ae60f..7504d9fbff2a 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -814,7 +814,7 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
>  	tf.lbal = (temp >> 8) & 0xff;
>  	tf.nsect = temp & 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  
>  static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index e517bd8822a5..b6239dae524a 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -657,7 +657,7 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
>  		}
>  
>  		inic_tf_read(ap, &tf);
> -		*class = ata_dev_classify(&tf);
> +		*class = ata_port_classify(ap, &tf);
>  	}
>  
>  	return 0;
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index f99ec6f7d7c0..7e9c1945dc81 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -680,7 +680,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	}
>  
>  	sil24_read_tf(ap, 0, &tf);
> -	*class = ata_dev_classify(&tf);
> +	*class = ata_port_classify(ap, &tf);
>  
>  	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2a8404b26083..235fdbeb19ea 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1160,6 +1160,8 @@ extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
>  extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
>  		 unsigned int n_elem);
>  extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
> +extern unsigned int ata_port_classify(struct ata_port *ap,
> +				      const struct ata_taskfile *tf);
>  extern void ata_dev_disable(struct ata_device *adev);
>  extern void ata_id_string(const u16 *id, unsigned char *s,
>  			  unsigned int ofs, unsigned int len);


-- 
Damien Le Moal
Western Digital Research
