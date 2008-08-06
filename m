From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Wed, 6 Aug 2008 08:10:23 +0200
Message-ID: <20080806061023.GA23773@gollum.tnic>
References: <20080802183253.GA2239@gollum.tnic> <200808022046.16990.bzolnier@gmail.com> <20080803073756.GA8762@gollum.tnic> <20080803125907.67676948@lxorguk.ukuu.org.uk> <20080803143837.GA26672@gollum.tnic> <20080803162214.394b13a1@lxorguk.ukuu.org.uk> <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com> <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com> <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:60997 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYHFGKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 02:10:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1495354fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 23:10:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 05, 2008 at 04:41:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tue, Aug 5, 2008 at 4:32 PM, Boris Petkov <petkovbb@googlemail.com> wrote:
> 
> [...]
> 
> > Will look into it later and redo the patch, thanks for reviewing. I
> > still haven't heard from
> > Bart, though, whether he's OK with the code duplication...?
> 
> Given Alan & Jeff concerns about moving it to <linux/ata.h>, just
> copying the function to ide_generic seems like a best solution for now.

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Sun, 3 Aug 2008 18:46:35 +0200
Subject: [PATCH] ide-generic: handle probing of legacy io-ports v4

Avoid probing the io-ports in case an IDE PCI controller is present and it uses
the legacy iobases. If we still want to enforce the probing, we do

ide_generic.probe_mask=0x3f

on the kernel command line. The iobase checking code is adapted from
drivers/ata/pata_legacy.c after converting hex pci ids into their corresponding
macros in <linux/pci_ids.h>.

CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-generic.c |   59 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 8fe8b5b..efce159 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/ide.h>
+#include <linux/pci_ids.h>
 
 /* FIXME: convert m32r to use ide_platform host driver */
 #ifdef CONFIG_M32R
@@ -27,7 +28,7 @@
 
 #define DRV_NAME	"ide_generic"
 
-static int probe_mask = 0x03;
+static int probe_mask;
 module_param(probe_mask, int, 0);
 MODULE_PARM_DESC(probe_mask, "probe mask for legacy ISA IDE ports");
 
@@ -100,19 +101,69 @@ static const u16 legacy_bases[] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
 static const int legacy_irqs[]  = { 14, 15, 11, 10, 8, 12 };
 #endif
 
+static void ide_generic_check_pci_legacy_iobases(int *primary, int *secondary)
+{
+	struct pci_dev *p = NULL;
+	u16 val;
+
+	for_each_pci_dev(p) {
+		int r;
+
+		for (r = 0; r < 6; r++) {
+			if (pci_resource_start(p, r) == 0x1f0)
+				*primary = 1;
+			if (pci_resource_start(p, r) == 0x170)
+				*secondary = 1;
+		}
+
+		/* Cyrix CS55{1,2}0 pre SFF MWDMA ATA on the bridge */
+		if (p->vendor == PCI_VENDOR_ID_CYRIX &&
+		    (p->device == PCI_DEVICE_ID_CYRIX_5510 ||
+		     p->device == PCI_DEVICE_ID_CYRIX_5520))
+			*primary = *secondary = 1;
+
+		/* Intel MPIIX - PIO ATA on non PCI side of bridge */
+		if (p->vendor == PCI_VENDOR_ID_INTEL &&
+		    p->device == PCI_DEVICE_ID_INTEL_82371MX) {
+
+			pci_read_config_word(p, 0x6C, &val);
+			if (val & 0x8000) {
+				/* ATA port enabled */
+				if (val & 0x4000)
+					*secondary = 1;
+				else
+					*primary = 1;
+			}
+		}
+	}
+}
+
 static int __init ide_generic_init(void)
 {
 	hw_regs_t hw[MAX_HWIFS], *hws[MAX_HWIFS];
 	struct ide_host *host;
 	unsigned long io_addr;
-	int i, rc;
+	int i, rc, primary = 0, secondary = 0;
 
 #ifdef CONFIG_MIPS
 	if (!ide_probe_legacy())
 		return -ENODEV;
 #endif
-	printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" module "
-			 "parameter for probing all legacy ISA IDE ports\n");
+	ide_generic_check_pci_legacy_iobases(&primary, &secondary);
+
+	if (!probe_mask) {
+		printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
+		     "module parameter for probing all legacy ISA IDE ports\n");
+
+		if (primary == 0)
+			probe_mask |= 0x1;
+
+		if (secondary == 0)
+			probe_mask |= 0x2;
+	} else {
+		printk(KERN_WARNING "%s: enforcing probing of io ports upon "
+			"user request.\n", DRV_NAME);
+	}
 
 	memset(hws, 0, sizeof(hw_regs_t *) * MAX_HWIFS);
 
-- 
1.5.5.4


-- 
Regards/Gruss,
    Boris.
