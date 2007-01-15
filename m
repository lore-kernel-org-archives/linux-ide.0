From: "Dailey, Nate" <Nate.Dailey@stratus.com>
Subject: RE: sata_vsc.c cache line size question
Date: Mon, 15 Jan 2007 11:26:59 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF43703EE3171@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.stratus.com ([134.111.1.17]:48648 "EHLO
	mailhub4.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbXAOQ1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jan 2007 11:27:03 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org

Here's a patch that does what you suggest.

Because the default cache line size on my system is 0x10, I tested the
patch by checking against this value rather than 0... it worked as
expected.

This patch is against 2.6.19.2 that I just downloaded from kernel.org. I
actually tested on RHEL4 update 4, a 2.6.9 kernel, but I'll try building
the 2.6.19.2 on my system to make sure it works in that version as well.

Nate


--- sata_vsc.c.orig     2007-01-15 11:06:17.000000000 -0500
+++ sata_vsc.c  2007-01-15 11:10:29.000000000 -0500
@@ -340,6 +340,7 @@ static int __devinit vsc_sata_init_one (
        int pci_dev_busy = 0;
        void __iomem *mmio_base;
        int rc;
+       u8 cls;

        if (!printed_version++)
                dev_printk(KERN_DEBUG, &pdev->dev, "version "
DRV_VERSION "\n");
@@ -389,9 +390,13 @@ static int __devinit vsc_sata_init_one (
        base = (unsigned long) mmio_base;

        /*
-        * Due to a bug in the chip, the default cache line size can't
be used
+        * Due to a bug in the chip, the default cache line size can't
be
+        * used (unless the default is non-zero).
         */
-       pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
+       pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
+       if (cls == 0x00) {
+               pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
+       }

        probe_ent->sht = &vsc_sata_sht;
        probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |





-----Original Message-----
From: Jeremy Higdon [mailto:jeremy@sgi.com] 
Sent: Sunday, January 14, 2007 3:03 AM
To: Dailey, Nate
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_vsc.c cache line size question

On Fri, Jan 12, 2007 at 02:45:23PM -0500, Dailey, Nate wrote:
> Hoping someone on this list might shed some light on this...
> 
> I was investigating a problem of poor sequential write performance
> (IOmeter, various size sequential writes) with an embedded Vitesse
7174,
> maxing out (with disk write cache on) at around 10 MB/s...
> 
> After noticing that Windows on the same hardware was using 0x10 for
the
> cache line size, but Linux was using 0x80, I tried removing the
> following from sata_vsc.c:
> 
> 381         /*
> 382          * Due to a bug in the chip, the default cache line size
> can't be used
> 383          */
> 384         pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> 
> Now, with cache line size the same as Windows, Linux is doing more
like
> 43 MB/s.
> 
> Just wondering what the deal with this "bug in the chip" might be,
since
> for me it seems that the default cache line size is better? If there's
a
> real bug, I don't want to do anything dangerous by removing this code
> (though I've heard--haven't seen the code--that the Windows driver
> doesn't touch the cache line size, nor does the Linux non-libata
> reference driver from Vitesse).


The problem is that it can't be zero, which is the default value
after reset.

So I suppose the driver should be modified to set it to 0x80 only
if it's 0.  I believe that most PCI implementations will set it in
the BIOS or whatever.

Care to send a patch?

jeremy
