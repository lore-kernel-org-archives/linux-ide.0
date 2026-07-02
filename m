Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3F431E68
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987613; cv=none; b=Qq+VPjiWeY1g/fPpydnlKcazOpnnoyk2pNmqm4OsGtr44HaxTrpUWYbG3uFWHQEc2gA+lkIrSYuHSdqARV4hCPvATbYfkyzKzK+F2cZsWFLDHjirzURA1CRYV9F/o4Ld55bhgb3EVKbkY9oZtMrnXbSfEVy5fvSWTlomGez3v6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987613; c=relaxed/simple;
	bh=pLTtDcGUudsoN75ansYP1/wNVbX1XUXDaK+01Su9hFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MY0HPhW6goisc6MgkpLuu8lr+p4+Nx8nayb4OGeqOhTUNrcpWZL/0YCkW/Bcaeeuww08OyntfSZ8RV/AUryY0cbrMXmUCE0fYsn4g9ZIu4owJ4jYfUQXiGSAwUerZEdmvXH1QbDthK8TCNaY8n7N1THIGjyUePzvmJPUpIrGmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjpQko3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjpQko3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1F1F00A3A;
	Thu,  2 Jul 2026 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987612;
	bh=heWlvWokyGalsAigQKC8l5nK6rd+pETjmA6rm+F36pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TjpQko3h7eSxfU119N11smzaYKU3HalDzm5buzKHW6qZwKe735LoEar/WJo9ASCtE
	 7WUuZQ3bGpIYR5I7Qd/QK0OcRZHSdAniajeSxkODg1M0f+gcU9hWV0jOciXF07eObg
	 yoL14g12mZv/tlXKX0FZWHy7eEM2WpNAweFONlzeBjWL3NEHyqgYjnigIm3kjkZzAW
	 7sLT0L1eUnkxbVhlTh5L0USQHFggT+swtajQUs02zrUetBMQ92FAVfOj683+oY1V1c
	 Ajk5Wb0WOS8AMe9b5ArBdbXebarEV/U+FeQ+ff6heXODzdfhb4q2OrTf35XBePLBgu
	 UmnvXRHxfRErQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] ata: libata-scsi: scale DSM TRIM payload by MAX
 PAGES PER DSM COMMAND
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702100410.2039383-6-cassel@kernel.org>
References: <20260702100410.2039383-4-cassel@kernel.org>
 <20260702100410.2039383-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:20:11 +0000
Message-Id: <20260702102012.1FD1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ata_dsm_trim_pages() does not enforce a minimum value for logica=
l sector sizes, causing max_pages to evaluate to 0 for non-compliant device=
s. This permanently disables TRIM for devices that previously worked.
--

commit cdc4dda768e65a6957c51f439c9f87c5c94b90d7
Author: Niklas Cassel <cassel@kernel.org>

ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND

This commit modifies DSM TRIM to emit a payload sized up to the maximum=20
number of pages the device can accept, instead of just a single 512-byte=20
page. It also builds the descriptor directly into the WRITE SAME data-out=20
buffer via an atomic sg_miter mapping.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 429b03a080717..82342351b1c99 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> @@ -2198,6 +2198,39 @@ static unsigned int ata_scsiop_inq_89(struct ata_d=
evice *dev,
> +static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
> +{
> +	unsigned int sector_size =3D ata_id_logical_sector_size(dev->id);
> +	unsigned int max_pages =3D ata_id_dsm_max_pages(dev->id);
> +	unsigned int pages =3D sector_size / ATA_SECT_SIZE;
> +
> +	/* If the device does not specify a limit, assume only a single page. */
> +	if (!max_pages)
> +		max_pages =3D 1;
> +
> +	pages =3D min(pages, max_pages);
> +
> +	return pages;
> +}

[Severity: Medium]
What happens here if a buggy device reports an invalid logical sector size=
=20
less than 512 (e.g., 0)?

If sector_size is 0, pages will evaluate to 0. Since min(pages, max_pages)
is used, ata_dsm_trim_pages() will return 0.=20

While the SCSI disk layer typically corrects invalid 0-byte sector sizes=20
dynamically to keep the device functional, this raw uncorrected IDENTIFY=20
data calculation bypasses that correction.

[ ... ]

> @@ -3523,7 +3568,7 @@ static unsigned int ata_scsi_write_same_xlat(struct=
 ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  	/* If the request is too large the cmd is invalid */
> -	if (n_block > 0xffff * trmax) {
> +	if (n_block > max_pages * ATA_MAX_TRIM_RNUM * (u64)U16_MAX) {
>  		fp =3D 2;
>  		goto invalid_fld;
>  	}

[Severity: Medium]
Does this unintentionally break TRIM operations for non-compliant devices?

If ata_dsm_trim_pages() returns 0 as discussed above, max_pages is 0 here.
Because the Linux block layer prevents 0-length discard bios, n_block will
strictly be > 0.=20

This makes the condition n_block > 0 unconditionally true for any valid=20
TRIM request. The request will safely be rejected via goto invalid_fld, but
this permanently fails TRIM operations for a device that might have previou=
sly
worked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702100410.2039=
383-4-cassel@kernel.org?part=3D2
