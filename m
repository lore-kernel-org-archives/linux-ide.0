From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/15] ide: remove ide_find_best_pio_mode()
Date: Wed, 04 Jul 2007 00:20:16 +0400
Message-ID: <468AAF80.4050209@ru.mvista.com>
References: <200706302106.01458.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:25909 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756645AbXGCUSf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:18:35 -0400
In-Reply-To: <200706302106.01458.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ->host_flags to ide_hwif_t to store ide_pci_device_t.host_flags,
>   assign it in setup-pci.c:ide_pci_setup_ports().

> * Add IDE_HFLAG_PIO_NO_{BLACKLIST,DOWNGRADE} to ide_pci_device_t.host_flags
>   and teach ide_get_best_pio_mode() about them.  Also remove needless
>   !drive->id check while at it (drive->id is always present).

> * Convert amd74xx, via82cxxx and ide-timing.h to use ide_get_best_pio_mode()
>   and then remove no longer needed ide_find_best_pio_mode().

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Shtylyov <sshtylyov@ru.mvista.com>

    Still I have something to ask...

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -291,11 +291,11 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
>  	struct hd_driveid* id = drive->id;
>  	int overridden  = 0;
>  
> -	if (mode_wanted != 255) {
> -		pio_mode = mode_wanted;
> -	} else if (!drive->id) {
> -		pio_mode = 0;
> -	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
> +	if (mode_wanted != 255)
> +		return min_t(u8, mode_wanted, max_mode);
> +
> +	if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_BLACKLIST) == 0 &&

    C also has ! operator. ;-)

> +	    (pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
>  		printk(KERN_INFO "%s: is on PIO blacklist\n", drive->name);
>  	} else {
>  		pio_mode = id->tPIO;
> @@ -324,7 +324,8 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
>  		/*
>  		 * Conservative "downgrade" for all pre-ATA2 drives
>  		 */
> -		if (pio_mode && pio_mode < 4) {
> +		if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_DOWNGRADE) == 0 &&

    It really does! :-)

> +		    pio_mode && pio_mode < 4) {
>  			pio_mode--;
>  			printk(KERN_INFO "%s: applying conservative "
>  					 "PIO \"downgrade\"\n", drive->name);
> Index: b/drivers/ide/pci/amd74xx.c
> ===================================================================
> --- a/drivers/ide/pci/amd74xx.c
> +++ b/drivers/ide/pci/amd74xx.c
> @@ -1,5 +1,5 @@
>  /*
> - * Version 2.20
> + * Version 2.21
>   *
>   * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
>   * IDE driver for Linux.
> @@ -275,10 +275,8 @@ static int amd_set_drive(ide_drive_t *dr
>  
>  static void amd74xx_tune_drive(ide_drive_t *drive, u8 pio)
>  {
> -	if (pio == 255) {
> -		amd_set_drive(drive, ide_find_best_pio_mode(drive));
> -		return;
> -	}
> +	if (pio == 255)
> +		pio = ide_get_best_pio_mode(drive, 255, 5);
>  
>  	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
>  }

    Erm, I don't get it -- why not just use ide_get_best_pio_mode() for every 
'pio'? There should be no functionality changes, no?

> Index: b/drivers/ide/pci/via82cxxx.c
> ===================================================================
> --- a/drivers/ide/pci/via82cxxx.c
> +++ b/drivers/ide/pci/via82cxxx.c
> @@ -1,6 +1,6 @@
>  /*
>   *
> - * Version 3.45
> + * Version 3.46
>   *
>   * VIA IDE driver for Linux. Supported southbridges:
>   *
> @@ -203,10 +203,8 @@ static int via_set_drive(ide_drive_t *dr
>  
>  static void via82cxxx_tune_drive(ide_drive_t *drive, u8 pio)
>  {
> -	if (pio == 255) {
> -		via_set_drive(drive, ide_find_best_pio_mode(drive));
> -		return;
> -	}
> +	if (pio == 255)
> +		pio = ide_get_best_pio_mode(drive, 255, 5);
>  
>  	via_set_drive(drive, XFER_PIO_0 + min_t(u8, pio, 5));

    Same question here...

MBR, Sergei
