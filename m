From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Mon, 18 Oct 2004 13:00:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4173F6AC.7090409@pobox.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com> <58cb370e04101312321c78f3b8@mail.gmail.com> <416D88FA.1050200@pobox.com> <001901c4b4fd$88204bc0$294bbf09@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266896AbUJRRAm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Oct 2004 13:00:42 -0400
In-Reply-To: <001901c4b4fd$88204bc0$294bbf09@tw.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>

I'm applying to libata-dev, but won't push this upstream for a while.

My comments:

1) why is ROM enabled?  Normally you don't want to do this.

+       /* Enable the ROM */
+       /*
+       if (pdev->resource[PCI_ROM_RESOURCE].start) {
+               pci_write_config_dword(pdev, PCI_ROM_ADDRESS,
+                       pdev->resource[PCI_ROM_RESOURCE].start | 
PCI_ROM_ADDRESS
_ENABLE);



2) why does this quirk exist?  if pata_pdc2027x (libata) will work with 
this hardware, then remove this code (and quirk) completely.  It is up 
to the user to choose the correct driver, if multiple drivers will 
function properly on the hardware.

+#ifdef PDC_20276_QUIRK
+       /*
+        * Skip Promise PDC20276 attached to I2O RAID controller
+        */
+       if ((pdev->device == PCI_DEVICE_ID_PROMISE_20276) &&
+           (pdev->bus->self) &&
+           (pdev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
+           ((pdev->bus->self->device == PCI_DEVICE_ID_INTEL_I960) ||
+            (pdev->bus->self->device == PCI_DEVICE_ID_INTEL_I960RM))) {
+               printk(KERN_INFO DRV_NAME ": Skipping Promise PDC20276 "
+                      "attached to I2O RAID controller.\n");
+               return -ENODEV;
+       }
+#endif



3) the quirk PDC_20270_QUIRK needs work to conform to current PCI API 
standards.



