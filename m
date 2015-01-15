From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 01:28:36 -0800
Message-ID: <20150115092836.GA14051@infradead.org>
References: <546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
 <20150109181529.GA1301458@devbig257.prn2.facebook.com>
 <20150109214307.GE2785@htj.dyndns.org>
 <20150109215919.GA1826518@devbig257.prn2.facebook.com>
 <20150109221209.GA1851286@devbig257.prn2.facebook.com>
 <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
 <20150114163006.GA3575264@devbig257.prn2.facebook.com>
 <CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>
 <20150114171328.GA3636164@devbig257.prn2.facebook.com>
 <CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50263 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbAOJ2i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 04:28:38 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>

On Wed, Jan 14, 2015 at 09:37:30AM -0800, Dan Williams wrote:
> libsas uses the libata allocated tag for NCQ.  libsas first asks
> libata to allocate a tag/qc for ncq, then it creates a sas_task and
> assigns the scsi tag.  To use a generic allocator I assume you would
> need to flip that ordering to allocate the sas_task tag first and then
> use that plus another key to allocate a sub-tag for ata to use for
> NCQ.

As far as I can tell all libsas drivers as well as ipr use block
layer tagging, so they always get requests/scsi_cmnds with a tag
already assigned. For libsas drivers currently use per-LUN tags,
although with scsi-mq we will get per-host tags.

libata on the other hand at the moment assigns it's own tags,
which are only stored in struct ata_queued_cmd, but never in the
request. libata assigns tags per ata_host.  Each ata_host
might have multiple ports, which each get their own Scsi_Host
allocated.

Given that ATA NCQ has a fairly low queue depth I assume we want
to stick to assigning ATA tags per-device, but due to the host
per device scheme libata that even works using scsi-mq. (Q: how do tags
work when port mulipliers are involved?)

So for SAS driver using libata we will need a separate tag allocator,
but that one might as well be in libsas instead of keeping it in libata.
