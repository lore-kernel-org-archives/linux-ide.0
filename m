From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Thu, 21 Oct 2004 16:36:08 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <001601c4b749$04f49550$7301a8c0@tw.ibm.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com> <58cb370e04101312321c78f3b8@mail.gmail.com> <416D88FA.1050200@pobox.com> <001901c4b4fd$88204bc0$294bbf09@tw.ibm.com> <4173F6AC.7090409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:10486 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S270408AbUJUIgi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 04:36:38 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>

Hi, Jeff:

 Please see my reply below.
I'll resend the patch according to your review/comments later.
Thanks for your patience for newbie like me. :-)

Thanks,
Albert

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Albert Lee" <albertcc@tw.ibm.com>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>; "IDE Linux"
<linux-ide@vger.kernel.org>
Sent: Tuesday, October 19, 2004 1:00 AM
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata


> I'm applying to libata-dev, but won't push this upstream for a while.
>
> My comments:
>
> 1) why is ROM enabled?  Normally you don't want to do this.
>
> +       /* Enable the ROM */
> +       /*
> +       if (pdev->resource[PCI_ROM_RESOURCE].start) {
> +               pci_write_config_dword(pdev, PCI_ROM_ADDRESS,
> +                       pdev->resource[PCI_ROM_RESOURCE].start |
> PCI_ROM_ADDRESS
> _ENABLE);
>

Ported from the original driver blindly. I'll remove this stuff.

>
>
> 2) why does this quirk exist?  if pata_pdc2027x (libata) will work with
> this hardware, then remove this code (and quirk) completely.  It is up
> to the user to choose the correct driver, if multiple drivers will
> function properly on the hardware.
>
> +#ifdef PDC_20276_QUIRK
> +       /*
> +        * Skip Promise PDC20276 attached to I2O RAID controller
> +        */
> +       if ((pdev->device == PCI_DEVICE_ID_PROMISE_20276) &&
> +           (pdev->bus->self) &&
> +           (pdev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
> +           ((pdev->bus->self->device == PCI_DEVICE_ID_INTEL_I960) ||
> +            (pdev->bus->self->device == PCI_DEVICE_ID_INTEL_I960RM))) {
> +               printk(KERN_INFO DRV_NAME ": Skipping Promise PDC20276 "
> +                      "attached to I2O RAID controller.\n");
> +               return -ENODEV;
> +       }
> +#endif
>

  Ported from the original driver blindly, too.  :-(
I don't know why the original driver doesn't support it.
I'll remove it, too.

>
>
> 3) the quirk PDC_20270_QUIRK needs work to conform to current PCI API
> standards.
>
>

  Could this also be removed?
This is also ported blindly from the original driver. :-(
It seems to be a bug of DEC21150 PCI south bridge chip,
but there is no detail about the actual problem.
(I've searched the archive, but no clue found.)


>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

