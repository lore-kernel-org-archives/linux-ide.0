From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] advertise correct IDE mode on Pegasos2
Date: Fri, 17 Aug 2007 16:33:11 +0200
Message-ID: <20070817143311.GA32390@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <20070817131048.GA31192@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33769 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764427AbXHQOdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2007 10:33:00 -0400
Content-Disposition: inline
In-Reply-To: <20070817131048.GA31192@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, Aug 17, Olaf Hering wrote:

Still not 100% perfect.

> +		prom_printf("Fixing up IDE class-code on Pegasos...\n");
> +		rc = prom_getprop(ph, "class-code", prop, sizeof(u32));
> +		if (rc == sizeof(u32)) {
> +			prop[0] &= ~0x5;
> +			prom_setprop(ph, name, "class-code", prop, sizeof(u32));
> +		}

This updates the class code in the device-tree, but sysfs still shows
the old value.

> +	pci_read_config_byte(viaide, PCI_CLASS_PROG, &progif);
> +	pci_write_config_byte(viaide, PCI_CLASS_PROG, progif & ~0x5);

Is this a readonly register by any chance?
Appending a 'viaide->class &= ~0x5;' changes the code paths in
do_ide_setup_pci_device(), now IDE prints 'not 100%% native mode,
will probe irqs later'. Where are the irqs supposed to come from?

> -#ifdef CONFIG_PPC_CHRP
> -	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
> -		hwif->irq = hwif->channel ? 15 : 14;
> -	}
> -#endif

Maybe we should just leave this in and dont bother about the arch
specific tweak?
