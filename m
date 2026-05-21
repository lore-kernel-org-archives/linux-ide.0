Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4636D9F5
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389796; cv=none; b=fCc4CI3ZZRmBVbuXGw9WY9YbFH2D28+jkK+eBQVXr7ZJ2ExlQuJXqSQARjtGnIwRcXyL9E0NOpiDKVB64iiKcILLVvb+JqqteS0KP8+25Env/8dZw7M5Gb4+7bjVDo5RIKlBESkHdfgQHZAIbM9mqxwgKRgE9xmm7Hgwp/bAums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389796; c=relaxed/simple;
	bh=oVZHRGJ0zBD9j8SgZs0+X0AaBOuvx2WyVzd5UBZh9k4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PPiDV2xj5OajmNd07o0ZQ3mi4JXY9HruCN7I6QTaPkCIwaaee53Aq0JCVnG5oNmM5sm8MkjLXlQVZ7epeHgPMu9Flq/yCMim8ym7No0CmoiJamiQcgHkjeRgEMh/d67DcW1DgEG4vhdjy8REQfSllQyHkH5w5tSBY55RK5ZEtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QExt5aJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QExt5aJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4809E1F000E9;
	Thu, 21 May 2026 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779389795;
	bh=q3ELa1p8e1F09nJcrUzCKu4icIZpsaYG1CAHQ33ZGPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QExt5aJJJj+09tg2sqdpzpPXrEjGRt2FoYRme+/1Mzk+JfbWBzP1IRlaDtXpKl5nl
	 eYUlDGETBYV71jFza+WI6yByim49XHnaOaB4lgu9YuF7f+tOw9uNsiuJ4R0FmLnEZO
	 R98nUVgJiikDJk4ugc37mIBVkfBJYJ+fVy8s5gk/9URWokLm16V7HlTpgOd08wZM1s
	 0aR72xTbPStB2pL4RIB5sgADQjIjtZ8Od6GalHrNWZ8dKOmElCYItik9cGv+5z5csw
	 x3cOixYsmMrPfyBTtONn/M1hvaaNz00I+a5lXlhtm2vLO9zh+ZWx5raaZT3uRwSPyp
	 n2kYosgVVEnVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] ata: libata: Pass the ATA port argument directly
 to ata_qc_issue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bart Van Assche" <bvanassche@acm.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260521173347.2079560-6-bvanassche@acm.org>
References: <20260521173347.2079560-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:56:34 +0000
Message-Id: <20260521185635.4809E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing kernel-doc parameter documentation for 'ap'.
--

commit b81f096dbed2ff9052d6614eac11c53f07517937
Author: Bart Van Assche <bvanassche@acm.org>

ata: libata: Pass the ATA port argument directly to ata_qc_issue()

This commit prepares for adding lock context annotations by passing the ATA
port argument directly to ata_qc_issue(). No functionality has been changed.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[ ... ]
> @@ -5159,9 +5159,8 @@ EXPORT_SYMBOL_GPL(ata_qc_get_active);
>   *	LOCKING:
>   *	spin_lock_irqsave(host lock)
>   */
> -void ata_qc_issue(struct ata_queued_cmd *qc)
> +void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)

[Severity: Low]
This isn't a bug, but should the kernel-doc comment block above this
function be updated to document the new ap parameter? It looks like this
might trigger a warning during documentation builds.

>  {
> -	struct ata_port *ap =3D qc->ap;
>  	struct ata_link *link =3D qc->dev->link;
>  	u8 prot =3D qc->tf.protocol;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521173347.2079=
560-1-bvanassche@acm.org?part=3D5
