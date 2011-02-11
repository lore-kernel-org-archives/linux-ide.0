From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Fri, 11 Feb 2011 15:27:04 +0300
Message-ID: <4D552B18.8030808@ru.mvista.com>
References: <20110209115929.GS5778@Redstar.dorchain.net> <4D528F00.1090000@ru.mvista.com> <20110210192321.GB5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48864 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1BKM2T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 07:28:19 -0500
Received: by bwz15 with SMTP id 15so3147425bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2011 04:28:18 -0800 (PST)
In-Reply-To: <20110210192321.GB5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org

Hello.

On 10-02-2011 22:23, Joerg Dorchain wrote:

> On Wed, Feb 09, 2011 at 03:56:32PM +0300, Sergei Shtylyov wrote:
> [Several formal corrections]

> Should be addressed by this try.

>>> The patch to ahci.c is required for suspend/resume.

>>     Need a better description than thatl, I think...

> Well, then it is a bit longer story.

> During resume from suspend to ram, the kernel pci layer restores
> the registers for the SATA controller once, then says okay, and
> sets dev->state_saved = false. However, since the restore goes
> from highest address (the BARs [base address registers]) to
> lowest register, some of the higher registers are set as RO
> because according to the lower registers controller is in PIIX
> mode.  This patch introduces a workaround for
> this problem, hacking around the PCI API by setting pdev->state_saved = true
> before we do the restore.

> Admittingly, more testing would be welcome.

> Signed-Off-By: joerg Dorchain<joerg@dorchain.net>

    This only describes drivers/ata/ahci.c change. And looks like it should be 
in a patch of its own...

> --- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
> +++ linux/drivers/pci/quirks.c	2011-02-09 14:40:15.000000000 +0100
> @@ -2684,6 +2684,76 @@
[...]
> +static void ich789_force_ahci_mode(struct pci_dev *pdev)
> +{
> +        u8 amrval;
> +        u8 sclkgc;
> +        const int ich89_address_map_reg = 0x90;
> +        const int ich89_sata_clock_gen_config_reg = 0x9c;

    You indent with spaces instead of tab here.

> +
> +	if (!ich_force_ahci_mode)
> +		return;
> +
> +        /* ICH8 datasheet section 12.1.33 */
> +        if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +        	ich89_address_map_reg, &amrval))

    You again indent with spaces...

> +	{

    I've clearly said that { should be on the same line as the end of *if* 
statement.

> +                if (amrval & (BIT(6) | BIT(7))) {
> +                        dev_printk(KERN_DEBUG, &pdev->dev,
> +                                        "ICH7/8/9 SATA controller not in IDE mode.  Not modifying.\n");
> +                        return;
> +                }
> +                if (amrval & (BIT(0) | BIT(1)))
> +                        dev_printk(KERN_DEBUG, &pdev->dev,
> +                                        "ICH7/8/9 in SATA/PATA combined mode.  Untested.\n");
> +                /* AHCI mode */
> +                amrval |= BIT(6);
> +                amrval &= ~BIT(7);
> +                pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +                                ich89_sata_clock_gen_config_reg, &sclkgc);
> +                dev_printk(KERN_DEBUG, &pdev->dev, "sclkgc is %#0x\n", sclkgc);
> +                pci_bus_write_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +                                ich89_address_map_reg, amrval);
> +                ich_ahci_mode_forced = true;
> +                dev_printk(KERN_DEBUG, &pdev->dev, "Forced ICH7/8/9 mode PIIX->AHCI\n");

    Again indented with spaces...

> +        }
> +

    Empty line not needed...

> +}

> --- linux/drivers/ata/ahci.c.orig	2011-02-04 18:13:33.000000000 +0100
> +++ linux/drivers/ata/ahci.c	2011-02-09 14:30:06.000000000 +0100
> @@ -640,6 +640,9 @@
>   	struct ata_host *host = dev_get_drvdata(&pdev->dev);
>   	int rc;
>
> +	/* override check to see if PCI config space is already
> +	 * restored in pci_restore_state */

    The preferred style for the multi-line comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
