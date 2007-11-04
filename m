From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: new errors with sata_sil24 with port multiplier
Date: Sat, 3 Nov 2007 22:37:22 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4DA0EB31@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:28605
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbXKDCfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 22:35:48 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Now that the speed of this drive has been at 1.5gbs, the error has not
returned under moderate disk load for 20 or so hours.  This is odd
because 7 other drives on the same controller are working at 3.0gbs.

Jon

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Saturday, November 03, 2007 12:25 AM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org
Subject: Re: new errors with sata_sil24 with port multiplier

Jon Chelton wrote:
> ata2.02: irq_stat 0x02020002, device error via SDB FIS
> ata2.02: cmd 60/50:00:6f:5b:02/00:00:00:00:00/40 tag 0 cdb 0x0 data
> 40960 in
>          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x1 (device
> error)

Hmmm... Status register value is weird here.  It's reporting device
error via SDB FIS but ERR bit is not set in the status register.

> ata2.03: exception Emask 0x0 SAct 0x10 SErr 0x0 action 0x2 frozen

This is collateral damage.

> ata2.15: hard resetting link
> ata2: controller in dubious state, performing PORT_RST

Ah, okay.  Receiving SDB FIS confused the controller.  This is a erratum
of the controller.  If error occurs while commands are in flight to more
than on device, the controller gets completely f***ed up.  This is
probably why the status and error registers are not updated correctly
above.

[EH kicks in and cleans up]

> ata2.00: exception Emask 0x0 SAct 0x20 SErr 0x0 action 0x0
> ata2.02: exception Emask 0x0 SAct 0x8 SErr 0x380000 action 0x2
> ata2.02: irq_stat 0x02020002, device error via SDB FIS
> ata2.02: cmd 60/78:18:47:6f:76/00:00:00:00:00/40 tag 3 cdb 0x0 data
> 61440 in
>          res 41/84:07:b8:6f:76/00:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>

Okay, again, the same device reporting device error and commands only to
the device were in flight so the controller updated status and error
correctly.  The device is reporting ATA bus error.

[again, EH cleans up]

> ata2.02: exception Emask 0x0 SAct 0x80 SErr 0x380000 action 0x2
> ata2.02: irq_stat 0x02020002, device error via SDB FIS
> ata2.02: cmd 60/80:38:3f:78:77/00:00:00:00:00/40 tag 7 cdb 0x0 data
> 65536 in
>          res 41/84:6f:50:78:77/00:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata2.02: soft resetting link
> ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

And the same thing one more time.  Note that link is still 3Gbps.

> ata2.02: exception Emask 0x0 SAct 0x77060000 SErr 0x380000 action 0x2
> ata2.02: irq_stat 0x02020002, device error via SDB FIS
> ata2.02: cmd 60/08:e0:7f:05:77/00:00:00:00:00/40 tag 28 cdb 0x0 data
> 4096 in
>          res 41/84:00:86:05:77/00:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>
> ata2.02: soft resetting link
> ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

Ditto.

> ata2.02: limiting SATA link speed to 1.5 Gbps
> ata2.02: exception Emask 0x0 SAct 0x6 SErr 0x380000 action 0x6
> ata2.02: irq_stat 0x02020002, device error via SDB FIS
> ata2.02: cmd 60/80:10:bf:54:79/00:00:00:00:00/40 tag 2 cdb 0x0 data
> 65536 in
>          res 41/84:0f:30:55:79/0c:00:00:00:00/40 Emask 0x410 (ATA bus
> error) <F>

One more time.  EH had enough and limited link speed to 1.5Gbps.  Did
error repeat after this?

Possibilities...

1. The disk or the connector on that slot is faulty.  You can find out
by swapping disk positions and see where the error follows.

2. The specific disk model and the PMP don't like each other at 3Gbps?

Solutions...

1. If the disk is faulty, exchange.

2. If the slot is faulty, exchange.

3. If the disk has dip switch to limit PHY speed to 1.5Gbps, put it on.
 You will hardly lose anything.

Thanks.

-- 
tejun

