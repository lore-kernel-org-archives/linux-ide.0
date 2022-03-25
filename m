Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F137C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 03:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354366AbiCYDHU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356499AbiCYDHT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 23:07:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D86E290
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 20:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648177544; x=1679713544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T2vLq1IiJ4qYhj/gtAryNicF1VZIGBEIFJzQs3PRqbQ=;
  b=DH/eqK0jk7Yad/j74gLL4yawBUqlIfD2IdeyaeBrBR86XsLaYPzSb6BR
   r8nNbZ1KrT/5We8L5kXJX52xkgBwc1UFpl3aixiTpxliM8TEJ3Rp322gp
   wZUgcpNARWDwVa1+I5pT2UzwR9gKzeKFYIQ7wko0TUq4njvSN95S2arwe
   JZicobeC4R1nIPC0eeb2kOAINYvpJ8Z7ekJjeQtISfwKyAUd6ZA79i5z3
   VM/Bf0jDmRXxBEp+oR/L/RZQzwoVT/85Kh1feeIpYBDcc2218ob1eywCu
   wKUAV6Vv9ERgmhncAqIQ79GepUILxvCHjtIFz5RFnCzEuSvro3OyjzueB
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="201074233"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 11:05:43 +0800
IronPort-SDR: pdpZ/sQeGGYMLlCWl9X80a0/TberSuZqsWOSs+6S8ylzmy4XncSReo4JaMGiD/MpvwkI4JZiD3
 2iNFhL2olvjJozVgItpC2VrY8YJ62yXj5Y6QCvsth1Juyjaa7IYvoWTgbGk2TdoG0kg27WMw5U
 65IjyMft+Z5SMrs5eoa28ZgjDDPL/FVXdaKZpKO7KudxX2d34hoCyFi2XrUVcFhKDOxYrovA5n
 pzbv53E4vVX2EwXbfMWXiibRR1/8Aq0bqCG/p50lFIUJsqjrG0iIS6etPKsPYK3AFjnTtpzh0k
 kMepQaaOcxm37C1bWHlLNWEo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:37:35 -0700
IronPort-SDR: ounlDj6IPhhG8hmC2PhbboKwQ4EH9rSKVYlQio7SrB33IJIUvmRmpuvdj4tOGt0uYD97FNxQgd
 ZxxMXZZBarH8xRLhZrCbq/8pAzErUswliCmWLaVH1jAa23g9JGZec5JkjWIQmbRKnPtluSzJ6Q
 +k+4+AfOnc2xlXpAGqY4Q73kSk9zFSWenz1uyDPz4Ly3q+xL7DrgkBz0ECetlD3loap0J1w87b
 dtQSqh0bJhxl5RbIs79Gwcp79k3o0yPD/YFrQlYg7i7i+O+HFRXLRwmzOeK9XRkM9mENBFYFbd
 WKc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 20:05:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPn6002f0z1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 20:05:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648177543; x=1650769544; bh=T2vLq1IiJ4qYhj/gtAryNicF1VZIGBEIFJz
        Qs3PRqbQ=; b=uqmubHaW0xZw4GsAzDa+8Nw59U2kszQ6Jq99T8EZydogEw/mN0y
        KCu5V6VTMQxJ4xEJMsEuTRCdXZa1neM9iDb4smmT6Aslb91kSUn/PQs0cRGKMEpT
        416c1qz5Od4idpcUow4IYgmQyVw5/VhM47zUlO+h6P3tysB9rurMmUDlvetC+8RS
        7xfDH8gmUFXWBkzX4l+Ydax+bXWI2+e0jZIwEEF938ZLCipeisNmtELf4iILc9uM
        +t8iin+kQ5c9OrL0tR2WQH9wl+Khhbv3aHM5lSfNlbM0wtpP7bjrsbRlxOeLe853
        USSCXVoaXrYH2P9U2FEd+QMjJ/gcqTPKOpQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZZvFbN4ZK7K6 for <linux-ide@vger.kernel.org>;
        Thu, 24 Mar 2022 20:05:43 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPn5y6xwPz1Rvlx;
        Thu, 24 Mar 2022 20:05:42 -0700 (PDT)
Message-ID: <62a7433e-d9f4-a95b-818c-0f1d31160ac8@opensource.wdc.com>
Date:   Fri, 25 Mar 2022 12:05:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] libata: rework sysfs naming
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220324123204.61534-1-hare@suse.de>
 <20220324123204.61534-2-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324123204.61534-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 21:32, Hannes Reinecke wrote:
> This patch adds a new dummy bus 'ata', which collects all ata device
> objects like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix
> to the message log.
> To be consistent with the other libata objects the 'ata_port' object name
> has been changed from 'ata' to 'port'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/ata/libata-transport.c | 21 +++++++++++--
>   include/linux/libata.h         | 54 ++++++++++------------------------
>   2 files changed, 34 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index ca129854a88c..555fe6e2293d 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -81,10 +81,13 @@ struct ata_internal {
>   	tdev_to_port((dev)->parent)
>   
>   
> -/* Device objects are always created whit link objects */
> +/* Device objects are always created with link objects */
>   static int ata_tdev_add(struct ata_device *dev);
>   static void ata_tdev_delete(struct ata_device *dev);
>   
> +struct bus_type ata_bus_type = {
> +        .name		= "ata",
> +};
>   
>   /*
>    * Hack to allow attributes of the same name in different objects.
> @@ -288,7 +291,9 @@ int ata_tport_add(struct device *parent,
>   	dev->parent = parent;
>   	ata_host_get(ap->host);
>   	dev->release = ata_tport_release;
> -	dev_set_name(dev, "ata%d", ap->print_id);
> +	dev->bus = &ata_bus_type;
> +	dev_set_name(dev, "port%d", ap->print_id);
> +
>   	transport_setup_device(dev);
>   	ata_acpi_bind_port(ap);
>   	error = device_add(dev);
> @@ -444,6 +449,8 @@ int ata_tlink_add(struct ata_link *link)
>   	device_initialize(dev);
>   	dev->parent = &ap->tdev;
>   	dev->release = ata_tlink_release;
> +	dev->bus = &ata_bus_type;
> +
>   	if (ata_is_host_link(link))
>   		dev_set_name(dev, "link%d", ap->print_id);
>   	else
> @@ -695,8 +702,10 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>   	device_initialize(dev);
>   	dev->parent = &link->tdev;
>   	dev->release = ata_tdev_release;
> +	dev->bus = &ata_bus_type;
> +
>   	if (ata_is_host_link(link))
> -		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
> +		dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
>   	else
>   		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
>   
> @@ -822,8 +831,13 @@ __init int libata_transport_init(void)
>   	error = transport_class_register(&ata_dev_class);
>   	if (error)
>   		goto out_unregister_port;
> +	error = bus_register(&ata_bus_type);
> +	if (error)
> +		goto out_unregister_bus;

Why is it needed to call bus_unregister() if bus_register() fails ? 
Shouldn't this be a "goto out_unregister_dev" which does a 
"transport_class_unregister(&ata_dev_class)" ?

>   	return 0;
>   
> + out_unregister_bus:
> +	bus_unregister(&ata_bus_type);
>    out_unregister_port:
>   	transport_class_unregister(&ata_port_class);
>    out_unregister_link:
> @@ -835,6 +849,7 @@ __init int libata_transport_init(void)
>   
>   void __exit libata_transport_exit(void)
>   {
> +	bus_unregister(&ata_bus_type);
>   	transport_class_unregister(&ata_link_class);
>   	transport_class_unregister(&ata_port_class);
>   	transport_class_unregister(&ata_dev_class);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 0619ae462ecd..b17683b00c90 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -835,6 +835,7 @@ struct ata_port {
>   	struct ata_host		*host;
>   	struct device 		*dev;
>   	struct device		tdev;
> +	struct device		cdev;

This one is not used...

>   
>   	struct mutex		scsi_scan_mutex;
>   	struct delayed_work	hotplug_task;
> @@ -1458,61 +1459,38 @@ static inline int sata_srst_pmp(struct ata_link *link)
>   	return link->pmp;
>   }
>   
> -#define ata_port_printk(level, ap, fmt, ...)			\
> -	pr_ ## level ("ata%u: " fmt, (ap)->print_id, ##__VA_ARGS__)
> -
>   #define ata_port_err(ap, fmt, ...)				\
> -	ata_port_printk(err, ap, fmt, ##__VA_ARGS__)
> +	dev_err(&ap->tdev, fmt, ##__VA_ARGS__)
>   #define ata_port_warn(ap, fmt, ...)				\
> -	ata_port_printk(warn, ap, fmt, ##__VA_ARGS__)
> +	dev_warn(&ap->tdev, fmt, ##__VA_ARGS__)
>   #define ata_port_notice(ap, fmt, ...)				\
> -	ata_port_printk(notice, ap, fmt, ##__VA_ARGS__)
> +	dev_notice(&ap->tdev, fmt, ##__VA_ARGS__)
>   #define ata_port_info(ap, fmt, ...)				\
> -	ata_port_printk(info, ap, fmt, ##__VA_ARGS__)
> +	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
>   #define ata_port_dbg(ap, fmt, ...)				\
> -	ata_port_printk(debug, ap, fmt, ##__VA_ARGS__)
> -
> -#define ata_link_printk(level, link, fmt, ...)			\
> -do {								\
> -	if (sata_pmp_attached((link)->ap) ||			\
> -	    (link)->ap->slave_link)				\
> -		pr_ ## level ("ata%u.%02u: " fmt,		\
> -			      (link)->ap->print_id,		\
> -			      (link)->pmp,			\
> -			      ##__VA_ARGS__);			\
> -        else							\
> -		pr_ ## level ("ata%u: " fmt,			\
> -			      (link)->ap->print_id,		\
> -			      ##__VA_ARGS__);			\
> -} while (0)
> +	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
>   
>   #define ata_link_err(link, fmt, ...)				\
> -	ata_link_printk(err, link, fmt, ##__VA_ARGS__)
> +	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
>   #define ata_link_warn(link, fmt, ...)				\
> -	ata_link_printk(warn, link, fmt, ##__VA_ARGS__)
> +	dev_warn(&link->tdev, fmt, ##__VA_ARGS__)
>   #define ata_link_notice(link, fmt, ...)				\
> -	ata_link_printk(notice, link, fmt, ##__VA_ARGS__)
> +	dev_notice(&link->tdev, fmt, ##__VA_ARGS__)
>   #define ata_link_info(link, fmt, ...)				\
> -	ata_link_printk(info, link, fmt, ##__VA_ARGS__)
> +	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
>   #define ata_link_dbg(link, fmt, ...)				\
> -	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
> -
> -#define ata_dev_printk(level, dev, fmt, ...)			\
> -        pr_ ## level("ata%u.%02u: " fmt,			\
> -               (dev)->link->ap->print_id,			\
> -	       (dev)->link->pmp + (dev)->devno,			\
> -	       ##__VA_ARGS__)
> +	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
>   
>   #define ata_dev_err(dev, fmt, ...)				\
> -	ata_dev_printk(err, dev, fmt, ##__VA_ARGS__)
> +	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
>   #define ata_dev_warn(dev, fmt, ...)				\
> -	ata_dev_printk(warn, dev, fmt, ##__VA_ARGS__)
> +	dev_warn(&dev->tdev, fmt, ##__VA_ARGS__)
>   #define ata_dev_notice(dev, fmt, ...)				\
> -	ata_dev_printk(notice, dev, fmt, ##__VA_ARGS__)
> +	dev_notice(&dev->tdev, fmt, ##__VA_ARGS__)
>   #define ata_dev_info(dev, fmt, ...)				\
> -	ata_dev_printk(info, dev, fmt, ##__VA_ARGS__)
> +	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
>   #define ata_dev_dbg(dev, fmt, ...)				\
> -	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
> +	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
>   
>   void ata_print_version(const struct device *dev, const char *version);
>   


-- 
Damien Le Moal
Western Digital Research
