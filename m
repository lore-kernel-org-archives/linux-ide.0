From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: IDE - do spin up for all platforms
Date: Mon, 09 Aug 2004 10:57:34 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411790DE.7010503@pobox.com>
References: <20040809143902.GA16025@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44257 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266680AbUHIO7Y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Aug 2004 10:59:24 -0400
In-Reply-To: <20040809143902.GA16025@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> This was put in for PPC specifically and defined in the 2.4 tree to be
> paranoid about breaking stuff. The actual wait for hwif spin up is however
> perfectly correct for all drives. In the normal PC case the PC BIOS has done
> this but with other embedded boxes and with things like LinuxBIOS it may not
> have done. Thus it should always be done.
> 
> --- drivers/ide/ide-probe.c~	2004-08-09 15:36:13.109053400 +0100
> +++ drivers/ide/ide-probe.c	2004-08-09 15:36:13.109053400 +0100
> @@ -635,7 +635,6 @@
>  	device_register(&hwif->gendev);
>  }
>  
> -#ifdef CONFIG_PPC
>  static int wait_hwif_ready(ide_hwif_t *hwif)
>  {
>  	int rc;
> @@ -671,7 +670,6 @@
>  	
>  	return rc;
>  }
> -#endif
>  
>  /*
>   * This routine only knows how to look for drive units 0 and 1
> @@ -717,7 +715,6 @@
>  
>  	local_irq_set(flags);
>  
> -#ifdef CONFIG_PPC
>  	/* This is needed on some PPCs and a bunch of BIOS-less embedded
>  	 * platforms. Typical cases are:
>  	 * 
> @@ -739,7 +736,6 @@
>  	 */
>  	if (wait_hwif_ready(hwif))
>  		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
> -#endif /* CONFIG_PPC */


It needs to check for "status != 0x7f" which is the standard "no device 
here" return status.

But worse than that, status can return 0xFF for "no hardware there", in 
which case this routine will hang the boot for 35 seconds.

Note also that libata code does this:
* wait 7 seconds
* printk("it's taking a long time, be patient")
* wait ~30 seconds

	Jeff


