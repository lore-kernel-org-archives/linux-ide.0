From: Root Kit <rootkit85@yahoo.it>
Subject: [PATCH] AHCI PCI ID for MacBook Pro
Date: Thu, 8 Feb 2007 18:33:07 +0100 (CET)
Message-ID: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web25412.mail.ukl.yahoo.com ([217.146.176.230]:46288 "HELO
	web25412.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1423246AbXBHRdJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Feb 2007 12:33:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,
i have a MacBook pro and i noticed that linux
(2.6.20)
binds the ata_piix driver
to the SATA controller.
being my SATA controller an AHCI (ICH7M) i added the
PCI ID to ahci.c
then tested the system.
i inline the patch here:

--- linux-2.6.20/drivers/ata/ahci.c	2007-02-06
19:11:08.000000000 +0100
+++ linux-2.6.20/drivers/ata/ahci.c	2007-02-06
19:13:31.000000000 +0100
@@ -366,6 +366,7 @@
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7
*/
 	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M
*/
 	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R
*/
+	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M
*/
 	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr },
/* ULi M5288 */
 	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2
*/
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2
*/

and i also done some benchmarks just to test if it is
worth it:
http://teknoraver.campuslife.it/bench/ata_piix_vs_ahci.pdf

Best Regards,
Matteo Croce





	

	
		
___________________________________ 
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: 
http://it.docs.yahoo.com/nowyoucan.html
