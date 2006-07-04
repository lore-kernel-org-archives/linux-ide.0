From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 09/24] pci_ids: Add JMicron identifiers as we need them in various drivers and quirks
Date: Tue, 4 Jul 2006 18:14:36 +0000 (UTC)
Message-ID: <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47246 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932305AbWGDSO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:26 -0400
Date: Maw, 04 Gor 2006 19:01:33 +0100
In-Reply-To: <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

now.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 include/linux/pci_ids.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

dec51da9fefcc65cccbf99874590a8f35b2a73f7
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9ae6b1a..3b167f8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2016,6 +2016,13 @@
 #define PCI_VENDOR_ID_TDI               0x192E
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
+#define PCI_VENDOR_ID_JMICRON		0x197B
+#define PCI_DEVICE_ID_JMICRON_JMB360	0x2360
+#define PCI_DEVICE_ID_JMICRON_JMB361	0x2361
+#define PCI_DEVICE_ID_JMICRON_JMB363	0x2363
+#define PCI_DEVICE_ID_JMICRON_JMB365	0x2365
+#define PCI_DEVICE_ID_JMICRON_JMB366	0x2366
+#define PCI_DEVICE_ID_JMICRON_JMB368	0x2368
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
-- 
1.2.GIT

