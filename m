Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDF1D5151;
	Sun, 12 Apr 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775990572; cv=none; b=Cf3I55kh5eMgYfgNknn1aIBEFXb8my2RS+sVtopdqsljN6d8PJgG3QHgRDalGLBVOS/djaSFjBmilQDc8J6wxZbeKGM30ZvzBFsmplwj8NJkea7cpNZF92fhUK+0jEfqvy87ZVOoc/cf8VC5q8yCT1DUfzeWjYp817Q+7EHS33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775990572; c=relaxed/simple;
	bh=AZbOoikGmncQ+1zfs/8uAtJ8jAVI+LGDVPzQ/NHMwkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsr3XK+HKWuXSrhiucGtXB4GhqBbQp8Hl+JWH5MZTmaDCabLGTJb32eMlRqzDRZLEm/I/yZFwR8uv/TeOZouCcmJj0mFYh1fK9YO9YmNQwG7qE41Y1n6WlhiCfd37VNH+IAt6MoDQBXTdCsEJOWkmpdOI9l4X0J+RwWn5MLLWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0UMKbwr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0UMKbwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C671C19424;
	Sun, 12 Apr 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775990571;
	bh=AZbOoikGmncQ+1zfs/8uAtJ8jAVI+LGDVPzQ/NHMwkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0UMKbwrNw3CAFkVCW/x7t5fW5uYj/26cZm1KFdqratQd9nDi+CFR0SCGP5hFhZVn
	 QEiAUH/KiuScAorTTgsMUeC4FiISzFUePjTt7EQ7eXS1iHLiSeErWAzuc1kQjowREf
	 M/V4NWDzAFRkmscRIOKZI+J8BwZajO8bHArrb1GogahNESTNj9FR1j0s8Yc79NnzFW
	 ojX6Hp5eTOIvRBfv49Oq2rQjsuxaPQcjzh29ITYSmQ5ddTzmFc2GbAKGIJRRYl1shz
	 ihE+1sB6gny20OzfUG5qFEDvKlX6rfvcymRrNYFUN6raTr6Gx1C1liTW8qHQegPt6z
	 KNuiB3CNyVIsw==
Date: Sun, 12 Apr 2026 12:42:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Xingui Yang <yangxingui@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: fix requeue of deferred ATA
 PASS-THROUGH commands
Message-ID: <adt3JqwFcDx-Xe30@fedora>
References: <20260410231519.951971-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410231519.951971-1-ipylypiv@google.com>

On Fri, Apr 10, 2026 at 04:15:19PM -0700, Igor Pylypiv wrote:
> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced ata_scsi_requeue_deferred_qc() to handle commands deferred
> during resets or NCQ failures. This deferral logic completed commands
> with DID_SOFT_ERROR to trigger a retry in the SCSI mid-layer.
> 
> However, DID_SOFT_ERROR is subject to scsi_cmd_retry_allowed() checks.
> ATA PASS-THROUGH commands sent via SG_IO ioctl have scmd->allowed set
> to zero. This causes the mid-layer to fail the command immediately
> instead of retrying, even though the command was never actually issued
> to the hardware.
> 
> Switch to DID_REQUEUE to ensure these commands are inserted back into
> the request queue regardless of retry limits.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3b65df914ebb..0236394900cc 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1692,7 +1692,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	/*
>  	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
>  	 * do not try to be smart about what to do with this deferred command
> -	 * and simply retry it by completing it with DID_SOFT_ERROR.
> +	 * and simply requeue it by completing it with DID_REQUEUE.
>  	 */
>  	if (!qc)
>  		return;
> @@ -1701,7 +1701,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	ap->deferred_qc = NULL;
>  	cancel_work(&ap->deferred_qc_work);
>  	ata_qc_free(qc);
> -	scmd->result = (DID_SOFT_ERROR << 16);
> +	set_host_byte(scmd, DID_REQUEUE);

set_host_byte() will set the host byte, but it will keep the status byte
and the ML byte intact.

By using the assignment operator, I assumed that Damien intentionally
wanted to clear the status byte and the ML byte.

My point is that using set_host_byte() is a logical change.
If we want to stop clearing the status byte and the ML byte, then I think
that change should be in a separate commit, with a proper motivation/commit
message.

However, for the fix patch itself, I think we should just do:
-	scmd->result = (DID_SOFT_ERROR << 16);
+	scmd->result = (DID_REQUEUE << 16);


If that is sufficient to fix your observed problem.

I would also be happy to see a follow up patch that changes to use
set_host_byte(), if there is a motivation that can motivate why that change
is safe/valid.


Kind regards,
Niklas
