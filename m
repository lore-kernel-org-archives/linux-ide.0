Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEAF383329
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551031; cv=none; b=k5/Z+UcqUoqAlE1Feap4J2OzZPVtRnby9D5jbzbHvf0C0VQ5KlMe9+zDp7uwC5viOBYjBbQDSKvk+WM1vipz1ieala8zHUeZPKB2FHt6cAR+MvwELJ4nWnSN4mQJR1q7BJ3oqS2devAjV9JGWdNAuPp73Mofnr8bHb8nxjx4nfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551031; c=relaxed/simple;
	bh=7mc1Gb3Z9edllzpULXX65OVmWzVvNpmTmIXQl6e+Bp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahMhKvv5IY0DbTBroPyLRgOjBon5Z3K4VYmtff6DSZ5/W34pMts6rV5U8j1BzCWdK6ufX2qTQHKeinJl9L9bLQsBkZV2gw4F9/PU3IMfNlnvNxAvso2KmCkhny9b5nXtZAEqaRmZX+uC0lNLSt2r/k/q5TejJmPc9amTx/i1Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5W7yDvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5W7yDvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A872C2BCB0;
	Tue, 12 May 2026 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551031;
	bh=7mc1Gb3Z9edllzpULXX65OVmWzVvNpmTmIXQl6e+Bp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a5W7yDvc5WUCnYYIdRqa4AU336O9YTOIC/qZwrVZDBDjTDmubxdzgMkWzT8/R65JH
	 uvyAt002zUkuCmBmW9ONCoVnuntiy5YX5Xv1mHVz/m+3s1c6yEVBQBfWJeegx4gwe3
	 3b4C3tsVXuF+z9ttgzKu0mPCuYDwGu/ROc5WFVSMJIbAhbNyIiJE0TEWscIhXnsQrh
	 GL6GMjGprPx50N+iR9rcByDl3ABsN9Zcqa92Wf+qanZroZ32SpqzqO+hOY4NBs1VI/
	 nHa5+p5uSy6nr+bQqnqUR5xr0+ylWvQhIKCYLI/zKYY3yBNEFsNxaN2Dr232fWFKxq
	 O6ngMx+cAdFeQ==
Message-ID: <5aeae334-3bcb-42c6-a779-f07589d49748@kernel.org>
Date: Tue, 12 May 2026 10:57:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-scsi: do not use the deferred QC
 feature on PMPs with CBS
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260508193240.176735-4-cassel@kernel.org>
 <20260508193240.176735-5-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260508193240.176735-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 04:32, Niklas Cassel wrote:
> When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
> can only issue commands to one link at a time. For PMPs with CBS, there is
> already code to handle commands being sent to different links in
> sata_pmp_qc_defer_cmd_switch() using ap->excl_link.
> 
> A user on the list reported that commit 0ea84089dbf6 ("ata: libata-scsi:
> avoid Non-NCQ command starvation") broke PMPs with CBS. The commit
> introduced code that stores a deferred qc in ap->deferred_qc, to later be
> issued via a workqueue. It turns out that this change is incompatible with
> the existing ap->excl_link handling used by PMPs with CBS.
> 
> Thus, modify sata_pmp_qc_defer_cmd_switch() code to return
> ATA_DEFER_PORT_PMP_CBS and ATA_DEFER_LINK_PMP_CBS, and make sure that the
> deferred QC handling via workqueue is not used for these return values.
> 
> This way, PMPs with CBS will work once again. Note that the starvation
> referenced in commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ
> command starvation") can only happen on libsas ports, and libsas does not
> support Port Multipliers, thus there is no harm of reverting back to the
> previous way of deferring commands for PMPs with CBS.
> 
> Non-libsas ports connected to anything but a PMP with CBS (e.g. a normal
> drive or a PMP with FBS) will continue using the deferred workqueue, since
> it does result in lower completion latencies for non-NCQ commands, even
> though the workqueue is not strictly needed to avoid starvation for
> non-libsas ports.
> 
> If we want to modify the scope of the workqueue issuing to also handle
> PMPs with CBS, then we should ensure that we can save both NCQ and non-NCQ
> commands in ap->deferred_qc, while also removing the existing PMP CBS
> handling using ap->excl_link, such that we don't duplicate features.
> 
> While at it, also add a comment explaining how the ap->excl_link mechanism
> works.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me. See some nits below.

> ---
>  drivers/ata/libata-pmp.c  | 24 ++++++++++++++--
>  drivers/ata/libata-scsi.c | 58 ++++++++++++++++++++++++---------------
>  include/linux/libata.h    |  2 ++
>  3 files changed, 60 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index e3adc008fed1..d847bdff6d0a 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -113,14 +113,34 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
>  
>  	if (ap->excl_link == NULL || ap->excl_link == link) {
>  		if (ap->nr_active_links == 0 || ata_link_active(link)) {
> +			int ret;
> +
>  			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
> -			return ata_std_qc_defer(qc);
> +			ret = ata_std_qc_defer(qc);
> +			switch (ret) {
> +			case 0:
> +				return ret;
> +			case ATA_DEFER_LINK:
> +				return ATA_DEFER_LINK_PMP_CBS;
> +			case ATA_DEFER_PORT:
> +				return ATA_DEFER_PORT_PMP_CBS;
> +			default:
> +				WARN_ON_ONCE(1);
> +				return ATA_DEFER_PORT_PMP_CBS;
> +			}
>  		}
>  
> +		/*
> +		 * Note: ap->excl_link contains the link that is next in line,
> +		 * i.e. implicit round robin. If there is only one link
> +		 * dispatching, ap->excl_link will be left unclaimed, allowing
> +		 * other links to set ap->excl_link, ensuring that the currently
> +		 * active link cannot queue any more.
> +		 */
>  		ap->excl_link = link;
>  	}
>  
> -	return ATA_DEFER_PORT;
> +	return ATA_DEFER_PORT_PMP_CBS;
>  }
>  
>  /**
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f44612e269a4..6f273c5d0cd3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1767,7 +1767,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	int ret;
>  
>  	if (!ap->ops->qc_defer)
> -		goto issue;
> +		goto issue_qc;
>  
>  	/*
>  	 * If we already have a deferred qc, then rely on the SCSI layer to
> @@ -1783,38 +1783,52 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
>  	ret = ap->ops->qc_defer(qc);
>  	switch (ret) {
>  	case 0:
> -		break;
> +		goto issue_qc;

Please keep the break here (see below).

>  	case ATA_DEFER_LINK:
>  		ret = SCSI_MLQUEUE_DEVICE_BUSY;
> -		break;
> +		goto store_qc;
>  	case ATA_DEFER_PORT:
>  		ret = SCSI_MLQUEUE_HOST_BUSY;
> -		break;
> +		goto store_qc;
> +	case ATA_DEFER_LINK_PMP_CBS:
> +		/*
> +		 * PMP in CBS mode has independent handling using ap->excl_link
> +		 * that is incompatible with ap->deferred_qc workqueue handling.
> +		 */
> +		ret = SCSI_MLQUEUE_DEVICE_BUSY;
> +		goto free_qc;
> +	case ATA_DEFER_PORT_PMP_CBS:
> +		/*
> +		 * PMP in CBS mode has independent handling using ap->excl_link
> +		 * that is incompatible with ap->deferred_qc workqueue handling.
> +		 */
> +		ret = SCSI_MLQUEUE_HOST_BUSY;
> +		goto free_qc;

The repeated comment is not great... What about writing this like this ?

+	case ATA_DEFER_LINK_PMP_CBS:
+	case ATA_DEFER_PORT_PMP_CBS:
+		/*
+		 * PMP in CBS mode has independent handling using ap->excl_link
+		 * that is incompatible with ap->deferred_qc workqueue handling.
+		 */
+		if (ret == ATA_DEFER_LINK_PMP_CBS)
+			ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		else
+			ret = SCSI_MLQUEUE_HOST_BUSY;
+		goto free_qc;

>  	default:
>  		WARN_ON_ONCE(1);
>  		ret = SCSI_MLQUEUE_HOST_BUSY;
> -		break;
> +		goto free_qc;
>  	}
>  
> -	if (ret) {
> -		/*
> -		 * We must defer this qc: if this is not an NCQ command, keep
> -		 * this qc as a deferred one and report to the SCSI layer that
> -		 * we issued it so that it is not requeued. The deferred qc will
> -		 * be issued with the port deferred_qc_work once all on-going
> -		 * commands complete.
> -		 */
> -		if (!ata_is_ncq(qc->tf.protocol)) {
> -			ap->deferred_qc = qc;
> -			return 0;
> -		}
> -
> -		/* Force a requeue of the command to defer its execution. */
> -		ata_qc_free(qc);
> -		return ret;
> +store_qc:

defer_qc would be a better name since we do not necessarily "store" it

> +	/*
> +	 * We must defer this qc: if this is not an NCQ command, keep
> +	 * this qc as a deferred one and report to the SCSI layer that
> +	 * we issued it so that it is not requeued. The deferred qc will
> +	 * be issued with the port deferred_qc_work once all on-going
> +	 * commands complete.
> +	 */
> +	if (!ata_is_ncq(qc->tf.protocol)) {
> +		ap->deferred_qc = qc;
> +		return 0;
>  	}
>  
> -issue:
> +free_qc:
> +	/* Force a requeue of the command to defer its execution. */
> +	ata_qc_free(qc);
> +	return ret;
> +
> +issue_qc:
>  	ata_qc_issue(qc);
>  
>  	return 0;

Since this is the normal case most of the time, let's keep it at the top, right
after the switch/case so that we can simply break in that switch.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5c085ef4eda7..511cdf1a6650 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -371,6 +371,8 @@ enum {
>  	/* return values for ->qc_defer */
>  	ATA_DEFER_LINK		= 1,
>  	ATA_DEFER_PORT		= 2,
> +	ATA_DEFER_LINK_PMP_CBS	= 3,
> +	ATA_DEFER_PORT_PMP_CBS	= 4,
>  
>  	/* desc_len for ata_eh_info and context */
>  	ATA_EH_DESC_LEN		= 80,


-- 
Damien Le Moal
Western Digital Research
