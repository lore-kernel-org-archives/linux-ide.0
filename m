From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 13:57:20 -0500
Message-ID: <20150115185720.GB28195@htj.dyndns.org>
References: <20150109214307.GE2785@htj.dyndns.org>
 <20150109215919.GA1826518@devbig257.prn2.facebook.com>
 <20150109221209.GA1851286@devbig257.prn2.facebook.com>
 <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
 <20150114163006.GA3575264@devbig257.prn2.facebook.com>
 <CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>
 <20150114171328.GA3636164@devbig257.prn2.facebook.com>
 <CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
 <20150115092836.GA14051@infradead.org>
 <20150115184008.GA2222288@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:52840 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbbAOS50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 13:57:26 -0500
Received: by mail-qa0-f47.google.com with SMTP id n8so12432220qaq.6
        for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 10:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150115184008.GA2222288@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>

Hello, Shaohua.

On Thu, Jan 15, 2015 at 10:40:08AM -0800, Shaohua Li wrote:
> I'm afraid I can't work out a patch to delete the old tag allocator for
> libata. Can we take this patch series first and later we can delete the
> old tag allocator till libsas has its own tag allocator. This isn't
> optimal, but I really know nothing about libsas.

As long as it's clear that this is libsas-only and the rest of code
doesn't have to care about it, I guess it'll have to do.  But please
do isolate it clearly.

Thanks.

-- 
tejun
