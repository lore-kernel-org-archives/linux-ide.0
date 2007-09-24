From: "Peer Chen" <peerchen@gmail.com>
Subject: Re: Re: [PATCH] ahci: Add MCP79 support to AHCI driver
Date: Mon, 24 Sep 2007 10:16:25 +0800
Message-ID: <200709241016214230742@gmail.com>
References: <200709211406065332552@gmail.com>,
 <20070921113908.180cd154@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:50641 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXIXCQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 22:16:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1857412wah
        for <linux-ide@vger.kernel.org>; Sun, 23 Sep 2007 19:16:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Code change, remove some Device IDs.

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.000000=
000 -0400
+++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-24 10:08:03.000000000 -=
0400
@@ -472,6 +472,14 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
 	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
+	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
=20
 	/* SiS */
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
-

------------------				=20
Peer Chen
2007-09-24

-------------------------------------------------------------
=B7=A2=BC=FE=C8=CB=A3=BAAlan Cox
=B7=A2=CB=CD=C8=D5=C6=DA=A3=BA2007-09-21 18:32:09
=CA=D5=BC=FE=C8=CB=A3=BAPeer Chen
=B3=AD=CB=CD=A3=BAlinux-kernel; linux-ide; akpm; jeff
=D6=F7=CC=E2=A3=BARe: [PATCH] ahci: Add MCP79 support to AHCI driver

On Fri, 21 Sep 2007 14:06:10 +0800
"Peer Chen" <peerchen@gmail.com> wrote:

> Add the MCP79 support to ahci driver.
> The patch base on kernel 2.6.23-rc7

Is this actually needed or as they are standard ahci devices will the
class match get them anyway ?

