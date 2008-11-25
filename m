From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v2).
Date: Tue, 25 Nov 2008 11:59:14 -0500
Message-ID: <492C2EE2.3090702@garzik.org>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47486 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbYKYQ7U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 11:59:20 -0500
In-Reply-To: <1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

David Daney wrote:
> As part of our efforts to get the Cavium OCTEON processor support
> merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
> have this CF driver for your consideration.
> 
> Most OCTEON variants have *no* DMA or interrupt support on the CF
> interface so for these, only PIO is supported.  Although if DMA is
> available, we do take advantage of it.
> 
> The register definitions are part of the chip support patch set
> mentioned above, and are not included here.
> 
> In this second version, I think I have addressed all the issued raised
> by Alan Cox and Sergei Shtylyov.
> 
> Thanks,
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/ata/Kconfig          |    9 +
>  drivers/ata/Makefile         |    1 +
>  drivers/ata/pata_octeon_cf.c |  904 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 914 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_octeon_cf.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 78fbec8..b59904b 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -697,6 +697,15 @@ config PATA_IXP4XX_CF
>  
>  	  If unsure, say N.
>  
> +config PATA_OCTEON_CF
> +	tristate "OCTEON Boot Bus Compact Flash support"
> +	depends on CPU_CAVIUM_OCTEON
> +	help
> +	  This option enables a polled compact flash driver for use with
> +	  compact flash cards attached to the OCTEON boot bus.
> +
> +	  If unsure, say N.
> +
>  config PATA_SCC
>  	tristate "Toshiba's Cell Reference Set IDE support"
>  	depends on PCI && PPC_CELLEB
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 674965f..7f1ecf9 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
>  obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
>  obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
>  obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
> +obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
>  obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>  obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>  obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> new file mode 100644
> index 0000000..a31d999
> --- /dev/null
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -0,0 +1,904 @@
> +/*
> + * Driver for the Octeon bootbus compact flash.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2005-2008 Cavium Networks
> + * Copyright (C) 2008 Wind River Systems
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/libata.h>
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <scsi/scsi_host.h>
> +
> +#include <asm/octeon/octeon.h>
> +
> +#define DRV_NAME	"pata_octeon_cf"
> +#define DRV_VERSION	"2.1"
> +
> +
> +struct octeon_cf_port {
> +	struct tasklet_struct delayed_irq_tasklet;
> +	int dma_finished;
> +};
> +
> +/* Timing multiple used for configuring the boot bus DMA engine */
> +#define CF_DMA_TIMING_MULT	4
> +
> +static struct scsi_host_template octeon_cf_sht = {
> +	ATA_PIO_SHT(DRV_NAME),
> +};
> +
> +static int mwdmamodes = 0x1f;	/* Support Multiword DMA 0-4 */
> +module_param(mwdmamodes, int, 0444);
> +MODULE_PARM_DESC(mwdmamodes,
> +		 "Bitmask controlling which MWDMA modes are supported.  "
> +		 "Default is 0x1f for MWDMA 0-4.");

Two comments:

* perhaps I missed this, but why is this module param necessary?  In 
general we avoid things like this.

* I would avoid pretending to be an SFF DMA engine, and just code it in 
the style of a custom DMA engine with SFF registers/mode, such as 
sata_mv or sata_promise.

	Jeff


