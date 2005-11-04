From: Virginio GL <virginiogl_web@ono.com>
Subject: sata_sil.c, firmware information
Date: Fri, 4 Nov 2005 11:50:46 +0100
Message-ID: <200511041150.46666.virginiogl_web@ono.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:48883 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1161140AbVKDKuy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 05:50:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Tree weeks ago I've read in my /usr/src/linux/drivers/scsi/sata_sil.c f=
ile=20
that my hard disk is backlisted.

I comment the line:
{ "ST3200822AS",      SIL_QUIRK_MOD15WRITE }
and it works fine (and faster) !!!

My chipset is sil3114, and the firmware version of the hard disk is 3.0=
1.

Info in dmesg:

**
scsi3 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
**

I have two hard disk, using dmraid and my motherboard is "ASUS A8N SLI=20
Deluxe".





Doing "hdparam -I /dev/sda":

**
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific mi=
nimum
        R/W multiple sector transfer: Max =3D 16  Current =3D 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udm=
a6
             Cycle time: min=3D120ns recommended=3D120ns
**

=C2=BFwhy is not configured in udma6 by default? ("hdparm -X70 /dev/sda=
" not work).

Best regards.

Virginio Garc=C3=ADa L=C3=B3pez

--=20
http://virginiogl.blogspot.com/
