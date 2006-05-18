From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: ASUS A8V Deluxe, x86_64
Date: Thu, 18 May 2006 06:57:22 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7024643@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:61795 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S1751227AbWERK5Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 06:57:24 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, Tejun Heo <htejun@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, =?iso-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

> >> sd 0:0:0:0: Attached scsi disk sda
> >>   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
> >>   Type:   CD-ROM                             ANSI SCSI revision: 05
> > 
> > Above and the detailed log too indicate that everything went smooth 
> > the first time around.  Albert, do you have any ideas?  Could it be 
> > something related to irq-pio?

You cannot image how happy I was :)

 
> I've checked Vincent't dmesg for 2.6.17-rc0 again.
> (http://bugzilla.kernel.org/show_bug.cgi?id=5533)
> (http://bugzilla.kernel.org/attachment.cgi?id=7700&action=view)
> 
> It seems DMA commands are also affected by this problem, not 
> PIO unique.

> After comparing the code of 2.6.17-rc4 and current libata 
> upstream, maybe "flush" is the fix:
> The CDB was sent to the ATAPI device by PIO, but not flushed 
> to device.
> So, the device was busy waiting for the CDB to arrive.
 
> Hi Vincent,
>   Could you please try 2.6.17-rc4, both with and without the 
> attached patch, to see if the flush works. Thanks.

On a pure 2.6.17-rc4 without upstream libata patches I presume?  Sure I will tonight.
I'll forward this patch to my home email address and come back to you.

- vin
