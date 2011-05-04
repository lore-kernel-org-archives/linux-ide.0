From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/3] New driver mtipx2xx submission
Date: Wed, 04 May 2011 14:26:18 +0400
Message-ID: <4DC129CA.5070905@ru.mvista.com>
References: <22A973199D2C2F46933448F6E7990A300204FB87@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47620 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDK2A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2011 06:28:00 -0400
Received: by wwa36 with SMTP id 36so1052550wwa.1
        for <linux-ide@vger.kernel.org>; Wed, 04 May 2011 03:27:59 -0700 (PDT)
In-Reply-To: <22A973199D2C2F46933448F6E7990A300204FB87@ntxboimbx31.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: linux-ide@vger.kernel.org

Hello.

On 04-05-2011 0:14, Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) 
[CONTRACTOR] wrote:

> Part 1

    Need a better description than that.

> diff -uNr a/drivers/block/mtipx2xx/Kconfig
> b/drivers/block/mtipx2xx/Kconfig
> --- a/drivers/block/mtipx2xx/Kconfig	1969-12-31 17:00:00.000000000
> -0700
> +++ b/drivers/block/mtipx2xx/Kconfig	2011-05-03 12:57:34.000000000
> -0600
> @@ -0,0 +1,13 @@
> +#
> +# mtipx2xx device driver configuration
> +#
> +
> +config BLK_DEV_PCIE_SSD
> +        tristate "Block Device Driver for Micron PCIe SSDs"
> +        depends on  HOTPLUG_PCI_PCIE
> +        default n
> +        help
> +
> +          This option enables block device driver for Micron PCIe SSDs.
> This

    The patch is line-wrapped.

> +          driver depends on pciehp module to support surprise insertion
> +          surprise removal (SRSI) of the device.
> diff -uNr a/drivers/block/mtipx2xx/Makefile
> b/drivers/block/mtipx2xx/Makefile
> --- a/drivers/block/mtipx2xx/Makefile	1969-12-31 17:00:00.000000000
> -0700
> +++ b/drivers/block/mtipx2xx/Makefile	2011-05-03 12:57:34.000000000
> -0600
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for  Block device driver for Micron PCIe SSD
> +#
> +
> +obj-$(CONFIG_BLK_DEV_PCIE_SSD) += mtipx2xx.o
> +
> +mtipx2xx-y := module.o pci.o block.o ahci.o

    This patch should clearly be the last in the series, as at this point 
there's no source files yet in this directory.

WBR, Sergei
