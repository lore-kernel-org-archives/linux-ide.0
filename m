From: Florian Attenberger <valdyn@gmail.com>
Subject: [PATCH 2.6.22-rc6] sata_mv: PCI-ID for Adaptec 1430SA SATA
	Controller
Date: Mon, 2 Jul 2007 17:09:29 +0200
Message-ID: <20070702150929.GA15731@master.home>
References: <20070630144436.GA13479@master.home> <468906B6.1050700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758059AbXGBPJt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <468906B6.1050700@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Florian Attenberger  <valdyn@gmail.com>


--- 2.6.22-rc6/drivers/ata/sata_mv.c	2007-06-30 16:21:47.462020256 +0200
+++ 2.6.22-rc6.mine/drivers/ata/sata_mv.c	2007-06-30 16:25:25.999165444 +0200
@@ -582,6 +582,9 @@ static const struct pci_device_id mv_pci
 
 	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
 
+	/* Adaptec 1430SA */
+	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
+
 	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
 
 	/* add Marvell 7042 support */
