From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI
 driver
Date: Wed, 11 Jun 2014 11:41:52 +0200
Message-ID: <1666501.UPn96gHtAf@amdc1032>
References: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140603175827.GH26210@htj.dyndns.org> <5391E812.1060009@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17551 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaFKJmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2014 05:42:31 -0400
In-reply-to: <5391E812.1060009@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday, June 06, 2014 11:10:58 AM Suravee Suthikulanit wrote:
> Hans/Bartlomiej,
> 
> Do you guys have any questions about this patch?

Sorry for the delay, some questions regarding the patch below.

> Thank you,
> 
> Suravee
> 
> On 6/3/2014 12:58 PM, Tejun Heo wrote:
> > Hans, Bartlomiej, can you guys please review this patch?
> >
> > Thanks.
> >
> > On Fri, May 23, 2014 at 12:35:10PM -0500, suravee.suthikulpanit@amd.com wrote:
> >> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>
> >> The current platform AHCI drier does not set the dma_mask correctly
> >> for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
> >> capability bit and set the dma_mask and coherent_dma_mask accordingly.
> >>
> >> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >> ---
> >>   drivers/ata/libahci_platform.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >> index 7cb3a85..85049ef 100644
> >> --- a/drivers/ata/libahci_platform.c
> >> +++ b/drivers/ata/libahci_platform.c
> >> @@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
> >>   	ahci_init_controller(host);
> >>   	ahci_print_info(host, "platform");
> >>
> >> +	if (hpriv->cap & HOST_CAP_64) {
> >> +		if (!dev->dma_mask)

What configuration is the above dev->dma_mask checking supposed to handle?
Is it really needed?  If not the current dma_set_mask_and_coherent() call
can be replaced by dma_coerce_mask_and_coherent() one.

> >> +			dev->dma_mask = &dev->coherent_dma_mask;
> >> +
> >> +		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >> +		if (rc)
> >> +			return rc;

Shouldn't we try to set DMA masks to 32-bit ones on error (like it is done
in ahci_configure_dma_masks()) instead of failing the initialization?

> >> +	}
> >> +
> >>   	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
> >>   				 &ahci_platform_sht);
> >>   }
> >> --
> >> 1.9.0

BTW It seems that after DMA masks handling is fixed in the generic AHCI
platform code the driver specific code in ahci_xgene.c can be removed.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

