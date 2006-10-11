From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Wed, 11 Oct 2006 14:50:41 +0200
Message-ID: <200610111450.41909.matthias.fuchs@esd-electronics.com>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159972725.25772.26.camel@localhost.localdomain> <20061005091631.GA8631@localhost.hsdv.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:50389 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161047AbWJKMyG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Oct 2006 08:54:06 -0400
In-Reply-To: <20061005091631.GA8631@localhost.hsdv.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-ide@vger.kernel.org

Hi Paul,

I tried you patch on our CPCI405 PowerPC board 
(arch/ppc/platforms/4xx/cpci405.c). 
It seems to work fine together with our onboard CompactFlash slot.

Because our IDE registers are memory mapped, I had to patch the 
resource .start and .end address by subtracting _IO_BASE, 
so that the pata code can use the IO way to talk to the 
IDE registers.

Perhaps it is a good idea to update the pata platform driver to be able to 
handle both _IO and _MEM resources. The _IO resources be be handled 
as it is already done by your code and for _MEM resources the pata platform
driver can do the ioremapping as I currently do in my board setup.

I vote for the generic pata platform device IDE driver:-)

Here's my patch for the cpci405 board setup - just for information:

diff --git a/arch/ppc/platforms/4xx/cpci405.c 
b/arch/ppc/platforms/4xx/cpci405.c
index 3674309..f696854 100644
--- a/arch/ppc/platforms/4xx/cpci405.c
+++ b/arch/ppc/platforms/4xx/cpci405.c
@@ -26,6 +26,8 @@ #include <linux/serial_core.h>
 #include <asm/ocp.h>
 #include <asm/ibm_ocp_pci.h>
 #include <platforms/4xx/ibm405gp.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>

 #ifdef CONFIG_GEN_RTC
 void *cpci405_nvram;
@@ -108,6 +110,68 @@ #endif
        }
 }

+#ifdef CONFIG_PATA_PLATFORM
+#define CPCI405_CF_PADDR        0xf0100000
+#define CPCI405_CF_SIZE         0x10
+#define CPCI405_CF_IRQ          31
+#define CPCI405_CTRL_PADDR      0xf0400000
+#define CPCI405_CTRL_SIZE       0x100
+
+static struct resource cpci405_cf_resources[3];
+
+static struct platform_device cpci405_cf = {
+       .name           = "pata_platform",
+       .id             = 0,
+       .num_resources  = 3,
+       .resource       = cpci405_cf_resources
+};
+
+static int __init
+cpci405_setup_cf(void)
+{
+       void __iomem *cf;
+       volatile u16 __iomem *fpgactrl;
+
+       if ((cf = ioremap(CPCI405_CF_PADDR, CPCI405_CF_SIZE)) == NULL) {
+               printk("ioremap for CompactFlash controller failed\n");
+               return -1;
+       }
+
+       if ((fpgactrl = ioremap(CPCI405_CTRL_PADDR, CPCI405_CTRL_SIZE)) == 
NULL) {
+               printk("ioremap for FPGA control registers failed\n");
+               goto unmap;
+       }
+
+       /* reset CompactFlash card */
+       *fpgactrl &= ~0x0001;
+       mdelay(1);
+       *fpgactrl |= 0x0001;
+       iounmap(fpgactrl);
+
+       cpci405_cf_resources[0].start = (resource_size_t)cf - _IO_BASE;
+       cpci405_cf_resources[0].end   = (resource_size_t)cf - _IO_BASE + 7;
+       cpci405_cf_resources[0].flags = IORESOURCE_IO;
+
+       cpci405_cf_resources[1].start = (resource_size_t)cf - _IO_BASE + 0x0e;
+       cpci405_cf_resources[1].end   = (resource_size_t)cf - _IO_BASE + 0x0f;
+       cpci405_cf_resources[1].flags = IORESOURCE_IO;
+
+       cpci405_cf_resources[2].start = CPCI405_CF_IRQ;
+       cpci405_cf_resources[2].flags = IORESOURCE_IRQ;
+
+       if (platform_device_register(&cpci405_cf) < 0) {
+               printk("platform_device_register for CompactFlash failed\n");
+               goto unmap;
+       }
+
+       return 0;
+unmap:
+       iounmap(cf);
+       return -1;
+}
+arch_initcall(cpci405_setup_cf);
+#endif /* CONFIG_PATA_PLATFORM */
+
 void __init
 cpci405_setup_arch(void)
 {

Matthias

On Thursday 05 October 2006 11:16, Paul Mundt wrote:
> On Wed, Oct 04, 2006 at 03:38:45PM +0100, Alan Cox wrote:
> > Ar Iau, 2006-10-05 am 05:05 +0900, ysgrifennodd Paul Mundt:
> > > Ok, I wasn't sure if libata was intended for anything outside of the
> > > SATA case (especially non-PCI), but if that's the way to go, I'll look
> > > at hacking something up under libata.
> > 
> > Take a look at 2.6.18-mm or 2.6.19-* and you should see all you need in
> > that including the pcmcia driver and other users who set up much the
> > same way a generic platform device driver would.
> > 
> Ok, just hacked this together quickly, how does it look? I'm booting
> this on an SH-4A (R7780RP) from current git and all works fine..
> 
> Thankfully you did most of the heavy lifting :-)
> 
