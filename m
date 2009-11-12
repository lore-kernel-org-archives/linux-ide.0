From: =?iso-8859-1?Q?=D6rjan_Nordlund?= <orjan@laxfiske.se>
Subject: Re: Nvidia ION (MCP79) eSata fails for external cabinet Thecus N2050 (SIL5744)
Date: Thu, 12 Nov 2009 13:51:20 +0100
Message-ID: <8A904902-4AB1-4CD9-9C2E-1B06461E3010@laxfiske.se>
References: <A5D2B277-9D37-49FC-A5C2-30E8707C26B2@laxfiske.se> <4AF7CE6F.9050306@kernel.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay2.bredband.net ([195.54.107.70]:57326 "EHLO
	mailrelay2.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZKLM5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Nov 2009 07:57:44 -0500
Received: from mailrelay1.bredband.net (mailrelay1.bredband.net [195.54.107.83])
	by mailrelay2.bredband.net (Postfix) with ESMTP id 6B34E111D31
	for <linux-ide@vger.kernel.org>; Thu, 12 Nov 2009 13:52:58 +0100 (CET)
In-Reply-To: <4AF7CE6F.9050306@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Will do. Have to wait until i am in the office again. I only have eSata=
 on my ubuntu box @ home.
As previously stated this device has had some quirks before when i trie=
d to use USB. The comments below are from Alan Stern who developed a pa=
tch for scsi_scan.c to make the device work when using the USB port on =
the Thecus N2050.

<snip>
This patch (as1154) fixes a problem in scsi_probe_lun(): The function
doesn't check whether the device has actually sent back any INQUIRY
data!  The patch adds a test to see if the result buffer is still
empty after the command has been executed.

This enables the Thecus N2050 storage device to work.  The firmware on
that device starts up strangely; it sends no data in response to the
initial INQUIRY, and it sends the INQUIRY information in response to
the followup REQUEST SENSE!  But after that it works better, so
retrying the INQUIRY is enough to get it going.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
</snip>

=D6rjan Nordlund
orjan@laxfiske.se
+46 707 93 61 28




9 nov 2009 kl. 09.10 skrev Tejun Heo:

> Hello,
>=20
> =D6rjan Nordlund wrote:
>> I am having an issue using eSata to connect my Thecus N2050 storage
>> cabinet to my new homeserver running Ubuntu Server 9.04.
>> dmesg shows "failed to IDENTIFY (I/O error, err_mask=3D0x100)"
>>=20
>> I have read forums and mailing lists to understand solutions to simi=
lar
>> problems and the following steps have been taken:
>> Upgraded to Vanilla kernel 2.6.31
>> Changed BIOS settings from SATA->AHCI and then back again
>> Tried boot with pci=3Dnomsi
>> Changed cables (i have three cables now and no one works)
>> Checked that no jumpers can be changed on disks or mainboard
>> Checked that the disks can be read through USB interface and from ot=
her
>> computers (works on Linux, OS X and Win XP)
>> Checked disks through eSata on Win XP box
>> Upgraded BIOS to latest release (August 2009)
>>=20
>> I have looked in all forums and LKML archives for a solution but can=
 not
>> really find anyone that has a similar problem.
>>=20
>> I am suspecting the quirks are in the Thecus N2050. I have had some
>> problems with this device in linux before when i was using USB. Than=
ks
>> to Alan Stern a patch (as1154) was introduced in October 2008 to hel=
p
>> get the device recognized properly by scsi when probing it.
>>=20
>> My Nvidia ION board has a MCP79 controller on-board (should be OK fr=
om
>> 2.6.24) and the Thecus has a Silicon Image controller (i opened the =
box
>> and read on the chip) with markings:
>> SIL5744CNU
>=20
> SIL5744 should work fine.  Hmmm...
>=20
>> dmesg (extract from hotplug of device):
>> [  753.849929] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1810000 ac=
tion
>> 0xe frozen
>> [  753.849970] ata3: irq_stat 0x00400000, PHY RDY changed
>> [  753.849994] ata3: SError: { PHYRdyChg LinkSeq TrStaTrns }
>> [  753.850024] ata3: hard resetting link
>> [  754.598415] ata3: SATA link down (SStatus 10 SControl 300)
>> [  754.598430] ata3: EH complete
>> [  758.663954] ata3: exception Emask 0x10 SAct 0x0 SErr 0x4140000 ac=
tion
>> 0xe frozen
>> [  758.663993] ata3: irq_stat 0x00000040, connection status changed
>> [  758.664018] ata3: SError: { CommWake Dispar DevExch }
>> [  758.664046] ata3: hard resetting link
>> [  759.588208] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [  759.588245] ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x=
100)
>=20
> Looks like the device is failing IDENTIFYs immediately.  I don't thin=
k
> this has anything to do with being _e_SATA.  Can you try it with othe=
r
> controllers?
>=20
> Thanks.
>=20
> --=20
> tejun

