From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI
 driver
Date: Thu, 12 Jun 2014 01:22:29 -0500
Message-ID: <53994725.5000001@amd.com>
References: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140603175827.GH26210@htj.dyndns.org> <5391E812.1060009@amd.com>
 <1666501.UPn96gHtAf@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:34889
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752158AbaFLGWj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2014 02:22:39 -0400
In-Reply-To: <1666501.UPn96gHtAf@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, tphan@apm.com, stripathi@apm.com



On 06/11/2014 04:41 AM, Bartlomiej Zolnierkiewicz wrote:
>>> On Fri, May 23, 2014 at 12:35:10PM -0500,suravee.suthikulpanit@amd.com  wrote:
>>>> > >>From: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>>>> > >>
>>>> > >>The current platform AHCI drier does not set the dma_mask correctly
>>>> > >>for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
>>>> > >>capability bit and set the dma_mask and coherent_dma_mask accordingly.
>>>> > >>
>>>> > >>Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>>>> > >>---
>>>> > >>   drivers/ata/libahci_platform.c | 9 +++++++++
>>>> > >>   1 file changed, 9 insertions(+)
>>>> > >>
>>>> > >>diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>>> > >>index 7cb3a85..85049ef 100644
>>>> > >>--- a/drivers/ata/libahci_platform.c
>>>> > >>+++ b/drivers/ata/libahci_platform.c
>>>> > >>@@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>>> > >>   	ahci_init_controller(host);
>>>> > >>   	ahci_print_info(host, "platform");
>>>> > >>
>>>> > >>+	if (hpriv->cap & HOST_CAP_64) {
>>>> > >>+		if (!dev->dma_mask)
> What configuration is the above dev->dma_mask checking supposed to handle?
> Is it really needed?  If not the current dma_set_mask_and_coherent() call
> can be replaced by dma_coerce_mask_and_coherent() one.

I was just trying to be safe and not always assuming that dev->dma_mask 
is pointing to the dev->coherent_dma_mask. If you think this is not 
necessary, I can remove this.

>
>>>> > >>+			dev->dma_mask = &dev->coherent_dma_mask;
>>>> > >>+
>>>> > >>+		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>>> > >>+		if (rc)
>>>> > >>+			return rc;
> Shouldn't we try to set DMA masks to 32-bit ones on error (like it is done
> in ahci_configure_dma_masks()) instead of failing the initialization?

I can also add the additional logic to try for 32-bit.

>
>>>> > >>+	}
>>>> > >>+
>>>> > >>   	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
>>>> > >>   				 &ahci_platform_sht);
>>>> > >>   }
>>>> > >>--
>>>> > >>1.9.0
> BTW It seems that after DMA masks handling is fixed in the generic AHCI
> platform code the driver specific code in ahci_xgene.c can be removed.

I am including Loc Ho, Tuan Phan, and Suman Tripathi to help verifying 
if code could be removed. If so, I'll send out the change in V2.

Suravee

>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
