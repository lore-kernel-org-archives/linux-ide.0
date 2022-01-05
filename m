Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD46C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 06:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiAEGS7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:18:59 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47612 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231416AbiAEGSU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 01:18:20 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTK6f3lMyz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 22:18:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641363498; x=1643955499; bh=VwZguVML3EwB6g0YhRhquY46Z2k7489ZD0g
        /t0p7hYE=; b=FO8CQj/auj/zp2WaB/I5e5oqoFMYxKT8EywSHgYYZNXLl72iY1e
        hPpJ6yzq5dTxV0Ll/rWQWhC9ZOepdvhNJzOGbmvx5S9QBmB8R6oMJ3K1s0Xj9GKs
        DdnMTshlJlxbbuLnwobK5oJ3DYuaLEGcySLPD7OVaWN7BdMA66yRXHbPzreqvSZ9
        WW7aI6S0684+wfZfZtU2JL7+J84q6bPVLrC8NRq8bmlnJrCxHRvQczeHQMR1yF2I
        04oABXL8mtNgxYPH8R+NzHI5AC/w8YPe6ShiPblwZef2MDQ0RtzfNSPRoN5DW721
        k7B1tmH4iNcHfPb2v50aUFFB6X8PIbPbdpg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VurZZB8r-Ouh for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 22:18:18 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTK6d3R4Wz1VSkV;
        Tue,  4 Jan 2022 22:18:17 -0800 (PST)
Message-ID: <e48f13f0-f79a-e8a9-d8c2-cf53657d8072@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 15:18:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] libata: sysfs naming option
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220103090939.36238-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220103090939.36238-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/3/22 18:09, Hannes Reinecke wrote:
> This patch adds a config option ATA_SYSFS_NAMING to align the libata
> device names in sysfs with those in the kernel message log.
> It adds a new dummy bus 'ata', which collects all ata device objects
> like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix to the
> message log.
> For consistency the 'ata_dev' name has been changed from 'ata' to 'dev';
> as this induces a sysfs change the config option is disabled per default.
> 
> Patch is relative to the 'for-5.17-logging' branch from Damien.

FYI, I queued the logging series in for-5.17, minus this patch.
Everything is in for-next too to check that nothing is broken.

For this patch, as I commented, I think we can keep a backward
compatible naming using sysfs symlinks. But I am not entirely sure if
that can work with port-multiplier setups. Let's work on that for the
next cycle ?


> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/Kconfig            | 17 ++++++++++++++++
>  drivers/ata/libata-transport.c | 24 +++++++++++++++++++++--
>  include/linux/libata.h         | 36 ++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index f6e943c74001..9ebaa3c288dd 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -51,6 +51,23 @@ config ATA_VERBOSE_ERROR
>  
>  	  If unsure, say Y.
>  
> +config ATA_SYSFS_NAMING
> +	bool "Align sysfs device names with kernel messages"
> +	default n
> +	help
> +	  This option modifies the device naming to use a common
> +	  format for all ATA objects (port, link, and devices) and use
> +	  these names for both the sysfs directories and the kernel message
> +	  log to align with the linux driver model.
> +	  The names have the format ata<port>-<link>.<device>, such that an
> +	  ATA port will have the name 'ata<port>', an ATA link the name
> +	  'ata<port>-<link>', and an ATA device the name
> +	  'ata<port>-<link>.<devno>'.
> +	  This option changes the sysfs names, so userland tools might be
> +	  impacted.
> +
> +	  If unsure, say N.
> +
>  config ATA_FORCE
>  	bool "\"libata.force=\" kernel parameter support" if EXPERT
>  	default y
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index ca129854a88c..b537eadc6501 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -81,10 +81,14 @@ struct ata_internal {
>  	tdev_to_port((dev)->parent)
>  
>  
> -/* Device objects are always created whit link objects */
> +/* Device objects are always created with link objects */
>  static int ata_tdev_add(struct ata_device *dev);
>  static void ata_tdev_delete(struct ata_device *dev);
>  
> +struct bus_type ata_bus_type = {
> +        .name		= "ata",
> +};
> +
>  
>  /*
>   * Hack to allow attributes of the same name in different objects.
> @@ -288,7 +292,12 @@ int ata_tport_add(struct device *parent,
>  	dev->parent = parent;
>  	ata_host_get(ap->host);
>  	dev->release = ata_tport_release;
> +#ifdef CONFIG_ATA_SYSFS_NAMING
> +	dev->bus = &ata_bus_type;
> +	dev_set_name(dev, "port%d", ap->print_id);
> +#else
>  	dev_set_name(dev, "ata%d", ap->print_id);
> +#endif
>  	transport_setup_device(dev);
>  	ata_acpi_bind_port(ap);
>  	error = device_add(dev);
> @@ -444,6 +453,9 @@ int ata_tlink_add(struct ata_link *link)
>  	device_initialize(dev);
>  	dev->parent = &ap->tdev;
>  	dev->release = ata_tlink_release;
> +#ifdef CONFIG_ATA_SYSFS_NAMING
> +	dev->bus = &ata_bus_type;
> +#endif
>  	if (ata_is_host_link(link))
>  		dev_set_name(dev, "link%d", ap->print_id);
>  	else
> @@ -695,8 +707,11 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>  	device_initialize(dev);
>  	dev->parent = &link->tdev;
>  	dev->release = ata_tdev_release;
> +#ifdef CONFIG_ATA_SYSFS_NAMING
> +	dev->bus = &ata_bus_type;
> +#endif
>  	if (ata_is_host_link(link))
> -		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
> +		dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
>  	else
>  		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
>  
> @@ -822,8 +837,13 @@ __init int libata_transport_init(void)
>  	error = transport_class_register(&ata_dev_class);
>  	if (error)
>  		goto out_unregister_port;
> +	error = bus_register(&ata_bus_type);
> +	if (error)
> +		goto out_unregister_bus;
>  	return 0;
>  
> + out_unregister_bus:
> +	bus_unregister(&ata_bus_type);
>   out_unregister_port:
>  	transport_class_unregister(&ata_port_class);
>   out_unregister_link:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index c258f69106f4..ab2d404cde08 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1440,6 +1440,41 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  	return link->pmp;
>  }
>  
> +#ifdef CONFIG_ATA_SYSFS_NAMING
> +#define ata_port_err(ap, fmt, ...)				\
> +	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
> +#define ata_port_warn(ap, fmt, ...)				\
> +	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
> +#define ata_port_notice(ap, fmt, ...)				\
> +	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
> +#define ata_port_info(ap, fmt, ...)				\
> +	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
> +#define ata_port_dbg(ap, fmt, ...)				\
> +	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
> +
> +#define ata_link_err(link, fmt, ...)				\
> +	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
> +#define ata_link_warn(link, fmt, ...)				\
> +	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
> +#define ata_link_notice(link, fmt, ...)				\
> +	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
> +#define ata_link_info(link, fmt, ...)				\
> +	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
> +#define ata_link_dbg(link, fmt, ...)				\
> +	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
> +
> +#define ata_dev_err(dev, fmt, ...)				\
> +	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
> +#define ata_dev_warn(dev, fmt, ...)				\
> +	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
> +#define ata_dev_notice(dev, fmt, ...)				\
> +	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
> +#define ata_dev_info(dev, fmt, ...)				\
> +	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
> +#define ata_dev_dbg(dev, fmt, ...)				\
> +	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
> +
> +#else
>  #define ata_port_printk(level, ap, fmt, ...)			\
>  	pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
>  
> @@ -1495,6 +1530,7 @@ do {								\
>  	ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
>  #define ata_dev_dbg(dev, fmt, ...)				\
>  	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
> +#endif
>  
>  void ata_print_version(const struct device *dev, const char *version);
>  


-- 
Damien Le Moal
Western Digital Research
