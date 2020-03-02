Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BCC3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B99F2465E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O74AXF0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCBQws (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:52:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38015 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBQwr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 11:52:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302165246euoutp024523a0521d5683b464cad422fce8a331~4iuCcxbk92153521535euoutp02A
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 16:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302165246euoutp024523a0521d5683b464cad422fce8a331~4iuCcxbk92153521535euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583167966;
        bh=llSqPg6ha0hhT+7RA3GyuSa1qJpHk4J81OO5jpGr8N8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O74AXF0LYGOpopzZwqBGYmJUAJiIZ4dh8QA7XdyYXMQF3FEDH6AL1vlurL/5Qtzy5
         844TDws2mwS+skHp1NC017jkHSGn53DmspbWsNGrtelPcoPtUxc6FAgnsl4hj8Ph12
         Af1M7ub1Nq9Z5FakGIyqyEUROb27jMkgSPVD1rbI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302165246eucas1p2815ecad810ed0eba57a579f342b339f5~4iuCXrf3w2331323313eucas1p2a;
        Mon,  2 Mar 2020 16:52:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 76.38.60679.ED93D5E5; Mon,  2
        Mar 2020 16:52:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302165245eucas1p1eda27224e9328da02c8df95bc9d69247~4iuCDf-ld2630226302eucas1p1V;
        Mon,  2 Mar 2020 16:52:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302165245eusmtrp2eef932c27c08489a838018757c34684a~4iuCC9Yy-1113511135eusmtrp2b;
        Mon,  2 Mar 2020 16:52:45 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-69-5e5d39dece19
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.57.07950.DD93D5E5; Mon,  2
        Mar 2020 16:52:45 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302165245eusmtip24397b7268b4a0edad7deca6dbe353218~4iuBesCc62687226872eusmtip2l;
        Mon,  2 Mar 2020 16:52:45 +0000 (GMT)
Subject: Re: [PATCH 09/42] libata: Add ata_port_classify() helper
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4add37e0-6c50-1169-3bc9-8582b44d3ab4@samsung.com>
Date:   Mon, 2 Mar 2020 17:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-10-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7r3LGPjDP7M57FYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGtUWCBZts
        KrZcusbWwHjKoIuRk0NCwETi3OLf7F2MXBxCAisYJTZ1vmAFSQgJfGGUuNDhCpH4zCix8e4r
        RpiOQxMuMEMULWeUeDpZBaLoLaNE/9EvTF2MHBzCAo4SrdvABokIKEl8bD/EDmIzC0RIbNyw
        lgnEZhOwkpjYvgpsJq+AncSmDWdZQGwWARWJr22TwGxRoPpPDw6zQtQISpyc+YQFZDyngLHE
        +5OhECPFJW49mc8EYctLbH87hxnkHAmBbnaJpTeb2CFudpGYems3C4QtLPHq+BaouIzE/50g
        zSAN6xgl/na8gOreziixfPI/Nogqa4k7536xgWxmFtCUWL9LHyLsKLHz7HxmkLCEAJ/EjbeC
        EEfwSUzaNh0qzCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheSzWUjemYXknVkIexcwsqxiFE8t
        Lc5NTy02ykst1ytOzC0uzUvXS87P3cQITCin/x3/soNx15+kQ4wCHIxKPLwBzLFxQqyJZcWV
        uYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgST
        ZeLglGpg1FzsH/Bv2t2czRwLPyXbf/LgtEyyO9lxT2r+nikFqZzZRyelM6w+oCiT9CBn0prW
        ugOlMcc5XV87euy8/3Ceu9ziBZddDU5Wd+6aMqH6dsXED0oqYgvP290SZ/njb2k1nSHkjELn
        nf43j70fOU38x/TJf1NX1LWGtIkPAqrmF/ZP5OTdzjj1qRJLcUaioRZzUXEiAKyuAYckAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7p3LWPjDPommFisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j2iLBgk02FVsuXWNrYDxl0MXIySEhYCJx
        aMIF5i5GLg4hgaWMEn83/GHqYuQASshIHF9fBlEjLPHnWhcbRM1rRoklM/rAaoQFHCVat7GC
        1IgIKEl8bD/EDmIzC0RIdL86A1W/jlHi7Lv/YAk2ASuJie2rGEFsXgE7iU0bzrKA2CwCKhJf
        2yaB2aJAzYd3zIKqEZQ4OfMJC8guTgFjifcnQyHmq0v8mXeJGcIWl7j1ZD4ThC0vsf3tHOYJ
        jEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG0LZjP7fsYOx6
        F3yIUYCDUYmH9wdDbJwQa2JZcWXuIUYJDmYlEV5fzug4Id6UxMqq1KL8+KLSnNTiQ4ymQL9N
        ZJYSTc4HxndeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGolrP
        5T9vWX1WmHll5eJyxp971zysUGqf81jIp3iHqbJMsNDs725af9451OzwNMxcPcPrekp60JlL
        dwuMxTztbao3uK+c7seb5LXa9sAaJf+4E5k7Xh18+STR6tiGR/3azyte/bGsrJt7XNf+5cs+
        y4sTt5ps39fSe7ROm6uo8Ltv+SefVN+ZSizFGYmGWsxFxYkALiFlLbcCAAA=
X-CMS-MailID: 20200302165245eucas1p1eda27224e9328da02c8df95bc9d69247
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095437eucas1p18646a35ad546ed2853214ebd6e4ddae6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095437eucas1p18646a35ad546ed2853214ebd6e4ddae6
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095437eucas1p18646a35ad546ed2853214ebd6e4ddae6@eucas1p1.samsung.com>
        <20200213095412.23773-10-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Add an ata_port_classify() helper to print out the results from
> the device classification and remove the debugging statements
> from ata_dev_classify(). Also provide a mapping ata_dev_class_string()
> to provide a string representation for those instances calling
> ata_dev_classify() directly.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libahci.c       |  2 +-
>  drivers/ata/libata-core.c   | 67 ++++++++++++++++++++++++++++++++++-----------
>  drivers/ata/libata-sff.c    |  5 ++++
>  drivers/ata/sata_fsl.c      |  2 +-
>  drivers/ata/sata_inic162x.c |  2 +-
>  drivers/ata/sata_sil24.c    |  2 +-
>  include/linux/libata.h      |  3 ++
>  7 files changed, 63 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 4055071f213f..c1bc973ecc16 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1276,7 +1276,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)
>  	tf.lbal		= (tmp >> 8)	& 0xff;
>  	tf.nsect	= (tmp)		& 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  EXPORT_SYMBOL_GPL(ahci_dev_classify);
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a9d47a746f77..17abc52ce41e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1025,6 +1025,27 @@ const char *sata_spd_string(unsigned int spd)
>  	return spd_str[spd - 1];
>  }
>  
> +const char *ata_dev_class_string(unsigned int class)
> +{
> +	static const char * const class_str[] = {
> +		"unknown",
> +		"ATA",
> +		"ATA (unsupported)",
> +		"ATAPI",
> +		"ATAPI (unsupported",
> +		"PMP",
> +		"PMP (unsupported)",
> +		"SEMB",
> +		"SEMB (unsupported)",
> +		"ZAC",
> +		"ZAC (unsupported)",
> +		"none",
> +	};
> +	if (class == 0 || (class - 1) >= ARRAY_SIZE(class_str))
> +		return "unknown";
> +	return class_str[class - 1];
> +}
> +
>  /**
>   *	ata_dev_classify - determine device type based on ATA-spec signature
>   *	@tf: ATA taskfile register set for device to be identified
> @@ -1063,35 +1084,48 @@ unsigned int ata_dev_classify(const struct ata_taskfile *tf)
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
>  
> -	DPRINTK("unknown device\n");
>  	return ATA_DEV_UNKNOWN;
>  }
>  
> +/**
> + *	ata_port_classify - determine device type based on ATA-spec signature
> + *	@ap: ATA port device on which the classification should be run
> + *	@tf: ATA taskfile register set for device to be identified
> + *
> + *	A wrapper around ata_dev_classify() to provide additional logging
> + *
> + *	RETURNS:
> + *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP,
> + *	%ATA_DEV_ZAC, or %ATA_DEV_UNKNOWN the event of failure.
> + */
> +unsigned int ata_port_classify(struct ata_port *ap,
> +			      const struct ata_taskfile *tf)
> +{
> +	unsigned int class = ata_dev_classify(tf);
> +
> +	if (class != ATA_DEV_UNKNOWN)
> +		ata_port_dbg(ap, "found %s device by sig\n",
> +			     ata_dev_class_string(class));
> +	else
> +		ata_port_dbg(ap, "found unknown device\n");
> +	return class;
> +}
> +
>  /**
>   *	ata_id_string - Convert IDENTIFY DEVICE page into string
>   *	@id: IDENTIFY DEVICE results we will examine
> @@ -7302,6 +7336,7 @@ EXPORT_SYMBOL_GPL(sata_link_hardreset);
>  EXPORT_SYMBOL_GPL(sata_std_hardreset);
>  EXPORT_SYMBOL_GPL(ata_std_postreset);
>  EXPORT_SYMBOL_GPL(ata_dev_classify);
> +EXPORT_SYMBOL_GPL(ata_port_classify);
>  EXPORT_SYMBOL_GPL(ata_dev_pair);
>  EXPORT_SYMBOL_GPL(ata_ratelimit);
>  EXPORT_SYMBOL_GPL(ata_msleep);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 9fbe67f73197..939cda91c56d 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1839,6 +1839,11 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
>  
>  	/* determine if device is ATA or ATAPI */
>  	class = ata_dev_classify(&tf);
> +	if (class != ATA_DEV_UNKNOWN)
> +		ata_dev_dbg(dev, "found %s device by sig\n",
> +			     ata_dev_class_string(class));
> +	else
> +		ata_dev_dbg(dev, "found unknown device\n");
>  
>  	if (class == ATA_DEV_UNKNOWN) {
>  		/* If the device failed diagnostic, it's likely to
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index d55ee244d693..0864c4fafa39 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -812,7 +812,7 @@ static unsigned int sata_fsl_dev_classify(struct ata_port *ap)
>  	tf.lbal = (temp >> 8) & 0xff;
>  	tf.nsect = temp & 0xff;
>  
> -	return ata_dev_classify(&tf);
> +	return ata_port_classify(ap, &tf);
>  }
>  
>  static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index a6b76cc12a66..12f189f2ab1e 100644
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
> index 560070d4f1d0..2373cf5d8d14 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -677,7 +677,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	}
>  
>  	sil24_read_tf(ap, 0, &tf);
> -	*class = ata_dev_classify(&tf);
> +	*class = ata_port_classify(ap, &tf);
>  
>  	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 508f501095c9..0b784c298f97 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1173,7 +1173,10 @@ extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
>  extern enum ata_completion_errors ata_noop_qc_prep(struct ata_queued_cmd *qc);
>  extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
>  		 unsigned int n_elem);
> +extern const char *ata_dev_class_string(unsigned int class);
>  extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
> +extern unsigned int ata_port_classify(struct ata_port *ap,
> +				      const struct ata_taskfile *tf);
>  extern void ata_dev_disable(struct ata_device *adev);
>  extern void ata_id_string(const u16 *id, unsigned char *s,
>  			  unsigned int ofs, unsigned int len);
> 

