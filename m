From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 10:33:00 -0500
Message-ID: <yq1vdd6bzgz.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org>
	<1268031640.4389.11.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268031640.4389.11.camel@mulgrave.site> (James Bottomley's
	message of "Mon, 08 Mar 2010 12:30:40 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@suse.de> writes:

James> However, for 4k sectors, the main issues which have shown up in
James> testing by others (mostly Martin) are

James>      1. In native 4k mode, we work perfectly fine.  *however*,
James>         most BIOSs can't boot native 4k drives.

Correct.  I have engaged with pretty much all the big OEMs in the
industry and so far the interest has been near zero.


James>      4. The aligment problem is made more complex by drives that
James>         make use of the offset exponent feature (what you refer
James>         to as offset by one) ... fortunately very few of these
James>         have been seen in the wild and we're hopeful they can be
James>         shot before they breed.

This topic is constantly up for debate in IDEMA.  However, it looks like
we might win because of the impending demise of XP.


James> so the bottom line seems to be that if you want the device as a
James> non boot disk, use native 4k sectors and a non-msdos partition
James> label.  If you want to boot from the drive and your bios won't
James> book 4k natively, partition everything using the 512 emulation
James> and try to align the partitions correctly.  If your bios/uefi
James> will boot 4k natively, just use it and whatever partition label
James> the bios/uefi supports.

James> Martin can fill in the pieces I've left out.

Here's my latest take given what I hear on the grapevine:

1. 512-byte logical block size drives will be around forever for legacy
   deployments because nobody is willing to do the required BIOS int13
   work.  It's not just a BIOS thing, this requires heavy changes to HBA
   boot ROMs as well.

2. Some vendors are working on EFI firmware and will support booting off
   of 4KB LBS drives there.  This is mostly aimed at the server space.

3. 4 KB logical block size drives will mainly be targeted for use inside
   arrays.  Off the shelf enterprise drive models will most likely
   continue to ship with a 512-byte LBS.

4. Part of the hesitation to work on booting off of 4 KB lbs drives is
   motivated by a general trend in the industry to move boot
   functionality to SSD.  There are 4 KB LBS SSDs out there but in
   general the industry is sticking to ATA for local boot.

-- 
Martin K. Petersen	Oracle Linux Engineering
