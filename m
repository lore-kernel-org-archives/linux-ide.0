From: Tejun Heo <tj@kernel.org>
Subject: Re: [sata_mv]: enable FIS Based Switching when a Port Multiplier
 is connected
Date: Sat, 04 Oct 2008 16:19:57 +0900
Message-ID: <48E7191D.7030806@kernel.org>
References: <e7510f760809211336s9b31924x7c243562fd805272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38735 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYJDHV1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 03:21:27 -0400
In-Reply-To: <e7510f760809211336s9b31924x7c243562fd805272@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Gwendal.

Patch was line wrapped.  Can you please repost?

Gwendal Grignou wrote:
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 79e3a8e..fcc7ce2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4607,8 +4607,11 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
>  {
>  	struct ata_port *ap = qc->ap;
> 
> -	qc->result_tf.flags = qc->tf.flags;
> -	ap->ops->qc_fill_rtf(qc);
> +	if ((qc->flags & ATA_QCFLAG_RTF_VALID) == 0) {
> +		qc->result_tf.flags = qc->tf.flags;
> +		qc->flags |= ATA_QCFLAG_RTF_VALID;
> +		ap->ops->qc_fill_rtf(qc);
> +	}
>  }

Please separate out RTF_VALID changes into a separate patch and if
possible please update other LLDs too.  I think I posted RTF_VALID
patch sometime ago and it probably contains changes for other drivers.

>  static void ata_verify_xfer(struct ata_queued_cmd *qc)
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c1db2f2..b5d753e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1518,6 +1518,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  	memcpy(&qc->result_tf, &tf, sizeof(tf));
>  	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
>  	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
> +	qc->flags |= ATA_QCFLAG_RTF_VALID;
>  	ehc->i.err_mask &= ~AC_ERR_DEV;
>  }

Ditto.

> @@ -1642,23 +1643,24 @@ static void mv_pmp_error_handler(struct ata_port *ap)
>  	struct mv_port_priv *pp = ap->private_data;
> 
>  	if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
> -		/*
> -		 * Perform NCQ error analysis on failed PMPs
> -		 * before we freeze the port entirely.
> -		 *
> -		 * The failed PMPs are marked earlier by mv_pmp_eh_prep().
> -		 */
> -		pmp_map = pp->delayed_eh_pmp_map;
>  		pp->pp_flags &= ~MV_PP_FLAG_DELAYED_EH;
> -		for (pmp = 0; pmp_map != 0; pmp++) {
> -			unsigned int this_pmp = (1 << pmp);
> -			if (pmp_map & this_pmp) {
> -				struct ata_link *link = &ap->pmp_link[pmp];
> -				pmp_map &= ~this_pmp;
> -				ata_eh_analyze_ncq_error(link);
> +		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
> +			/*
> +			 * Perform NCQ error analysis on failed PMPs
> +			 * before we freeze the port entirely.
> +			 *
> +			 * The failed PMPs are marked earlier by mv_pmp_eh_prep().
> +			 */
> +			pmp_map = pp->delayed_eh_pmp_map;
> +			for (pmp = 0; pmp_map != 0; pmp++) {
> +				unsigned int this_pmp = (1 << pmp);
> +				if (pmp_map & this_pmp) {
> +					struct ata_link *link = &ap->pmp_link[pmp];
> +					pmp_map &= ~this_pmp;
> +					ata_eh_analyze_ncq_error(link);
> +				}

I don't have much idea what's going on here but it looks like
DELAYED_EH clearing is gone.  Is this intended?

I'll try to review deeper on your next posting.  If I can tell it's
gonna be okay, I'll include it into #tj-upstream.  Don't depend on it
as I don't know much about sata_mv but Mark will be away for several
more weeks, so I'll try my best but if I can't tell whether it's okay
or not I'll put it into a separate branch and push it to #linux-next.

Thanks.

-- 
tejun
