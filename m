From: "jameshsu" <jameshsu@acard.com>
Subject: Re: [PATCH] Re: Should be Acard ATP8620 2SATA / 1 IDE  driver
Date: Thu, 8 Nov 2007 19:34:36 +0800
Message-ID: <005f01c821fb$649fa0b0$6200a8c0@jameshsu>
Reply-To: "jameshsu" <jameshsu@acard.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:2330 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758467AbXKHLma (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 06:42:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jason Wu <jason_wu@acard.com>, laurence@mail.acard.com, Daniel Weng <dweng@acard.com>

RESEND as TEXT FORMAT
----- Original Message -----
From: jameshsu
To: Jeff Garzik
Cc: Andrew Morton ; IDE/ATA development list ; tytso@us.ibm.com ; Matti
Aarnio ; James Bottomley ; Jason Wu ; laurence@mail.acard.com ; Daniel Weng
Sent: Thursday, November 08, 2007 7:28 PM
Subject: Re: [PATCH] Re: Should be Acard ATP8620 2SATA / 1 IDE driver


Hi Jeff,

Not really understand your patch listed below.
We do not provide ahci.c file to you, so we don't know where the patch came
from(diff from where)??
Who create this and how can we get ahci.c file?? Can you tell us??
BTW, please ONLY use PCI device ID "D" for this hardware.
ACARD needs to reserve the rest device IDs for other purpose.(DO NOT USE "E"
& "F")
{ PCI_VDEVICE(ARTOP, 0x000D), board_ahci }

Thanks!  From Acard---James Hsu
----- Original Message -----
From: Jeff Garzik
To: jameshsu
Cc: Andrew Morton ; IDE/ATA development list ; tytso@us.ibm.com ; Matti
Aarnio ; James Bottomley ; 'David Miller' ; Daniel Weng ; Jason Wu ;
laurence@mail.acard.com
Sent: Thursday, November 08, 2007 6:30 AM
Subject: [PATCH] Re: Should be Acard ATP8620 2SATA / 1 IDE driver


On Tue, Nov 06, 2007 at 07:25:46PM +0800, jameshsu wrote:
> By the way, once you complete the SATA sample driver , please inform us ,
so
> we could modify, test and submit in the near future.
> If any chip info still missing or need us to involve, please let me know.

Any chance the patch below works?

Jeff


 drivers/ata/ahci.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ed9b407..7a42b4e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -553,6 +553,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
  /* Marvell */
  { PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv }, /* 6145 */

+ /* Acard */
+ { PCI_VDEVICE(ARTOP, 0x000D), board_ahci },
+ { PCI_VDEVICE(ARTOP, 0x000E), board_ahci },
+ { PCI_VDEVICE(ARTOP, 0x000F), board_ahci },
+
  /* Generic, PCI class code for AHCI */
  { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
    PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

