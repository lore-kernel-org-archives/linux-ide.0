From: "John Stoffel" <john@stoffel.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 1 Nov 2006 09:06:43 -0500
Message-ID: <17736.43507.649685.484648@smtp.charter.net>
References: <20061101021301.GA21568@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:11238 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1946888AbWKAOHH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 09:07:07 -0500
In-Reply-To: <20061101021301.GA21568@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

>>>>> "Jeff" == Jeff Garzik <jeff@garzik.org> writes:


Jeff> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
Jeff> index 5250187..8385387 100644
Jeff> --- a/drivers/ata/ata_piix.c
Jeff> +++ b/drivers/ata/ata_piix.c
Jeff> @@ -126,8 +126,7 @@ enum {
Jeff>  	ich6_sata		= 7,
Jeff>  	ich6_sata_ahci		= 8,
Jeff>  	ich6m_sata_ahci		= 9,
Jeff> -	ich7m_sata_ahci		= 10,
Jeff> -	ich8_sata_ahci		= 11,
Jeff> +	ich8_sata_ahci		= 10,
 
Jeff>  	/* constants for mapping table */
Jeff>  	P0			= 0,  /* port 0 */
Jeff> @@ -169,6 +168,7 @@ static const struct pci_device_id piix_p
Jeff>  #ifdef ATA_ENABLE_PATA
Jeff>  	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
Jeff>  	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },

Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
an ISA bridge, not a PIIX? controller?  

00:00.0 Host bridge [0600]: Intel Corporation 440GX - 82443GX Host bridge [8086:71a0]
00:01.0 PCI bridge [0604]: Intel Corporation 440GX - 82443GX AGP bridge [8086:71a1]
00:07.0 ISA bridge [0601]: Intel Corporation 82371AB/EB/MB PIIX4 ISA [8086:7110] (rev 02)
00:07.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4 IDE [8086:7111] (rev 01)
00:07.2 USB Controller [0c03]: Intel Corporation 82371AB/EB/MB PIIX4 USB [8086:7112] (rev 01)
00:07.3 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI [8086:7113] (rev 02)

John
