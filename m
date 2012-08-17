From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] [Patch] pata_cs5536: add quirk for broken udma
Date: Fri, 17 Aug 2012 13:34:56 -0400
Message-ID: <502E80C0.80304@pobox.com>
References: <CAH9NwWcHv=A2EQYdzdCrjwkms7pdNQ5L9uyBh1Q8_+QAACD=zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34972 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab2HQRe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:34:59 -0400
Received: by yhmm54 with SMTP id m54so4210693yhm.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:34:59 -0700 (PDT)
In-Reply-To: <CAH9NwWcHv=A2EQYdzdCrjwkms7pdNQ5L9uyBh1Q8_+QAACD=zQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-ide@vger.kernel.org, mkp@mkp.net

On 07/26/2012 09:40 AM, Christian Gmeiner wrote:
> Hi all.
>
> I am working on a device which uses the cs5536 pata driver. There are
> some broken hardware
> revisions out in the field, which can be detected via DMI. I am
> looking for a way now to get
> this quirk upstream. On older versions with an embedded BIOS and I
> used libata.dma=0
> to disable dma completely.
> Now we are switching to a coreboot/seabios based BIOS where we have
> DMI support and
> so I think its a good idea to get rid of all those hacky kernel
> parameters as the same image
> is used other devices where libata.dma=0 is not so a good idea.
>
> I came up with this patch. I am not sure if it would be better to
> patch libata-core.c
>
> Thanks,
> ---
> Christian Gmeiner, MSc
>
>
> --- linux-3.2.24___OK/drivers/ata/pata_cs5536.c	2012-07-25
> 05:11:50.000000000 +0200
> +++ linux-3.2.24/drivers/ata/pata_cs5536.c	2012-07-26 15:38:27.674909884 +0200
> @@ -37,6 +37,7 @@
>   #include <linux/delay.h>
>   #include <linux/libata.h>
>   #include <scsi/scsi_host.h>
> +#include <linux/dmi.h>
>
>   #ifdef CONFIG_X86_32
>   #include <asm/msr.h>
> @@ -95,6 +96,21 @@
>   	PCI_IDE_CFG, PCI_IDE_DTC, PCI_IDE_CAST, PCI_IDE_ETC,
>   };
>
> +/* Some Bachmann OT200 devices have a non working UDMA support due a
> + * missing resistor.
> + */
> +static const struct dmi_system_id udma_quirk_dmi_table[] = {
> +        {
> +                .ident = "Bachmann electronic OT200",
> +                .matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Bachmann electronic"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "OT200"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "1")
> +		},
> +        },
> +        { }
> +};
> +
>   static inline int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
>   {
>   	if (unlikely(use_msr)) {
> @@ -257,9 +273,22 @@
>   		.port_ops = &cs5536_port_ops,
>   	};
>
> -	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
> +	static const struct ata_port_info no_udma_info = {
> +                .flags = ATA_FLAG_SLAVE_POSS,
> +                .pio_mask = ATA_PIO4,
> +                .port_ops = &cs5536_port_ops,
> +	};
> +
> +	const struct ata_port_info *ppi[2];
>   	u32 cfg;
>
> +	if (dmi_check_system(udma_quirk_dmi_table))
> +		ppi[0] = &no_udma_info;
> +	else
> +		ppi[0] = &info;
> +
> +	ppi[1] = &ata_dummy_port_info;

ACK patch content, but it did not apply



