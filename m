From: "Carlos Pardo" <Carlos.Pardo@siliconimage.com>
Subject: RE: > 2TB storage
Date: Mon, 24 Oct 2005 10:18:12 -0700
Message-ID: <2E9B8131C44AF746B1E06BF9B15A434B045D8027@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from siimage.com ([12.24.47.101]:55092 "EHLO mail.siimage.com")
	by vger.kernel.org with ESMTP id S1751177AbVJXRPH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 13:15:07 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

Randy et al,

I will retest and do a more accurate report in a couple of days. Thanks.

C-

-----Original Message-----
From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
Sent: Monday, October 24, 2005 9:20 AM
To: Carlos Pardo
Cc: Randy.Dunlap; Jeff Garzik; Tejun Heo; linux-ide@vger.kernel.org;
Edward Falk
Subject: RE: > 2TB storage


On Mon, 24 Oct 2005, Carlos Pardo wrote:

> Randy,
>
> I did not get any errors. Will recheck CONFIG_LBD settings. This is what I saw:
>
> With open source driver:
>
> scsi1: sata_sil
> SCSI device sda: 586153984 512-byte hdwr sectors (300111 MB)
> SCSI device sda: drive cache: write back
> mke2fs reports => 2232
>
> With our driver:
>
> sda : use 0xffffffff as device size

Wasn't there a message above this one?  There should have been
one like:

		printk(KERN_NOTICE "%s : READ CAPACITY(16) failed.\n"
		       "%s : status=%x, message=%02x, host=%d, driver=%02x \n",

> SCSI device sda: 4294967296 512-byte hdwr sectors (2199023 MB)
           == hex: 1_0000_0000

Looks to me like you really need CONFIG_LBD=y.

What CPU arch. are you using?

> SCSI device sda: drive cache: none
> mke2fs reports => 16384
>
> C-
>
> -----Original Message-----
> From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
> Sent: Monday, October 24, 2005 8:54 AM
> To: Jeff Garzik
> Cc: Carlos Pardo; Tejun Heo; linux-ide@vger.kernel.org; Edward Falk
> Subject: Re: > 2TB storage
>
>
> On Mon, 24 Oct 2005, Jeff Garzik wrote:
>
> > Carlos Pardo wrote:
> > > To everyone,
> > >
> > > Has anyone tested libATA drivers using disks bigger than 2 Terabytes? I just attached what is
> > > essentially a 2.2 TB disk drive to a Silicon Image 3114 chipset. It reported around 300 Megabytes
> > > instead of the expected 2200 Megabytes. How is the disk geometry determined ? Is it done by
> > > reading the IDENTIFY data or by accessing the BIOS ? Thanks in advance for any feedback.
> >
> > We read IDENTIFY DEVICE data directly, and use that...
> >
> > Make sure you have CONFIG_LBD turned on, as Randy mentioned.  There may
> > be other factors at play here too that I'm not seeing...
>
> With CONFIG_LBD=n and drive size near max 32-bit value,
> there is a drive size calculation overflow error.
> That's (another) reason that I asked for precise message logs.
>
> It only affects the reported size (in the message log).
> James has a fix for it.

-- 
~Randy
