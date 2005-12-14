From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 1/7] SATA suspend/resume support (Jens)
Date: Wed, 14 Dec 2005 14:22:12 -0800
Message-ID: <20051214142212.20c1b729.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
	<20051213160245.020457a4.randy_d_dunlap@linux.intel.com>
	<43A097AA.5050105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:50874 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965027AbVLNWSx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 17:18:53 -0500
In-Reply-To: <43A097AA.5050105@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, axboe@suse.de

On Wed, 14 Dec 2005 17:07:38 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > From: Jens Axboe <axboe@suse.de>
> > 
> > Add libata suspend/resume support.
> > 
> >  drivers/scsi/ata_piix.c    |    4 +
> >  drivers/scsi/libata-core.c |  122 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/scsi/libata-scsi.c |   16 +++++
> >  drivers/scsi/scsi_sysfs.c  |   35 ++++++++++++
> >  include/linux/ata.h        |    2 
> >  include/linux/libata.h     |    7 ++
> >  include/scsi/scsi_host.h   |    6 ++
> >  7 files changed, 190 insertions(+), 2 deletions(-)
> 
> What happened to the patch you were attempting to resurrect, which 
> implemented scsi suspend/resume a better way?

The last incarnation of it is still at
  http://www.xenotime.net/linux/scsi/scsi-susres-devattr.patch

It is missing some linkage (maybe ->ops) between layers.
I was getting close to zero feedback on it --> it went stale,
so I decided to try make make Jens's patch work with ACPI
additions.

---
~Randy
