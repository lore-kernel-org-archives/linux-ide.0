From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 21/21] ide: make remaining built-in only IDE host drivers
 modular
Date: Fri, 04 Jan 2008 23:19:57 +0300
Message-ID: <477E94ED.8090009@ru.mvista.com>
References: <200711182341.31267.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2563 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754407AbYADUTR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jan 2008 15:19:17 -0500
In-Reply-To: <200711182341.31267.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Bartlomiej Zolnierkiewicz wrote:

> * Make remaining built-in only IDE host drivers modular, add ide-scan-pci.c
>   file for probing PCI host drivers registered with IDE core (special case
>   for built-in IDE and CONFIG_IDEPCI_PCIBUS_ORDER=y) and then take care of
>   the ordering in which all IDE host drivers are probed when IDE is built-in
>   during link time.

> * Move probing of gayle, falconide, macide, q40ide and buddha (m68k arch
>   specific) host drivers, before PCI ones (no PCI on m68k), ide-cris (cris
>   arch specific), cmd640 (x86 arch specific) and pmac (ppc arch specific).

> * Move probing of ide-cris (cris arch specific) host driver before cmd640
>   (x86 arch specific).

> * Move probing of mpc8xx (ppc specific) host driver before ide-pnp (depends
>   on ISA and none of ppc platform that use mpc8xx supports ISA) and ide-h8300
>   (h8300 arch specific).

> * Add "probe_vlb" kernel parameter to cmd640 host driver and update
>   Documentation/ide.txt accordingly.

> * Make IDE_ARM config option visible so it can also be disabled if needed.

> * Remove bogus comment from ide.c while at it.

> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[...]

> Index: b/drivers/ide/h8300/ide-h8300.c
> ===================================================================
> --- a/drivers/ide/h8300/ide-h8300.c
> +++ b/drivers/ide/h8300/ide-h8300.c
[...]
> @@ -104,7 +104,7 @@ void __init h8300_ide_init(void)
>  	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
>  	if (hwif == NULL) {
>  		printk(KERN_ERR "ide-h8300: IDE I/F register failed\n");
> -		return;
> +		return -ENOMEM;
>  	}

    ENOENT would seem more appropriate...

> Index: b/drivers/ide/pci/cmd640.c
> ===================================================================
> --- a/drivers/ide/pci/cmd640.c
> +++ b/drivers/ide/pci/cmd640.c
> @@ -706,9 +706,9 @@ static int pci_conf2(void)
>  }
>  
>  /*
> - * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
> + * Probe for a cmd640 chipset, and initialize it if found.
>   */
> -int __init ide_probe_for_cmd640x (void)
> +static int __init cmd640x_init(void)
>  {
>  #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
>  	int second_port_toggled = 0;
> @@ -883,3 +883,7 @@ int __init ide_probe_for_cmd640x (void)
>  	return 1;
>  }
>  
> +module_param_named(probe_vlb, cmd640_vlb, bool, 0);
> +MODULE_PARM_DESC(probe, "probe for VLB version of CMD640 chipset");

    Shouldn't 'probe' be 'probe_vlb' here?

> +
> +module_init(cmd640x_init);

    BTW, it's interesting why this driver still uses it's own home-grown PCI 
config. space access code? 8-)

MBR, Sergei
