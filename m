From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Wed, 09 Feb 2011 15:56:32 +0300
Message-ID: <4D528F00.1090000@ru.mvista.com>
References: <20110209115929.GS5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43541 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab1BIM5s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 07:57:48 -0500
Received: by bwz15 with SMTP id 15so919980bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 04:57:47 -0800 (PST)
In-Reply-To: <20110209115929.GS5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org

Hello.

On 09-02-2011 14:59, Joerg Dorchain wrote:

> Hello all,

> Disclaimer: this patch is based on http://mjg59.livejournal.com/85504.html
> It is in works-for-me state.

> The patch to ahci.c is required for suspend/resume.

    Need a better description than thatl, I think...

> Signed-Off-By: joerg Dorchain <joerg@dorchain.net>

> --- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
> +++ linux/drivers/pci/quirks.c	2011-02-09 11:16:36.000000000 +0100
> @@ -2684,6 +2684,79 @@
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
>
>   /*
> + * Force ICH7/8/9 into AHCI mode.  This is needed because some
> + * BIOSes do not make AHCI-mode operation available to the user.
> + * As the Intel documentation states that the OS should not carry
> + * out the operation - the user must force this on the kernel
> + * commandline using quirk_ich_force_ahci
> + *
> + * As this quirk gets called whilst the PCI subsystem is
> + * walking the PCI bus, we declare this quirk against the LPC
> + * (device 00:1f.0), so that we can frob 00:1f.2 before the PCI
> + * code has scanned it.
> + * Note: the pci id might change due to this (e.g. from 27c4 to 27c5)
> + *
> + */
> +
> +static bool ich_force_ahci_mode = false;
> +static bool ich_ahci_mode_forced = false;

    This variable is write-only, hence not needed.

> +static void ich789_force_ahci_mode(struct pci_dev *pdev)
> +{
> +        u8 amrval;
> +        u8 sclkgc;
> +        const int ich89_address_map_reg = 0x90;
> +        const int ich89_sata_clock_gen_config_reg = 0x9c;
> +        /* const u32 ich89_func_disable_reg_offset = 0x3418; */

    No commented out code, please.

> +        /* ICH8 datasheet section 12.1.33 */
> +        if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +                                ich89_address_map_reg,&amrval))
> +{

    Brace should be on the same line as the end of *if*.

> --- linux/drivers/ata/ahci.c.orig	2011-02-04 18:13:33.000000000 +0100
> +++ linux/drivers/ata/ahci.c	2011-02-04 18:23:41.000000000 +0100
> @@ -640,6 +640,8 @@
>   	struct ata_host *host = dev_get_drvdata(&pdev->dev);
>   	int rc;
>
> +	// override check to see if PCI config space is already restored in pci_restore_state

    No C99 // comments please.

WBR, Sergei
