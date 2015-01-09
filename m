From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Fri, 9 Jan 2015 14:12:09 -0800
Message-ID: <20150109221209.GA1851286@devbig257.prn2.facebook.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
 <546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
 <20150109181529.GA1301458@devbig257.prn2.facebook.com>
 <20150109214307.GE2785@htj.dyndns.org>
 <20150109215919.GA1826518@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62197 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751554AbbAIWRl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2015 17:17:41 -0500
Content-Disposition: inline
In-Reply-To: <20150109215919.GA1826518@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, dan.j.williams@intel.com
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 09, 2015 at 01:59:19PM -0800, Shaohua Li wrote:
> On Fri, Jan 09, 2015 at 04:43:07PM -0500, Tejun Heo wrote:
> > On Fri, Jan 09, 2015 at 10:15:29AM -0800, Shaohua Li wrote:
> > > Ping!
> > 
> > I like the idea but it bothers me that we end up with two separate
> > ways of allocating command tags.  Any chance the old one can be
> > removed?

Oh, sorry, my reply truncated.

So I checked with IPR driver guys, the ipr doesn't use ncq, so we can
always use sata tag 0, but not sure for libsas.

Maybe Dan can answer if there is a way we can map SCSI tag to SATA tag.

Thanks,
Shaohua
