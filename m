From: Matteo Croce <rootkit85@yahoo.it>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Fri, 9 Feb 2007 15:27:07 +0100
Message-ID: <200702091527.08447.rootkit85@yahoo.it>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com> <45CC3FE5.2010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out12.alice.it ([85.37.17.107]:1979 "EHLO
	smtp-out12.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946483AbXBIOlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 09:41:25 -0500
In-Reply-To: <45CC3FE5.2010408@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Signed-off-by: Matteo Croce <rootkit85@yahoo.it>
---

--- linux-2.6.20/drivers/ata/ahci.c	2007-02-06 19:11:08.000000000 +0100
+++ linux-2.6.20/drivers/ata/ahci.c	2007-02-06 19:13:31.000000000 +0100
@@ -366,6 +366,7 @@
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
 	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
 	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
+	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
 	{ PCI_VDEVICE(AL, 0x5288), board_ahci_ign_iferr }, /* ULi M5288 */
 	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
