From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Fri, 11 Feb 2011 23:50:06 +0300
Message-ID: <4D55A0FE.30505@ru.mvista.com>
References: <20110209115929.GS5778@Redstar.dorchain.net> <4D528F00.1090000@ru.mvista.com> <20110210192321.GB5778@Redstar.dorchain.net> <4D552B18.8030808@ru.mvista.com> <20110211173620.GF5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58762 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077Ab1BKUvf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 15:51:35 -0500
Received: by bwz15 with SMTP id 15so3614446bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 11 Feb 2011 12:51:33 -0800 (PST)
In-Reply-To: <20110211173620.GF5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: linux-ide@vger.kernel.org

Hello.

Joerg Dorchain wrote:

>>> During resume from suspend to ram, the kernel pci layer restores
>>> the registers for the SATA controller once, then says okay, and
>>> sets dev->state_saved = false. However, since the restore goes
>> >from highest address (the BARs [base address registers]) to
>>> lowest register, some of the higher registers are set as RO
>>> because according to the lower registers controller is in PIIX
>>> mode.  This patch introduces a workaround for
>>> this problem, hacking around the PCI API by setting pdev->state_saved = true
>>> before we do the restore.

>> This only describes drivers/ata/ahci.c change.

> Well, the functionality of the patch to quirks.c is described in
> the comments on the top of it. Should that be repeated?

    Yes, certainly.

>> And looks like it
>> should be in a patch of its own...

> I need both parts in order to use the AHCI driver and having
> suspend/resume work, hence they are together.

    They are solving two different issues, as far as I understand, hence should 
be in two different patches. One issue per patch is the basic rule.

> Bye,

> Joerg

> Signed-Off-By: joerg Dorchain<joerg@dorchain.net>

> --- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
> +++ linux/drivers/pci/quirks.c	2011-02-11 13:44:12.000000000 +0100
> @@ -2684,6 +2684,74 @@
[...]
> +static void ich789_force_ahci_mode(struct pci_dev *pdev)
> +{
> +	u8 amrval;
> +	u8 sclkgc;
> +	const int ich89_address_map_reg = 0x90;
> +	const int ich89_sata_clock_gen_config_reg = 0x9c;
> +
> +	if (!ich_force_ahci_mode)
> +		return;
> +
> +	/* ICH8 datasheet section 12.1.33 */
> +	if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
> +        	ich89_address_map_reg, &amrval)) {

    Still spaces at the start of line... run your patches thru 
scripts/checkpatch.pl -- it notices such style violations.

WBR, Sergei

