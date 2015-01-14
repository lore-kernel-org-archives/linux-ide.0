From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Wed, 14 Jan 2015 08:30:06 -0800
Message-ID: <20150114163006.GA3575264@devbig257.prn2.facebook.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
 <546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
 <20150109181529.GA1301458@devbig257.prn2.facebook.com>
 <20150109214307.GE2785@htj.dyndns.org>
 <20150109215919.GA1826518@devbig257.prn2.facebook.com>
 <20150109221209.GA1851286@devbig257.prn2.facebook.com>
 <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33379 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001AbbANQas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2015 11:30:48 -0500
Content-Disposition: inline
In-Reply-To: <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>

On Wed, Jan 14, 2015 at 12:08:26AM -0800, Dan Williams wrote:
> On Fri, Jan 9, 2015 at 2:12 PM, Shaohua Li <shli@fb.com> wrote:
> > On Fri, Jan 09, 2015 at 01:59:19PM -0800, Shaohua Li wrote:
> >> On Fri, Jan 09, 2015 at 04:43:07PM -0500, Tejun Heo wrote:
> >> > On Fri, Jan 09, 2015 at 10:15:29AM -0800, Shaohua Li wrote:
> >> > > Ping!
> >> >
> >> > I like the idea but it bothers me that we end up with two separate
> >> > ways of allocating command tags.  Any chance the old one can be
> >> > removed?
> >
> > Oh, sorry, my reply truncated.
> >
> > So I checked with IPR driver guys, the ipr doesn't use ncq, so we can
> > always use sata tag 0, but not sure for libsas.
> >
> > Maybe Dan can answer if there is a way we can map SCSI tag to SATA tag.
> >
> 
> For libsas or for ata drivers?  For libsas, iirc, the internal libata
> tag is ignored and we use the scsi tag for the sas task  For ata some
> drivers want round robin, but others appear to care about using the
> lowest available: https://urldefense.proofpoint.com/v1/url?u=https://bugzilla.kernel.org/show_bug.cgi?id%3D87101&k=ZVNjlDMF0FElm4dQtryO4A%3D%3D%0A&r=3RFlL12A7nwmLRXunVJq2g%3D%3D%0A&m=i5Fz0FbsOgTMAtXW2WeXro9juvX%2BRmkKOK%2Fnl5ZZWMw%3D%0A&s=b8747b79ff51a364a841dd8e2ff51814536fcd63eedb7ad8f1de68e6691e5e98.
> 
> Is ata using it's own legacy tag ordering scheme getting in the way of
> other improvements?  I'd just as soon recommend letting legacy dogs
> lie.  In other words what do we gain by switching?
> 
> I need to follow up on bz87101, seems I never reworked the patch as
> Tejun asked.  However, I'm glad a fix like the one proposed in that
> report can be self-contained to libata and need not worry about
> supporting ata specific quirks in the block layer tag ordering scheme.

Basically I'd like using block tag instead of an open coded tag
implementation in libata. The block tag implenmentation is more
sophisticated, and with blk-mq tag is built-in, so it's great to remove
tag implementation in libata. For sata, it's easy to do it. The problem
is sas, which implements its own scsi driver/tag. My question is if we
can map SCSI tag (of libsas) to ATA tag. So for example, the ipr sas
driver doesn't use NCQ, so we can always use ata tag 0 in libata for
ipr. I'm wondering if we can do some mapping in libsas too, so we can
completely delete the tag code in libata.

Thanks,
Shaohua
