Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A18C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 07:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiBBHsB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:48:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47906 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiBBHsA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 02:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643788080; x=1675324080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2lUTqHjCEXRf+700gvyTEjHFV3hrhEq2aGr/eXLyaFc=;
  b=dV3XTZbw33gU8CQwRMeN/65gE+VxggSTMo3gLD3F+WyvULeHZeZbV0Rk
   S/u4zU37y2RKOHSWL/PkYDjM81kEhMn7Sf1xjntm4AU5dyUBkmob2IjAa
   5rfDhW/XGFIOzSDQBd+sIrSPa8ARU8MCiW4k8RouLvD5U3ScBHXQ2zKmn
   Ykka1hwEOwfVuG3panNPZ30qf8pPvZk2IArN4MtGegQsiE1hLCXQrfyej
   5hPocDuOoJS+v5D85tZWGrzSqcau5EZH9ijExWwA78D9epyICXTwWw0mb
   itmFs9c3BSEnpraCVZD7R7L/90Bi870j6Q297wi5wFxpN8eXgZHVg7zS5
   g==;
X-IronPort-AV: E=Sophos;i="5.88,336,1635177600"; 
   d="scan'208";a="190901940"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 15:48:00 +0800
IronPort-SDR: 6Io1KsDeLq9zNAs570RhIsrjWDkZoFol7Q1kCrHUUyrplC4SmS8Xhn+WdELzYf34VpQ24RjGzM
 DGTvPjYQLGgsN8sHYrc+yBm/PSz4e5XvhI+u7LEpbi1vZQUmc1nJpdirByHCIzDQ30Ggx5N86P
 SW7gNZTyfOdhroddArGfvvR9lXplNeEE1sj9YpJsAxHOS0B4UDToMn7Qu6s2u1TqxEZ0awXwDb
 7PPuInuwlnYgbm2NZCWI8buckE4SWvbJT20tywZL3l6kmranbdcrvvZkTHWCqS23suqAsNR9bn
 cCRt+WjPUQyZSFngKTR/Qt4V
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 23:21:10 -0800
IronPort-SDR: XprMJ4kfZtcd5vWTgO6DD7jFWZAE9v50U2xRA2oVdmeqRvmQeXJn5yZZakaH6JL5bLT6kaQ9Ot
 zvGk6YiISjvv7vZRJ4nR++tlVwf3QC+z0jCa4kU7tJq/dwbDHj8SvLvvGqvJ1BbHpKqI4LyIAx
 GmQBka99VyIwuwLKW+G9IkLvp8byZhH2Kwb0CHS9tyJn2WaJ+lHTrHj7b57hPR+OiRZktV53iW
 uCT872ywhjvQdilyGcBZEpAe8+6BqDWD4zr18sefX6dmlpsDrs5OS3vFvgVss2Mafgmi1V0fhe
 qOA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 23:48:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpYnD1H54z1SHwl
        for <linux-ide@vger.kernel.org>; Tue,  1 Feb 2022 23:48:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643788079; x=1646380080; bh=2lUTqHjCEXRf+700gvyTEjHFV3hrhEq2aGr
        /eXLyaFc=; b=aMNTt6tnY6tK1A2mHYoenNocJdwKZJ+Vz+CfiDzvrE/siWrwQf3
        3dCULWvbBC75sNQ9Kp2+ujcpmrpOb+SJmK/uqHlOqac+r4IM/Se2ASRZO/NBJ1qj
        itNYshucGaGakdexXWPwNklv5Z0AK7QDDbuIr1h1Uwj1qI+HBKsUVfr5aE4uuD+l
        SVJ7UNAtfkB1iIKY14C+Os8lIhRW/FSfHKFbcnDl20WqoTUMbGOlD5NiP8kVm3Hj
        u4wgrRvSQw7M7LsWz3ssx4URj+tQQKGJlG6DHuUSPBPXKZeDMb/Oz4pygvzzWs0q
        525OsP+8uYtOxlo+R+JyH+h6yrFeBCFkGKA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dUtYroijB4wm for <linux-ide@vger.kernel.org>;
        Tue,  1 Feb 2022 23:47:59 -0800 (PST)
Received: from [10.225.163.62] (unknown [10.225.163.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpYnB0S5mz1RvlN;
        Tue,  1 Feb 2022 23:47:57 -0800 (PST)
Message-ID: <e6dbc236-a8b5-7b2a-a016-71523d72c0ce@opensource.wdc.com>
Date:   Wed, 2 Feb 2022 16:47:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: ata_host_suspend() always returns 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <b690e385-0e2b-d476-2590-01b2abf4811f@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b690e385-0e2b-d476-2590-01b2abf4811f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/22 04:57, Sergey Shtylyov wrote:
> ata_host_suspend() always returns 0, so the result checks in the drivers
> are pointless.  However I chose not to change ata_host_suspend() to *void*
> not to have to change
> 
> 	return ata_host_suspend(...);
> to
> 	ata_host_suspend(...);
> 	return 0;

Nice cleanup, I like it. But given how simple ata_host_suspend() is, I
would prefer that it is turned into a void function...

My view is: if the function returns an int error code, it should be
checked, always. If said function always return "success", then it
should be void. This makes it clear for the users (the different
drivers) how the function should be used.

With your change, anybody looking at the driver code and at
ata_host_suspend() interface in the header file may think "the error
check is missing", unless the person also look at the function code...

So let's simplify and make ata_host_suspend() a void function. There are
not that many call sites to change. Not all users do "return
ata_host_suspend()".

> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/ata_piix.c     |    5 +----
>  drivers/ata/libata-core.c  |    7 +++----
>  drivers/ata/pata_cs5520.c  |    5 +----
>  drivers/ata/pata_imx.c     |   15 ++++++---------
>  drivers/ata/pata_macio.c   |    6 +-----
>  drivers/ata/pata_triflex.c |    5 +----
>  drivers/ata/sata_mv.c      |    6 +++---
>  drivers/ata/sata_rcar.c    |   18 ++++++++----------
>  8 files changed, 24 insertions(+), 43 deletions(-)
> 
> Index: libata/drivers/ata/ata_piix.c
> ===================================================================
> --- libata.orig/drivers/ata/ata_piix.c
> +++ libata/drivers/ata/ata_piix.c
> @@ -993,11 +993,8 @@ static int piix_pci_device_suspend(struc
>  {
>  	struct ata_host *host = pci_get_drvdata(pdev);
>  	unsigned long flags;
> -	int rc = 0;
>  
> -	rc = ata_host_suspend(host, mesg);
> -	if (rc)
> -		return rc;
> +	ata_host_suspend(host, mesg);
>  
>  	/* Some braindamaged ACPI suspend implementations expect the
>  	 * controller to be awake on entry; otherwise, it burns cpu
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -5168,6 +5168,8 @@ EXPORT_SYMBOL_GPL(ata_sas_port_resume);
>   *	@host: host to suspend
>   *	@mesg: PM message
>   *
> + *	Return: always 0
> + *
>   *	Suspend @host.  Actual operation is performed by port suspend.
>   */
>  int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
> @@ -6090,11 +6092,8 @@ EXPORT_SYMBOL_GPL(ata_pci_device_do_resu
>  int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
>  {
>  	struct ata_host *host = pci_get_drvdata(pdev);
> -	int rc = 0;
>  
> -	rc = ata_host_suspend(host, mesg);
> -	if (rc)
> -		return rc;
> +	ata_host_suspend(host, mesg);
>  
>  	ata_pci_device_do_suspend(pdev, mesg);
>  
> Index: libata/drivers/ata/pata_cs5520.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_cs5520.c
> +++ libata/drivers/ata/pata_cs5520.c
> @@ -259,11 +259,8 @@ static int cs5520_reinit_one(struct pci_
>  static int cs5520_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
>  {
>  	struct ata_host *host = pci_get_drvdata(pdev);
> -	int rc = 0;
>  
> -	rc = ata_host_suspend(host, mesg);
> -	if (rc)
> -		return rc;
> +	ata_host_suspend(host, mesg);
>  
>  	pci_save_state(pdev);
>  	return 0;
> Index: libata/drivers/ata/pata_imx.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_imx.c
> +++ libata/drivers/ata/pata_imx.c
> @@ -223,17 +223,14 @@ static int pata_imx_suspend(struct devic
>  {
>  	struct ata_host *host = dev_get_drvdata(dev);
>  	struct pata_imx_priv *priv = host->private_data;
> -	int ret;
>  
> -	ret = ata_host_suspend(host, PMSG_SUSPEND);
> -	if (!ret) {
> -		__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
> -		priv->ata_ctl =
> -			__raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
> -		clk_disable_unprepare(priv->clk);
> -	}
> +	ata_host_suspend(host, PMSG_SUSPEND);
>  
> -	return ret;
> +	__raw_writel(0, priv->host_regs + PATA_IMX_ATA_INT_EN);
> +	priv->ata_ctl = __raw_readl(priv->host_regs + PATA_IMX_ATA_CONTROL);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
>  }
>  
>  static int pata_imx_resume(struct device *dev)
> Index: libata/drivers/ata/pata_macio.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_macio.c
> +++ libata/drivers/ata/pata_macio.c
> @@ -853,12 +853,8 @@ static int pata_macio_slave_config(struc
>  #ifdef CONFIG_PM_SLEEP
>  static int pata_macio_do_suspend(struct pata_macio_priv *priv, pm_message_t mesg)
>  {
> -	int rc;
> -
>  	/* First, core libata suspend to do most of the work */
> -	rc = ata_host_suspend(priv->host, mesg);
> -	if (rc)
> -		return rc;
> +	ata_host_suspend(priv->host, mesg);
>  
>  	/* Restore to default timings */
>  	pata_macio_default_timings(priv);
> Index: libata/drivers/ata/pata_triflex.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_triflex.c
> +++ libata/drivers/ata/pata_triflex.c
> @@ -198,11 +198,8 @@ static const struct pci_device_id trifle
>  static int triflex_ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
>  {
>  	struct ata_host *host = pci_get_drvdata(pdev);
> -	int rc = 0;
>  
> -	rc = ata_host_suspend(host, mesg);
> -	if (rc)
> -		return rc;
> +	ata_host_suspend(host, mesg);
>  
>  	/*
>  	 * We must not disable or powerdown the device.
> Index: libata/drivers/ata/sata_mv.c
> ===================================================================
> --- libata.orig/drivers/ata/sata_mv.c
> +++ libata/drivers/ata/sata_mv.c
> @@ -4235,10 +4235,10 @@ static int mv_platform_remove(struct pla
>  static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	struct ata_host *host = platform_get_drvdata(pdev);
> +
>  	if (host)
> -		return ata_host_suspend(host, state);
> -	else
> -		return 0;
> +		ata_host_suspend(host, state);
> +	return 0;
>  }
>  
>  static int mv_platform_resume(struct platform_device *pdev)
> Index: libata/drivers/ata/sata_rcar.c
> ===================================================================
> --- libata.orig/drivers/ata/sata_rcar.c
> +++ libata/drivers/ata/sata_rcar.c
> @@ -945,19 +945,17 @@ static int sata_rcar_suspend(struct devi
>  	struct ata_host *host = dev_get_drvdata(dev);
>  	struct sata_rcar_priv *priv = host->private_data;
>  	void __iomem *base = priv->base;
> -	int ret;
>  
> -	ret = ata_host_suspend(host, PMSG_SUSPEND);
> -	if (!ret) {
> -		/* disable interrupts */
> -		iowrite32(0, base + ATAPI_INT_ENABLE_REG);
> -		/* mask */
> -		iowrite32(priv->sataint_mask, base + SATAINTMASK_REG);
> +	ata_host_suspend(host, PMSG_SUSPEND);
>  
> -		pm_runtime_put(dev);
> -	}
> +	/* disable interrupts */
> +	iowrite32(0, base + ATAPI_INT_ENABLE_REG);
> +	/* mask */
> +	iowrite32(priv->sataint_mask, base + SATAINTMASK_REG);
>  
> -	return ret;
> +	pm_runtime_put(dev);
> +
> +	return 0;
>  }
>  
>  static int sata_rcar_resume(struct device *dev)


-- 
Damien Le Moal
Western Digital Research
