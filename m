From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Thu, 15 May 2008 00:28:04 +0200
Message-ID: <200805150028.04625.bzolnier@gmail.com>
References: <58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com> <20080509.215601.208967867.takada@mbf.nifty.com> <200805142244.48548.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:60428 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYENWLz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 18:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so61221nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 15:11:54 -0700 (PDT)
In-Reply-To: <200805142244.48548.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TAKADA Yoshihito <takada@mbf.nifty.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 14 May 2008, Bartlomiej Zolnierkiewicz wrote:
> On Friday 09 May 2008, TAKADA Yoshihito wrote:
> > Hi.
> > 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
> > Date: Fri, 9 May 2008 11:27:53 +0200
> > 
> > > On Friday 09 May 2008, TAKADA Yoshihito wrote:
> > > > Thanks for quick reply.
> > > > 
> > > > I tried 2.6.26rc1. It hangs same as 2.6.25.
> > > > kernel 2.6.26rc1 with cs5520 cannot boot. cs5520 scans ide0 and ide1.
> > > > It seems 2nd port DMA base issue was solved.
> > > 
> > > [...]
> > > 
> > > Thanks.
> > > 
> > > The following patch for 2.6.26-rc1 disables VDMA, please give it a try
> > > (I haven't time to fully audit VDMA support yet but lets see if it is
> > > the main source of the problems).
> > 
> > I applied the patch. But kernel was hung.
> > And I attempt to kill IDE_HFLAG_CS5520. It cannot boot, oo.
> > 
> >   kill IDE_HFLAG_VDMA  : hang  
> >   kill IDE_HFLAG_CS5520: hang
> >   kill both flags      : boot
> 
> Thanks for investigating this - I forgot that currently VDMA and CS5520
> host flags use the same bit (so it also needs to be fixed).
> 
> I'm going to send the following patch to Linus (please verify it):
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] cs5520: disable VDMA

[...]

Please also try 2.6.26-rc2 without the above patch but with the following
patch applied instead - according to comments in OpenFirmware & pata_cs5520
code 0x60 register contains bus-master enable bit, it could be that it was
left disabled by BIOS and we need to explicitely enable it (if somebody has
CX5510 or CX5520 datasheet please verify this + send me a copy if possible).

---
 drivers/ide/pci/cs5520.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -147,6 +147,7 @@ static int __devinit cs5520_init_one(str
 {
 	const struct ide_port_info *d = &cyrix_chipsets[id->driver_data];
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	u8 pcicfg;
 
 	ide_setup_pci_noise(dev, d);
 
@@ -163,6 +164,13 @@ static int __devinit cs5520_init_one(str
 		return -ENODEV;
 	}
 
+	pci_read_config_byte(dev, 0x60, &pcicfg);
+
+	if ((pcicfg & 0x40) == 0) {
+		printk(KERN_WARNING "cs5520: DMA mode disabled. Enabling.\n");
+		pci_write_config_byte(dev, 0x60, pcicfg | 0x40);
+	}
+
 	/*
 	 *	Now the chipset is configured we can let the core
 	 *	do all the device setup for us

