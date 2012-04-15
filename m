From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 2/2] ata_piix: defer disks to the Hyper-V drivers by
 default
Date: Sun, 15 Apr 2012 00:10:18 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF92CCDDA@CH1PRD0310MB381.namprd03.prod.outlook.com>
References: <4F87351E.9040905@pobox.com>
	<1334418796-11473-1-git-send-email-apw@canonical.com>
	<1334418796-11473-3-git-send-email-apw@canonical.com>
 <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:58400
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755143Ab2DOAK1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Apr 2012 20:10:27 -0400
In-Reply-To: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Whitcroft <apw@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Sterling <mike.sterling@microsoft.com>



> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Saturday, April 14, 2012 12:02 PM
> To: Andy Whitcroft
> Cc: Jeff Garzik; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org; KY
> Srinivasan; Mike Sterling
> Subject: Re: [PATCH 2/2] ata_piix: defer disks to the Hyper-V drivers by default
> 
> O> +#ifdef CONFIG_X86
> > +	/* On Hyper-V hypervisors the disks are exposed on both the emulated
> > +	 * SATA controller and on the paravirtualised drivers.  The CD/DVD
> > +	 * devices are only exposed on the emulated controller.  Request we
> > +	 * ignore ATA devices on this host.
> > +	 */
> > +	if (prefer_ms_hyperv && x86_hyper == &x86_hyper_ms_hyperv) {
> > +		host->flags |= ATA_HOST_IGNORE_ATA;
> > +		dev_info(&pdev->dev, "Hyper-V hypervisor detected, ignoring
> ATA disks\n");
> > +	}
> > +#endif
> 
> Does hyper-v not set its own unique and identifable pci
> subvendor/subdevice ?

Number of elements of the virtual BIOS we present the guest can be used
to detect that we are running on Hyper-V. Additionally, we are exporting state based
on CPU detection which is what Andy is using here. As far as I know these are the only
ways to detect that we are running on Hyper-V. 

Regards,

K. Y
> 
> Alan
> 
> 



