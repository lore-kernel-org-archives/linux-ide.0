Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A39C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  2 Feb 2022 23:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbiBBXzs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:55:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32491 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBBXzr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 18:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643846147; x=1675382147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KCGOyPYseKXCnOmcNIHvoz2eRgS5GV8vykk72yZOU58=;
  b=VPFyoA77fwinbtq4+/7BE2K/zaYWkvs19ViEc7bJJPUThV9ks4jbCT9e
   7yjrBUA9LPCjUlypIWZDpN0qRBwdygClpakWO5hbcouxBA5ZL2b0Qbsqo
   YejNbBpMIYk/zc0yHaEalsqXUoeV54s4PJVWxMW96mhhpZuS/HdsSwQtB
   U9pd/FDQ++bvHGWE169pHGU2IErbiszqBWFbZiYWGpoVqSgjc3nS6c77d
   GIsR4cOJL/g5sguHL4xhpcNPWgrH/4KQtLfGhMKxG4VDMuxsgYFaK1ecI
   ve6ixCglMuTgb7BcaxTHHDsc+B5ka2mfaDlgvB7B/zBZHbMeXQvm1lyAA
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="296107981"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:55:47 +0800
IronPort-SDR: 9SnJQ/6NYeNJBZ1oKY/EGsI2xq+bISEaDwedZpki/djr+DoGNJEAL5WhZogg5W5+zK+PIY99AU
 /xB8AfEK0MZTsoD1gFewuDEqI+vYPeYPJPm8Fy9mu5no+CSTTtas7sYZnb++/DA1nHlpDFORnW
 sngAQXr5hydgnD1xSGzFDC9PVof8ooftlkQC+3iWtdttZzsIlVbrOf0u1MHYZ70h+9ZvGSR36h
 7VYOccSg6IFoSaGR1BKbpovEsJdVARntwJsIGuUJV/aQuV/suMOLkQdzm8jqrT2w1FUV2ybnUg
 gIzB+UggAESoAmnvd4qpsnKp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:27:43 -0800
IronPort-SDR: Mi9kG1Pv4HltVHVlE7UVtbhbmaiPBAyjzEECIZH3sYzQRb33JfsVo1v7By926OKsgkVYFAunH9
 ufLL2NCyrwkQclsk4FYEdh1XYIkaPxzLPUHtVHzwi2uIymLgODJd2vVozbTS2v6lzc4dam/Vjc
 Nu5iRD//m0ZzpOBOCBhy1FjnnLn+bcHhoXQ2l4V415QWT2YApy/Gocgpjif9HuOFuenVv6UAtM
 jRonvi2PP/Si7COxiu/WWym/q0ifo2jIxfxhlkvd87nQEXc+vYkbG6p0pULm9BmUOnqoWEvHoV
 080=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:55:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpzFt5Qgmz1SVp7
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 15:55:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643846144; x=1646438145; bh=KCGOyPYseKXCnOmcNIHvoz2eRgS5GV8vykk
        72yZOU58=; b=P7/UDT5WWy9QTxMkN+vh01R9eBqUH+rEChnaEU1vwl14SQs7RFI
        pVSq1B2p8XBdB6Q+f4lKPcAcIC8rg1jr1k89xFR43IUvTadl1H0b/jF4fMqThywZ
        P95eKnsMRgN4Izmr7ZwY85pD4yce2ThXLtqOjnoSdmZBd/w/trRtiDmI9xgODmUB
        raDaJ1RU6E1NoZRVwESUAOt23ZukZo//CyVIJQU5FOeFizYY0pHPJgvsizkd5hYc
        xpEXuV5/3qCTme76Uj9SU+XZ4wYNrvrAx5OlVuF/TumQttZKsrkuhCWweL515QB4
        L8qJX44JKpgcgmQCpESwv22o4DJLhuTHb3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JUwrfj_WTQHM for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 15:55:44 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpzFq04wtz1Rwrw;
        Wed,  2 Feb 2022 15:55:42 -0800 (PST)
Message-ID: <239dc982-ae2d-3110-0d25-65191f53eeec@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:55:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] libata: make ata_host_suspend() *void*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Viresh Kumar <vireshk@kernel.org>
References: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 05:58, Sergey Shtylyov wrote:
> ata_host_suspend() always returns 0, so the result checks in many drivers
> look pointless.  Let's make this function return *void* instead of *int*.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Looks good to me. Let's wait a little for comments/reviews then I will
apply.

> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/ahci.c             |    3 ++-
>  drivers/ata/ata_piix.c         |    5 +----
>  drivers/ata/libahci_platform.c |    3 ++-
>  drivers/ata/libata-core.c      |    8 ++------
>  drivers/ata/pata_arasan_cf.c   |    3 ++-
>  drivers/ata/pata_cs5520.c      |    5 +----
>  drivers/ata/pata_imx.c         |   15 ++++++---------
>  drivers/ata/pata_macio.c       |    6 +-----
>  drivers/ata/pata_mpc52xx.c     |    3 ++-
>  drivers/ata/pata_samsung_cf.c  |    3 ++-
>  drivers/ata/pata_triflex.c     |    5 +----
>  drivers/ata/sata_fsl.c         |    4 +++-
>  drivers/ata/sata_highbank.c    |    3 ++-
>  drivers/ata/sata_mv.c          |    6 +++---
>  drivers/ata/sata_rcar.c        |   18 ++++++++----------
>  include/linux/libata.h         |    2 +-
>  16 files changed, 39 insertions(+), 53 deletions(-)
> 
> Index: libata/drivers/ata/ahci.c
> ===================================================================
> --- libata.orig/drivers/ata/ahci.c
> +++ libata/drivers/ata/ahci.c
> @@ -891,7 +891,8 @@ static int ahci_pci_device_suspend(struc
>  	}
>  
>  	ahci_pci_disable_interrupts(host);
> -	return ata_host_suspend(host, PMSG_SUSPEND);
> +	ata_host_suspend(host, PMSG_SUSPEND);
> +	return 0;
>  }
>  
>  static int ahci_pci_device_resume(struct device *dev)
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
> Index: libata/drivers/ata/libahci_platform.c
> ===================================================================
> --- libata.orig/drivers/ata/libahci_platform.c
> +++ libata/drivers/ata/libahci_platform.c
> @@ -733,7 +733,8 @@ int ahci_platform_suspend_host(struct de
>  	if (hpriv->flags & AHCI_HFLAG_SUSPEND_PHYS)
>  		ahci_platform_disable_phys(hpriv);
>  
> -	return ata_host_suspend(host, PMSG_SUSPEND);
> +	ata_host_suspend(host, PMSG_SUSPEND);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
>  
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -5170,10 +5170,9 @@ EXPORT_SYMBOL_GPL(ata_sas_port_resume);
>   *
>   *	Suspend @host.  Actual operation is performed by port suspend.
>   */
> -int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
> +void ata_host_suspend(struct ata_host *host, pm_message_t mesg)
>  {
>  	host->dev->power.power_state = mesg;
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_host_suspend);
>  
> @@ -6090,11 +6089,8 @@ EXPORT_SYMBOL_GPL(ata_pci_device_do_resu
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
> Index: libata/drivers/ata/pata_arasan_cf.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_arasan_cf.c
> +++ libata/drivers/ata/pata_arasan_cf.c
> @@ -937,7 +937,8 @@ static int arasan_cf_suspend(struct devi
>  		dmaengine_terminate_all(acdev->dma_chan);
>  
>  	cf_exit(acdev);
> -	return ata_host_suspend(host, PMSG_SUSPEND);
> +	ata_host_suspend(host, PMSG_SUSPEND);
> +	return 0;
>  }
>  
>  static int arasan_cf_resume(struct device *dev)
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
> Index: libata/drivers/ata/pata_mpc52xx.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_mpc52xx.c
> +++ libata/drivers/ata/pata_mpc52xx.c
> @@ -824,7 +824,8 @@ mpc52xx_ata_suspend(struct platform_devi
>  {
>  	struct ata_host *host = platform_get_drvdata(op);
>  
> -	return ata_host_suspend(host, state);
> +	ata_host_suspend(host, state);
> +	return 0;
>  }
>  
>  static int
> Index: libata/drivers/ata/pata_samsung_cf.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_samsung_cf.c
> +++ libata/drivers/ata/pata_samsung_cf.c
> @@ -608,7 +608,8 @@ static int pata_s3c_suspend(struct devic
>  {
>  	struct ata_host *host = dev_get_drvdata(dev);
>  
> -	return ata_host_suspend(host, PMSG_SUSPEND);
> +	ata_host_suspend(host, PMSG_SUSPEND);
> +	return 0;
>  }
>  
>  static int pata_s3c_resume(struct device *dev)
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
> Index: libata/drivers/ata/sata_fsl.c
> ===================================================================
> --- libata.orig/drivers/ata/sata_fsl.c
> +++ libata/drivers/ata/sata_fsl.c
> @@ -1546,7 +1546,9 @@ static int sata_fsl_remove(struct platfo
>  static int sata_fsl_suspend(struct platform_device *op, pm_message_t state)
>  {
>  	struct ata_host *host = platform_get_drvdata(op);
> -	return ata_host_suspend(host, state);
> +
> +	ata_host_suspend(host, state);
> +	return 0;
>  }
>  
>  static int sata_fsl_resume(struct platform_device *op)
> Index: libata/drivers/ata/sata_highbank.c
> ===================================================================
> --- libata.orig/drivers/ata/sata_highbank.c
> +++ libata/drivers/ata/sata_highbank.c
> @@ -587,7 +587,8 @@ static int ahci_highbank_suspend(struct
>  	writel(ctl, mmio + HOST_CTL);
>  	readl(mmio + HOST_CTL); /* flush */
>  
> -	return ata_host_suspend(host, PMSG_SUSPEND);
> +	ata_host_suspend(host, PMSG_SUSPEND);
> +	return 0;
>  }
>  
>  static int ahci_highbank_resume(struct device *dev)
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
> Index: libata/include/linux/libata.h
> ===================================================================
> --- libata.orig/include/linux/libata.h
> +++ libata/include/linux/libata.h
> @@ -1080,7 +1080,7 @@ extern int ata_sas_scsi_ioctl(struct ata
>  extern bool ata_link_online(struct ata_link *link);
>  extern bool ata_link_offline(struct ata_link *link);
>  #ifdef CONFIG_PM
> -extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
> +extern void ata_host_suspend(struct ata_host *host, pm_message_t mesg);
>  extern void ata_host_resume(struct ata_host *host);
>  extern void ata_sas_port_suspend(struct ata_port *ap);
>  extern void ata_sas_port_resume(struct ata_port *ap);


-- 
Damien Le Moal
Western Digital Research
