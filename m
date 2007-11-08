From: "jameshsu" <jameshsu@acard.com>
Subject: Re:Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Thu, 8 Nov 2007 19:34:22 +0800
Message-ID: <005e01c821fb$502be120$6200a8c0@jameshsu>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence>
Reply-To: "jameshsu" <jameshsu@acard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 219-80-62-20.static.tfn.net.tw ([219.80.62.20]:2310 "EHLO
	Thunder.acard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758986AbXKHLkc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 06:40:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jason Wu <jason_wu@acard.com>, =?utf-8?Q?DerweiChen_=28=E9=99=B3=E5=BE=B7=E5=A8=81=29?= <derwei@acard.com>, LaurenceWu <laurence@acard.com>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, tytso@us.ibm.com, Matti Aarnio <postmaster@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Daniel Weng <dweng@acard.com>

=46YI
----- Original Message -----
=46rom: LaurenceWu
To: jameshsu
Cc: Jason Wu ; DerweiChen (=E9=99=B3=E5=BE=B7=E5=A8=81)
Sent: Thursday, November 08, 2007 4:34 PM
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE driver


Hi James,

We didn't study about ata/ahci.c, but it should be based on AHCI1.0 or =
1.1
spec. That is, NO P.M. FIS base switching, but supports both non-NCQ an=
d NCQ
protocols.

=46or NCQ or nonNCQ, 8620 is very AHCI-like, although not fully compati=
ble,
programmer can easily modify standard ahci.c
for 8620. The main differences between 8620 and AHCI are :

1. PRD table format changed, (please compare AHCI 1.x section 4.2.3.3 a=
nd
8620 datasheet section 7.3), 'I' bit in 8620 is defined as 'EOT' and NO
PRDTL value are available in the
    Command List Structure.

2. For NCQ transfer, PxIS bit 3(SDBS) is changed. ATP8620 add the Reg_1=
44h
to accumulate 32 Sactive bits in each SDB FIS.
    The Reg_144h is RWC and all its 32 bits are 'ORed'  to form the PxI=
S
bit3 and interrupt, if PxIE bit 3 enabled.


Yes.  Modifying the ata/ahci.c is OK to support atp8620.

Regards,
Laurence
----- Original Message -----
=46rom: jameshsu
To: laurence@mail.acard.com
Cc: Jason Wu
Sent: Thursday, November 08, 2007 10:36 AM
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE driver


=46YI

ata/ahci.c driver structure should support our 8620 AHCI-compatible
hardware, right?!
Any restriction and special condition we should inform them??
If no, I will tell them nothing.
Please advise! Thanks!

James
----- Original Message -----
=46rom: Jeff Garzik
To: jameshsu
Cc: Andrew Morton ; IDE/ATA development list ; tytso@us.ibm.com ; Matti
Aarnio ; James Bottomley ; 'David Miller' ; Daniel Weng ; Jason Wu ;
laurence@mail.acard.com
Sent: Thursday, November 08, 2007 6:13 AM
Subject: Re: Should be Acard ATP8620 2SATA / 1 IDE driver


On Tue, Nov 06, 2007 at 07:25:46PM +0800, jameshsu wrote:
> Hi Jeff,
>
> Please help Acard to add this chip spec on the web site in your earli=
er
> conveniance.
> http://gkernel.sourceforge.net/specs/
> http://linux-ata.org/driver-status.html#open_chipsets

Updated, thanks much!


> By the way, once you complete the SATA sample driver , please inform =
us ,
so
> we could modify, test and submit in the near future.
> If any chip info still missing or need us to involve, please let me k=
now.

I began working on a sample driver, but looking at your document, it
appears you are AHCI-compatible?

If so, we would prefer to modify drivers/ata/ahci.c to support your
hardware.  This already supports AHCI variants from Intel, NVIDIA, ATI,
VIA, JMicron and Marvell.

Jeff

