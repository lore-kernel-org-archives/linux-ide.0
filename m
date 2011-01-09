From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4 2/3] ahci_platform: switch to module device table
 matching
Date: Sun, 9 Jan 2011 05:56:18 +0300
Message-ID: <20110109025618.GA27507@oksana.dev.rtsoft.ru>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
 <1294537775-21714-3-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49131 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1AIC4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 21:56:24 -0500
Received: by ewy5 with SMTP id 5so8316831ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 18:56:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294537775-21714-3-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Jan 09, 2011 at 09:49:34AM +0800, mkl0301@gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> Switch the driver to use module device table matching mechanism to add SoC-specific parts to the generic driver.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>
> ---
>  drivers/ata/ahci_platform.c  |   14 +++++++++++++-
>  drivers/ata/ahci_platforms.h |   16 ++++++++++++++++

I think header and .c file names should match. I.e. just
ahci_platform.h.

>  2 files changed, 29 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/ahci_platforms.h
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6fef1fa..190db2c 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -19,9 +19,11 @@
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
>  #include "ahci.h"
> +#include "ahci_platforms.h"
>  
>  static struct scsi_host_template ahci_platform_sht = {
>  	AHCI_SHT("ahci_platform"),
> @@ -29,6 +31,7 @@ static struct scsi_host_template ahci_platform_sht = {
>  
>  static int __init ahci_probe(struct platform_device *pdev)
>  {
> +	const struct platform_device_id *platid = platform_get_device_id(pdev);
>  	struct device *dev = &pdev->dev;
>  	struct ahci_platform_data *pdata = dev->platform_data;
>  	struct ata_port_info pi = {
> @@ -46,6 +49,9 @@ static int __init ahci_probe(struct platform_device *pdev)
>  	int i;
>  	int rc;
>  
> +	if (!pdata && platid && platid->driver_data)
> +		pdata = (void *)platid->driver_data;
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem) {
>  		dev_err(dev, "no mmio space\n");
> @@ -171,12 +177,19 @@ static int __devexit ahci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct platform_device_id ahci_pltfm_ids[] = {

s/pltfm/platform/ to match the rest of the driver.

On the next resend, feel free to add my

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
