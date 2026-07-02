Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A78426400;
	Thu,  2 Jul 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998731; cv=none; b=KiVdb/VjV1yRs9sjH+qOUyNMyRV/hNenceSR95KydypkqCisrzmIEJ1DasqimZp6hHyyokvOcSIGMjRzkkgoTDO6zzZegOsVq1MwDzVzesASj71e36ZnwgmFtPi4MGmqjJGsjNCQBBgY430vALKeauBqGYrDge3KDEmsXGhj4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998731; c=relaxed/simple;
	bh=bGrc03pYKtkmnfLtcffGwn6lxZ0wW8YjEleva6L91uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3rXNf1Glxk0Oq0Hj6IiXGj18N59SwClMEIOFVkRSgyYNcooqJdLv1MUHom/kbSQRXAkYWdW5aaWzoT85THdbC/hMDZVylFiKl7cKXG7nZdQX9hYwsNw2G42GIRlmIs/7BVdKeA/nloTHP3+38YugtiUlA+TLeEIrrMkKSZXaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD7mweOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD7mweOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCB61F000E9;
	Thu,  2 Jul 2026 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782998730;
	bh=HbiHxjldhTPSPFtd/wOTknWf4TrHjI+oOqbikIFhhck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bD7mweORhkEJ875eZQ8AmxJWSZZl3ZtH4nhoXz1OhGfqaiKASb30PBfkH+JN6fKba
	 5VuYdzs3OEtxlqRCvXgFAlswUbzugZ5CyTBhW9MVrLd7eTDAjc9VR6D+uCtHnKHt4O
	 2XykQ+CTtjhsaUlrjyaX9V080HCnlk0ntFWFGdYNBTslfKVzb5J9bwPeZQl2KYMj+C
	 7yXV7yrZg82bpb/v1EFXLrGb5YgdH61rRIvEri9swn87finrM4zjeXD/CgmkyUl/4v
	 A0XLGyTuUStx4+Qo50nCCEx2jzXBFmFAKj5ON7PBN6I+Ffm+QYrHHJignJS5t22HeU
	 MAayx/LJoL6IQ==
Date: Thu, 2 Jul 2026 15:25:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
Message-ID: <akZmx5L1HLsb7-wk@ryzen>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
 <20260702065321.07EB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702065321.07EB51F000E9@smtp.kernel.org>

On Thu, Jul 02, 2026 at 06:53:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] WRITE_SAME_16 is unconditionally reported as supported via REPORT SUPPORTED OPERATION CODES, even for devices that do not support TRIM.
> --
>
> commit b8e6e9f4e6e3177fe0e766704af6b504468c2de3
> Author: Damien Le Moal <dlemoal@kernel.org>
>
> ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
>
> This commit refactors ata_scsi_report_supported_opcodes() to use an array
> of supported commands for easier modifications and extensions. It also adds
> handling for WRITE_SAME_16 and VARIABLE_LENGTH_CMD to the list of commands
> which libata-scsi translates.
>
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 8811bfc373697..4f0ae44f59dd2 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> [ ... ]
> > +static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
> > +				      struct ata_scsi_cmd_support *sup)
> > +{
> > +	const struct ata_scsi_cmd *cmd;
> > +
> > +	/* First, see if we support the command. */
> > +	cmd = ata_scsi_get_supported_cmd(op);
> > +	if (!cmd)
> > +		return false;
> > +
> > +	/* Now refine the support report depending on the device features. */
> > +	memset(sup, 0, sizeof(*sup));
> > +	switch (op) {
> > +	case READ_16:
> [ ... ]
> > +	case ZBC_IN:
> > +	case ZBC_OUT:
> > +		return ata_dev_is_zoned(dev);
> > +	case SECURITY_PROTOCOL_IN:
> > +	case SECURITY_PROTOCOL_OUT:
> > +		return dev->flags & ATA_DFLAG_TRUSTED;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return true;
> > +}
>
> [Severity: Medium]
> Should WRITE_SAME_16 be refined here to check for TRIM support?

No, AFAICT, libata should not expose WRITE SAME (16) support, regardless if
TRIM is supported or not.


In ata_scsi_write_same_xlat(), we have:

/*
 * We only allow sending this command through the block layer,
 * as it modifies the DATA OUT buffer, which would corrupt user
 * memory for SG_IO commands.
 */
if (unlikely(blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))))
	goto invalid_opcode;

This means that we will always reject a WRITE SAME (16) passthrough command.

Additionally, in ata_scsi_sdev_config(), we have sdev->no_write_same = 1;


Thus the only way we can reach ata_scsi_write_same_xlat() is via the block
layer.

Block layer commands that can reach ata_scsi_write_same_xlat():

REQ_OP_WRITE_ZEROES:
In sd.c, sd_setup_write_zeroes_cmnd() we have:
if (sdp->no_write_same) return BLK_STS_TARGET;

So REQ_OP_WRITE_ZEROES will not reach ata_scsi_write_same_xlat().


REQ_OP_DISCARD:
In sd.c, REQ_OP_DISCARD builds a WRITE_SAME_16 with the UNMAP bit and never
consults no_write_same. provisioning_mode == SD_LBP_WS16 is chosen by
sd_discard_mode() purely from the LBP/thin-provisioning bits
(lbpme, lbpws - both of which libata advertises for a TRIM device), again
independent of no_write_same.

So a libata TRIM device ends up with no_write_same = 1 and
provisioning_mode = SD_LBP_WS16 simultaneously, and every discard is a
WRITE SAME(16) UNMAP that lands in ata_scsi_write_same_xlat() -> DSM TRIM.

That's exactly the intended arrangement: no_write_same turns off the
"write a pattern" use while leaving discard working.

This seems correct as ATA has no way to splat an arbitrary pattern across
many blocks in one command.


Kind regards,
Niklas
