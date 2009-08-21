From: Andrei Martynov <andrei.martynov@web.de>
Subject: Re[2]: libata: waiting for the drives to settle
Date: Fri, 21 Aug 2009 09:56:33 +0200
Message-ID: <969415927.20090821095633@web.de>
References: <54773205.20090820114051@web.de> <4A8D7203.50006@garzik.org>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:53117 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZHUH4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Aug 2009 03:56:52 -0400
In-Reply-To: <4A8D7203.50006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Thursday, August 20, 2009, 5:55:47 PM, Jeff Garzik wrote:

> Have you verified this is needed, under libata?  We already have several
> waits...

Unfortunately it is needed. It is embedded system, where bootloader
always tries to boot from the first device (dvd-rom). Second device
(hard disk) is not yet ready when kernel is loaded from flash and does
probe.

I placed the code into dev_select callback

void jasper_dev_select(struct ata_port *ap, unsigned int device)
{
        u8 tmp;
        if (device == 0)
                tmp = ATA_DEVICE_OBS;
        else
                tmp = ATA_DEVICE_OBS | ATA_DEV1;
        iowrite8(tmp, ap->ioaddr.device_addr);
        ata_pause(ap);          /* needed; also flushes, for mmio */
        if (device && firstSlaveAccess) {
                firstSlaveAccess = 0;
                printk("waiting for drive to settle...\n");
                if (ioread8(ap->ioaddr.device_addr) != tmp) {
                        int rc;
                        for (rc = 0; rc < 150; rc++) {
                                iowrite8(tmp, ap->ioaddr.device_addr);
                                mdelay(50); //ata_pause(ap);
                                if (ioread8(ap->ioaddr.device_addr) == tmp)
                                        break;
                        }
                }
        }
}

It takes about 30 cycles (1.5s) to select slave for the first time.


-- 
Best regards,
 Andrei                            mailto:andrei.martynov@web.de

