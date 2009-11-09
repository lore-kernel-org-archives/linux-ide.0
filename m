From: Tejun Heo <tj@kernel.org>
Subject: Re: Nvidia ION (MCP79) eSata fails for external cabinet Thecus N2050
 (SIL5744)
Date: Mon, 09 Nov 2009 17:10:23 +0900
Message-ID: <4AF7CE6F.9050306@kernel.org>
References: <A5D2B277-9D37-49FC-A5C2-30E8707C26B2@laxfiske.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34833 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbZKIIK1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 03:10:27 -0500
In-Reply-To: <A5D2B277-9D37-49FC-A5C2-30E8707C26B2@laxfiske.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=D6rjan_Nordlund?= <orjan@laxfiske.se>
Cc: linux-ide@vger.kernel.org

Hello,

=D6rjan Nordlund wrote:
> I am having an issue using eSata to connect my Thecus N2050 storage
> cabinet to my new homeserver running Ubuntu Server 9.04.
> dmesg shows "failed to IDENTIFY (I/O error, err_mask=3D0x100)"
>=20
> I have read forums and mailing lists to understand solutions to simil=
ar
> problems and the following steps have been taken:
> Upgraded to Vanilla kernel 2.6.31
> Changed BIOS settings from SATA->AHCI and then back again
> Tried boot with pci=3Dnomsi
> Changed cables (i have three cables now and no one works)
> Checked that no jumpers can be changed on disks or mainboard
> Checked that the disks can be read through USB interface and from oth=
er
> computers (works on Linux, OS X and Win XP)
> Checked disks through eSata on Win XP box
> Upgraded BIOS to latest release (August 2009)
>=20
> I have looked in all forums and LKML archives for a solution but can =
not
> really find anyone that has a similar problem.
>=20
> I am suspecting the quirks are in the Thecus N2050. I have had some
> problems with this device in linux before when i was using USB. Thank=
s
> to Alan Stern a patch (as1154) was introduced in October 2008 to help
> get the device recognized properly by scsi when probing it.
>=20
> My Nvidia ION board has a MCP79 controller on-board (should be OK fro=
m
> 2.6.24) and the Thecus has a Silicon Image controller (i opened the b=
ox
> and read on the chip) with markings:
> SIL5744CNU

SIL5744 should work fine.  Hmmm...

> dmesg (extract from hotplug of device):
> [  753.849929] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 act=
ion
> 0xe frozen
> [  753.849970] ata3: irq_stat 0x00400000, PHY RDY changed
> [  753.849994] ata3: SError: { PHYRdyChg LinkSeq TrStaTrns }
> [  753.850024] ata3: hard resetting link
> [  754.598415] ata3: SATA link down (SStatus 10 SControl 300)
> [  754.598430] ata3: EH complete
> [  758.663954] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4140000 act=
ion
> 0xe frozen
> [  758.663993] ata3: irq_stat 0x00000040, connection status changed
> [  758.664018] ata3: SError: { CommWake Dispar DevExch }
> [  758.664046] ata3: hard resetting link
> [  759.588208] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  759.588245] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x1=
00)

Looks like the device is failing IDENTIFYs immediately.  I don't think
this has anything to do with being _e_SATA.  Can you try it with other
controllers?

Thanks.

--=20
tejun
