From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480, take #2
Date: Wed, 09 May 2007 14:23:02 +0200
Message-ID: <4641BD26.1020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:2004 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806AbXEIMXR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 08:23:17 -0400
Received: by py-out-1112.google.com with SMTP id a29so139683pyi
        for <linux-ide@vger.kernel.org>; Wed, 09 May 2007 05:23:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg K-H <greg@kroah.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>

MSI doesn't work on RS400-200 and RS480 requiring pci=3Dnomsi kernel
boot parameter for ahci to work.  This patch renames quirk_svw_msi()
to quirk_disable_all_msi() and use it to disable MSI on those chips.

  http://thread.gmane.org/gmane.linux.ide/17820
  http://thread.gmane.org/gmane.linux.ide/17516
  https://bugzilla.novell.com/show_bug.cgi?id=3D263893

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mat=ED=ADas Alejandro Torres <torresmat@gmail.com>
---
Okay, this is the fixed version and should probably included in
-stable too as there have been quite some number of reports which got
resolved by adding 'pci=3Dnomsi'.  Verified by Mat=ED=ADas Alejandro To=
rres.

Thanks.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3411483..1e3070e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1624,18 +1624,20 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_N
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
=20
 #ifdef CONFIG_PCI_MSI
-/* The Serverworks PCI-X chipset does not support MSI. We cannot easil=
y rely
- * on setting PCI_BUS_FLAGS_NO_MSI in its bus flags because there are =
actually
- * some other busses controlled by the chipset even if Linux is not aw=
are of it.
- * Instead of setting the flag on all busses in the machine, simply di=
sable MSI
- * globally.
+/* Some chipsets do not support MSI. We cannot easily rely on setting
+ * PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
+ * some other busses controlled by the chipset even if Linux is not
+ * aware of it.  Instead of setting the flag on all busses in the
+ * machine, simply disable MSI globally.
  */
-static void __init quirk_svw_msi(struct pci_dev *dev)
+static void __init quirk_disable_all_msi(struct pci_dev *dev)
 {
 	pci_no_msi();
 	printk(KERN_WARNING "PCI: MSI quirk detected. MSI deactivated.\n");
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVE=
RWORKS_GCNB_LE, quirk_svw_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVE=
RWORKS_GCNB_LE, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS400_200=
, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS480, qu=
irk_disable_all_msi);
=20
 /* Disable MSI on chipsets that are known to not support it */
 static void __devinit quirk_disable_msi(struct pci_dev *dev)
