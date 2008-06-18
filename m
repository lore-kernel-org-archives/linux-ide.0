From: Tejun Heo <tj@kernel.org>
Subject: [PATCH RFC] ahci: implement handoff quirk
Date: Wed, 18 Jun 2008 12:37:34 +0900
Message-ID: <485882FE.1060409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50321 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757786AbYFRDhq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2008 23:37:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

ahci 1.2 has an exciting! new feature called BIOS/OS handoff which
basically is there to allow BIOS to keep tinkering with the controller
even after OS starts executing.  I have no idea what this is useful
for but it's there and we need to do it.

This patch implements the handoff as FIXUP_HEADER as the controller
needs to be claimed before the OS changes any configuration including
IRQ routing.

I'm yet to see any controller which actually requires this, so it's
not for inclusion yet.  Maybe keep this in a separate branch?

RFC, DON'T COMMIT
---
 drivers/pci/quirks.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7a222d0..9b77d49 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1207,6 +1207,115 @@ static void asus_hides_ac97_lpc(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
 
+/*
+ * We don't want the BIOS to meddle with the controller no matter when
+ * or which driver will get attached to it.  Claim the controller
+ * early.
+ */
+static void quirk_ahci_handoff(struct pci_dev *pdev)
+{
+	enum {
+		ABAR		= 5,
+
+		CTL		= 0x04,
+		CTL_AHCI_EN	= (1 << 31), /* AHCI enabled */
+
+		VERSION		= 0x10,      /* AHCI spec. version compliancy */
+		VER_1_2		= 0x00010200,
+
+		CAP2		= 0x24,	     /* host capabilities extended */
+		CAP2_HANDOFF	= (1 << 0),  /* BIOS/OS handoff */
+
+		HANDOFF		= 0x28,      /* BIOS/OS handoff ctl and stat */
+		HANDOFF_BIOS	= (1 << 0),  /* BIOS owns */
+		HANDOFF_OS	= (1 << 1),  /* OS owns */
+		HANDOFF_OS_CHG_SMI = (1 << 2), /* SMI on OS_CHG */
+		HANDOFF_OS_CHG	= (1 << 3),  /* OS ownership changed */
+		HANDOFF_BUSY	= (1 << 4),  /* BIOS is accessing */
+	};
+	void __iomem *mmio;
+	u32 saved_ctl, version, cap2, handoff;
+	int i;
+
+	/* Fixup can't match class, do it manually.  Add device
+	 * matches here too.
+	 */
+	if (pdev->class == PCI_CLASS_STORAGE_SATA_AHCI)
+		goto is_ahci;
+	return;
+
+ is_ahci:
+	/* map AHCI BAR */
+	mmio = pci_iomap(pdev, ABAR, 0);
+	if (!mmio) {
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "%s: failed to map AHCI_BAR\n", __FUNCTION__);
+		return;
+	}
+
+	/* turn on AHCI mode and check version */
+	saved_ctl = ioread32(mmio + CTL);
+	if (!(saved_ctl & CTL_AHCI_EN))
+		iowrite32(saved_ctl | CTL_AHCI_EN, mmio + CTL);
+
+	version = ioread32(mmio + VERSION);
+	if (version < VER_1_2)
+		goto out;
+
+	/* test HOST_CAP2_HANDOFF */
+	cap2 = ioread32(mmio + CAP2);
+	if (!(cap2 & CAP2_HANDOFF))
+		goto out;
+
+	/* do we already own it? */
+	handoff = ioread32(mmio + HANDOFF);
+	if ((handoff & (HANDOFF_BIOS|HANDOFF_OS|HANDOFF_BUSY)) == HANDOFF_OS)
+		goto out;
+
+	dev_printk(KERN_INFO, &pdev->dev,
+		   "executing AHCI BIOS/OS handoff (0x%x)\n", handoff);
+
+	handoff |= HANDOFF_OS;
+	iowrite32(handoff, mmio + HANDOFF);
+
+	/* BIOS should set HANDOFF_BUSY in 25ms if necessary, be
+	 * generous and give it 50ms.
+	 */
+	for (i = 0; i < 5; i++) {
+		handoff = ioread32(mmio + HANDOFF);
+		if (handoff & HANDOFF_BUSY)
+			break;
+		msleep(10);
+	}
+
+	/* If BIOS wants to spend a bit more with the controller, let
+	 * it.  Spec says 2s but we're merciful.  Give it one more
+	 * full second.
+	 */
+	if (handoff & HANDOFF_BUSY)
+		for (i = 0; i < 30; i++) {
+			handoff = ioread32(mmio + HANDOFF);
+			if (handoff & HANDOFF_BUSY)
+				break;
+			msleep(100);
+		}
+
+	if ((handoff & (HANDOFF_BIOS|HANDOFF_OS|HANDOFF_BUSY)) == HANDOFF_OS)
+		goto out;
+
+	dev_printk(KERN_WARNING, &pdev->dev,
+		   "AHCI BIOS/OS handoff failed (handoff=0x%x)\n", handoff);
+
+	/* try to override */
+	handoff |= HANDOFF_OS;
+	handoff &= ~(HANDOFF_BIOS | HANDOFF_BUSY);
+	iowrite32(handoff, mmio + HANDOFF);
+ out:
+	iowrite32(saved_ctl, mmio + CTL);
+	pci_iounmap(pdev, mmio);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_ahci_handoff);
+
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
