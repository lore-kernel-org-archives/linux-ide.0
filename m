From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Sun, 18 Mar 2007 13:35:41 +0100
Message-ID: <200703181335.41988.jareguero@telefonica.net>
References: <200701311504.40277.jareguero@telefonica.net> <200703161521.29461.jareguero@telefonica.net> <45FCCDFA.8050800@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dIT/FrQzeXHyHeG"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:54502 "EHLO
	ctsmtpout2.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750957AbXCRMfz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 08:35:55 -0400
In-Reply-To: <45FCCDFA.8050800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

--Boundary-00=_dIT/FrQzeXHyHeG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Domingo, 18 de Marzo de 2007, Tejun Heo escribi=F3:
> Jose Alberto Reguero wrote:
> > I found that the driver work well for Marvel 6121 without the flag
> > ATA_FLAG_SKIP_D2H_BSY.
> > What is the meaning of this flag?
>
> This is usually meaningful with hotplug.  The problem is that, on some
> SATA controllers including ahci and sata_sil24, the wait for the first
> D2H Reg FIS indicating device readiness isn't reliable.  It's supposed
> to work like the following (sata_sil behaves pretty good on this regard).
>
> 1. User hotplug device to port and PHY event interrupt raised, the
> controller should set BSY status bit.
>
> 2. libata EH kicks in and waits for BSY to clear (current timeout 30s).
>  Done by the first D2H Reg FIS.  Drives usually send this after spinup
> is complete.
>
> 3. After BSY is cleared, the device is reset.
>
> The problem with ahci and sata_sil24 is that there really is no TF
> status register is non-existent or emulated in some way and they doesn't
> let us reliably wait for !BSY after hotplug event.  This often makes the
> wait in #2 timeout and that's 30 seconds.  :-(
>
> So, the flag makes libata EH skip #2.  Post-reset waiting is reliable,
> so there is no timeout.  But this causes problems on some devices (the
> Quantum GoVault thing) which takes a looooong time to get ready and
> don't respond correctly to phy reset while it's busy initializing.
>
> The flag is there primarily for ICH ahci's.  Marvell might be different.
>  Care to remove SKIP_D2H_BSY and test a LOT of hotplugging with several
> different devices?  :-)

With  SKIP_D2H_BSY I have a old dmesg -> dmesg1 (2.6.20 I think)
I test with and a external sata disk without SKIP_D2H_BSY -> dmes2=20
(2.6.21-rc4)
Both takes ~8 seconds.

Thanks
Jose Alberto



--Boundary-00=_dIT/FrQzeXHyHeG
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg1"

ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4: (irq_stat 0x02400000, PHY RDY changed)
ata4: waiting for device to spin up (8 secs)
ata4: soft resetting port
ata4: softreset failed (port busy but CLO unavailable)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata4.00: Drive reports diagnostics failure. This may indicate a drive
ata4.00: fault or invalid emulation. Contact drive vendor for information.
ata4.00: configured for UDMA/133
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3300831AS      3.03 PQ: 0 ANSI: 5
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0

--Boundary-00=_dIT/FrQzeXHyHeG
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg2"

ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4: (irq_stat 0x02400000, PHY RDY changed)
ata4: port is slow to respond, please be patient (Status 0x80)
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7: ST3300831AS, 3.03, max UDMA/133
ata4.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
ata4: EH complete
scsi 3:0:0:0: Direct-Access     ATA      ST3300831AS      3.03 PQ: 0 ANSI: 5
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd:<6>ata4: D2H reg with I during NCQ, this message won't be printed again
 sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg5 type 0

--Boundary-00=_dIT/FrQzeXHyHeG--
