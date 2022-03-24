Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E11C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 09:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiCXJ2q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiCXJ2p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 05:28:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34B6FA23
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648114031; x=1679650031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qFzcS6rX+iR10FWGovbfPfvcFX5WEKNPFLAmC3qWmBQ=;
  b=iA/os4KcYyytoP5+TKUdulDTT38+HVUKB9RtWIVl2MOm4EajBVvunj2D
   TLKu6Pu+0hIZbifiii6R8gqrF02s+ru8/zBEjqwIBFVEtzACcRkuFp3Ym
   KdfjiR2o3PKVK+oePli9N0/L2VgOjkOtVG+3BoMe12fqiEfCAm+7F+a3h
   tl79Uopa6TU+T0znavFKv62Uc2rqVQ+SvhMOWI8R/Ici9BA7FttfawCdT
   QTV/NjM9tyYQuXekpWLlngHV+TInZNuEromHeo2ZZ+qcC8AxWMY131tQw
   k4QUvNONh9NM5qVvL3ApmTGxu+XNs2BW7wkcRk4+hP1Y3RDqGK9rdScHo
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="200999707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 17:27:10 +0800
IronPort-SDR: SyR1GXF9p+uKvGatNzPFR+HzO2qALBvnLTSAAsuF9wrVRwTfwL7bRsv7cXZXoMPnaZPE07PJIB
 gAJZA/AgwerFbc18dny/v9OnxfJ8w47NYtBlkvDg67SFNHyp9NqJSjLPk9XIxk+rQtIb3BGSqR
 +e54sg5XUQZmMkxI9atpC6u9Xf8a3PBc+rMcewq5CdSWMJcCbSGIKbAMYPS8rEdhBy0Fjmpnn0
 oAjyCInLWikjYxuL4cfDD/oK0lgkfxnvTdTt9F5gJgr3fPh/5hDizakSoEii5khsoNZ0tF7OrZ
 Gk8Rl+vY/O9h1jLUfSvlsXk1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 01:59:05 -0700
IronPort-SDR: CCVoZBQ+frdP3jOQEQA1M7FShn7/DGkWIi46MqKnlItVwEb3PRsW1lsp4lcthF+ljehYgIe6EM
 l3HMXkyHgWVGTGfxxr/9wfxG/MOrtFvPC2H06KJWQ0WGyeVYqj+iNjJTqkzNtoF5gs1SZingqj
 ygbRcXVb9aG+Rgs0Doit9LgeOvdaiwLaj8auCkqgD+YwEAKwCS1Z05Fyt1/FPz7RTomWairYgw
 BfnqAmA2vHHna68kU/qdf/HqmYSZQfszZi48nxTp99Y+Q3OpNB0CmGE/Qh8xruZES7p7YoW/kx
 MkA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:27:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPKcc2L7Fz1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 02:27:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648114031; x=1650706032; bh=qFzcS6rX+iR10FWGovbfPfvcFX5WEKNPFLA
        mC3qWmBQ=; b=FL7llrINkp8UBTuWJeETm3tBCubeRuELpwgWMwynPKtVzEMIcJj
        i7eQ8e0edaknFMzX436ALfl84T9uolRlBua5c6fkElP4CUH+k2/NDeKTgdsNnCIa
        bRq06RPJKSDAlfaBgQ43tbu1ktXzA0t9s6TLKQVMrCGYsSTGwjwonkMmC5oVKWAV
        qBXSgq4QHPPl39v5RAaliZwEKyh4LADWy0KLDO/FEWnKWQF9AmcUV7DYokPZrGyl
        7QglSfBDH7MZ65WHbYRP2KNZdnFhS/FCZ1zTpJw28WbZJCkJxqlWRCvmUK+ziagI
        zxQ8u8YHmpwN1SBl3Jvg2VLc9QJmJh8MSXA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RiCUIgHtIlHc for <linux-ide@vger.kernel.org>;
        Thu, 24 Mar 2022 02:27:11 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPKcb0YJzz1Rvlx;
        Thu, 24 Mar 2022 02:27:10 -0700 (PDT)
Message-ID: <508ecc68-96e4-b587-2d9a-82d73d58871e@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 18:27:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/3] libata: CONFIG_ATA_SYSFS_COMPAT
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220321145659.97150-1-hare@suse.de>
 <20220321145659.97150-3-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220321145659.97150-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/21/22 23:56, Hannes Reinecke wrote:
> Add a config option 'ATA_SYSFS_COMPAT' to allow the user to select
> whether the compability 'ata_port' object with the name of 'ata'
> should be registered with sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/Kconfig            | 10 ++++++++++
>  drivers/ata/libata-transport.c | 19 ++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index cb54631fd950..fe42a246d21d 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -51,6 +51,16 @@ config ATA_VERBOSE_ERROR
>  
>  	  If unsure, say Y.
>  
> +config ATA_SYSFS_COMPAT
> +	bool "Keep original sysfs layout"
> +	default y
> +	help
> +	  This option retains the original sysfs layout by adding an
> +	  additional ata_port object with the name of 'ataX' in
> +	  to the ATA objects like 'ata_port', 'ata_link', and 'ata_device'.
> +
> +	  If unsure, say Y.
> +
>  config ATA_FORCE
>  	bool "\"libata.force=\" kernel parameter support" if EXPERT
>  	default y
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 5169a5db141d..efca41039d1e 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -261,15 +261,21 @@ static int ata_tport_match(struct attribute_container *cont,
>  void ata_tport_delete(struct ata_port *ap)
>  {
>  	struct device *dev = &ap->tdev;
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	struct device *cdev = &ap->cdev;
> +#endif
>  
>  	ata_tlink_delete(&ap->link);
>  
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	device_del(cdev);
> +#endif
>  	transport_remove_device(dev);
>  	device_del(dev);
>  	transport_destroy_device(dev);
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	put_device(cdev);
> +#endif
>  	put_device(dev);
>  }
>  
> @@ -288,7 +294,9 @@ int ata_tport_add(struct device *parent,
>  {
>  	int error;
>  	struct device *dev = &ap->tdev;
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	struct device *cdev = &ap->cdev;
> +#endif
>  
>  	device_initialize(dev);
>  	dev->type = &ata_port_type;
> @@ -299,23 +307,24 @@ int ata_tport_add(struct device *parent,
>  	dev->bus = &ata_bus_type;
>  	dev_set_name(dev, "port%d", ap->print_id);
>  
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	device_initialize(cdev);
>  	cdev->parent = get_device(dev);
>  	cdev->class = &ata_port_class.class;
>  	dev_set_name(cdev, "ata%d", ap->print_id);
> -
> +#endif
>  	transport_setup_device(dev);
>  	ata_acpi_bind_port(ap);
>  	error = device_add(dev);
>  	if (error) {
>  		goto tport_err;
>  	}
> -
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	error = device_add(cdev);
>  	if (error) {
>  		goto cdev_err;
>  	}
> -

Instead of adding a device, can't we simply create a symlink ?
E.g.:

	sprintf(symlink_name, "ata%d", ap->print_id);
	sysfs_create_link(&parent->kobj, &dev->kobj, symlink_name);

? This seems to work, but I have not checked all possible paths to see if
a symlink or directory name expected to be "ataX" ends up being "portX",
which could break userspace relying on the old name.

> +#endif
>  	device_enable_async_suspend(dev);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> @@ -331,14 +340,18 @@ int ata_tport_add(struct device *parent,
>  	return 0;
>  
>   tport_link_err:
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	device_del(cdev);
>   cdev_err:
> +#endif
>  	transport_remove_device(dev);
>  	device_del(dev);
>  
>   tport_err:
>  	transport_destroy_device(dev);
> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>  	put_device(cdev);
> +#endif
>  	put_device(dev);
>  	ata_host_put(ap->host);
>  	return error;


-- 
Damien Le Moal
Western Digital Research
