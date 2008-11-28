From: "Raz Ben-Yehuda" <razb@bitband.com>
Subject: RE: about TRIM/DISCARD support and barriers
Date: Fri, 28 Nov 2008 15:21:45 +0200
Message-ID: <83CA05F64804AF43B8F733C4ABDFAA51022D04B0@mail1.bitband.com>
References: <4928E010.4090801@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:33410 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751355AbYK1NhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Nov 2008 08:37:11 -0500
Content-class: urn:content-classes:message
In-reply-to: <4928E010.4090801@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


Tejun Hello
Is there a WIKI for SSD disk in Linux?
I want to understand what is the rational for the OS intervention. Why
and when you discard, fsck changes, why and how IO scheduling is
changed...
Thank you

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Tejun Heo
Sent: Sunday, November 23, 2008 6:46 AM
To: Linux Kernel Mailing List; dwmw2@infradead.org; Nick Piggin; Jens
Axboe; IDE/ATA development list; Jeff Garzik; Dongjun Shin;
chris.mason@oracle.com; Jens Axboe
Subject: about TRIM/DISCARD support and barriers

Hello, all.

Dongjun Shin who works for Samsung SSD dep asked me about libata TRIM
support and pointed me to the new DISCARD support David Woodhouse got
merged for 2.6.28.  I took a look at the code and blk-layer
interface-wise we seemed to be ready both for filesystems and userland
(so that fsck or something which runs background can mark unused
blocks) but there doesn't seem to be any low level driver which
actually implements ->prepare_discard_fn or fs which sets the DISCARD
flag.

Adding ->prepare_discard_fn wouldn't be difficult at all but I became
curious about a few things after looking at the DISCARD interface.
First of all - how to avoid racing aginst reusing and how to schedule
DISCARDs.

* There are two variants of DISCARD - DISCARD w/o barrier and DISCARD
  w/ barrier, if a fs uses the former, it would need to make sure that
  it the DISCARD finishes before re-using the block.  Block layer will
  make sure order will be kept for the latter but depending on how
  often those DICARDs are issued it can disrupt IO scheduling.

* It looks like non-barrier DISCARD will be put into the IO sched and
  scheduled the same way as regular IOs.  I don't relly think this is
  necessary or a good idea.  DISCARDs probably don't need any kind of
  sorting anyway and it's likely to disrupt IO sched heuristics.
  Also, DISCARDs can be postponed w/o affecting correct operation.
  However, DISCARDs are not likely to take a long time and we might
  not have to worry about it too much unless it starves regular IOs.

With the above three points, I think it might be better to make block
layer manage and order DISCARD requests than putting it onto the
filesystem or barrier mechanism.  If block layer manages map of
pending DISCARDs and FSes just tell block layer newly freed blocks,
block layer can schedule DISCARDs as it sees fit and cancels pending
ones if IO access to it occurs before the DISCARD is issued to the
drive.  This way, adding DISCARD support to FSes become much easier -
it can just put blk_discard(lba, range) where it's discarding blocks
and don't have to worry about ordering or error handling.

What do you think?

Also, I have a question regarding the current barrier implementation.
When I asked it to Chris Mason some time ago, I was told that btrfs
doesn't really make use of barrier in that btrfs itself waits for the
barrier to complete before proceeding.  I've been thinking about
colored barrier implementation because I heard that the current
barrier ordering is too crude or heavy handed.  But, then again, if
the filesystem waits for requests to complete itself and those
dependent requests are marked SYNC as necessary so that they don't get
postponed too much, all that's needed is flush cache.  Doing it that
way will add a bit of latency but as long as things can progress in
parallel, it will probably perform better than the current barrier.

After all, it's not like we have selective FLUSH on actual devices
anyway.  Where the selective barriering can make difference is how
it's handled in the IO scheduler and FS waiting for requests to finish
and then issuing barrier achieves that quite alright and communicating
the partitial ordering of requests to block layer wouldn't be much
simpler than doing it in FS proper and there's also the problem of how
to communicate or handle when one of the request in the partial
ordering fails.  So, would selective / more intelligent barrier be
beneficial to filesystems or is the way things are just fine?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
