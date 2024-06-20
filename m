Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB694F211;
	Thu, 20 Jun 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893456; cv=none; b=jQw0Ur48fYFJvNHqoIXr4YW+4qUtTUR39Ep359lj9BhZMOCs2uGldLb3qOJm00jwL2tK1rM8kcAs9P/GahPhqKrvszrqrwMhVgCOkQm362HKiA+fLdGWcdNUmdAr55pOs8aIn/CM6DFmue5VDTnobu/Z892tnRiKQit5WnPyJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893456; c=relaxed/simple;
	bh=ETZWUt7xyCwGE4R3jrxnsb21YfXHAakfK1Gr356U4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oub+knnPEw3f8YKryx6lQH/A/yW0b03OWT54W8gct6wBMwU8aizpFESPxHhXFzryIW1rZZjJhnLBrWndIep2Mdaye6Q+oEHdYuIcE5Z5n9cp4Jf7YH5p4wuEKjc5UrL26bpLxpsW8DNtragnIjXXw/shRdgZ6KkFWYCVyTy4KMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOxo3rjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOxo3rjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52FFC2BD10;
	Thu, 20 Jun 2024 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893456;
	bh=ETZWUt7xyCwGE4R3jrxnsb21YfXHAakfK1Gr356U4TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOxo3rjDL+nQ6tZdArV2ps9kpS6geTM1we4BTlek/G84V3Dnej/yY84gpPCruUhkV
	 lwv2x0YWsyx0THn3Lgk9Bzx7KOX4kl2y/+5JOueHg1rEpxwXk9Ta8gKdQ+vFGhblOJ
	 a/P1TS7vw2mdZZsuN8zOG2rX/eLaeGJsbTC3i4OKc+YqCL5RvualgATVyZD9rlUtPx
	 cW7Y9KiXohS1YZI6IR5J8RY+GyFbq0cTdQf88KdAdC82T/By2ERHD1OTEGUnAOyTCv
	 CVMvwWg8CgMvOIWNsPnLXI4a+wSHb3uwxjd5ZrFVSAMLNUYPSOX6z4Z0u7BI30P3vI
	 1UDKxU7E9NgVA==
Date: Thu, 20 Jun 2024 16:24:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnQ7i0D4syhhI_hO@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <ZnAUy5C-DXEuliSm@ryzen.lan>
 <ZnDHZWZQFtUmwtwE@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnDHZWZQFtUmwtwE@google.com>

On Mon, Jun 17, 2024 at 11:31:49PM +0000, Igor Pylypiv wrote:
> On Mon, Jun 17, 2024 at 12:49:47PM +0200, Niklas Cassel wrote:
> > On Fri, Jun 14, 2024 at 07:18:34PM +0000, Igor Pylypiv wrote:
> > > Do not generate sense data from ATA status/error registers
> > > if valid sense data is already present.
> > > 
> > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > ---
> > >  drivers/ata/libata-scsi.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > > index 79e8103ef3a9..4bfe47e7d266 100644
> > > --- a/drivers/ata/libata-scsi.c
> > > +++ b/drivers/ata/libata-scsi.c
> > > @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> > >  	unsigned char *desc = sb + 8;
> > >  	u8 sense_key, asc, ascq;
> > 
> > Like I suggested in the earlier patch,
> > 
> > can't you do a:
> > 
> > if (qc->flags & ATA_QCFLAG_SENSE_VALID)
> > 	return;
> > 
> > here instead?
> > 
> 
> We need to populate the "ATA Status Return sense data descriptor" as per SAT-5
> "Table 209 — ATA command results". By returning early we are skipping the code
> that copies ATA output fields into descriptor/fixed sense data buffer.

We might get sense data from the drive.
If we use REQUEST SENSE DATA EXT, we will get SK/ASC/ASCQ,
we will then call scsi_build_sense_buffer() which will generate
sense data in either the descriptor format or the fixed format,
based on the D_SENSE bit, which is set in the control mode page.

The user can toggle this bit, see:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-scsi.c#L3691-L3694

But by default it is 0:
https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-scsi.c#L86
which means fixed format.

This all seems to be in accordance with
"Table 209 — Returned sense data with the CK_COND bit set to one"
in sat6r1.



When calling scsi_build_sense_buffer(), we supply:
scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
                        cmd->sense_buffer, tf.lbah,
                        tf.lbam, tf.lbal);

so we do not supply the STATUS and ERROR fields when building the sense data.

This seems fine, since SCSI has no knowledge of ATA status or ATA error.


However, for ATA-passthrough commands, ATA status and ATA error fields
are part of either the COMMAND-SPECIFIC information in the fixed format
case, or part for the descriptor format, in case of the descriptor type
being ATA Status Return sense data descriptor.


So what I think we should do:
1) Keep the sense data if it exists, and fill in
   the ATA status and ATA error at the correct offset (depending on if
   the existing sense data is in fixed format or descriptor format).
2) If there doesn't exist any sense data, generate it, including the
   ATA passthru command specific fields (ATA status and ATA error).
   This is basically what ata_gen_passthru_sense() does today.


So something like this:
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bb4d30d377ae..a0687eb28ff7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1645,9 +1645,17 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
         * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
         */
        if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-           ((cdb[2] & 0x20) || need_sense))
-               ata_gen_passthru_sense(qc);
-       else if (need_sense)
+           ((cdb[2] & 0x20) || need_sense)) {
+               if ((qc->flags & ATA_QCFLAG_SENSE_VALID)) {
+                       /*
+                        * ATA PASS-THROUGH commands also need to fill in the
+                        * command specific ATA status and ATA error fields.
+                        */
+                       ata_fill_passthru_specific_sense_fields(qc);
+               } else {
+                       ata_gen_passthru_sense(qc);
+               }
+       } else if (need_sense)
                ata_gen_ata_sense(qc);
        else
                /* Keep the SCSI ML and status byte, clear host byte. */


Kind regards,
Niklas



