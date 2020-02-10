Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C32C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D3B2070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jnjdz9Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJLvJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:51:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49079 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJLvI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 06:51:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210115106euoutp010e12bee5fe77a28cab1246c8b2a066e9~yCDqIuW7t0412404124euoutp01D
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 11:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210115106euoutp010e12bee5fe77a28cab1246c8b2a066e9~yCDqIuW7t0412404124euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581335466;
        bh=YAX8oqGBV8ClQo477d1/9huOg4u5dNBBb8Nzs8rLxNU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jnjdz9VsKG0G0CRP9C6O65AMEk7IlIUkEeSBIfmPY6E420sE0H0F9B0QMSUvoqUac
         gGNauCgcht+TCLjbij7ka8nWFnOuHqM+YcxafDpMgyUGS5Imadd3FnCamSHbkTVhxG
         lU8ADDn/U6jeItV2N3GF63H15veuIRxQjHlRZeZ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210115106eucas1p27ccb1acd942e4701c2ac94bc301a8e2c~yCDqBjUpd2287422874eucas1p2j;
        Mon, 10 Feb 2020 11:51:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.AE.60698.AA3414E5; Mon, 10
        Feb 2020 11:51:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210115106eucas1p2f9a0a24206a45365de9835771b2d7a8c~yCDpwgrAE0066800668eucas1p2K;
        Mon, 10 Feb 2020 11:51:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210115106eusmtrp29234e2c79ddfd268303ebb4578cc7aab~yCDpv--xG3226632266eusmtrp2I;
        Mon, 10 Feb 2020 11:51:06 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ce-5e4143aae3da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.5E.08375.AA3414E5; Mon, 10
        Feb 2020 11:51:06 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210115105eusmtip17580788df647a637f59597b7305ae1d3~yCDpc_MBu0653706537eusmtip1D;
        Mon, 10 Feb 2020 11:51:05 +0000 (GMT)
Subject: Re: [PATCH 02/46] libata.h: whitespace and indentation fixes
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7bcf24d1-9f22-3bd7-40f7-a79cf2a6f25b@samsung.com>
Date:   Mon, 10 Feb 2020 12:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-3-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd1Vzo5xBhc+yFmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGYdWdTMWnNCt6J20hrWB8ZhK
        FyMnh4SAicTiiwfYuxi5OIQEVjBKfHq2nQnC+cIoMXnxVSjnM6PEnkl97DAtB758YINILGeU
        WDRrPTOE85ZR4sS2bYwgVcICrhIfz/5hArFFBJQkPrYfAutmFrCWmL14PVicTcBKYmL7KrB6
        XgE7ic8PF7OC2CwCqhJ31p9hAbFFBSIkPj04zApRIyhxcuYTsDingLHEjTv32CBmikvcejKf
        CcKWl9j+dg7YQRICzewSz95NZYM420Vi7etNLBC2sMSr41ug3pGR+L9zPhNEwzpGib8dL6C6
        tzNKLJ/8D6rbWuLOuV9ANgfQCk2J9bv0IcKOEtMn3GAHCUsI8EnceCsIcQSfxKRt05khwrwS
        HW1CENVqEhuWbWCDWdu1cyXzBEalWUhem4XknVlI3pmFsHcBI8sqRvHU0uLc9NRi47zUcr3i
        xNzi0rx0veT83E2MwDRy+t/xrzsY9/1JOsQowMGoxMM7w9EhTog1say4MvcQowQHs5IIr6W0
        Y5wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjPt+vOh/
        czfN3Oid3qcbPYWyrIGXJ5usmnuitJSledsXrnDZ5b1ql9c+XFQwy/KkLW/H3xlT3hp+Wuvm
        /qM5Yi1H3fI4Fau9eqs+6TvkXxUwy1f6xhTn6LQsyln+T0WvVHqI6cZa1RnRPFqtoTKL/D82
        hXKsv/uxINw2dtOh6MqoG5cZ0vXzlFiKMxINtZiLihMBx+/LnB8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7qrnB3jDFqfclisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GYdWdTMWnNCt6J20hrWB8ZhKFyMnh4SAicSBLx/YQGwhgaWM
        EhebgGwOoLiMxPH1ZRAlwhJ/rnUBhbmASl4zStz+1g5WLyzgKvHx7B8mEFtEQEniY/shdhCb
        WcBaYvbi9UwQDesZJa5s2AlWxCZgJTGxfRUjiM0rYCfx+eFiVhCbRUBV4s76MywgtqhAhMTh
        HbOgagQlTs58AhbnFDCWuHHnHhvEAnWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUha
        ZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAmNl27OfmHYyXNgYfYhTgYFTi
        4XWwd4gTYk0sK67MPcQowcGsJMJrKe0YJ8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wHjO
        K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqKVzq/8Mf56t2lq9
        M28FLn5IviczYXekikBp655Jbq9EEnyMDl08xO61LPvQ5bc6Ki/7HjjMe/PmQOZ/+zehMkFr
        e/ev8QucHbFXtfPhh6TAbf/yYqaqHXkhdrCfYdL3lfZeVtLZD7bJH1i878ec2jPSkRsuNSvc
        nmpXfrLiyDNOGd13j+d8uKTEUpyRaKjFXFScCADjYN/MrwIAAA==
X-CMS-MailID: 20200210115106eucas1p2f9a0a24206a45365de9835771b2d7a8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165609eucas1p1c43442d85f050cdce16537b11878f8b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165609eucas1p1c43442d85f050cdce16537b11878f8b1
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165609eucas1p1c43442d85f050cdce16537b11878f8b1@eucas1p1.samsung.com>
        <20200204165547.115220-3-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index bd78646f88a0..19c9c32bd339 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -593,7 +593,7 @@ struct ata_ioports {
>  
>  struct ata_host {
>  	spinlock_t		lock;
> -	struct device 		*dev;
> +	struct device		*dev;
>  	void __iomem * const	*iomap;
>  	unsigned int		n_ports;
>  	unsigned int		n_tags;			/* nr of NCQ tags */
> @@ -813,7 +813,7 @@ struct ata_port {
>  	/* Flags that change dynamically, protected by ap->lock */
>  	unsigned int		pflags; /* ATA_PFLAG_xxx */
>  	unsigned int		print_id; /* user visible unique port ID */
> -	unsigned int            local_port_no; /* host local port num */
> +	unsigned int		local_port_no; /* host local port num */
>  	unsigned int		port_no; /* 0 based port no. inside the host */
>  
>  #ifdef CONFIG_ATA_SFF
> @@ -848,7 +848,7 @@ struct ata_port {
>  
>  	struct ata_port_stats	stats;
>  	struct ata_host		*host;
> -	struct device 		*dev;
> +	struct device		*dev;
>  	struct device		tdev;
>  
>  	struct mutex		scsi_scan_mutex;
> @@ -900,11 +900,14 @@ struct ata_port_operations {
>  	 * Configuration and exception handling
>  	 */
>  	int  (*cable_detect)(struct ata_port *ap);
> -	unsigned long (*mode_filter)(struct ata_device *dev, unsigned long xfer_mask);
> +	unsigned long (*mode_filter)(struct ata_device *dev,
> +				     unsigned long xfer_mask);
>  	void (*set_piomode)(struct ata_port *ap, struct ata_device *dev);
>  	void (*set_dmamode)(struct ata_port *ap, struct ata_device *dev);
> -	int  (*set_mode)(struct ata_link *link, struct ata_device **r_failed_dev);
> -	unsigned int (*read_id)(struct ata_device *dev, struct ata_taskfile *tf, u16 *id);
> +	int  (*set_mode)(struct ata_link *link,
> +			 struct ata_device **r_failed_dev);
> +	unsigned int (*read_id)(struct ata_device *dev,
> +				struct ata_taskfile *tf, u16 *id);
>  
>  	void (*dev_config)(struct ata_device *dev);
>  
> @@ -999,7 +1002,7 @@ struct ata_port_info {
>  	unsigned long		mwdma_mask;
>  	unsigned long		udma_mask;
>  	struct ata_port_operations *port_ops;
> -	void 			*private_data;
> +	void			*private_data;
>  };
>  
>  struct ata_timing {
> @@ -1103,7 +1106,8 @@ extern int ata_host_activate(struct ata_host *host, int irq,
>  			     irq_handler_t irq_handler, unsigned long irq_flags,
>  			     struct scsi_host_template *sht);
>  extern void ata_host_detach(struct ata_host *host);
> -extern void ata_host_init(struct ata_host *, struct device *, struct ata_port_operations *);
> +extern void ata_host_init(struct ata_host *, struct device *,
> +			  struct ata_port_operations *);
>  extern int ata_scsi_detect(struct scsi_host_template *sht);
>  extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
>  			  void __user *arg);
> @@ -1117,7 +1121,8 @@ extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
>  			    unsigned int cmd, void __user *arg);
>  extern void ata_sas_port_destroy(struct ata_port *);
>  extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
> -					   struct ata_port_info *, struct Scsi_Host *);
> +					   struct ata_port_info *,
> +					   struct Scsi_Host *);
>  extern void ata_sas_async_probe(struct ata_port *ap);
>  extern int ata_sas_sync_probe(struct ata_port *ap);
>  extern int ata_sas_port_init(struct ata_port *);
> @@ -1188,12 +1193,17 @@ extern int ata_scsi_slave_config(struct scsi_device *sdev);
>  extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>  extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>  				       int queue_depth);
> -extern int __ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
> +extern int __ata_change_queue_depth(struct ata_port *ap,
> +				    struct scsi_device *sdev,
>  				    int queue_depth);
>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
> -extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
> -extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
> -extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
> +extern int ata_do_set_mode(struct ata_link *link,
> +			   struct ata_device **r_failed_dev);
> +extern void ata_scsi_port_error_handler(struct Scsi_Host *host,
> +					struct ata_port *ap);
> +extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host,
> +				       struct ata_port *ap,
> +				       struct list_head *eh_q);
>  extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
>  
>  extern int ata_cable_40wire(struct ata_port *ap);
> @@ -1223,7 +1233,8 @@ struct pci_bits {
>  	unsigned long		val;
>  };
>  
> -extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
> +extern int pci_test_config_bits(struct pci_dev *pdev,
> +				const struct pci_bits *bits);
>  extern void ata_pci_remove_one(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_PM
> @@ -1496,7 +1507,7 @@ static inline bool ata_tag_valid(unsigned int tag)
>   * Internal use only, iterate commands ignoring error handling and
>   * status of 'qc'.
>   */
> -#define ata_qc_for_each_raw(ap, qc, tag)					\
> +#define ata_qc_for_each_raw(ap, qc, tag)			\
>  	__ata_qc_for_each(ap, qc, tag, ATA_MAX_QUEUE, __ata_qc_from_tag)
>  
>  /*
> 
