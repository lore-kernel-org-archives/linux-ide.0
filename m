From: "Eamonn Hamilton" <EAMONN.HAMILTON@saic.com>
Subject: problems with sata_nv and MV88SX5081 under 2.6.28, fine under2.6.17.6
Date: Wed, 07 Jan 2009 14:53:25 +0000
Message-ID: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mclmx.mail.saic.com ([149.8.64.10]:38748 "EHLO
	mclmx.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbZAGPIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 10:08:41 -0500
Received: from 0015-ITS-SMS02 ([149.8.64.21] [149.8.64.21]) by mclmx.mail.saic.com with ESMTP id BT-MMP-2318035 for linux-ide@vger.kernel.org; Wed, 7 Jan 2009 09:53:27 -0500
Received: from mclmx.mail.saic.com (unknown [149.8.64.21])
	by 0015-ITS-SMS02 (Symantec Mail Security) with SMTP id 2713D5940D5
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2009 09:53:27 -0500 (EST)
Received: from 0602-its-exbh01.eu.saic.com ([149.8.64.21] [149.8.64.21]) by mclmx.mail.saic.com with ESMTP id BT-MMP-1050000 for linux-ide@vger.kernel.org; Wed, 7 Jan 2009 09:53:26 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I look after a server with a bunch of drives hooked up to two 8 port
PCI-X sata cards, detected as above.

The server was running 2.6.17.6 which has sata_mv version 0.7, which
worked fine. I recently upgraded the kernel to 2.6.18 with version 1.24,
and started getting

ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen

for several of the disks, and performance went through the floor because
of multiple bus resets. Now, the system was running SMART monitoring,
and in the course of some googling it was suggested that this perhaps
was causing a timeout, however disabling the smartd made no difference.

Reverting to 2.6.17.6 made the problem go away, suggesting something
between 0.7 and 1.24 is causing some difficulty.

Before I launch into trying to find out where in the interim the
regression occurred, does anybody have any suggestions?

Cheers,
Eamonn

System details :

00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub (rev
01)
00:00.1 Class ff00: Intel Corporation E7500/E7501 Host RASUM Controller
(rev 01)
00:03.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface C
PCI-to-PCI Bridge (rev 01)
00:03.1 Class ff00: Intel Corporation E7500/E7501 Hub Interface C RASUM
Controller (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev
02)
00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2) (rev
02)
00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3) (rev
02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller
(rev 02)
00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
01:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet
Controller (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev
04)
02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev
04)
03:02.0 SCSI storage controller: Marvell Technology Group Ltd.
MV88SX5081 8-port SATA I PCI-X Controller (rev 03)
03:03.0 SCSI storage controller: Adaptec AIC-7901A U320 (rev 03)
04:02.0 SCSI storage controller: Marvell Technology Group Ltd.
MV88SX5081 8-port SATA I PCI-X Controller (rev 03)


disks :Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400833AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD4000YR-01P Rev: 01.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.06
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.03
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400620NS      Rev: 3.AE
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi13 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.03
  Type:   Direct-Access                    ANSI SCSI revision: 05

 




SAIC Limited is a private limited company registered in England and Wales. Registered number 1396396. Registered office at 120 New Cavendish Street, London, W1W 6XX. VAT number 599 5474 64.
This e-mail and any attachments are private and confidential.  If you are not the intended recipient of this e-mail, any disclosure, copying, distribution or use of its contents is strictly prohibited. Please notify the sender immediately and then delete it (including any attachments) from your system.
All emails and attachments are virus scanned. It is your responsibility to ensure that any onward transmission, opening or use of this message and any attachments will not adversely affect your or the onward recipients' systems or data. Please carry out such virus and other such checks as you consider appropriate.
SAIC Limited may monitor email traffic data and, also, the content of email for the purposes of security, staff training and compliance with SAIC policies.

