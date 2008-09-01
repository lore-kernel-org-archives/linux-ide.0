From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Mon, 1 Sep 2008 21:10:14 +1000
Message-ID: <65a6ef750809010410v503ba217u13dc5a55490ef07c@mail.gmail.com>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	 <18605.27969.933718.902876@harpo.it.uu.se>
	 <65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
	 <18606.60604.356878.363677@harpo.it.uu.se>
	 <48AF282B.4090904@garzik.org>
	 <18607.14142.979717.852078@harpo.it.uu.se>
	 <65a6ef750808230223t6da2560fx1799dbf271e95959@mail.gmail.com>
	 <18607.58441.367432.715909@harpo.it.uu.se>
	 <65a6ef750808230340s1d44cb0ajfba8092d9f62f8e@mail.gmail.com>
	 <18607.64440.810334.137910@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:28202 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYIALKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Sep 2008 07:10:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1094855yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 04:10:14 -0700 (PDT)
In-Reply-To: <18607.64440.810334.137910@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, Aug 23, 2008 at 9:59 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Mark Nelson writes:
>  > >  > Forgive my ignorance, but does the fact that the T3 controller can also
>  > >  > use SAS disks mean we should be looking for a SCSI driver?
>  > >
>  > > Promise lists only this one partial-source driver for the tx4650,
>  > > and it /is/ a Linux scsi driver.
>  > >
>  >
>  > Oh sorry, I meant to ask should we be looking at an in-kernel
>  > (or fully open source driver) that is a SCSI driver that we could make
>  > work with the T3? So maybe my question is actually: does the
>  > fact that this controller supports SAS disks mean that the
>  > driver for it should be a scsi driver (rather than an ATA driver)?
>
> The candidate Linux drivers would be ata/sata_promise, ata/sata_sx4,
> block/sx8, and scsi/stex. You tried sata_promise, and from looking
> at the PCI IDs I doubt the others are likely to drive the T3.
>
> If you can find an open-source T3 driver in some other operating
> system, like OpenSolaris, Darwin, or some *BSD, then that would be
> great.
>

Okay, so after trying all of the above drivers you suggested (as
well as a few other SAS drivers I found) I figured I'd try AHCI.

And it actually works!

After making the following simple change:

--- linux/drivers/ata/ahci.c_orig	2008-09-01 18:42:26.000000000 +1000
+++ linux/drivers/ata/ahci.c	2008-09-01 19:41:29.000000000 +1000
@@ -542,6 +542,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */

+	/* Promise */
+	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },		/* T3 */
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },


the ahci driver finds the four SATA ports connected to the T3
controller:

ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:02:00.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl RAID mode
ahci 0000:02:00.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
scsi7 : ahci
ata5: SATA max UDMA/133 abar m8192@0xfbefc000 port 0xfbefc100 irq 17
ata6: SATA max UDMA/133 abar m8192@0xfbefc000 port 0xfbefc180 irq 17
ata7: SATA max UDMA/133 abar m8192@0xfbefc000 port 0xfbefc200 irq 17
ata8: SATA max UDMA/133 abar m8192@0xfbefc000 port 0xfbefc280 irq 17
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata7: SATA link down (SStatus 0 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)

and when I connect a drive to the eSATA port it's detected
and I can mount it and use it:

ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
ata7: irq_stat 0x00000040, connection status changed
ata7: SError: { PHYRdyChg CommWake DevExch }
ata7: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata7.00: ATA-7: HTS721060G9SA00, MC3IC10H, max UDMA/100
ata7.00: 117210240 sectors, multi 0: LBA48
ata7.00: configured for UDMA/100
ata7: EH complete
scsi 6:0:0:0: Direct-Access     ATA      HTS721060G9SA00  MC3I PQ: 0 ANSI: 5
sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
sd 6:0:0:0: [sdb] Write Protect is off
sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 6:0:0:0: [sdb] 117210240 512-byte hardware sectors (60012 MB)
sd 6:0:0:0: [sdb] Write Protect is off
sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 6:0:0:0: [sdb] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg3 type 0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

I am however not so sure about the SError line above -
perhaps this Promise chip doesn't correctly implement all
of AHCI and I should be using something other than
"board_ahci"?

This feels like a good start - I've been copying large amounts
of data over to the disk and it seems to be working - I can
play back movie files from there and diff doesn't find any
differences between the copied files and the original.

I'm not sure whether this is frowned upon but I didn't exactly
just stumble upon trying AHCI: after not having any luck with
the in-kernel drivers I began examining Promise's binary blob.
And today I came across a function called
"T3DisableAHCIMode" which made me think that the chips
native mode could be AHCI (when it's not setup to be used
with Promise's software raid).

Thanks!

Mark
