From: Stephen Atkins <atkinss@shaw.ca>
Subject: sata_sil with seagate st3120026as
Date: Fri, 23 Jul 2004 08:06:41 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <LPEKIDCKCKICKJCIGCBLMEIACBAA.atkinss@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19654 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S267748AbUGWOSr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jul 2004 10:18:47 -0400
Received: from pd2mr7so.prod.shaw.ca (pd2mr7so-qfe3.prod.shaw.ca [10.0.141.10])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0I1B00AAF5S3P6@l-daemon> for linux-ide@vger.kernel.org; Fri,
 23 Jul 2004 08:04:51 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd2mr7so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0I1B00IFM5S3SCA0@pd2mr7so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 23 Jul 2004 08:04:51 -0600 (MDT)
Received: from calt04 ([68.144.48.230])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with SMTP id <0I1B00GIF5S2G7@l-daemon> for linux-ide@vger.kernel.org; Fri,
 23 Jul 2004 08:04:51 -0600 (MDT)
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello.  I've been poking around in the sata_sil.c file because I saw a message
at one time about the Seagate drives and how some of them need to be in the
sil_blacklist.  Any way I've been trying to get this driver to work under the
2.6 kernel (it seems find in 2.4.26 but ivtv doesn't like that version).  Any
way this is the error I received from the kernel when I was trying to access the
drive.

ata1: DMA timeout 0x58 on port 0xE0851087
scsi0: Error on channel 0, id 0, lun 0, CDB: 0x2a 00 0b bd a8 a4 00 04 00 00
current sda: sense=70 3
ASC= c ASCQ= 2
Raw sense data: 0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x0c
0x02
end_request: I/O error, dev sda, sector 191735972

A bit of info on my hardware:
MoBo: Gigabyte GA-7N400 Pro2 (Dual DDR400, intel8x0 sound, r8169 lan, sil3512A,
Gigaraid IDE, IDE nForce2)
HD: 6G regular IDE, 120G Seagate SATA ST3120026AS, DVDROM
Memory: 512M DDR 2100 (w 256M sticks) not useing dual channel
TV Cards: 1 PVR-250 model 980, 1 Leadtek winfast TV2000 XP Deluxe
Network: On board r8169 and wireless 802.11abg (used madwifi drivers)
Video: GForce 5200 (using 6106 drivers from nVidia)

Not sure what else you might need.  Just let me know if there is and I'll do my
best to supply it.

Stephen Atkins

