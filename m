From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Tue, 19 Apr 2011 11:20:30 +0200
Message-ID: <201104191120.31061.bzolnier@gmail.com>
References: <1303084704.2583.23.camel@mulgrave.site> <1303142114.7167.6.camel@mulgrave.site> <4DAC63EA.4000707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1DSJVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 05:21:31 -0400
Received: by fxm17 with SMTP id 17so3263145fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 19 Apr 2011 02:21:30 -0700 (PDT)
In-Reply-To: <4DAC63EA.4000707@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org


Hi,

Sergei Shtylyov wrote:

> Hello.
> 
> James Bottomley wrote:
> 
> >>> I can get all of this working by fixing up all the hard coded knowledge
> >>> in libata-sff only to use a single port.
> >>> However, I can't fix the libata-sff driver until I know how to tell
> >>> there's only one port wired.  Does anyone with cmd649 knowledge have any
> >>> idea how I might tell this?
> 
> >>     The secondary port is enabled in the PCI config. space: register 0x51 bit 
> >> 3 controls this. Unfortunately, pata_cmd64x driver still doesn't check the 
> >> channel enable bits; the cmd64x driver does though, so it might be worth trying...
> 
> > So this is the enablebits code in driver/ide
> 
>     We still need to ensure that these are indeed the enable bits that are at 
> play here...
> 
> > that's missing from any of
> > the libata stuff?
> 
>     Not from any. It's handled in some drivers, like pata_hpt37x, for example -- 
> in their prereset() methods.
> 
> > Should this be generic in libata-sff? ...
> 
>     There's even libata core function, pci_test_config_bits() that facilitates 
> this check.
> 
> > I mean even on an x86 where arbitrary memory can be poked without consequence,
> > trying to activate a disabled port will still produce lots of noise.
> 
>     The story with pata_cmd64x is somewhat convoluted: originally (when the 
> libata driver was created) in the IDE driver there were only enable bits for the 
> secondary channel of PCI0646 (and even those wrong); I fixed those and added the 
> enable bits for other chips back in 2007 but it never got propagated to 
> pata_cmd64x. Well, I have some plans for changes to this driver but not much 
> time to actually do them currently...

>From atang tree, orginally posted in 2009:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH v2] pata_cmd64x: add enablebits checking

Fixes IDE -> libata regression.

IDE's cmd64x host driver has been supporting enablebits checking
since the initial driver's merge.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -79,6 +79,40 @@ static int cmd648_cable_detect(struct at
 }
 
 /**
+ *	cmd64x_prereset	-	perform reset handling
+ *	@link: ATA link
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Reset sequence checking enable bits to see which ports are
+ *	active.
+ */
+
+static int cmd64x_prereset(struct ata_link *link, unsigned long deadline)
+{
+	static const struct pci_bits cmd64x_enable_bits[] = {
+		{ 0x51, 1, 0x04, 0x04 },
+		{ 0x51, 1, 0x08, 0x08 }
+	};
+
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	/*
+	 * The original PCI0643 and PCI0646 didn't have the primary
+	 * channel enable bit, it appeared starting with PCI0646U
+	 * (i.e. revision ID 3).
+	 */
+	if (ap->port_no == 0 && (pdev->device == PCI_DEVICE_ID_CMD_643 ||
+	    (pdev->device == PCI_DEVICE_ID_CMD_646 && pdev->revision < 3)))
+		goto out;
+
+	if (!pci_test_config_bits(pdev, &cmd64x_enable_bits[ap->port_no]))
+		return -ENOENT;
+out:
+	return ata_sff_prereset(link, deadline);
+}
+
+/**
  *	cmd64x_set_timing	-	set PIO and MWDMA timing
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -266,6 +300,7 @@ static const struct ata_port_operations
 	.inherits	= &ata_bmdma_port_ops,
 	.set_piomode	= cmd64x_set_piomode,
 	.set_dmamode	= cmd64x_set_dmamode,
+	.prereset	= cmd64x_prereset,
 };
 
 static struct ata_port_operations cmd64x_port_ops = {




