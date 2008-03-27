From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 10:24:43 -0400
Message-ID: <47EBAE2B.8070102@rtr.ca>
References: <12066128663306-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4203 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752AbYC0OYp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Mar 2008 10:24:45 -0400
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
>
> As the code is being smart against retrying needlessly, it won't be
> too dangerous to increase the 20 tries (taken from Alan's patch) but I
> think it's as good as any other random number.  If anyone knows any
> meaningful number, please chime in.  The same goes for 60 secs timeout
> too.
..

I really think that we should enforce a strict upper limit on the time
that can be spent inside the flush-cache near-infinite loop being introduced.

Some things rely on I/O completing or failing in a time deterministic manner.

Really, the entire flush + retries etc.. should never, ever, be permitted
to take more than XX seconds total.  Not 60 seconds per retry, but XX seconds
total for the original command + however many retries we can fit in there.

As for the value of XX, well.. make it a sysfs attribute, with a default
of something "sensible".   The time bounds is really dependent upon how
quickly the drive can empty its onboard cache, or how large a cache it has.

Figure the biggest drives will have no more than, say 64MB of cache for
many years (biggest SATA drive now uses 16MB).  Assuming near-worst case
I/O size of 4KB, that's 16384 I/O operations, if none were adjacent on disk.

What's the average access time these days?  Say.. 20ms worst case for any
drive with a cache that huge?   That's unrealistically slow for data that's
already in the drive cache, but .. 16384 * .020 seconds = 328 seconds.

Absolute theoretical worst case for a drive with a buffer 4X the largest
current size:  328 seconds.  Not taking into account having bad-sector
retries for each of those I/O blocks, but *nobody* is going to wait
that long anyway.  They'll have long since pulled the power cord or 
reached for the BIG RED BUTTON.

On a 16MB cache drive, that number would be 328 / 4 = 82 seconds.

That's what I'd put for the limit.
But we could be slighly nonsensical and agree upon 120 seconds.  :)

Cheers



