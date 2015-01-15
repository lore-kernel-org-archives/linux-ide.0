From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 10:40:08 -0800
Message-ID: <20150115184008.GA2222288@devbig257.prn2.facebook.com>
References: <20150109181529.GA1301458@devbig257.prn2.facebook.com>
 <20150109214307.GE2785@htj.dyndns.org>
 <20150109215919.GA1826518@devbig257.prn2.facebook.com>
 <20150109221209.GA1851286@devbig257.prn2.facebook.com>
 <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
 <20150114163006.GA3575264@devbig257.prn2.facebook.com>
 <CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>
 <20150114171328.GA3636164@devbig257.prn2.facebook.com>
 <CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
 <20150115092836.GA14051@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53343 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbbAOSkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 13:40:42 -0500
Content-Disposition: inline
In-Reply-To: <20150115092836.GA14051@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>

On Thu, Jan 15, 2015 at 01:28:36AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2015 at 09:37:30AM -0800, Dan Williams wrote:
> > libsas uses the libata allocated tag for NCQ.  libsas first asks
> > libata to allocate a tag/qc for ncq, then it creates a sas_task and
> > assigns the scsi tag.  To use a generic allocator I assume you would
> > need to flip that ordering to allocate the sas_task tag first and then
> > use that plus another key to allocate a sub-tag for ata to use for
> > NCQ.
> 
> As far as I can tell all libsas drivers as well as ipr use block
> layer tagging, so they always get requests/scsi_cmnds with a tag
> already assigned. For libsas drivers currently use per-LUN tags,
> although with scsi-mq we will get per-host tags.
> 
> libata on the other hand at the moment assigns it's own tags,
> which are only stored in struct ata_queued_cmd, but never in the
> request. libata assigns tags per ata_host.  Each ata_host
> might have multiple ports, which each get their own Scsi_Host
> allocated.
> 
> Given that ATA NCQ has a fairly low queue depth I assume we want
> to stick to assigning ATA tags per-device, but due to the host
> per device scheme libata that even works using scsi-mq. (Q: how do tags
> work when port mulipliers are involved?)
> 
> So for SAS driver using libata we will need a separate tag allocator,
> but that one might as well be in libsas instead of keeping it in libata.

Yep, the ATA NCQ should work well with block tag as each port is a
scsi host. So looks it's not easy to map scsi tag to ATA tag for libsas
and we eventually will have another tag allocator for libsas.

Tejun,
I'm afraid I can't work out a patch to delete the old tag allocator for
libata. Can we take this patch series first and later we can delete the
old tag allocator till libsas has its own tag allocator. This isn't
optimal, but I really know nothing about libsas.

Thanks,
Shaohua
