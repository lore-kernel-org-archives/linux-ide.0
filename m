Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866611ACE76;
	Thu, 20 Jun 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888164; cv=none; b=pPqWLys+OOa+dDgNyyhvu0O+t7h1LZgps1lOXRUoh7z3+BN0wv9ftcACNBGI3H8tz7XQ6jK5WSvot7bculSYzsqa8dOnbIFpY6UDcGud1yyAMfAJixS8sMvc7CnyKBhDfBG0B4RpAOnH9dp537wQX6HgNEnd4QbJxRUGK3QejQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888164; c=relaxed/simple;
	bh=8cykN1c2mMQEkbuY06k7H6YYMrKkSvyIO1LK882iTxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj5MB++sSr9dkI9XCQTZ5eS/x478nW5dUeeGBt7pST93fiIoetGED58dTu9u57FL8r0b45PL/E4SUzSxLXrb7532WWmabzaWuD2YJ1QZrCMv55t1nlJXrRSbMXUzMh3pZcpQZVN13TLzA489GlDCJNwN+nI7vo3/MFR8NYjhCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNK1Iunn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNK1Iunn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7356DC2BD10;
	Thu, 20 Jun 2024 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888164;
	bh=8cykN1c2mMQEkbuY06k7H6YYMrKkSvyIO1LK882iTxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNK1Iunn6JiOcOQea6vBO9Nxbzv9mJApbxra+qJ7d5optwfVyzsp4QnHBu9VF8zOu
	 dAQoLSC7tnoWQ51j0MbqJNeVD2q0KbYhSmp3xoN7i+THb0eb9kfAbX5AmNVHgveEIR
	 c/nkRar71VtsIvKLfRKzrWpWI8Cjyi3GevfQTesk8RR5YwHSWfV8sj1+i2UPUvcGnH
	 /9K5cQt2yQKbZUE4R1S4yITvT308inJhB51dbXY2uTL8I0rL3rq78L7gEHf4jzHbDk
	 a3yBnrWCnC+T6sa4zk9zd3/Gvy5QSdJwKOtqGG1u2G1ysYiE2/8QLnhGll+oVeKou4
	 XDUwu/fErty6g==
Date: Thu, 20 Jun 2024 14:55:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnQm3-OL95x_Z_VP@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <ZnAeFbdt02zge2my@ryzen.lan>
 <ZnIBdj02yKFz4sK8@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnIBdj02yKFz4sK8@google.com>

On Tue, Jun 18, 2024 at 09:51:50PM +0000, Igor Pylypiv wrote:
> On Mon, Jun 17, 2024 at 01:29:25PM +0200, Niklas Cassel wrote:
> > On Fri, Jun 14, 2024 at 07:18:33PM +0000, Igor Pylypiv wrote:
> > > SCSI/ATA Translation-5 (SAT-5) Table 209 — "ATA command results"
> > > specifies that SATL shall generate sense data for ATA PASS-THROUGH
> > > commands when either CK_COND is set or when ATA_ERR or ATA_DF status
> > > bits are set.
> > > 
> > > ata_eh_analyze_tf() sets AC_ERR_DEV bit in qc->err_mask when ATA_ERR
> > > or ATA_DF bits are set. It looks like qc->err_mask can be used as
> > > an error indicator but ata_eh_link_autopsy() clears AC_ERR_DEV bit
> > > when ATA_QCFLAG_SENSE_VALID is set. This effectively clears the error
> > > indication if no other bits were set in qc->err_mask.
> > 
> > The reason why libata clears the err_mask when having sense data,
> > is because the upper layer, i.e. SCSI, should determine what to do
> > with the command, if there is sense data.
> > 
> > For a non-passthrough command, this will be done by
> > scsi_io_completion_action():
> > https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1084-L1087
> > 
> > 
> > However, if there is any bits set in cmd->result,
> > scsi_io_completion_nz_result() will be called:
> > https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1052-L1053
> > 
> > which will do the following for a passthrough command:
> > https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L969-L978
> > which will set blk_stat.
> > 
> > After that, scsi_io_completion() which check blk_stat and if it is a
> > scsi_noretry_cmd():
> > https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1073-L1078
> > 
> > A passthrough command will return true for scsi_noretry_cmd(), so
> > scsi_io_completion_action() should NOT get called for a passthough command.
> > 
> > So IIUC, for a non-passthrough command, scsi_io_completion_action() will
> > decide what to do depending on the sense data, but a passthrough command will
> > get finished with the sense data, leaving the user to decide what to do.
> >
> 
> Thank you for the detailed explanation, Niklas!
> I was looking at a related logic in ata_eh_link_report():
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-eh.c#L2359-L2360
>  
> Is my understanding correct that if we have ATA_QCFLAG_SENSE_VALID set and 
> qc->err_mask is zero then we don't want to report the error to user since
> SCSI might decide that it is not an error based on the sense data?

I'm assuming that that was the reasoning.

However, IIUC, passthrough commands should never be retried by SCSI,
it should always be reported back to the user.


> 
> > 
> > > 
> > > ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
> > > commands because qc->err_mask can be zero (i.e. "no error") even when
> > > the corresponding command has failed with ATA_ERR/ATA_DF bits set.
> > > 
> > > Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
> > > should not prevent SATL from generating sense data for ATA PASS-THROUGH.
> > > 
> > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > ---
> > >  drivers/ata/libata-scsi.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > > index 032cf11d0bcc..79e8103ef3a9 100644
> > > --- a/drivers/ata/libata-scsi.c
> > > +++ b/drivers/ata/libata-scsi.c
> > > @@ -1632,8 +1632,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> > >  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > >  
> > >  	/* For ATA pass thru (SAT) commands, generate a sense block if
> > > -	 * user mandated it or if there's an error.  Note that if we
> > > -	 * generate because the user forced us to [CK_COND =1], a check
> > > +	 * user mandated it or if ATA_ERR or ATA_DF bits are set. Note that
> > > +	 * if we generate because the user forced us to [CK_COND=1], a check
> > >  	 * condition is generated and the ATA register values are returned
> > >  	 * whether the command completed successfully or not. If there
> > >  	 * was no error, we use the following sense data:
> > > @@ -1641,7 +1641,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> > >  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> > >  	 */
> > >  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > > -	    ((cdb[2] & 0x20) || need_sense))
> > > +	    ((cdb[2] & 0x20) || (qc->result_tf.status & (ATA_ERR | ATA_DF))))
> > 
> > qc->result_tf can only be used if qc->flags has ATA_QCFLAG_RESULT_TF set,
> > otherwise it can contain bogus data.
> > You don't seem to check if ATA_QCFLAG_RESULT_TF is set.
> >
> > ata_scsi_pass_thru() does set ATA_QCFLAG_RESULT_TF.
> > 
> 
> Thanks for pointing this out! Looks like ATA PASS-TRHOUGH case is fine
> since the flag is always set by ata_scsi_pass_thru() as you pointed out.
> Do we still want to add the check even though we know that it is always
> set by ata_scsi_pass_thru()?
> 
> If the answer is "yes", I wonder if we should use the ATA_QCFLAG_RTF_FILLED
> flag instead? Currently it is used for ahci only but looks like it can be
> expanded to other drivers. inic_qc_fill_rtf() will benefit from this change
> because it is not always setting the status/error values:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/sata_inic162x.c#L583-L586
> 
> For the non passthough case qc->result_tf in ata_gen_ata_sense() is also valid
> because fill_result_tf() is being called for failed commands regardless of
> the ATA_QCFLAG_RESULT_TF flag:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/ata/libata-core.c#L4856-L4873
> 
> In this case using ATA_QCFLAG_RTF_FILLED will be more accurate because
> fill_result_tf() is being called even when ATA_QCFLAG_RESULT_TF is not set.
> 
> With that said I'm not sure if it makes sense to update all of the ATA
> error handling to start checking for the ATA_QCFLAG_RTF_FILLED flag.
> 
> What are your thoughts on this?

I see your point, we will fill the result if there is an error,
even if ATA_QCFLAG_RESULT_TF wasn't set.

Perhaps we should modify fill_result_tf() to set ATA_QCFLAG_RTF_FILLED,
after it has called ap->ops->qc_fill_rtf(qc);

Then this code can check if ATA_QCFLAG_RTF_FILLED is set, like you suggested.


Kind regards,
Niklas
