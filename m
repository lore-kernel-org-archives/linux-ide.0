From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE driver assined IRQ for disabled IDE channel
Date: Sun, 27 Jul 2008 15:56:52 +0200
Message-ID: <200807271556.52270.bzolnier@gmail.com>
References: <20080725.143128.193681587.takada@mbf.nifty.com> <200807261358.59667.bzolnier@gmail.com> <20080727.105140.141855485.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:32451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYG0N7i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jul 2008 09:59:38 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3014078fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 27 Jul 2008 06:59:36 -0700 (PDT)
In-Reply-To: <20080727.105140.141855485.takada@mbf.nifty.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TAKADA Yoshihito <takada@mbf.nifty.com>
Cc: linux-ide@vger.kernel.org

On Sunday 27 July 2008, TAKADA Yoshihito wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: Re: IDE driver assined IRQ for disabled IDE channel
> Date: Sat, 26 Jul 2008 13:58:59 +0200
> 
> Hi. Thanks for your reply.
> 
> > Could you please post the full dmesg?
> 
> Ok. Attached it.

Thank you.

dmesg-2.6.26:
...
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=0
PCI: Using configuration type 1 for base access
Setting up standard PCI resources
...
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
...

ide_generic has no enablebits checking but 'ide_generic.probe_mask=1'
kernel parameter can be used to limit probing to the first port only.
However shouldn't a designated IDE PCI host driver be used instead?

[ if this is Cx5520 PCI IDE, the cs5520 host driver misses enablebits
  checking, untested fix attached ]

> > Unfortunately we can't fix it this way as this will cause regression
> > for other people (we now want ports with no devices attached to be also
> > registered to allow warm-plugging of IDE devices).
> 
> ide_probe_port() returns -ENODEV, so hwif->present clear to 0.
> I think hwif->present mean IDE channel is exist/enabled. Doesn't mean
> connected devices(disks, CD-ROM drives and others).

It used to mean both because the port was registered only if there
were devices connected to it but it is no longer a case (seems like
->present documentation in ide.h is out of date now and needs fixing).

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5520: add enablebits checking

Based on sparse comments in OpenFirmware code
(no Cx5510/Cx5520 datasheet here).

Cc: TAKADA Yoshihito <takada@mbf.nifty.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -123,6 +123,7 @@ static const struct ide_dma_ops cs5520_d
 #define DECLARE_CS_DEV(name_str)				\
 	{							\
 		.name		= name_str,			\
+		.enablebits	= { {0x60, 0x01, 0x01}, {0x60, 0x02, 0x02} }, \
 		.port_ops	= &cs5520_port_ops,		\
 		.dma_ops	= &cs5520_dma_ops,		\
 		.host_flags	= IDE_HFLAG_ISA_PORTS |		\
