Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75381533D6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958059; cv=none; b=Ui0U1CWD3zGXpLkuS983U/A+xd7irlulF0M8cY6pQ23zbBZgT88FJw80ToBEN7YF6VvUqydZ+5wscmVFHbQeOZZzu8QDATm1Uub3dx/IRC6pPYjeMltlvb19LWqF7v8tvgs/bPp/4HDpMjIQ6Ty3mBjx+vjgmucdUitaic3UuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958059; c=relaxed/simple;
	bh=clx3r1yDQ4oKzIfCYxmrT9AxstmLK50C4wd5t46wNgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=seEi4UM3pZ3IjhSYQ+FpUgHBCKdXUgoTKgbUAi/QgXpJVQNiIUHHnYhWQ7FGwNQRF8dsUBIy5mZGydFi6imL1kfHZT4bJ6uWUzW/xyMUkaKFrfsfpydC44KEURmicWU7Vdxeb0QpVIwRgEZbcW1D4tq1/JnH1x4UDz0VLjZxazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOU11jAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOU11jAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E61F000E9;
	Thu,  2 Jul 2026 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958058;
	bh=AyEBGPxzfW4TCGpWFvUMdBUNl0Dv8liWSQdigv7/nkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOU11jADgHyt12GqrQGjpl5GBw6TsXg/mOd/zgqLmEiKcg5RKwHF5hI7+nWEUEUp6
	 PpaFqYG/o8mWi5a7dMcOItuURBxd+CjFXl9xeEEw2ZpkT1ImMbnbtbCXNTG/Lv9iZa
	 5cA7mUpDWEP7unuZ3dZHVFyIjyytwvpYdLFaPLK3RRjaKYIRRBCRCuvOcj/f+rgIvN
	 J70An3X2TGoSjNY59imwn+qVrBa70zhkS6p6j3w7jf/JrbXPKlgdi+x1uQ0oMXlMia
	 zWhISSu3oLBvXlzOrBMXcaeHOrDcoPIlijPi8JPngqb1bD+Tjkj5YN/ihKgLGT5T9s
	 5m4pAKuzJhTug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] ata: libata-scsi: improves checks for ZBC_IN and
 ZBC_OUT commands support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702015646.1702539-5-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
 <20260702015646.1702539-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:07:37 +0000
Message-Id: <20260702020737.E00E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ZBC_IN is incorrectly evaluated as not having service actions be=
cause ZI_REPORT_ZONES equals 0, breaking all REPORT SUPPORTED OPERATION COD=
ES (RSOC) formats.
--

commit 6af9854276b3609a524ea350c87e6e2924aee340
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-scsi: improves checks for ZBC_IN and ZBC_OUT commands support

Improve ata_scsi_cmd_is_supported() to check the service action for the
ZBC_IN and ZBC_OUT opcodes, to correctly report supported zone management
commands for zoned disks.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index e432e521ad318..f9e6bda6833e4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3708,8 +3708,17 @@ static bool ata_scsi_cmd_is_supported(struct ata_d=
evice *dev, u8 op, u16 sa,
>  		}
>  		return true;
>  	case ZBC_IN:
> +		return sa =3D=3D ZI_REPORT_ZONES && ata_dev_is_zoned(dev);

[Severity: Medium]
Does this inadvertently break REPORT SUPPORTED OPERATION CODES (RSOC) forma=
ts
for ZBC_IN?

Because ZI_REPORT_ZONES evaluates to 0, the helper
ata_scsi_supported_cmd_has_sa() will evaluate this as not having service
actions:

drivers/ata/libata-scsi.c:ata_scsi_supported_cmd_has_sa() {
    return cmd->sa !=3D 0;
}

This appears to cause incorrect behavior during RSOC handling for ZBC_IN:

- Format 0 (ata_scsi_report_all_supported_opcodes) fails to set the SERVACTV
  (Service Action Valid) bit because cmd->sa evaluates to 0.

- Format 1 incorrectly accepts ZBC_IN.

- Format 2 (ata_scsi_report_supported_opcodes) incorrectly rejects valid
  queries for ZBC_IN with CHECK CONDITION (ILLEGAL REQUEST), preventing
  userspace from probing ZBC_IN service actions.

>  	case ZBC_OUT:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702015646.1702=
539-1-dlemoal@kernel.org?part=3D4
