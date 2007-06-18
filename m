From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 12:47:36 +0200
Message-ID: <467662C8.8040603@effenberger.org>
References: <200706180705.l5I75U6r000348@harpo.it.uu.se> <467630AA.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:41067 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXFRKrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 06:47:45 -0400
In-Reply-To: <467630AA.5050108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Tomi.Orava@ncircle.nullnet.fi, jeff@garzik.org, linux-ide@vger.kernel.org

Hi,

> Maybe we need to limit link speed to 1.5Gbps for these drives on
> sata_promise?

in our case, it's a

   Vendor: ATA       Model: WDC WD1600YS-01S  Rev: 20.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200YS-01P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200YS-01P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200YS-01P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200YS-01P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200YS-01P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05

on a

00:00.0 Host bridge: Intel Corporation P965/G965 Memory Controller Hub 
(rev 02)
00:01.0 PCI bridge: Intel Corporation P965/G965 PCI Express Root Port 
(rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
#2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 5 (rev 02)
00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 6 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
#1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface 
Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) SATA AHCI 
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation Unknown device 
016a (rev a1)
03:00.0 Ethernet controller: Marvell Technology Group Ltd. Unknown 
device 4364 (rev 12)
04:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 
AHCI Controller (rev 02)
04:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 
AHCI Controller (rev 02)
05:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 0c)
05:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)

Maybe blacklisting makes sense here, too?

Florian
