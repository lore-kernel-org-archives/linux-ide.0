From: "Kuan Luo" <kluo@nvidia.com>
Subject: [PATCH]ata: sata_nv fix mcp51 timeout with SWNCQ
Date: Fri, 26 Oct 2007 15:49:18 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B059FE1DB@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:13571 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbXJZHtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 03:49:55 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Peer Chen <pchen@nvidia.com>

>From Kuan Luo <kluo@nvidia.com>

The patch will avoid ncq function use of sata_nv when swncq is zero by
default.

signed-off-by: Kuan Luo <kluo@nvidia.com>
---

 sata_nv.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 240a892..e6b6455 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -365,9 +365,9 @@ static const struct pci_device_id nv_pci_tbl[] = {
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2),
SWNCQ },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA),
SWNCQ },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2),
SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
SWNCQ },
-	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
SWNCQ },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2),
GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3),
GENERIC },
 
 	{ } /* terminate list */
 };
@@ -2383,6 +2383,9 @@ static int nv_init_one (struct pci_dev *pdev,
const struct pci_device_id *ent)
 		type = ADMA;
 	}
 
+	if (type == SWNCQ && !swncq_enabled)
+		type = GENERIC;
+
 	ppi[0] = &nv_port_info[type];
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
_
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
