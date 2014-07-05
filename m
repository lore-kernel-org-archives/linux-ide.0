From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Sat, 5 Jul 2014 16:00:55 -0400
Message-ID: <20140705200055.GB3069@mtj.dyndns.org>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703134717.GA16191@htj.dyndns.org>
 <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
 <20140704153022.GA764@mtj.dyndns.org>
 <20140705132134.GA15232@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:53587 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060AbaGEUA7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2014 16:00:59 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so2390775qgd.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 13:00:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140705132134.GA15232@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

Hello, Kevin.

On Sat, Jul 05, 2014 at 09:21:34PM +0800, Kevin Hao wrote:
> @@ -1570,15 +1572,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
...
> +	/* Tag 0 is used as some drivers choke if any other tag is given. */
> +	tag = 0;

If we switch to using a qcflag for marking internal commands, it
probably would be better to guarantee that EH commands always use tag
0.

> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 5ab4e3a76721..74612875b198 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -265,6 +265,7 @@ enum {
>  	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
>  	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
>  	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
> +	ATA_QCFLAG_INTERNAL	= (1 << 19), /* Internal command */

Let's make it more explicit - ATA_QCFLAG_EH.

> +static inline unsigned int ata_tag_internal(struct ata_queued_cmd *qc)
> +{
> +	return (qc->flags & ATA_QCFLAG_INTERNAL);
> +}

As we're changing the interface anyway, ata_qc_eh()?

> > Anyways, sata_fsl already has workaround for ATA_TAG_INTERNAL, right?
> 
> Yes, the internal command is mapped to tag 0 in sata_fsl.
> 
> > Given that the situation around internal tag handling may change, I'm
> > not sure about changing the interface now.  Is it a lot of cruft on
> > fsl side?
> 
> Yes, I agree.

So, yeah, I like the proposed changes.  This is a bit too much as a
fix for fsl tho.  First fix fsl and then update so that we use the
qcflag in the devel branch?

Thanks.

-- 
tejun
