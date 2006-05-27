From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 18:43:01 -0400
Message-ID: <4478D5F5.1050205@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <Pine.LNX.4.64.0605271515050.5623@g5.osdl.org> <4478D17C.2050300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:50924 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964980AbWE0WnD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:43:03 -0400
In-Reply-To: <4478D17C.2050300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Linus Torvalds wrote:
..
>> Can you move the two new lines to *after* the ata_busy_wait? I'd like 
>> to see if ATA_DRDY ever comes on (it quite possibly will not, just 
>> humor me)
> 
> Okay.  rebooting now..
..

Okay, I used a patch like this on top of what we had before (warning: broken whitespace):

--- linux/drivers/scsi/libata-core.c.saved      2006-05-27 17:22:42.000000000 -0400
+++ linux/drivers/scsi/libata-core.c    2006-05-27 18:35:02.000000000 -0400
@@ -4297,7 +4297,11 @@
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
        if (ap->flags & ATA_FLAG_SUSPENDED) {
+               u8 status1, status2;
+               status1 = ata_chk_status(ap);
                ata_busy_wait(ap, ATA_BUSY, 200000);
+               status2 = ata_chk_status(ap);
+               printk("ATA status1=%02x status2=%02x\n", status1, status2);
                ap->flags &= ~ATA_FLAG_SUSPENDED;
                ata_set_mode(ap);
        }
---------------------------------------------------------------------------

The output it gave me was:

May 27 18:39:12 localhost kernel: ATA status1=80 status2=50
May 27 18:39:12 localhost kernel: ata1: dev 0 configured for UDMA/100
May 27 18:39:12 localhost kernel: ATA status1=00 status2=00
May 27 18:39:12 localhost kernel: ata2: dev 0 configured for UDMA/33

So my drive, at least, seems to give DRDY very rapidly after de-asserting BUSY.

Cheers
