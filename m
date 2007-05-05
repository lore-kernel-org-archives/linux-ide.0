From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Sat, 05 May 2007 19:55:58 +0200
Message-ID: <463CC52E.8050500@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com> <463B019E.7010700@gmail.com> <463B71FA.8090005@gmail.com> <463B74DB.8060509@gmail.com> <463B89B9.8050104@gmail.com> <463B8B3C.9010509@gmail.com> <463CC22C.20902@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070909000808020204050605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:49116 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934164AbXEER4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 13:56:09 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1163510nzf
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 10:56:08 -0700 (PDT)
In-Reply-To: <463CC22C.20902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org, gregkh@suse.de

This is a multi-part message in MIME format.
--------------070909000808020204050605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Matí­as Alejandro Torres wrote:
> May be it disables MSI for some other device/bridge/what ever:

Right, that device gotta be PCI-e or PCI-x bridge and the disk
controller lives in a different bus.  Please apply the attached patch.
This one really should fix the problem.  :-)

-- 
tejun

--------------070909000808020204050605
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3411483..1e3070e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1624,18 +1624,20 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_N
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
 #ifdef CONFIG_PCI_MSI
-/* The Serverworks PCI-X chipset does not support MSI. We cannot easily rely
- * on setting PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
- * some other busses controlled by the chipset even if Linux is not aware of it.
- * Instead of setting the flag on all busses in the machine, simply disable MSI
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
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS400_200, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS480, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
 static void __devinit quirk_disable_msi(struct pci_dev *dev)

--------------070909000808020204050605--
