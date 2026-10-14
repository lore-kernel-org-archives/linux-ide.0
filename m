Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB272550DAF
	for <linux-ide@vger.kernel.org>; Wed, 14 Oct 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990677; cv=none; b=HgBXUG9Eh15lL5oJbM3FtyJlhwX2PHwozecC6eBzUBqx/Y3NV9O/RBH4AtciSOW8L1GhEvTj60oKhiF+M8LqWo/KR3ihj4jxvQtKMJeDvbxPNPHJx4y6jWcWqU0I71qnqjO+HiA+kze9Xm96H7NztAJOAEPAdpT4D6ymDvc571s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990677; c=relaxed/simple;
	bh=assXx6R3CJWTHz2PxBDjvDSS7kQhaAcpOedg1zqqZyk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VWg7rIZEt5oMX065hYmTa+vwFtrS3LsqiroMjHqWMU4ssnIJm6QOJ80FDaR07181KGTjtOWCg08l01eiZbgFZTYO0sCRrDzb/4JLn0M6zMB/DLkXpUCazBTBTa4VB8D/p8fmZLLsK8m6mPTDzNMMmyx0eMd8LAhS58On4DHPmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHU9rlSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHU9rlSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F7F1F000C4;
	Wed, 14 Oct 2026 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990670;
	bh=UCm/oBNQyv9sKdVsihpxApA0Dp2cLpUhLvomTH3PyW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHU9rlSCwej1JcZxBKwpRRaEa/AgQip79WOVe9wWar/itLzPa1P4uQKZvmMgq92xB
	 eefJAIkaDLM3s3kxkdEm1yh+L54r2+9XQlyzPsFLYZ7RQGP4GSNRlwOdPRn/YnbohX
	 qACIoxBGNRYMSQwdCNKfflCMrRrzJS/L9mPsfTXEkW3DO8dVRB0kBhp4EDMPvLtmle
	 HTA087vYuhPpuvlxkwouLvhWr2OBvH6dg+9kZ+1xm2ZOwHuAeHpGt7ND3xy+TMB329
	 toImbL4D/OfAnd6ogbla9/1ZACxjHVfeaL/3foHsToxtx3lWJQCQoal0rCe3AthA4K
	 Al2/+jF6LC2dA==
Message-ID: <sashiko-outbox-171459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libata-core: always apply all quirks matching for
 a device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org
In-Reply-To: <20261014150340.2410073-1-dlemoal@kernel.org>
References: <20261014150340.2410073-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:11:10 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ata: ata_dev_quirks() accumulation breaks specific quirk exclusions
- [Medium] ata: ata_dev_print_quirks() inside loop suppresses subsequent ma=
tch logs
--

commit 8f4a558f46757e1ace36c8ad018b708424fefd18
Author: Damien Le Moal <dlemoal@kernel.org>

ata: libata-core: always apply all quirks matching for a device

This commit changes ata_dev_quirks() to accumulate all matching quirks from
the __ata_dev_quirks array rather than returning on the first match. This
is intended to address issues where appended ATA_QUIRK_NO_FUA entries were
ignored if earlier patterns also matched the drive.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c

[ ... ]

> @@ -4521,16 +4522,18 @@ static u64 ata_dev_quirks(const struct ata_device=
 *dev)
>  	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
>  	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
> =20
> +	/* Get the quirks for all matching entries */
>  	while (ad->model_num) {
>  		if (glob_match(ad->model_num, model_num) &&
>  		    (!ad->model_rev || glob_match(ad->model_rev, model_rev))) {
>  			ata_dev_print_quirks(dev, model_num, model_rev,
>  					     ad->quirks);

[Severity: Medium]
Since ata_dev_print_quirks() sets ATA_EHI_DID_PRINT_QUIRKS on its first run
and suppresses subsequent printing attempts, won't it fail to log the quirks
from any second or subsequent matches?

Looking at ata_dev_print_quirks():

    if (!ata_dev_print_info(dev) || ehc->i.flags & ATA_EHI_DID_PRINT_QUIRKS)
        return;

    ehc->i.flags |=3D ATA_EHI_DID_PRINT_QUIRKS;

Should the print function be called exactly once, outside the loop, passing
the fully accumulated quirks mask instead of ad->quirks?

> -			return ad->quirks;
> +			quirks |=3D ad->quirks;

[Severity: High]
Does accumulating the quirks here break the ability for specific entries to
shadow and exclude broader entries?

For example, earlier in the __ata_dev_quirks table, a specific entry is used
to explicitly exclude a buggy drive:

    /*
     * The intel 510 drive has buggy DRAT/RZAT. Explicitly exclude
     * that model before whitelisting all other intel SSDs.
     */
    { "INTEL*SSDSC2MH*",        NULL,   0 },

If the loop continues, it will match the broader "INTEL*SSD*" pattern and
apply the exact quirks the earlier specific entry was meant to avoid. Can
this lead to functional regressions for devices that relied on earlier=20
entries to bypass buggy hardware features?

>  		}
>  		ad++;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014150340.2410=
073-1-dlemoal@kernel.org?part=3D1
