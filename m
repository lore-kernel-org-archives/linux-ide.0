From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 03/24] pata_amd - new chips
Date: Tue, 4 Jul 2006 18:15:19 +0000 (UTC)
Message-ID: <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56718 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932314AbWGDSPF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:05 -0400
Date: Maw, 04 Gor 2006 19:01:27 +0100
In-Reply-To: <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Add PCI identifiers for Nvidia newer chips

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_amd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

d2462e58448b854d4ff4f3f8140f99f2cc2158a9
diff --git a/drivers/scsi/pata_amd.c b/drivers/scsi/pata_amd.c
index 77f9372..d208581 100644
--- a/drivers/scsi/pata_amd.c
+++ b/drivers/scsi/pata_amd.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.2.2"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -674,6 +674,8 @@ static const struct pci_device_id amd[] 
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9 },
 	{ 0, },
 };
-- 
1.2.GIT

