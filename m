From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 06/24] Sort out MC65 compile for now
Date: Tue, 4 Jul 2006 18:14:32 +0000 (UTC)
Message-ID: <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43662 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932299AbWGDSOP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:15 -0400
Date: Maw, 04 Gor 2006 19:01:30 +0100
In-Reply-To: <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_amd.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

1f5d15d9442ff8aabda8e77f1446287e668987a2
diff --git a/drivers/scsi/pata_amd.c b/drivers/scsi/pata_amd.c
index d208581..c9e87d0 100644
--- a/drivers/scsi/pata_amd.c
+++ b/drivers/scsi/pata_amd.c
@@ -675,7 +675,6 @@ static const struct pci_device_id amd[] 
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9 },
 	{ 0, },
 };
-- 
1.2.GIT

