From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Tue, 30 Nov 2010 04:04:48 +0200
Message-ID: <4CF45BC0.2030701@iki.fi>
References: <4C4AFE7C.5070506@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070204080601060507040404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sypressi.dnainternet.net ([83.102.40.135]:51259 "EHLO
	sypressi.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0K3COT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2010 21:14:19 -0500
In-Reply-To: <4C4AFE7C.5070506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070204080601060507040404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 24.07.2010 17:53, Tejun Heo wrote:
> 88SE9128 can do FBS and sets it in HOST_CAP but forgets to set FBSCP
> in PORT_CMD.  Implement AHCI_HFLAG_YES_FBS and apply it to 88SE9128.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
[...]
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f252253..41fa0a3 100644
[...]
> @@ -362,6 +371,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* Marvell */
>  	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
>  	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
> +	{ PCI_DEVICE(0x1b4b, 0x9123),
> +	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */

The device contains an IDE interface as well, and the above
pci_device_id matches them both:
08:00.0 SATA controller [0106]: Device [1b4b:9123] (rev 10)
08:00.1 IDE interface [0101]: Device [1b4b:9123] (rev 10)

This results in some (apparently harmless) mess [1].

Attached is a patch to make the id entry class-specific. The patch is
untested (the issue happens in a production machine).


[1]
ahci 0000:08:00.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
ahci 0000:08:00.1: irq 51 for MSI/MSI-X
ahci 0000:08:00.1: controller can do FBS, turning on CAP_FBS
ahci 0000:08:00.1: controller reset failed (0x80000085)
ahci 0000:08:00.1: failed to stop engine (-5)
ahci 0000:08:00.1: failed to stop engine (-5)
ahci 0000:08:00.1: failed to stop engine (-5)
ahci 0000:08:00.1: AHCI ffff.ffff 1 slots 6 ports ? Gbps 0x308 impl IDE mode
ahci 0000:08:00.1: flags: fbs ccc apst nvmp boh
ahci 0000:08:00.1: setting latency timer to 64
scsi38 : ahci
scsi39 : ahci
scsi40 : ahci
scsi41 : ahci
scsi42 : ahci
scsi43 : ahci
scsi44 : ahci
scsi45 : ahci
scsi46 : ahci
scsi47 : ahci
ata39: DUMMY
ata40: DUMMY
ata41: DUMMY
ata42: SATA max UDMA/133 abar m16@0xfb8fe000 port 0xfb8fe280 irq 51
ata43: DUMMY
ata44: DUMMY
ata45: DUMMY
ata46: DUMMY
ata47: SATA max UDMA/133 abar m16@0xfb8fe000 port 0xfb8fe500 irq 51
ata48: SATA max UDMA/133 abar m16@0xfb8fe000 port 0xfb8fe580 irq 51
ata42: failed to resume link (SControl FFFFFFFF)
ata47: failed to resume link (SControl FFFFFFFF)
ata47: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
ata48: failed to resume link (SControl FFFFFFFF)
ata48: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
ata42: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)

-- 
Anssi Hannula

--------------070204080601060507040404
Content-Type: text/x-patch;
 name="0001-ahci-do-not-match-the-IDE-interface-of-88SE9128.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ahci-do-not-match-the-IDE-interface-of-88SE9128.patch"

>From 5e4e904eb78d69528bc3b3ddd39a55579642bfbd Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi.hannula@iki.fi>
Date: Tue, 30 Nov 2010 03:43:15 +0200
Subject: [PATCH] ahci: do not match the IDE interface of 88SE9128

Commit 5f173107ecad83a50 added HFLAG_YES_FBS workaround for 88SE9128
(1b4b:9123).

However, that change inadvertently caused the legacy IDE interface of
the controller (with the same pci id) to become associated with the AHCI
driver as well, causing the driver to try to bring the interface up in
vain.

Fix that by matching against class as well.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 drivers/ata/ahci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3288263..791cf9b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -379,6 +379,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
 	{ PCI_DEVICE(0x1b4b, 0x9123),
+	  .class = PCI_CLASS_STORAGE_SATA_AHCI,
+	  .class_mask = 0xffffff,
 	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */
 
 	/* Promise */
-- 
1.7.3


--------------070204080601060507040404--
