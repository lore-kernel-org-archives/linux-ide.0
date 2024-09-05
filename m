Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627219AA72;
	Thu,  5 Sep 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540034; cv=none; b=ZKOUyHGGsbywmlYimTYKnYHd/Cgx+C34CPzJtZY72Sp2b40TiolWQMgFZG8eUe3GYaqWsepVMDwZJ/Tyz8fzIGpoEEBOXaBXs/2thSTd6Ijbp1mwjr9xdqm/7tGncJGMRughjd0k3MwdhavsCp8f5zRDCDTsAQhmyBEX67qR98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540034; c=relaxed/simple;
	bh=b7VzZPMKbd09QlA5fD+GT4N8lHfOosj//nUPuzFz9as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+MjWUjAa/ZMG0bMAHWhQmqFUAAEmiiyLzL6S+9R5MI2vSuWeLmJDnug/90wYo0wnX5Drj2/lUlfkGGdjvFKVL5wK2DXO870lDUcRpUrunJHq5jXQ+0vU6UKI/URzyJvmx4+aMuUmS4KtcmGDFg8hZ2efZbik41MELTBDPJKBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dviBYCk0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dviBYCk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3244C4CED0;
	Thu,  5 Sep 2024 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540033;
	bh=b7VzZPMKbd09QlA5fD+GT4N8lHfOosj//nUPuzFz9as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dviBYCk0Snx99j3f9Ctx9AXpN+6l3eSqYJAeXRI9AAyX/GBWftdC+rbpDTOuePOOE
	 3btm5K+TEYMaMzXtAGPFVfezJbqMwnV2g/FsWOrxYUGQbwp8cus2J9xAVH2gEj+Sfg
	 2VHqO2lC3rSSJed35kCJUFDBM4Acurvh3B8OylXFTQ+BEygqxbtZkP5EQ5kqHneDaJ
	 5gzJ3swz9Or/BL034DOR2GRlssLbALwCJtbLVpNqrnPOm2F5fpMMaV8I1YzxR+Gxsf
	 7Nyqr6xW9WR122WOZxcvD3jwCPJHzcU2+dANVowELezRnS2F0PYnEpI6XPw06G48Up
	 igcA1iMxKAk2g==
Date: Thu, 5 Sep 2024 14:40:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <ZtmmvNYxkQGZwVwy@ryzen.lan>
References: <20240904223727.1149294-1-ipylypiv@google.com>
 <Ztls4mim6Jky7E0S@ryzen.lan>
 <Ztl5I1Kz53MOEtF4@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztl5I1Kz53MOEtF4@ryzen.lan>

On Thu, Sep 05, 2024 at 11:25:55AM +0200, Niklas Cassel wrote:
> On Thu, Sep 05, 2024 at 10:33:38AM +0200, Niklas Cassel wrote:
> > There are many different paths a QC can take via EH, e.g. policy 0xD NCQ
> > commands will not fetch sense data via ata_eh_request_sense(), so clearing
> > the host byte in ata_scsi_qc_complete() should be fine, otherwise we need
> > to do a similar change to yours in all the different code paths that sets
> > sense data ...which might actually be something that makes sense, but then
> > I would expect a patch series that changes all the locations where we set
> > sense data, not just in ata_eh_analyze_tf(), and then drops the clearing in
> > ata_scsi_qc_complete() (which was introduced in commit 7574a8377c7a ("ata:
> > libata-scsi: do not overwrite SCSI ML and status bytes")).
> 
> I tried to implement the suggestion above, it looks like this:
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e4023fc288ac..ff4945a8f647 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4824,6 +4824,14 @@ void ata_qc_free(struct ata_queued_cmd *qc)
>  		qc->tag = ATA_TAG_POISON;
>  }
>  
> +void ata_qc_set_sense_valid_flag(struct ata_queued_cmd *qc)
> +{
> +	qc->flags |= ATA_QCFLAG_SENSE_VALID;
> +
> +	/* Keep the SCSI ML and status byte, clear host byte. */
> +	qc->scsicmd->result &= 0x0000ffff;

This would have to be:
	/* Keep the SCSI ML and status byte, clear host byte. */
	if (qc->scsicmd)
		qc->scsicmd->result &= 0x0000ffff;

Since for ata_qc_complete_internal(), qc->scsicmd will be NULL.


> +}
> +

(snip)

> I guess the obvious advantage that I can see is that we would do the
> right thing regardless of qc->complete_fn.
> 
> qc->complete_fn can be any of:
> ata_qc_complete_internal()
> ata_scsi_qc_complete()
> atapi_qc_complete()
> ata_scsi_report_zones_complete()
> 
> Instead of only doing the right thing if:
> qc->complete_fn == ata_scsi_qc_complete().
> 
> Thoughts?

ata_scsi_report_zones_complete() calls ata_scsi_qc_complete().
And like I said above, qc->scsicmd is NULL for ata_qc_complete_internal(),
so I guess the one qc->complete_fn that is currently not doing the right
thing is atapi_qc_complete().

However, looking at atapi_qc_complete(), it actually does:

	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
		...
		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
		ata_qc_done(qc);
		return;
	}

	...
	cmd->result = SAM_STAT_GOOD;
	ata_qc_done(qc);

So atapi_qc_complete() will always overwrite the host byte.

So, AFAICT, there is no problematic qc->complete_fn function in the existing
libata code, so I don't think there is any urgency to change the code.

Anyway, I think I came up with an even nicer patch to clear the driver byte.

Change ata_scsi_set_sense():
-to set SENSE_DATA_VALID
-to clear driver byte (if scsicmd)

For the cases that calls:
-scsi_build_sense_buffer()
(because they don't want to set the SAM_STAT_CHECK_CONDITION)
or
-scsi_build_sense()
without using ata_scsi_set_sense():
create a new function/functions (e.g. ata_build_sense_keep_status())
-sets SENSE_DATA_VALID
-clears driver byte (if scsicmd)

Will send a PATCH/RFC series today or tomorrow.


Kind regards,
Niklas
