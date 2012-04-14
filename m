From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] ata_piix: defer disks to the Hyper-V drivers by
 default
Date: Sat, 14 Apr 2012 17:02:23 +0100
Message-ID: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
References: <4F87351E.9040905@pobox.com>
	<1334418796-11473-1-git-send-email-apw@canonical.com>
	<1334418796-11473-3-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58137 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab2DNQAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2012 12:00:12 -0400
In-Reply-To: <1334418796-11473-3-git-send-email-apw@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>

O> +#ifdef CONFIG_X86
> +	/* On Hyper-V hypervisors the disks are exposed on both the emulated
> +	 * SATA controller and on the paravirtualised drivers.  The CD/DVD
> +	 * devices are only exposed on the emulated controller.  Request we
> +	 * ignore ATA devices on this host.
> +	 */
> +	if (prefer_ms_hyperv && x86_hyper == &x86_hyper_ms_hyperv) {
> +		host->flags |= ATA_HOST_IGNORE_ATA;
> +		dev_info(&pdev->dev, "Hyper-V hypervisor detected, ignoring ATA disks\n");
> +	}
> +#endif

Does hyper-v not set its own unique and identifable pci
subvendor/subdevice ?

Alan
