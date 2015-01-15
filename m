From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 10:02:09 -0500
Message-ID: <20150115150209.GA25903@htj.dyndns.org>
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
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:52566 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbbAOPCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 10:02:14 -0500
Received: by mail-qa0-f41.google.com with SMTP id bm13so11425827qab.0
        for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 07:02:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150115092836.GA14051@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Shaohua Li <shli@fb.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>

Hello,

On Thu, Jan 15, 2015 at 01:28:36AM -0800, Christoph Hellwig wrote:
> libata on the other hand at the moment assigns it's own tags,
> which are only stored in struct ata_queued_cmd, but never in the
> request. libata assigns tags per ata_host.  Each ata_host

Per ata_port.

> might have multiple ports, which each get their own Scsi_Host
> allocated.
>
> Given that ATA NCQ has a fairly low queue depth I assume we want
> to stick to assigning ATA tags per-device, but due to the host
> per device scheme libata that even works using scsi-mq. (Q: how do tags
> work when port mulipliers are involved?)

It's still per-port.  The same number of tags are shared among all
devices attached via PMs.

Thanks.

-- 
tejun
