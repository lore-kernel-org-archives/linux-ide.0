From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Fri, 16 Jan 2009 00:46:04 +0900
Message-ID: <496F5A3C.2070600@gmail.com>
References: <200901051952.58029.bzolnier@gmail.com>	 <20090105185428.GS32491@kernel.dk>	 <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>	 <20090106073515.GY32491@kernel.dk> <4964866D.8010503@msgid.tls.msk.ru>	 <1231342473.3282.19.camel@localhost.localdomain>	 <496ECBA0.60209@gmail.com> <87f94c370901150707h10506e99reaa40c23e32ab18c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:17693 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbZAOPqL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 10:46:11 -0500
In-Reply-To: <87f94c370901150707h10506e99reaa40c23e32ab18c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Michael Tokarev <mjt@tls.msk.ru>, Jens Axboe <jens.axboe@oracle.com>, Kay Sievers <kay.sievers@vrfy.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Greg Freemyer wrote:
>> Or just compare prices per byte of memory, flash and rotation disk.
>> They haven't had changed too much during last several years.

I meant the ratio of prices here.

>> Secondary storage which is only slightly cheaper than the primary
>> storage doesn't have much chance of flying high and far.
>> tejun
> 
> Have you seen the new pricing Samsung has announced for their 3rd
> generation SSD.  It is about 1/3 of the Intel' SSD price if I recall
> correctly and the performance is approaching Intel's from what I've
> seen.

I compare the prices from time to time (about once a year I think) and
the difference has been usually much higher than 20 times if my memory
serves me right.  Intel SSDs are on pretty expensive side, even 1/3 of
that price means > 20 times price difference per byte.  If you compare
that price with main memory, it's only ~3.5 times cheaper.

> I've been talking to the OpenHSM (Hierachical Storage Manager) team
> about their project.  They are working on getting the logic in place
> now to move data blocks from one class of storage to another while
> leaving the filesystem itself un-affected from the users perspective.
> 
> http://code.google.com/p/fscops/
> 
> They have a very long way to go with their code/project, but it is
> conceptually similar to the ext4_defrag patch that already exists.
> The big difference is the data block allocation algorithm will have to
> be totally different.
> 
> If and when that get their code done, I would love to have 500 GB of
> SSD teamed with several TB of rotational HDD and have the HSM move my
> files between fast SSD and slow rotational.  I typically know which
> datasets I will be working with heavily, so even a simple user space
> tool that would let me adjust which tier of storage my files were
> sitting on would suffice.

I'd love that too.  For areas where data size doesn't grow
exponentially, it is and will continue to be great and be getting even
better, but I'm just not sure whether it will rise as the mainstream
secondary storage in foreseeable future given the price discrepancy
but I'll be happy to be taken by surprise.  :-)

Thanks.

-- 
tejun
