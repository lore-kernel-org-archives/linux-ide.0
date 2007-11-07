From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Re: Should be Acard ATP8620 2SATA / 1 IDE  driver
Date: Wed, 7 Nov 2007 17:30:31 -0500
Message-ID: <20071107223031.GB25799@havoc.gtf.org>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:47407 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbXKGWac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 17:30:32 -0500
Content-Disposition: inline
In-Reply-To: <025001c82067$d76c04c0$6200a8c0@jameshsu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jameshsu <jameshsu@acard.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, 'David Miller' <davem@davemloft.net>, Daniel Weng <dweng@acard.com>, Jason Wu <jason_wu@acard.com>, laurence@mail.acard.com

On Tue, Nov 06, 2007 at 07:25:46PM +0800, jameshsu wrote:
> By the way, once you complete the SATA sample driver , please inform us , so
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
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 
+	/* Acard */
+	{ PCI_VDEVICE(ARTOP, 0x000D), board_ahci },
+	{ PCI_VDEVICE(ARTOP, 0x000E), board_ahci },
+	{ PCI_VDEVICE(ARTOP, 0x000F), board_ahci },
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
