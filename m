From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Fix HDIO_DRIVE_RESET handling
Date: Tue, 24 Jun 2008 00:41:45 +0200
Message-ID: <200806240041.46109.bzolnier@gmail.com>
References: <87k5gmz596.fsf@denkblock.local> <87wskhuk98.fsf@denkblock.local> <87r6apuk16.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:15980 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYFWWqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2008 18:46:08 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2504423fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 23 Jun 2008 15:46:06 -0700 (PDT)
In-Reply-To: <87r6apuk16.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>


On Monday 23 June 2008, Elias Oltmanns wrote:
> Currently, the code path executing an HDIO_DRIVE_RESET ioctl is broken
> in various ways.  Most importantly, it is treated as an out of band
> request in an illegal way which may very likely lead to system lock ups.
> Use the drive's request queue to avoid this problem (and fix a locking
> issue for free along the way).
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

[...]

> +		} else if (!rq->rq_disk && blk_special_request(rq))
> +			/*
> +			 * TODO: Once all ULDs have been modified to
> +			 * check for specific op codes rather than
> +			 * blindly accepting any special request, the
> +			 * echeck for ->rq_disk above may be replaced

'echeck' typo.

[...]

> +static inline void ide_complete_drive_reset(ide_drive_t *drive)
> +{
> +	struct request *rq = HWGROUP(drive)->rq;
> +
> +	if (rq && blk_special_request(rq) && rq->cmd[0] == REQ_DRIVE_RESET)

Shouldn't we be also checking for !rq->rq_disk here?

[ also HWGROUP() macro is on its way out ]

Otherwise OK.
