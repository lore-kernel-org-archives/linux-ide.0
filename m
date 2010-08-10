From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 10 Aug 2010 21:12:45 +0400
Message-ID: <4C61888D.4000806@ru.mvista.com>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37737 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100Ab0HJRNj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Aug 2010 13:13:39 -0400
Received: by mail-bw0-f46.google.com with SMTP id 3so2053030bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 10 Aug 2010 10:13:38 -0700 (PDT)
In-Reply-To: <20100810155559.7620.79711.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello.

Alan Cox wrote:

> Intel IDE-R devices are part of the Intel AMT management setup. They don't
> have any special configuration registers or settings so the ata_generic
> driver will support them fully.

> Rather than add a huge table of IDs for each chipset and keep sending in
> new ones this patch autodetects them.

> (And yes Jeff I'll resurrect the delay patches in a couple of weeks)

    Doesn't have to be in the changelog...

> Signed-off-by: Alan Cox <alan@linux.intel.com>

[...]

> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index cc5f772..476f194 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c
[...]
> @@ -109,6 +110,44 @@ static struct ata_port_operations generic_port_ops = {
>  static int all_generic_ide;		/* Set to claim all devices */
>  
>  /**
> + *	is_intel_ider		-	identify intel IDE-R devices
> + *	@dev: PCI device
> + *
> + *	Distinguish Intel IDE-R controller devices from other Intel IDE
> + *	devices. IDE-R devices have no timing registers and are in
> + *	most respects virtual. They should be driven by the ata_generic
> + *	driver.
> + */
> +
> +static int is_intel_ider(struct pci_dev *dev)
> +{
> +	/* For Intel IDE the value at 0xF8 is only zero on IDE-R
> +	   interfaces */

    Preferred style for multi-line comments is:

/*
  * bla
  * bla
  */

> +	u32 r;
> +	u16 t;
> +
> +	pci_read_config_dword(dev, 0xF8, &r);
> +	/* Not IDE-R: punt so that ata_(old)piix gets it */
> +	if (r != 0)
> +		return 0;
> +	/* 0xF8 is also be zero on some early Intel IDE devices

    Grammar.

> +	   but they will have a sane timing register */

    The same remark about the comment style...

> +	pci_read_config_word(dev, 0x40, &t);
> +	if (t != 0)
> +		return 0;
> +	/* Finally check if the timing register is writable so that
> +	   we eliminate any early devices hot-docked in a docking
> +	   station */

    ... and here too.

> @@ -134,6 +173,10 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>  	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide == 0)
>  		return -ENODEV;
>  
> +	if (id->driver_data && ATA_GEN_INTEL_IDER)

    I think you mean & here, rather than &&...

MBR, Sergei

