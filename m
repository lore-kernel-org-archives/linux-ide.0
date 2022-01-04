Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DE0C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 08:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiADI0q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 03:26:46 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:27243 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234009AbiADI0q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 03:26:46 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSm1K6DrWz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 00:26:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641284805; x=1643876806; bh=0u0tmKUdUWjatLJyvDmQOKby8JYrNZ4rhu+
        46qKogQA=; b=JwA2avfkudunIOB0Yh2g9U16XM46OJcCcTMarlF3ov6JEQHDwS8
        gZvExo2FWu90K7OQEfsmw4jw8wno0JkBKJCyvZv/kEMw9StB6KD2wNzc/Rou1Ov1
        4KWDJXH4pDHBkJC6jshLJp75cTumvCkh14YH58fKwyUyvWlmQAWFKKlVeLZxdMFh
        Jrj4YLTU43AH3d2J5Kyvddg9AIgx1TszlhLk4wcUlv/dZS03W2D9oVWFCki17k0z
        zwkI0glrIpvxI9JHJhzQtz3s8HiflMehATgtxLnfSycDjDCMoWWIqovLZgg68vwL
        eNDUnr0lVxdu6iXDOFa9Jfz0HAv+pX92rHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jWHkUGq3cCed for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 00:26:45 -0800 (PST)
Received: from [10.225.163.42] (unknown [10.225.163.42])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSm1J68CGz1VSjC;
        Tue,  4 Jan 2022 00:26:44 -0800 (PST)
Message-ID: <aeb4bd10-44d0-c90b-4b81-7e04bd1e877e@opensource.wdc.com>
Date:   Tue, 4 Jan 2022 17:26:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] libata: sysfs naming option
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
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

Before the patch, in sysfs:

# tree /sys/class/ata_device/
/sys/class/ata_device/
...
|-- dev8.0 ->
../../devices/pci0000:00/0000:00:17.0/ata8/link8/dev8.0/ata_device/dev8.0
...

# tree /sys/class/ata_port/
/sys/class/ata_port/
...
|-- ata8 -> ../../devices/pci0000:00/0000:00:17.0/ata8/ata_port/ata8
...

# tree /sys/class/ata_link/
/sys/class/ata_link/
...
|-- link8 -> ../../devices/pci0000:00/0000:00:17.0/ata8/link8/ata_link/link8
...

And the dmesg:

[   20.713229] ata8: SATA max UDMA/133 abar m524288@0x9d200000 port
0x9d200380 irq 309
[   21.024579] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   21.025763] ata8.00: ATA-9: WDC  WUH721414ALE604, LDGNW240, max UDMA/133
[   21.035186] ata8.00: 27344764928 sectors, multi 16: LBA48 NCQ (depth
32), AA
[   21.377184] ata8.00: Features: NCQ-sndrcv NCQ-prio
[   21.432131] ata8.00: configured for UDMA/133

After the patch, in sysfs:

# tree ata_device/
ata_device/
...
|-- dev8.0 ->
../../devices/pci0000:00/0000:00:17.0/port8/link8/dev8.0/ata_device/dev8.0
...

# tree ata_port/
ata_port/
...
|-- port8 -> ../../devices/pci0000:00/0000:00:17.0/port8/ata_port/port8
...

# tree ata_link/
ata_link/
...
|-- link8 ->
../../devices/pci0000:00/0000:00:17.0/port8/link8/ata_link/link8
...

And the dmesg:

[   20.973002] ata port8: SATA max UDMA/133 abar m524288@0x9d200000 port
0x9d200380 irq 308
[   21.355104] ata link8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   21.412804] ata dev8.0: ATA-9: WDC  WUH721414ALE604, LDGNW240, max
UDMA/133
[   22.646935] ata dev8.0: 27344764928 sectors, multi 16: LBA48 NCQ
(depth 32), AA
[   22.680872] ata dev8.0: Features: NCQ-sndrcv NCQ-prio
[   22.748586] ata dev8.0: configured for UDMA/133

So for the dmesg changes, this looks all good to me. As readable as
before, no real change. If anything, we now clearly see if the message
if from ata_dev_xxx(), ata_port_xxx() or ata_link_XXX() functions.

For sysfs changes, the real change is "ataX" becoming "portX" and the
addition of the new ata bus:

# tree /sys/bus/ata
...
|   |-- dev8.0 ->
../../../devices/pci0000:00/0000:00:17.0/port8/link8/dev8.0
...
|   |-- link8 -> ../../../devices/pci0000:00/0000:00:17.0/port8/link8
...
|   |-- port8 -> ../../../devices/pci0000:00/0000:00:17.0/port8
...

All good.

And I wonder if we could not add a symbolic link named "ataX" pointing
to "portX" (the new name) to avoid breaking userspace. That would allow
dropping the Kconfig option. Hmm ?

-- 
Damien Le Moal
Western Digital Research
