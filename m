Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A6C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C682080C
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TwmamTGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJMZk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:25:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35502 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJMZk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:25:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210122537euoutp011fbdeea2b660251c95940dae9e07c279~yChzDieAd3071630716euoutp01j
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:25:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210122537euoutp011fbdeea2b660251c95940dae9e07c279~yChzDieAd3071630716euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581337537;
        bh=a9zSXlKpGV8U8nNPjN7uWVyV0q7ey0puDUU5PXBYlb0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TwmamTGIv1FSQvW3r6c/hwDuhR0BJQGWap6OldznIr17mI9Uhs6Tu2TFYKznbCXUv
         qcv1AnrTY/eUFPoPzWFAPd6hpx1g4mNVPhyFRznNu9OqLkZhkM/XbVyjkP6DK5d3Ld
         ucjyUAI/6Q92CiprBMh22lBpzTyZYdSvt4xqa8Qw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210122537eucas1p22ead0ae12537090d4db603c900f232f2~yChy5Jqsi1414214142eucas1p2k;
        Mon, 10 Feb 2020 12:25:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.90.61286.1CB414E5; Mon, 10
        Feb 2020 12:25:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210122537eucas1p29c9424b172c3b5ed1ff4179346a1530b~yChyjkmvj2170821708eucas1p2K;
        Mon, 10 Feb 2020 12:25:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210122537eusmtrp1eb66493730797a7ee09e07e798aa48bd~yChyjAApS0417504175eusmtrp1o;
        Mon, 10 Feb 2020 12:25:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-4a-5e414bc13113
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.53.08375.1CB414E5; Mon, 10
        Feb 2020 12:25:37 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210122536eusmtip255ceda7d0f97ef57a240b5788c930c41~yChxcnuVQ2144421444eusmtip2y;
        Mon, 10 Feb 2020 12:25:36 +0000 (GMT)
Subject: Re: [PATCH 04/46] libata: move ata_{port,link,dev}_dbg to standard
 dev_XXX() macros
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a8c1f276-a79e-5bca-1d21-205d80eddf73@samsung.com>
Date:   Mon, 10 Feb 2020 13:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-5-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7oHvR3jDNr/KFusvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGraNTWAvW
        plTcv3aIvYGxy7+LkZNDQsBE4t/xPqYuRi4OIYEVjBKf/51ihXC+MEoc3r2QGcL5zCixdM50
        oAwHWMuOK94Q8eWMEttOXWCBcN4ySnw/v50NpEhYIE7i1ckQkBUiAkoSH9sPsYPYzEDhpit3
        wWw2ASuJie2rGEFsXgE7iYXPF7CB2CwCqhLvb+wBi4sKREh8enCYFaJGUOLkzCcsIDangLHE
        2uetUDPFJW49mc8EYctLbH87B+xoCYF+dok9/6+yQBztIvHzVRbEy8ISr45vYYewZSROT+5h
        gahfxyjxt+MFVPN2Ronlk/+xQVRZS9w59wvsMWYBTYn1u/Qhwo4S05vmMkHM55O48VYQ4gY+
        iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5B8NgvJN7OQfDMLYe8CRpZVjOKppcW5
        6anFhnmp5XrFibnFpXnpesn5uZsYgUnl9L/jn3Ywfr2UdIhRgINRiYfXwd4hTog1say4MvcQ
        owQHs5IIr6W0Y5wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwc
        nFINjHbBL6tWxFnv9bsZEyT1fHq105W105b+07NXv7+YoXhuktm7WA9jH4W/Wd7L/sdt5rI/
        ucpoW9nTT53OO6UU8223VByrXHT+sMLxS6Jxv6X2igso6zZvWKW6JCL1tuCKR56bu9jn/zlR
        cXxdyuaS46JdWTEHwjsfPl+ZeTDnLUfqAWWnfrdVGUosxRmJhlrMRcWJAAsqGv8mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7oHvR3jDL6u57dYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MW0ensBasTam4f+0QewNjl38XIweHhICJ
        xI4r3l2MnBxCAksZJdbvZIcIy0gcX18GEpYQEJb4c62LrYuRC6jkNaPE6u/vmEBqhAXiJF6d
        DAGpERFQkvjYfogdxGYGCv/r280EMXI9o8Tpx8EgNpuAlcTE9lWMIDavgJ3EwucL2EBsFgFV
        ifc39oDFRQUiJA7vmAVVIyhxcuYTFhCbU8BYYu3zVqj56hJ/5l1ihrDFJW49mc8EYctLbH87
        h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIERtO3Yz807
        GC9tDD7EKMDBqMTD62DvECfEmlhWXJl7iFGCg1lJhNdS2jFOiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OB0Z1XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoEx
        2+Clb5NVlXRQpOkuiSt1+ccl/01+fHzHiVc92kx2Z7ZKHNwUerbM8/HJ3VlbT+9llQy6sutB
        F8c656BPwbPCFvjIHtnFJPxMr54xb2Voqvc7v5WTtXu2LpbkjBe5WeXgXb565U673JIvBY80
        wpRXTtxgveyrmH/Oo9lSzA9C/Y3sbljw/nVVYinOSDTUYi4qTgQAGCHhD7YCAAA=
X-CMS-MailID: 20200210122537eucas1p29c9424b172c3b5ed1ff4179346a1530b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165609eucas1p2a3437209579484cf0f8f05883cdd6ede
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165609eucas1p2a3437209579484cf0f8f05883cdd6ede
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165609eucas1p2a3437209579484cf0f8f05883cdd6ede@eucas1p2.samsung.com>
        <20200204165547.115220-5-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Use standard dev_{dbg,info,notice,warn,err} macros instead of the
> hand-crafted printk helpers.
> Also change the name for 'ata_device' structure to ataX:Y to be
> inline with the other ata object names.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/ahci.c             |  3 +--
>  drivers/ata/libata-acpi.c      | 48 ++++++++++++++++++---------------
>  drivers/ata/libata-core.c      | 61 ------------------------------------------
>  drivers/ata/libata-transport.c |  4 +--
>  include/linux/libata.h         | 48 +++++++++++----------------------
>  5 files changed, 45 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4bfd1b14b390..b2719c64fc04 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -796,8 +796,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  				(sstatus & 0xf) != 1)
>  			break;
>  
> -		ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
> -				port);
> +		ata_link_info(link, "avn bounce port%d\n", port);
>  
>  		pci_read_config_word(pdev, 0x92, &val);
>  		val &= ~(1 << port);
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 224e3486e9a5..9a7c25252e50 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -649,9 +649,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  	struct ata_taskfile *pptf = NULL;
>  	struct ata_taskfile tf, ptf, rtf;
>  	unsigned int err_mask;
> -	const char *level;
>  	const char *descr;
> -	char msg[60];
>  	int rc;
>  
>  	if ((gtf->tf[0] == 0) && (gtf->tf[1] == 0) && (gtf->tf[2] == 0)
> @@ -665,6 +663,10 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  		pptf = &ptf;
>  	}
>  
> +	descr = ata_get_cmd_descript(tf.command);
> +	if (!descr)
> +		descr = "unknown";
> +
>  	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
>  		rtf = tf;
>  		err_mask = ata_exec_internal(dev, &rtf, NULL,
> @@ -672,40 +674,42 @@ static int ata_acpi_run_tf(struct ata_device *dev,
>  
>  		switch (err_mask) {
>  		case 0:
> -			level = KERN_DEBUG;
> -			snprintf(msg, sizeof(msg), "succeeded");
> +			ata_dev_dbg(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) succeeded\n",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr);
>  			rc = 1;
>  			break;
>  
>  		case AC_ERR_DEV:
> -			level = KERN_INFO;
> -			snprintf(msg, sizeof(msg),
> -				 "rejected by device (Stat=0x%02x Err=0x%02x)",
> -				 rtf.command, rtf.feature);
> +			ata_dev_info(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) rejected by device (Stat=0x%02x Err=0x%02x)",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr,
> +				rtf.command, rtf.feature);
>  			rc = 0;
>  			break;
>  
>  		default:
> -			level = KERN_ERR;
> -			snprintf(msg, sizeof(msg),
> -				 "failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
> -				 err_mask, rtf.command, rtf.feature);
> +			ata_dev_err(dev,
> +				"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +				"(%s) failed (Emask=0x%x Stat=0x%02x Err=0x%02x)",
> +				tf.command, tf.feature, tf.nsect, tf.lbal,
> +				tf.lbam, tf.lbah, tf.device, descr,
> +				err_mask, rtf.command, rtf.feature);
>  			rc = -EIO;
>  			break;
>  		}
>  	} else {
> -		level = KERN_INFO;
> -		snprintf(msg, sizeof(msg), "filtered out");
> +		ata_dev_info(dev,
> +			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x"
> +			"(%s) filtered out\n",
> +			tf.command, tf.feature, tf.nsect, tf.lbal,
> +			tf.lbam, tf.lbah, tf.device, descr);
>  		rc = 0;
>  	}
> -	descr = ata_get_cmd_descript(tf.command);
> -
> -	ata_dev_printk(dev, level,
> -		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
> -		       tf.command, tf.feature, tf.nsect, tf.lbal,
> -		       tf.lbam, tf.lbah, tf.device,
> -		       (descr ? descr : "unknown"), msg);
> -
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6f4ab5c5b52d..cee815ecd7df 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -7236,67 +7236,6 @@ const struct ata_port_info ata_dummy_port_info = {
>  	.port_ops		= &ata_dummy_port_ops,
>  };
>  
> -/*
> - * Utility print functions
> - */
> -void ata_port_printk(const struct ata_port *ap, const char *level,
> -		     const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	printk("%sata%u: %pV", level, ap->print_id, &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_port_printk);
> -
> -void ata_link_printk(const struct ata_link *link, const char *level,
> -		     const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	if (sata_pmp_attached(link->ap) || link->ap->slave_link)
> -		printk("%sata%u.%02u: %pV",
> -		       level, link->ap->print_id, link->pmp, &vaf);
> -	else
> -		printk("%sata%u: %pV",
> -		       level, link->ap->print_id, &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_link_printk);
> -
> -void ata_dev_printk(const struct ata_device *dev, const char *level,
> -		    const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	printk("%sata%u.%02u: %pV",
> -	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
> -	       &vaf);
> -
> -	va_end(args);
> -}
> -EXPORT_SYMBOL(ata_dev_printk);
> -
>  void ata_print_version(const struct device *dev, const char *version)
>  {
>  	dev_printk(KERN_DEBUG, dev, "version %s\n", version);
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 4ccfeb85ec66..db42bd05c4cf 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -666,9 +666,9 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>  	dev->parent = &link->tdev;
>  	dev->release = ata_tdev_release;
>  	if (ata_is_host_link(link))
> -		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
> +		dev_set_name(dev, "ata%d.%d", ap->print_id, ata_dev->devno);
>  	else
> -		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
> +		dev_set_name(dev, "ata%d.%d.0", ap->print_id, link->pmp);

This change should be moved to a separate (pre-)patch.

However I worry that it is too late to change the device name as
it is a part of user-space ABI.

Please see Documentation/ABI/testing/sysfs-ata:

[...]
Files under /sys/class/ata_device
---------------------------------

Behind each link, up to two ata devices are created.
The name of the directory is devX[.Y].Z where:
- X is ata_port_id of the port where the device is connected,
- Y the port of the PM if any, and
- Z the device id: for PATA, there is usually 2 devices [0,1], only 1 for SATA.


What:           /sys/class/ata_device/devX[.Y].Z/spdn_cnt
What:           /sys/class/ata_device/devX[.Y].Z/gscr
What:           /sys/class/ata_device/devX[.Y].Z/ering
What:           /sys/class/ata_device/devX[.Y].Z/id
What:           /sys/class/ata_device/devX[.Y].Z/pio_mode
What:           /sys/class/ata_device/devX[.Y].Z/xfer_mode
What:           /sys/class/ata_device/devX[.Y].Z/dma_mode
What:           /sys/class/ata_device/devX[.Y].Z/class
Date:           May, 2010
KernelVersion:  v2.6.37
Contact:        Gwendal Grignou <gwendal@chromium.org>
[...]

>  	transport_setup_device(dev);
>  	ata_acpi_bind_dev(ata_dev);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 19c9c32bd339..437d2f27bfdd 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1414,51 +1414,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  	return link->pmp;
>  }
>  
> -/*
> - * printk helpers
> - */
> -__printf(3, 4)
> -void ata_port_printk(const struct ata_port *ap, const char *level,
> -		     const char *fmt, ...);
> -__printf(3, 4)
> -void ata_link_printk(const struct ata_link *link, const char *level,
> -		     const char *fmt, ...);
> -__printf(3, 4)
> -void ata_dev_printk(const struct ata_device *dev, const char *level,
> -		    const char *fmt, ...);
> -
>  #define ata_port_err(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_warn(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_notice(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_info(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_dbg(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_link_err(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_warn(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_notice(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_info(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_dbg(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&link->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_dev_err(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
> +	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_warn(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
> +	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_notice(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_NOTICE, fmt, ##__VA_ARGS__)
> +	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_info(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
> +	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_dbg(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&dev->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)

Addition of __func__ to ata_{port,link,dev}_dbg() should be done in
a separate (post-)patch.

It should also be done together with fixing existing ata_*_dbg()
instances that are already using __func__:

drivers/ata/libata-sff.c:               ata_port_dbg(ap, "%s: EXIT\n", __func__);
drivers/ata/pata_amd.c: ata_port_dbg(ap, "nv_mode_filter: 0x%lx&0x%lx->0x%lx, "
drivers/ata/libata-acpi.c:              ata_dev_dbg(dev, "%s: ENTER: port#: %d\n",
drivers/ata/libata-acpi.c-                          __func__, ap->port_no);
drivers/ata/libata-acpi.c:                      ata_dev_dbg(dev, "%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
drivers/ata/libata-acpi.c-                                  __func__,
drivers/ata/libata-acpi.c:                      ata_dev_dbg(dev, "%s: returning gtf=%p, gtf_count=%d\n",
drivers/ata/libata-acpi.c-                                  __func__, *gtf, rc);
drivers/ata/libata-acpi.c:              ata_dev_dbg(dev, "%s: ix = %d, port#: %d\n",
drivers/ata/libata-acpi.c-                          __func__, dev->devno, ap->port_no);
drivers/ata/libata-core.c:              ata_dev_dbg(dev, "%s: ENTER\n", __func__);
drivers/ata/libata-core.c:              ata_dev_dbg(dev, "%s: ENTER\n", __func__);
drivers/ata/libata-core.c:              ata_dev_dbg(dev, "%s: EXIT, err\n", __func__);

so we don't end up with duplicated __func__ info.

The rest of the patch looks fine.

>  void ata_print_version(const struct device *dev, const char *version);
>  
> @@ -1980,11 +1967,8 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
>  {
>  	u8 status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
>  
> -#ifdef ATA_DEBUG
>  	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
> -		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
> -				status);
> -#endif
> +		ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>  
>  	return status;
>  }
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
