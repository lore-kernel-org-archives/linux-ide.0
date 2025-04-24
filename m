Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F946222595;
	Thu, 24 Apr 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494156; cv=none; b=W3NNfd2Z1nsDurKLkQiZhg1wTKUg7VLzYM84tVS53H1LwQHiu+Voy8sa+BPIqWn2y58VQYu2gQ0kdfKMEDNSsVXB6yaBblfCYgY9JzjoHdp4fzgeIfxz9bGIph5XADca2h1XDiX/fTZNZzYs5D3KlIqkeV+xIEEczaXE5ei5TBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494156; c=relaxed/simple;
	bh=uuc4dQjj6AIl18FJbwIOJgDDVJmkJOHWuJSYRBo5XoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH055PF5C5l59vHY87sD+vj18eIoz7YjozknOPRL+txy783jxc1jhq6mTi4k5o4NgaHFglGS7LXUV9JON5rbPZ1/ma+6ZD9KUhCbn4/z1GUCajspabDveZMuS8dg61z7O/6DCv91JkFdc3EcTLBqCUNiGod0JT+CGGr/2jsQ8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7DNVw2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7DNVw2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B19C4CEE3;
	Thu, 24 Apr 2025 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745494156;
	bh=uuc4dQjj6AIl18FJbwIOJgDDVJmkJOHWuJSYRBo5XoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7DNVw2nQflSeGeW4XtCtSo19D1Awl8Te0NdEjtSD2WdLxV4y/CJzxnVCwEbjgpRw
	 LKHwwXHjkit71yIGZy9QEUekubqiAIhgp177zt+QL/45wq7f13609V0hwK4+f2i6rN
	 fgl5EjLE7hqP4iXlm8lQND0Wkhb8/Yegp+sdLNs7Vt1HfMIYMvjPJ90aOozkr5/kTs
	 j8uD9uNeV42K9TEnMg1/Byg3KT9rN77Oe1TMs8cMl4CBcd/z6yeyJSddGDDVboeonJ
	 sg0dTGVUyjm6HeA5XK/wVhpawR/oQotSidMBX0XlIz4+Ix1zscA7EpUGmc/guJA/Ry
	 26SCkXBzx9Z7A==
Date: Thu, 24 Apr 2025 13:29:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata-scsi: Do not set the INFORMATION field
 twice for ATA PT
Message-ID: <aAogiHxc-mdORpe8@ryzen>
References: <20250422172123.281387-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422172123.281387-1-ipylypiv@google.com>

On Tue, Apr 22, 2025 at 10:21:23AM -0700, Igor Pylypiv wrote:
> For ATA PASS-THROUGH + fixed format sense data + NCQ autosense
> the INFORMATION sense data field is being written twice:
> 
> - 1st write: (redundant)
> scsi_set_sense_information() sets the INFORMATION field to ATA LBA.
> This is incorrect for ATA PASS-THROUGH.
> 
> - 2nd write: (correct)
> ata_scsi_set_passthru_sense_fields() sets the INFORMATION field
> to ATA ERROR/STATUS/DEVICE/COUNT(7:0) as per SAT spec.
> 
> There is no user-visible issue because second write overwrites
> the incorrect data from the first write.
> 
> This patch eliminates the reduntant write by moving the INFORMATION
> sense data field population logic to ata_scsi_qc_complete().
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
> 
> Changes in v3:
> - Rewrote the commit message to clearly point that this patch removes
>   a redundant write to the INFORMATION sense data field.
> 
> Changes in v2:
> - Rephrased commit message to make it clearer.
> - Dropped kernel-doc comment for the ata_scsi_set_sense_information().
> 
> 
>  drivers/ata/libata-sata.c |  2 --
>  drivers/ata/libata-scsi.c | 31 ++++++++++++++-----------------
>  drivers/ata/libata.h      |  3 ---
>  3 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 2e4463d3a356..74a0af2888fa 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1659,8 +1659,6 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  		if (ata_scsi_sense_is_valid(sense_key, asc, ascq)) {
>  			ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc,
>  					   ascq);
> -			ata_scsi_set_sense_information(dev, qc->scsicmd,
> -						       &qc->result_tf);
>  			qc->flags |= ATA_QCFLAG_SENSE_VALID;
>  		}
>  	}
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 2796c0da8257..ef117a0bc248 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -216,17 +216,21 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
>  }
>  
> -void ata_scsi_set_sense_information(struct ata_device *dev,
> -				    struct scsi_cmnd *cmd,
> -				    const struct ata_taskfile *tf)
> +static void ata_scsi_set_sense_information(struct ata_queued_cmd *qc)

Nice refactoring of ata_scsi_set_sense_information()!

However, since it is a separate logical change, I would have prefered for it
to be in a separate patch, but I don't think you need to respin just for this.


Reviewed-by: Niklas Cassel <cassel@kernel.org>
