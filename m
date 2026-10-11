Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930B3019CD
	for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742445; cv=none; b=u6vHmQp/wBkaSCe/voYJLt3T4Cpj4dgli5ZYzwsGmG1lR2QdEruWUeX8eLOQvKzqKq7pdGNJfmRD/HAMttD7FSJmmK/gZk4xxEHKHjHQgIEDQsI03zX8Lf0VYKE5V40d1lDoDPAXo07kgHk9teL4UCdFRsTSNm+NwhoJpA3z65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742445; c=relaxed/simple;
	bh=vBlDE3ktZr3RBwwGw+9zfEsIiFUV4ESG4RKvs6dWs6Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BKI9BpjAQ++mp/qh6icVQ4dz3kEBCZ64xXnPFB6sK5bY/z8T4YhXM5P2NE/dfaZSO0WdkWN4Zu96mw3Ah+UEp/FnxmliFZ3HPVEoHLH54WhRfKLzjM5L7xrYcseAkJm4PBulTlPIR3Lu4z9c+PFER4WKKjGGgFOpmCEO904aVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWg29bhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWg29bhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB181F0089B;
	Sun, 11 Oct 2026 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742444;
	bh=RQNjyh554iUTxQrM8eTzWNfDeOEY9Z2TFCg4qBYguFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWg29bhB475pALMP2sRvjgOu+Fat1dQzDy9v0mXzeFjMg1ox60aOhX9XUHR7HkhtY
	 leA4VCEiXnRTlwqDXmrLVT8EoVFa2+fLsGhiQhTDsdJGrJgOkwNHgxr0gUfyvWQmy3
	 wtqcbAiitJH3ysBVrlkciASbxCxeGLrJuHLkVmo7Noh366jHqsLug8SxBeggwcd1Am
	 gglzhF7WIryE/pIi05oR9K8w3RlHLreW/rUat5if1cu7xlba1cGqmsmiRg9Y3Ag41r
	 kgBNt4g9rvpA3G+FbGdreLI7DMUhnnyrY3I4N68c0EG4ykUuTe/dqkdjxkB1VR43vT
	 WnCWCXX4qWLzQ==
Message-ID: <sashiko-outbox-167372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ata: libahci: re-enable FBS after error handling on
 a port multiplier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyrylo Biryuk" <illofspeed@gmail.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20261011180236.735-1-illofspeed@gmail.com>
References: <20261011180236.735-1-illofspeed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 18:14:02 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ata: ahci_enable_fbs() modifies PxFBS.EN without clearing PxCMD.=
FRE (AHCI spec violation)
--

commit 9f8000187fcdaf491c78af72f7fe5bba9f1d33a6
Author: Kyrylo Biryuk <illofspeed@gmail.com>

ata: libahci: re-enable FBS after error handling on a port multiplier

This commit re-enables FBS at the end of the error handler for port
multipliers. It addresses an issue where a softreset failure escalates
to a PMP hardreset, which leaves FBS disabled until the next boot.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2221,6 +2221,23 @@ void ahci_error_handler(struct ata_port *ap)
> =20
>  	sata_pmp_error_handler(ap);
> =20
> +	/*
> +	 * ahci_do_softreset() turns FBS off before resetting a fan-out link
> +	 * and turns it back on only if that reset succeeds. When it fails
> +	 * (e.g. a hot-plugged drive is still spinning up), EH escalates to a
> +	 * PMP hardreset, which never re-enables FBS, so the port would keep
> +	 * command-based switching until the PMP is attached again (reboot).
> +	 * Restore FBS once recovery is done and the PMP is still attached.
> +	 */
> +	if (sata_pmp_attached(ap) && ata_dev_enabled(ap->link.device)) {
> +		struct ahci_port_priv *pp =3D ap->private_data;
> +
> +		if (pp->fbs_supported && !pp->fbs_enabled) {
> +			ata_port_info(ap, "re-enabling FBS after error handling\n");
> +			ahci_enable_fbs(ap);

[Severity: Medium]
This problem wasn't introduced by this patch, but this new call to
ahci_enable_fbs() exposes a preexisting AHCI spec violation.

AHCI Spec 1.2+ section 9.3.6 requires that PxFBS.EN must not be set to '1'
while PxCMD.ST or PxCMD.FRE are '1'.

In ahci_enable_fbs(), we call hpriv->stop_engine():

drivers/ata/libahci.c:ahci_enable_fbs() {
    ...
	rc =3D hpriv->stop_engine(ap);
	if (rc)
		return;

	writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
    ...
}

However, stop_engine() only clears PxCMD.ST (PORT_CMD_START). It does not
clear PxCMD.FRE (PORT_CMD_FIS_RX).

Since ahci_stop_fis_rx() is not called here to clear PORT_CMD_FIS_RX, toggl=
ing
PORT_FBS_EN modifies PxFBS.EN while PxCMD.FRE is still '1'.

Does this run the risk of causing controller instability or command failures
on strict hardware implementations?

> +		}
> +	}
> +
>  	if (!ata_dev_enabled(ap->link.device))
>  		hpriv->stop_engine(ap);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011180236.735-=
1-illofspeed@gmail.com?part=3D1
