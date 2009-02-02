From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] Resume from hibernation fails with pata_it821x RAID volume
Date: Mon, 2 Feb 2009 22:41:59 +0100
Message-ID: <200902022242.01170.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760221AbZBBVnB@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,
hibernation didn't work for me since I started to use IT8212 controller. Now I 
did some debugging (booting with no_console_suspend init=/bin/sh).

Found that resume fails (2.6.28) with "serial number mismatch 'some 
garbage' != 'some other garbage'" and "revalidation failed" messages. That's 
because the controller firmware fills different serial number in the IDENTIFY 
every boot.

The patch below fixes the resume simply clearing the serial number. The proper 
fix would be probably to fill in the serial number of the RAID volume 
instead. I assume that there must be something like that stored on the drives 
but I don't know where.


Fix resume on pata_it821x RAID volume by clearing the serial number in 
IDENTIFY data, which is otherwise different on each boot.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.28-orig/drivers/ata/pata_it821x.c	2009-01-02 17:18:36.000000000 +0100
+++ linux/drivers/ata/pata_it821x.c	2009-02-02 17:47:57.000000000 +0100
@@ -561,6 +561,9 @@
 		id[83] |= 0x4400;	/* Word 83 is valid and LBA48 */
 		id[86] |= 0x0400;	/* LBA48 on */
 		id[ATA_ID_MAJOR_VER] |= 0x1F;
+		/* Clear the serial number because it's different each boot
+		   which breaks validation on resume */
+		memset(&id[ATA_ID_SERNO], 0x20, ATA_ID_SERNO_LEN);
 	}
 	return err_mask;
 }


-- 
Ondrej Zary
