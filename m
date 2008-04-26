From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Sat, 26 Apr 2008 10:30:12 +0100
Message-ID: <20080426103012.21dcf0fb@core>
References: <20080426140007.63cfeede@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42336 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752742AbYDZJhO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Apr 2008 05:37:14 -0400
In-Reply-To: <20080426140007.63cfeede@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

> +struct sch_80 {
> +       u16 device;
> +};

That seems somewhat overkill

> +       /* Check for specials - Intel SCH chipset */
> +       while (sch->device) {
> +               if (sch->device == pdev->device)
> +                       return ATA_CBL_PATA80;
> +               sch++;

PATA_80 means "controller *knows* we are 80 wire". PATA_UNK means
"controller can't do detect."

> +       /* Check for specials - Intel SCH chipset */
> +       while (sch->device) {
> +               if (sch->device == pdev->device) {
> +                       skip_check = 1;
> +                       break;
> +               }
> +               sch++;

This is horrible. If you just defined a new set of methods for your new
controller (remembering we now have inheritance anyway) you'd just use
the ata_sff_prereset and remove all the special casing code. At the very
least write the routine once only;)

> +       }
> +       if (!skip_check)
> +               if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
> +                       return -ENOENT;
>         return ata_sff_prereset(link, deadline);
>  }
> 
