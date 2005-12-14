From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/7] SATA suspend/resume support (Jens)
Date: Wed, 14 Dec 2005 17:07:38 -0500
Message-ID: <43A097AA.5050105@pobox.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com> <20051213160245.020457a4.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965006AbVLNWHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:07:48 -0500
In-Reply-To: <20051213160245.020457a4.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe@suse.de

Randy Dunlap wrote:
> From: Jens Axboe <axboe@suse.de>
> 
> Add libata suspend/resume support.
> 
>  drivers/scsi/ata_piix.c    |    4 +
>  drivers/scsi/libata-core.c |  122 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-scsi.c |   16 +++++
>  drivers/scsi/scsi_sysfs.c  |   35 ++++++++++++
>  include/linux/ata.h        |    2 
>  include/linux/libata.h     |    7 ++
>  include/scsi/scsi_host.h   |    6 ++
>  7 files changed, 190 insertions(+), 2 deletions(-)

What happened to the patch you were attempting to resurrect, which 
implemented scsi suspend/resume a better way?

	Jeff



