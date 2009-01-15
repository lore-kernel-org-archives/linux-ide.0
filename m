From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Thu, 15 Jan 2009 10:07:16 -0500
Message-ID: <87f94c370901150707h10506e99reaa40c23e32ab18c@mail.gmail.com>
References: <200901051952.58029.bzolnier@gmail.com>
	 <20090105185428.GS32491@kernel.dk>
	 <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>
	 <20090106073515.GY32491@kernel.dk> <4964866D.8010503@msgid.tls.msk.ru>
	 <1231342473.3282.19.camel@localhost.localdomain>
	 <496ECBA0.60209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:62976 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZAOPHS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 10:07:18 -0500
In-Reply-To: <496ECBA0.60209@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Michael Tokarev <mjt@tls.msk.ru>, Jens Axboe <jens.axboe@oracle.com>, Kay Sievers <kay.sievers@vrfy.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Jan 15, 2009 at 12:37 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> James Bottomley wrote:
>> I'm afraid that's pretty much marketing coolaid.  Rotational storage
>> will dominate for the forseeable future: just do a simple back of the
>> envelope calculation:
>
> Or just compare prices per byte of memory, flash and rotation disk.
> They haven't had changed too much during last several years.
> Secondary storage which is only slightly cheaper than the primary
> storage doesn't have much chance of flying high and far.
>
> Thanks.
>
> --
> tejun

Have you seen the new pricing Samsung has announced for their 3rd
generation SSD.  It is about 1/3 of the Intel' SSD price if I recall
correctly and the performance is approaching Intel's from what I've
seen.

I've been talking to the OpenHSM (Hierachical Storage Manager) team
about their project.  They are working on getting the logic in place
now to move data blocks from one class of storage to another while
leaving the filesystem itself un-affected from the users perspective.

http://code.google.com/p/fscops/

They have a very long way to go with their code/project, but it is
conceptually similar to the ext4_defrag patch that already exists.
The big difference is the data block allocation algorithm will have to
be totally different.

If and when that get their code done, I would love to have 500 GB of
SSD teamed with several TB of rotational HDD and have the HSM move my
files between fast SSD and slow rotational.  I typically know which
datasets I will be working with heavily, so even a simple user space
tool that would let me adjust which tier of storage my files were
sitting on would suffice.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
