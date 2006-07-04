From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 22/24] jmicron: Jmicron multifunction setup
Date: Tue, 4 Jul 2006 18:14:42 +0000 (UTC)
Message-ID: <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49038 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932311AbWGDSOb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:31 -0400
Date: Maw, 04 Gor 2006 19:01:46 +0100
In-Reply-To: <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

JMicron controllers start out in life pretending to be a single legacy IDE
interface with the ports magically mangled into it. When prodding they turn
into a dual function device which has an AHCI controller for SATA and a
PATA controller for the PATA ports.

Do the prodding early enough that our PCI layer enumeration finds and
discovers the extra functions.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/pci/quirks.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

e2b0e59a480b7d437b387cced5d96f60e6cb7aff
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5f7e0a9..0a115ca 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1186,7 +1186,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 static void __devinit quirk_jmicron_dualfn(struct pci_dev *pdev)
 {
 	u32 conf;
+	u8 hdr;
 
+	/* Only poke fn 0 */	
 	if (PCI_FUNC(pdev->devfn))
 		return;
 		
@@ -1206,11 +1208,19 @@ static void __devinit quirk_jmicron_dual
 			conf &= ~0x000F0200;	/* Clear bit 9 and 16-19 */
 			conf |=  0x00C20002;	/* Set bit 1, 17, 22, 23 */
 			pci_write_config_dword(pdev, 0x40, conf);
+			
+			/* Reconfigure so that the PCI scanner discovers the
+			   device is now multifunction */
+			   
+			pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
+			pdev->hdr_type = hdr & 0x7f;
+			pdev->multifunction = !!(hdr & 0x80);
+			
 			break;
 	}
 }
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
 
 #endif
 
-- 
1.2.GIT

