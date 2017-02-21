From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] ide-generic: add some notes to clarify probing PCI
 devices
Date: Tue, 21 Feb 2017 17:21:35 +0100
Message-ID: <1566626.Q6WeQGxH4p@amdc3058>
References: <CGME20170221142225epcas5p288f7cd6fa53598a370179edc993a9cf9@epcas5p2.samsung.com>
 <20170221142237.GB11234@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58858 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbdBUQVk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 11:21:40 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OLQ01VLWG425820@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 22 Feb 2017 01:21:38 +0900 (KST)
In-reply-to: <20170221142237.GB11234@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Cc: linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>, petkovbb@gmail.com


Hi,

On Tuesday, February 21, 2017 11:22:37 AM Luiz Carlos Ramos wrote:
> Some inline comments were added in ide-generic, to make clear to
> developers the way probe_mask is managed when PCI IDE devices are
> present.
> 
> A not-so-deep analysis of the code could make it is buggy, as it seems
> that if a device is detected, the probing procedure is avoided,
> suggesting some kind of reversed logic.
> 
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>

Looks fine overall, some minor nits below.

> ---
>  drivers/ide/ide-generic.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..ee11edcdba3170c077381d603918498d79ffa3bb 100644
> --- a/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -96,6 +96,33 @@ static int __init ide_generic_init(void)
>  		printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
>  		     "module parameter for probing all legacy ISA IDE ports\n");
>  
> +		/* Here the logic seems reversed, but it's not. *primary would
> +		 * be 1 if there is a device at 0x1f0 and *secondary would be 1
> +		 * if a device is detected at 0x170.
> +		 *
> +		 * However, the main intention here is to not allow PCI IDE devices
> +		 * using ide-generic unless the user chooses so, as this driver is
> +		 * designed to support ISA IDE devices mainly.

designed to support legacy ISA IDE devices that don't have chipset specific
support.

> +		 *
> +		 * In this case, users are strongly encouraged to use the designated
> +		 * PCI IDE driver, and not isa-generic.

PCI IDE drivers, and not ide-generic.

> +		 *
> +		 * Pure ISA IDE devices OTOH will use ide-generic. In this case, *primary
> +		 * and *secondary will return from ide_generic_check_pci_legacy_iobases()
> +		 * with zero (because they are not PCI...), and probe_mask will be set
> +		 * accordingly (to 0x01, 0x02 or 0x03, depending on which io ports are
> +		 * present).
> +		 *
> +		 * Users would even use ide-generic with such PCI IDE devices, choosing a

Users who would like to use ide-generic with PCI IDE devices (which is not
recommended) should choose a

> +		 * nonzero value for probe_mask when initializing ide-generic. Using
> +		 * probe_mask=0x03 is sufficient to make it detect common IDE interfaces
> +		 * (with primary at 0x1f0 and secondary at 0x170), but in the more
> +		 * general case, one should set probe_mask to 0x3f to check all possible
> +		 * io addresses. In this case, it is up to the user the task of checking

IO addresses. When using probe_mask it is up to the user to check

> +		 * for eventual conflicts between ide-generic and any other driver and
> +		 * manage those conflicts properly.
> +		 */
> +
>  		if (primary == 0)
>  			probe_mask |= 0x1;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

