From: Olaf Hering <olaf@aepfle.de>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
Date: Fri, 5 Jan 2007 11:26:18 +0100
Message-ID: <20070105102618.GA9970@aepfle.de>
References: <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org> <45741DDE.4080509@ru.mvista.com> <20061204132124.4f7c50a9@localhost.localdomain> <45742253.1000807@ru.mvista.com> <20061204142201.68d9621f@localhost.localdomain> <1165293679.29784.39.camel@localhost.localdomain> <20061205081557.GA8483@aepfle.de> <1165349941.5469.1.camel@localhost.localdomain> <20070104174947.GA3636@aepfle.de> <1167946240.5273.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54333 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161041AbXAEK0L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jan 2007 05:26:11 -0500
Content-Disposition: inline
In-Reply-To: <1167946240.5273.11.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org, greg@kroah.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

On Fri, Jan 05, Benjamin Herrenschmidt wrote:

> Nah, but also set resource->end = 0 too and or-in IORESOURCE_UNSET for
> flags not (=) (or just set it to 0, I have no problem with completely
> clearing the resource, that will keep it out of the way)

I get this output with the change below:

Using INTC for W82c105 IDE controller.
W82c105: bn 0 dfn 19
00: f 0000000000000101 s 000000000000f000 e 000000000000f007
01: f 0000000000000101 s 000000000000f010 e 000000000000f013
02: f 0000000000000101 s 000000000000f020 e 000000000000f027
03: f 0000000000000101 s 000000000000f030 e 000000000000f033
04: f 0000000000000101 s 000000000000f040 e 000000000000f04f
05: f 0000000000000101 s 0000000000000000 e 000000000000000f
05: disable IO resource on W82c105 IDE controller
06: f 0000000000000000 s 0000000000000000 e 0000000000000000
07: f 0000000000000000 s 0000000000000000 e 0000000000000000
08: f 0000000000000000 s 0000000000000000 e 0000000000000000
09: f 0000000000000000 s 0000000000000000 e 0000000000000000
10: f 0000000000000000 s 0000000000000000 e 0000000000000000
11: f 0000000000000000 s 0000000000000000 e 0000000000000000

If thats ok, I will submit a patch without the printk.

@@ -130,11 +130,18 @@ static void fixup_winbond_82c105(struct 
        /* Enable LEGIRQ to use INTC instead of ISA interrupts */
        pci_write_config_dword(dev, 0x40, reg | (1<<11));
 
+       printk("W82c105: bn %x dfn %x\n", dev->bus->number, dev->devfn);
        for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
+               printk("%02d: f %016lx s %016lx e %016lx\n", i, dev->resource[i].flags, dev->resource[i].start, dev->resource[i].end);
                /* zap the 2nd function of the winbond chip */
                if (dev->resource[i].flags & IORESOURCE_IO
                    && dev->bus->number == 0 && dev->devfn == 0x81)
                        dev->resource[i].flags &= ~IORESOURCE_IO;
+               if (dev->resource[i].start == 0 && dev->resource[i].end) {
+                       printk("%02d: disable IO resource on W82c105 IDE controller\n", i);
+                       dev->resource[i].flags = 0;
+                       dev->resource[i].end = 0;
+               }
        }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,

