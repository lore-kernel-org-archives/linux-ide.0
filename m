From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCH] Re: PCI IRQ problems -- update
Date: Thu, 16 Dec 2004 06:16:56 -0500
Message-ID: <20041216111656.GA12740@jim.sh>
References: <20041211173538.GA21216@jim.sh> <1102783555.7267.37.camel@localhost.localdomain> <20041211202314.GA22731@jim.sh> <20041211220307.GA23848@jim.sh> <1102851831.1371.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:43173 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S261480AbULPLRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2004 06:17:00 -0500
Content-Disposition: inline
In-Reply-To: <1102851831.1371.23.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Alan Cox wrote:
> > I added a quirk for this case.  This is against 2.6.10-rc3, and it
> > makes all of my problems go away cleanly.  Is this reasonable?
> 
> I think so. You might want to send a copy to linux-ide@vger.kernel.org
> so that Bartlomiej doesn't miss it.

Alan, thanks for the help.

Bartlomiej: I have an ICH3-M controller on my laptop.  The BIOS is
leaving the prog-if as 0x8E (primary = legacy, secondary = native).
When the PCI interrupt is routed (either in the IDE driver's
pci_enable_device, or earlier if pci=routeirq is used), unhandled
interrupts cause IRQ 9 to be disabled, breaking most of my other
hardware.  This seems to be caused by having the nonexistant secondary
interface set to native mode.  According to the datasheet I checked,
having different modes for primary/secondary is not an allowed
combination anyway, so the following PCI quirk checks for this case
and forces both interfaces to legacy if true.

It may make sense to make this more generic (this problem may affect
other PCI IDs as well), or it may be better solved in the IDE driver,
at least when pci=routeirq is not used.  But the following patch does
work well for me.

-jim

--- a/drivers/pci/quirks.c	2004-12-10 19:18:50.000000000 -0500
+++ b/drivers/pci/quirks.c	2004-12-11 16:32:41.000000000 -0500
@@ -717,6 +717,26 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
 
+/*
+ *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
+ */
+static void __init quirk_ide_samemode(struct pci_dev *pdev)
+{
+	u8 prog;
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
+	if ( ((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1)) )
+	{
+		printk(KERN_INFO
+		       "PCI: IDE mode mismatch; forcing legacy mode\n");
+		prog &= ~5;
+		pdev->class &= ~5;
+		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+		/* need to re-assign BARs for compat mode */
+		quirk_ide_bases(pdev);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
  */

