From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA open bugs
Date: Thu, 09 Aug 2007 12:58:57 +0900
Message-ID: <46BA9101.6080407@gmail.com>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:3749 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbXHID7R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 23:59:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so304740rvb
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 20:59:16 -0700 (PDT)
In-Reply-To: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Natalie Protasevich <protasnb@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Hello, Natalie.

Natalie Protasevich wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=7693

This bug isn't related to libata in anyway.  It's "Can't use radeonfb
with dvi port on a Samsung SyncMaster 204B (1600x1200)".

> http://bugzilla.kernel.org/show_bug.cgi?id=8738 adaptec and sata bad interaction

This is SATA support in SAS controller (SCSI) and probably solved by now.

> http://bugzilla.kernel.org/show_bug.cgi?id=8563 - waiting on alan
> http://bugzilla.kernel.org/show_bug.cgi?id=8441 - patch review

This is being worked on.  It requires some redesign in IRQ masking and
polling code.

> http://bugzilla.kernel.org/show_bug.cgi?id=8649

This one is chrp specific.  The native mode fix didn't work.  I'll
follow up later.

> http://bugzilla.kernel.org/show_bug.cgi?id=8424 - patch review

This one is on Alan.

> http://bugzilla.kernel.org/show_bug.cgi?id=8410 - patch status from tejun

This is done.  Closing.

> http://bugzilla.kernel.org/show_bug.cgi?id=8331 - waiting on reporter
> http://bugzilla.kernel.org/show_bug.cgi?id=8281

Will check with SIMG and see whether we need to worry about flash.

> http://bugzilla.kernel.org/show_bug.cgi?id=8223 small fixup, low
> priority tejun is out of time

On my todo list.  I think I'll defer this till we do EH per-queue.

> http://bugzilla.kernel.org/show_bug.cgi?id=7997
> http://bugzilla.kernel.org/show_bug.cgi?id=7869

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=7811 - regression

Seems to be yet another IRQ routing problem on via chipset.  I don't
think this has much to do with libata drivers.

> http://bugzilla.kernel.org/show_bug.cgi?id=7805 tejun is pinging
> pktcdvd maintainer (?)

Not a libata bug.  This is caused by pktcdvd holding onto the device
thus preventing it from being revalidated.  Didn't get pong for my ping
yet.  Jens, any ideas?

> http://bugzilla.kernel.org/show_bug.cgi?id=7599

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=7547 tejun is asking " and Jens

This one is pktcdvd too.  Jens?

> http://bugzilla.kernel.org/show_bug.cgi?id=7545 cold

Marked as duplicate of bug 8421.

> http://bugzilla.kernel.org/show_bug.cgi?id=7507

Asked for testing on newer kernels.

> http://bugzilla.kernel.org/show_bug.cgi?id=7501

Working on it now.

> http://bugzilla.kernel.org/show_bug.cgi?id=7500

Patch proposed.

> http://bugzilla.kernel.org/show_bug.cgi?id=7489 status?

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=7411 status?

Asked Alan to close it.

> http://bugzilla.kernel.org/show_bug.cgi?id=7241 waiting on reporter

Ditto.

> http://bugzilla.kernel.org/show_bug.cgi?id=7119 cold fixed?

Pinged.

> http://bugzilla.kernel.org/show_bug.cgi?id=7029 reporter is trying to get the hw

Pinged.

> http://bugzilla.kernel.org/show_bug.cgi?id=6891 - old sata report

Closed as INSUFFICIENT_DATA.

> http://bugzilla.kernel.org/show_bug.cgi?id=6890 - old kernel, needs retesting

Eeeek.  Yet another via IRQ problem.  Pinged.

> http://bugzilla.kernel.org/show_bug.cgi?id=6665 - old kernel

Marked as duplicate of bug 8421.

> http://bugzilla.kernel.org/show_bug.cgi?id=6594 - cold

Should probably be closed.  It's too old now.  Jeff?

> http://bugzilla.kernel.org/show_bug.cgi?id=6592 - pinged

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=6587

Pinged.

> http://bugzilla.kernel.org/show_bug.cgi?id=6516 - waiting on reporter

Definitely not a libata bug.  Pinged.

> http://bugzilla.kernel.org/show_bug.cgi?id=6253 - cold? waiting on reporter

Rejected as INSUFFICIENT_DATA.

> http://bugzilla.kernel.org/show_bug.cgi?id=6207 - cold?

Ditto.

> http://bugzilla.kernel.org/show_bug.cgi?id=5863 - cold

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=5798 - cold

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=4968 - cold

INSUFFICIENT_DATA

> http://bugzilla.kernel.org/show_bug.cgi?id=4238 pinged

FIXED

> http://bugzilla.kernel.org/show_bug.cgi?id=3993 pinged

I think it's about time to close this one.  It's way too cold.  Jeff?

> http://bugzilla.kernel.org/show_bug.cgi?id=3725 pinged

Closed.

> http://bugzilla.kernel.org/show_bug.cgi?id=3352 cold? waiting on reporter

Way too cold.  Somebody please close this.

> http://bugzilla.kernel.org/show_bug.cgi?id=2893 pinged

Jeff, please close this as INSUFFICIENT_DATA.

Thanks.

-- 
tejun
