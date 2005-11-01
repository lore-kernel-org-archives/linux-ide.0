From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Tue, 1 Nov 2005 12:24:22 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF2F@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:38480 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751123AbVKAUY0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2005 15:24:26 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> On Tue, Nov 01 2005, Timothy Thelin wrote:
> > Changes:
> > Increases the taskfile data transfer limit from 128K to a
> > theoretical 2-4MB (arch dependant) by using __get_free_pages
> > instead of kmalloc.  Note that larger requests have a lower
> > success rate because of needing to find a larger amount of
> > free consecutive memory.
> 
> I don't think this is a good way to do it. IDE already supports sg for
> regular fs requests, the correct solution would be to make 
> sure the user
> driven taskfile submission is sg based as well. That would 
> enable large
> transfers without risking allocation failures.

Agreed. I looked into doing sg first, but the changes
required would be more invasive and have a higher risk of
breaking existing things. This was targeted as an interim
solution by someone without lots of ide core experience
until someone came up with a proper sg solution.

> An interface that doesn't
> work for anything but a freshly booted kernel is pretty 
> worthless, imho.
> User interfaces must work predictably.
> 

A question though: is __get_free_pages less successful than
kmalloc in returning the same sized chunk of memory?  If
it's the same success rate (and I thought it was, is it not?),
then up to 128K the interface acts just like before, but now it
can possibly do larger transfers rather than having no
ability to do larger transfers.

My personal interests are in transfering data in the
130K-140K range, just over what kmalloc can do, and 
this interim solution has been great for that.

It might be possible for me to begin work on an sg solution
in a couple of weeks (design advice anyone?).


Regards,
Tim Thelin
