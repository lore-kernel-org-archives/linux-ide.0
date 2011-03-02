From: Tejun Heo <tj@kernel.org>
Subject: Re: libata default FUA support
Date: Wed, 2 Mar 2011 09:58:23 +0100
Message-ID: <20110302085823.GI19669@htj.dyndns.org>
References: <20110301203313.GA1656@gentoo.trippels.de>
 <4D6D952D.8030609@gmail.com>
 <4D6DF231.5090702@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57912 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab1CBI62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 03:58:28 -0500
Received: by fxm17 with SMTP id 17so5675902fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 02 Mar 2011 00:58:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D6DF231.5090702@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Robert Hancock <hancockrwd@gmail.com>, Markus Trippelsdorf <markus@trippelsdorf.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Mar 02, 2011 at 10:30:57AM +0300, Michael Tokarev wrote:
> > I believe the way the block layer uses it, basically it only saves the
> > overhead of one transaction to the drive. It might be significant on
> > some workloads (especially on high IOPS drives like SSDs) but it's
> > likely not a huge deal.
> 
> One transaction per what?  If it means extra, especially "large"
> transaction (lile flush with a wait) per each fsync-like call,
> that can be huge deal actually, especially on database-like
> workloads (lots of small syncronous random writes).

The way flushes are used by filesystems is that FUA is usually only
used right after another FLUSH.  ie. Using FUA replaces FLUSH + commit
block write + FLUSH sequence to FLUSH + FUA commit block write.  Due
to the preceding FLUSH, the cache is already empty, so the only
difference between WRITE + FLUSH and FUA WRITE becomes the extra
command issue overhead which is usually almost unnoticeable compared
to the actual IO.

Another thing is that with the recent updates to block FLUSH handling,
using FUA might even be less efficient.  The new implementation
aggressively merges those commit writes and flushes.  IOW, depending
on timing, multiple consecutive commit writes can be merged as,

 FLUSH + commit writes + FLUSH

or

 FLUSH + some commit writes + FLUSH + other commit writes + FLUSH

and so on,

These merges will happen with fsync heavy workloads where FLUSH
performance actually matters and, in these scenarios, FUA writes is
less effective because it puts extra ordering restrictions on each FUA
write.  ie. With surrounding FLUSHes, the drive is free to reorder
commit writes to maximize performance, with FUA, the disk has to jump
around all over the place to execute each command in the exact issue
order.

I personally think FUA is a misfeature.  It's a microoptimization with
shallow benefits even when used properly while putting much heavier
restriction on actual IO order, which usually is the slow part.

That said, if someone can show FUA actually brings noticeable
performance benefits, sure, let's do it, but till then, I think it
would be best to leave it up in the attic.

Thanks.

-- 
tejun
