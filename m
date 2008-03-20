From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] disk-protect: Add disk shock protection helpers to
 libata
Date: Thu, 20 Mar 2008 14:13:48 +0000
Message-ID: <20080320141348.7a5ca570@core>
References: <87skzgd1zk.fsf@denkblock.local>
	<20080226123946.75dbe3d2@core>
	<87mypl8p49.fsf@denkblock.local>
	<20080228111349.6831925c@core>
	<87bq5qfm2v.fsf@denkblock.local>
	<20080307181750.9981.88028.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46435 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753949AbYCTO3Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 10:29:25 -0400
In-Reply-To: <20080307181750.9981.88028.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> +	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
> +	if (err_mask)
> +		goto abort;

We assume you never use ata_exec_internal on a "live" to block layer
device, so this doesn't work for the general case. In the EH handler for
unparking it should be fine as the EH thread runs with the drive queue
shut down.


> +static inline int ata_id_has_unload(const u16 *id)
> +{
> +	/* ATA-7 specifies two places to indicate unload feature support.
> +	 * Since I don't really understand the difference, I'll just check
> +	 * both and only return zero if none of them indicates otherwise. */

Probably wise and we can fix that once it is obvious what reality is
using.

>
