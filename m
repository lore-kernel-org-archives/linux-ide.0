From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 14:03:54 -0500
Message-ID: <20150115190354.GC28195@htj.dyndns.org>
References: <20150109215919.GA1826518@devbig257.prn2.facebook.com>
 <20150109221209.GA1851286@devbig257.prn2.facebook.com>
 <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
 <20150114163006.GA3575264@devbig257.prn2.facebook.com>
 <CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>
 <20150114171328.GA3636164@devbig257.prn2.facebook.com>
 <CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
 <20150115092836.GA14051@infradead.org>
 <20150115184008.GA2222288@devbig257.prn2.facebook.com>
 <CAPcyv4imdCq83gN+KOWsu4=0arB59um8upnaGRV0UxhBwc6T4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:47310 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbbAOTD5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 14:03:57 -0500
Received: by mail-qa0-f51.google.com with SMTP id f12so11579949qad.10
        for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 11:03:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPcyv4imdCq83gN+KOWsu4=0arB59um8upnaGRV0UxhBwc6T4A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>

On Thu, Jan 15, 2015 at 10:59:36AM -0800, Dan Williams wrote:
> I still don't understand what we get by adding this new allocator
> besides complexity, am I missing something?

Hmmm... one problem with the existing tag allocator in ata is that
it's not very efficient which actually shows up in profile when libata
is used with a very zippy SSD.  Given that ata needs a different
allocation policies anyway maybe the right thing to do is making the
existing allocator suck less.

Thanks.

-- 
tejun
