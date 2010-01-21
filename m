From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 14:24:35 -0500
Message-ID: <fbae475f602d8f79f27d2d36be0de4f7.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:3854 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754531Ab0AUTYg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 14:24:36 -0500
Received: from d72-38-7-254.commercial1.cgocable.net
	([72.38.7.254] helo=thechecks.ca ident=www-data)
	by max with esmtp (Exim 4.71)
	(envelope-from <paul@thechecks.ca>)
	id 1NY2du-0005Lr-WB
	for linux-ide@vger.kernel.org; Thu, 21 Jan 2010 14:24:35 -0500
In-Reply-To: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I decided to try running 2.6.31 without the pata_marvell anyway, just to
see what would happen. It will be difficult to diagnose due to the fact
that the problem was only intermittent, but here are some interesting
observations so far:

With my old 2.6.31 kernel and pata_marvell selected, I had been getting
line such as the following in kern.log:

kernel: [    1.293997] scsi0 : pata_marvell
kernel: [    1.294093] scsi1 : pata_marvell

Sometimes instead of scsi0 and scsi1 it would say scsi4 and scsi5.  It
appears that when pata_marvell was associated with scsi0 and scsi1, my
drives would register on ata3 and ata4.  But, when pata_marvell was
associated with scsi4 and scsi5, the drives would be associated with ata1
and ata2.  [Note: The four hard drives are plugged into sata ports 1
through 4, the Sony BWU into port 5 and the front eSATA into port 6.]

Now, with pata_marvell NOT compiled into the kernel, on the first try I am
getting the hard drives on ata1.00, ata1.01, ata2.00 and ata2.01, and the
Sony BWU on sata3, which seems "correct" given the ports I have the drives
plugged into.

Also, I now see:

ata7: DUMMY

whereas before this entry did not occur.

So, it does appear that the pata_marvell module was at least responsible
for the shifting ata entries (answering one of my questions). We'll see if
it also gets rid of the much more serious link down problem.  I will try
multiple reboots later to see if I can trigger that old bad link down
behaviour.

P

> I am having an intermittent problem:
>
> ata1.01: SATA link down (SStatus 0 SControl 301)
>
> which is causing one of my four hard drives to not get recognized.
>
> This happens on ata1.01, ata2.00 or ata2.01, although it seems to happen
> more on the 01 channels, I believe.  My motherboard is an ASUS P6T Deluxe
> V2, with the Marvel 88SE61XX ATA controller.
>
> I am running the 2.6.31 kernel.  A variety of ATA controllers are enabled
> in my kernel (as per default?) including AHCI SATA Support (SATA_AHCI),
> Marvell SATA Support (SATA_MV), Generic ATA Support (ATA_Generic), and
> Marvell PATA Support via Legacy Mode (PATA_MARVELL), among others.
>
> I see that the pata, generic and ahci are getting loaded (from lsmod):
>
> libata                189532  4 pata_marvell,ata_generic,ahci,ata_piix
>
> I am not using hardware RAID (although do have software RAID 1 running).
>
> The BIOS for the board has been updated to the latest version.  The disks
> are Seagate ST31000528AS 1 TB drives (4 of them, 2 sets of RAID 1).  I
> also have a Sony BWU-300S plugged in.
>
> Would deselecting the pata_marvell likely get rid of this problem? The
> descriptor says:
>
> As I look through kern.log I see that the numbering on the ATA channels is
> not always consistent.  For example, sometimes the Seagates come on
> ata3.00, ata3.01, ata4.00 and ata4.01. Is this usual, or indicating a
> problem with the controller/driver?
>
> Regards, Paul (on list)
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


