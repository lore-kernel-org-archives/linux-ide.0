Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08A25BF13
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347196; cv=none; b=CoC3qAcxMlatj22xEcGf5eV+IyxrXjTUjaW9+Edes0q9ySC6Exk94VGZECXq1g6G6kfVMvJ7tyFKYTDCK/gyMxEkhmqozEpd+yp6LMB8gvpocqPco8jUS+1kmKi5x6j8bWozq+B/h0zcF1496pKcs4CjmYop8ELCyH/SQdiKgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347196; c=relaxed/simple;
	bh=AmvT5DZHN/w/BsEwLvhZp8LjKtreRXzkBonA1pECucU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcp6JX/Ao6sGo6M62eMLd8PDxWkdK/OgO53TOndPr+ftdemnzsGPljhmQ9Y1wAS79T6ylzQG0DRlszPdnYJr5bVveD7wjBN2YpLciFYtdof/ozisvNrdn+OaHeY4n8veJr4p2EKuQJaYDbjZwRfQeCv2MbTcp02R7FbfAIsn1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0PmTHpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0PmTHpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64335C16AAE;
	Fri,  2 Jan 2026 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767347195;
	bh=AmvT5DZHN/w/BsEwLvhZp8LjKtreRXzkBonA1pECucU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0PmTHpWKiNlT+vP83pXGHUX0vE8QN7FznBiK6MWFxJZjsyjOBSEKnsuQ2ThpnnHB
	 E5lj9Z1lbojx3kh3HHIAP4nINdZRXuFXVc54O5/DU8ckyFtRt2Q5+4qd36L6ZCoouE
	 Q3MWA+0ZbzcIIReYWCwPsde1W3PqsAdx17xRhTZpbpV3+rTp7EskcGxadiCMaJxp/f
	 Xcit6xKNcmppfpu3OZVULkEwFQ7m20g83kLE20ZsMWWPa3zI11tCy0GUUfCcpVoFrg
	 g3Ax3pd5y30z4x+2GOmI3y0HJfKcAUBV3G8JW4Ld9Eb+5Of+2KL8jTUCuD85bLbxIS
	 guggpMmfuTXyg==
Date: Fri, 2 Jan 2026 10:46:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aVeT9_ZK1NtUXMCT@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org>
 <aVULegmRVY2O-TUC@ryzen>
 <0b9fb4a6-db2d-488d-a486-74c67709b3a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9fb4a6-db2d-488d-a486-74c67709b3a2@kernel.org>

On Fri, Jan 02, 2026 at 10:10:44AM +0900, Damien Le Moal wrote:
> On 12/31/25 20:39, Niklas Cassel wrote:
> > On Sat, Dec 20, 2025 at 09:21:40AM +0900, Damien Le Moal wrote:
> >> @@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
> >>  	if (!ret)
> >>  		return 0;
> >>  
> >> +	/*
> >> +	 * We must defer this qc: if this is not an NCQ command, keep this qc
> >> +	 * as a deferred one and wait for all on-going NCQ commands to complete
> >> +	 * before issuing it with the deferred qc work.
> >> +	 */
> >> +	if (!ata_is_ncq(qc->tf.protocol)) {
> >> +		ap->deferred_qc = qc;
> >> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> > 
> > Here you save the qc, and you return SCSI_MLQUEUE_DEVICE_BUSY;
> > SCSI_MLQUEUE_DEVICE_BUSY will cause the block layer to reinsert the request
> > in the queue, so you will get the same request sent to ata_scsi_translate()
> > again, even though you have save it. A little ugly IMO.
> 
> No it will not cause a requeue in this case because this change:
> 
>  	rc = ata_scsi_defer(ap, qc);
> -	if (rc)
> +	if (rc) {
> +		if (qc == ap->deferred_qc)
> +			return 0;
> 
> ensures that we return "0", thus telling the scsi and block layer that the
> command/request was accepted, but we do *not* call ata_qc_issue() for that qc.
> It is deferred and will be issued by the deferred qc work once the queue drains.

I see how I got confused.

In the case where we store the deferred QC, you overload the return value.
But the original return value did not make sense (SCSI_MLQUEUE_DEVICE_BUSY),
as it means ask upper layer to requeue. I suggest that you let ata_scsi_defer()
return some other value in this case.

ATA_DEFER_ACTION_CMD_STORED or something.

Then at the call site:

	rc = ata_scsi_defer(ap, qc);
	if (rc) {
		if (rc == ATA_DEFER_ACTION_CMD_STORED)
			return 0;
		return rc;
	}


Kind regards,
Niklas
