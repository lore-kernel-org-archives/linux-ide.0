From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI
 driver
Date: Wed, 11 Jun 2014 11:30:34 +0200
Message-ID: <3571472.yt2eJCmG5L@amdc1032>
References: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
 <53977E79.2090000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8824 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaFKJbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2014 05:31:16 -0400
In-reply-to: <53977E79.2090000@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: suravee.suthikulpanit@amd.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Tuesday, June 10, 2014 04:54:01 PM David Milburn wrote:
> On 05/23/2014 12:35 PM, suravee.suthikulpanit@amd.com wrote:
> > From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >
> > The current platform AHCI drier does not set the dma_mask correctly
> > for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
> > capability bit and set the dma_mask and coherent_dma_mask accordingly.
> >
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > ---
> >   drivers/ata/libahci_platform.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 7cb3a85..85049ef 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
> 
> Hi Suravee,
> 
> Would it be better to do the following before ahci_reset_controller()?
> 
>          /* initialize adapter */
>          rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
>          if (rc)
>                 	return rc;

ahci_configure_dma_masks() is currently for PCI controllers only
so it can't be used for libahci_platform.c.

When it comes to setting DMA masks before ahci_reset_controller()
I don't think that it matters but it will make platform code more
similar to PCI one which is a good thing.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


> Thanks,
> David
> 
> 
> 
> >   	ahci_init_controller(host);
> >   	ahci_print_info(host, "platform");
> >
> > +	if (hpriv->cap & HOST_CAP_64) {
> > +		if (!dev->dma_mask)
> > +			dev->dma_mask = &dev->coherent_dma_mask;
> > +
> > +		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> >   	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
> >   				 &ahci_platform_sht);
> >   }

