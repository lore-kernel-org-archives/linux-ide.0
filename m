From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 18:51:35 +0200
Message-ID: <20080803165135.GA31977@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200808021902.12191.bzolnier@gmail.com> <20080802183253.GA2239@gollum.tnic> <200808022046.16990.bzolnier@gmail.com> <20080803073756.GA8762@gollum.tnic> <20080803125907.67676948@lxorguk.ukuu.org.uk> <20080803143837.GA26672@gollum.tnic> <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50668 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446AbYHCQvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 12:51:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so842850fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 09:51:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

[shortened up CC list]

On Sun, Aug 03, 2008 at 04:22:14PM +0100, Alan Cox wrote:
> > conventions, it is still the best one considering the other possibilities:
> > 
> > a) code duplication: dumb idea, bloated kernel for no reason
> 
> I think you might want to start somewhere else if that worries you. Its
> also a mostly bogus reasoning as almost nobody builds with both, in fact
> you have to be pretty careful if you do that or it all falls over in a
> heap.
> 
> For previous cases (eg ide timing) it has actually made more sense to
> split the code. The moment you get future different behaviour between
> libata and old IDE on any of these devices the sharing will just break
> again (eg if one or the other drops chipset support for one of those
> devices or adds one for another device)
> 
> > b) evil Kconfig SELECT pulling in core libata just so that ide might be calling
> > a function or two.
> 
> That would be stunningly dumb. I happen to think we have developers whose
> minds extent to adding libata-common.c and pulling in a single file if we
> do that. Yes people have the past done stupid stuff like pulling all of
> CONFIG_IDE in for a single USB device but that was because nobody noticed
> and fixed it promptly not because it was a good idea.
> 
> Alan

Ok then, so we duplicate. This seems like the easiest solution. Sharing code
between libata and IDE is not that smart in case the two development directions
divert, as you said. Bart, here's v3:

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Sun, 3 Aug 2008 18:46:35 +0200
Subject: [PATCH] ide-generic: handle probing of legacy io-ports v3

Avoid probing the io-ports in case an IDE PCI controller is present and it uses
the legacy iobases. If we still want to enforce the probing, we do

ide_generic.probe_mask=0x3f

on the kernel command line. The iobase checking code is adapted from
drivers/ata/pata_legacy.c

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-generic.c |   60 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 8fe8b5b..e9b7b69 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -27,7 +27,7 @@
 
 #define DRV_NAME	"ide_generic"
 
-static int probe_mask = 0x03;
+static int probe_mask;
 module_param(probe_mask, int, 0);
 MODULE_PARM_DESC(probe_mask, "probe mask for legacy ISA IDE ports");
 
@@ -100,19 +100,71 @@ static const u16 legacy_bases[] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
 static const int legacy_irqs[]  = { 14, 15, 11, 10, 8, 12 };
 #endif
 
+
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
+		/* Cyrix CS5510 pre SFF MWDMA ATA on the bridge */
+		if (p->vendor == 0x1078 && p->device == 0x0000)
+			*primary = *secondary = 1;
+
+		/* Cyrix CS5520 pre SFF MWDMA ATA on the bridge */
+		if (p->vendor == 0x1078 && p->device == 0x0002)
+			*primary = *secondary = 1;
+
+		/* Intel MPIIX - PIO ATA on non PCI side of bridge */
+		if (p->vendor == 0x8086 && p->device == 0x1234) {
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
