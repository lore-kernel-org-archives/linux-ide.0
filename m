Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79E6EB56;
	Fri, 28 Jun 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605544; cv=none; b=JVurznPPS5NIm3IDz8tck1lYILvfkBfgzALUBRfycHD4he17J892eIaqelRuj5zFIloqci3HZKX7KZdTVr5ep/F4CbXwjoC5bdC8Z9my0K1b41/fAgX4inxrlq2nzjsHxnR4m5qPzu0cCQpREqqxs7x1PZJ0ZReHzd8g2uirRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605544; c=relaxed/simple;
	bh=IyDvPqV592W5OU5kiIiJbG2I1gXc7ekIbCoB3mTkCXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVCgKvwb6RIOXTelz6FuXs/gZciJRvdUaqWjxmBIlDrOoALemNYT3A0yYuOb8flUTSM1SXTj3D07+1o2rtt60cYspKchu+ZHWT20heZd3MleRsZWVMpov7Aq4cPcscYggpxlVSKkd6f5NR1XYX9F/qwnBO2Zgi9zeYTLyR3cbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQGimdnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQGimdnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E24DC116B1;
	Fri, 28 Jun 2024 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719605543;
	bh=IyDvPqV592W5OU5kiIiJbG2I1gXc7ekIbCoB3mTkCXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQGimdnJ/UdCYk7cImHHgbw9A+JW8PS+oxpnpdBXOOc0k1azUTV1yTfZOq74H8BEB
	 FhEM8WQonPQydbtaKCtFgYDzXs+gQ9VBFisW0A/Q+PU5Wbno01YHw1Q+qxLIkdv7O6
	 oNnu1uEhx7KQKrgsQaJXBhYHbTP8Vv0kAS+QSuJbgFev+wD+ThtDv+csEtCqhsU25d
	 1PSe2pfizulYFUkiAc4A4EeSQ8ct36V+1MLxlXuLKgiDJOvRhyP6ZM/0XrUrPIl4JB
	 WhyazJXV+8+ojubnPIrBGdfIOQiuMRAtSzYi5A8evoCioITyo1RORihsyu9Z8Y26H1
	 7+njBIRZpcUCQ==
Date: Fri, 28 Jun 2024 22:12:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in
 fill_result_tf()
Message-ID: <Zn8ZIxQRimgVZ2S3@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-6-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230411.3471543-6-ipylypiv@google.com>

On Wed, Jun 26, 2024 at 11:04:10PM +0000, Igor Pylypiv wrote:
> ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> to check if qc->result_tf contains valid data.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libahci.c     | 10 ----------
>  drivers/ata/libata-core.c |  8 ++++++++
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 83431aae74d8..0728d445e531 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	struct ahci_port_priv *pp = qc->ap->private_data;
>  	u8 *rx_fis = pp->rx_fis;
>  
> -	/*
> -	 * rtf may already be filled (e.g. for successful NCQ commands).
> -	 * If that is the case, we have nothing to do.
> -	 */
> -	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> -		return;
> -
>  	if (pp->fbs_enabled)
>  		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
>  
> @@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	    !(qc->flags & ATA_QCFLAG_EH)) {
>  		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
>  		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
> -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  		return;
>  	}
>  
> @@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  		 */
>  		qc->result_tf.status = fis[2];
>  		qc->result_tf.error = fis[3];
> -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  		return;
>  	}
>  
>  	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
> -	qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  }
>  
>  static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e1bf8a19b3c8..a9fc3ec9300f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4801,8 +4801,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
>  {
>  	struct ata_port *ap = qc->ap;
>  
> +	/*
> +	 * rtf may already be filled (e.g. for successful NCQ commands).
> +	 * If that is the case, we have nothing to do.
> +	 */
> +	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> +		return;
> +
>  	qc->result_tf.flags = qc->tf.flags;

One functional change that I can see from this is that after this commit,
we will no longer do: qc->result_tf.flags = qc->tf.flags;
if ATA_QCFLAG_RTF_FILLED was set.

e.g. ata_scsi_set_passthru_sense_fields() and ata_gen_ata_sense()
makes use of result_tf->flags, so we probably still want to do this.


Perhaps keep this function as you have it and simply do:

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0728d445e531..fdfa7b266218 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2148,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
                        if (qc && ata_is_ncq(qc->tf.protocol)) {
                                qc->result_tf.status = status;
                                qc->result_tf.error = error;
+                               qc->result_tf.flags = qc->tf.flags;
                                qc->flags |= ATA_QCFLAG_RTF_FILLED;
                        }
                        done_mask &= ~(1ULL << tag);
@@ -2172,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
                        fis += RX_FIS_SDB;
                        qc->result_tf.status = fis[2];
                        qc->result_tf.error = fis[3];
+                       qc->result_tf.flags = qc->tf.flags;
                        qc->flags |= ATA_QCFLAG_RTF_FILLED;
                }
                done_mask &= ~(1ULL << tag);



>  	ap->ops->qc_fill_rtf(qc);
> +	qc->flags |= ATA_QCFLAG_RTF_FILLED;
>  }
>  
>  static void ata_verify_xfer(struct ata_queued_cmd *qc)
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
