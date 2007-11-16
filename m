From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH][RESUBMIT] drivers/ide/ide-probe.c, kernel 2.6.23.1
Date: Fri, 16 Nov 2007 15:51:45 +0300
Message-ID: <473D9261.6080209@ru.mvista.com>
References: <473434F1.50509@purplescout.se> <200711132303.28424.bzolnier@gmail.com> <473C08B2.1030004@purplescout.se> <200711152159.23607.bzolnier@gmail.com> <473D88A5.306@purplescout.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:5388 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754439AbXKPMve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 07:51:34 -0500
In-Reply-To: <473D88A5.306@purplescout.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonas Stare <jonas.stare@purplescout.se>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

Jonas Stare wrote:

> diff -u linux-2.6.23.1-orig/drivers/ide/ide-probe.c linux-2.6.23.1/drivers/ide/ide-probe.c 
> --- linux-2.6.23.1-orig/drivers/ide/ide-probe.c 2007-10-12 18:43:44.000000000 +0200
> +++ linux-2.6.23.1/drivers/ide/ide-probe.c      2007-11-16 10:26:23.000000000 +0100
> @@ -643,6 +643,7 @@
>  static int wait_hwif_ready(ide_hwif_t *hwif)
>  {
>         int rc;
> +       int unit;
>  
>         printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
>  
> @@ -659,16 +660,25 @@
>                 return rc;
>  
>         /* Now make sure both master & slave are ready */
> -       SELECT_DRIVE(&hwif->drives[0]);
> -       hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> -       mdelay(2);
> -       rc = ide_wait_not_busy(hwif, 35000);
> -       if (rc)
> -               return rc;
> -       SELECT_DRIVE(&hwif->drives[1]);
> -       hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
> -       mdelay(2);
> -       rc = ide_wait_not_busy(hwif, 35000);
> +       for (unit = 0; unit < MAX_DRIVES; ++unit) {
> +               /* Ignore disks that we will not probe for later. */
> +               if (!hwif->drives[unit].noprobe ||
> +                   hwif->drives[unit].present) {

    Why not:

		if (hwif->drives[unit].noprobe || !hwif->drives[unit].present) {
                 	printk(KERN_DEBUG "Skip ide_wait_not_busy for %s:%d\n",
                                hwif->name, unit);
			continue;
		}
                 SELECT_DRIVE(&hwif->drives[unit]);
                 hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
                 mdelay(2);
                 rc = ide_wait_not_busy(hwif, 35000);
                 if (rc) {
			/* Exit function with master reselected */
                         if (unit != 0)
                         	SELECT_DRIVE(&hwif->drives[0]);
                         return rc;
         	}
	}
>  
>         /* Exit function with master reselected (let's be sane) */
>         SELECT_DRIVE(&hwif->drives[0]);

MBR, Sergei
