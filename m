Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA029DB8E;
	Tue, 10 Jun 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564118; cv=none; b=Phi5XOQYekM5tTnfaenVce+Ys9l/hBh1k8TPyJVsSZWeVpABC5J7sq1sOJjmqBC0qAcaODTnNoQYqJ7qJRNgsMwLT8qf/u/jaolwii/m4lzguRZ6T+YFTRnGOxqd6rczIJg2Up+qSW6uEJOJU8OJWZ/P1XR/iHlq2Ad8n0Pstbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564118; c=relaxed/simple;
	bh=dJAjnjVCBWFi59JPuEDE12I/eCLx4eSBmPOBQ3kkkBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6MO1Nz3veG5NN0Wxt1vnOu9rvhnm22mUSyRYz3MACb5c7sdvPQytWAZHVRNmgtqqR+3K66YXGuLGliLf3OCTYroyxw5kUk7lHKr+dBrpe+wUnD384bbk9Xt0QLlxy+u6/DoFwWQAkVx4T8sGzXTfXaNJCOHw77vDvTSA6KHnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RcEPNm+9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RcEPNm+9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bGr7b4tGVz9sWN;
	Tue, 10 Jun 2025 16:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749564107; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V91fldRtjZGoREG79N9rf6WT/04EBxH6Xnys4sXjdGQ=;
	b=RcEPNm+9v5FivHKhdSwyJsKYdWtre4nWizpbUqr25wjyt27a/rIW0lq6Wd7NsvZci4+7E+
	cAUys5LUNbhtlSyaGpfKM1WQZ5oHuRMQc5n+mXj9oG/3MP/DkpwLQOzF87tfsyixcMYoZZ
	TRzGIoYlg1Jfwh+DXGYqRkwTjBzuDldymnEfaSLoicfIM+CWZzVobE9hIL8V9sZ7GXN8cL
	ciBr/IMD71zsPxbXIexbCg9tPNfT1K+nRGiJ5KE7ymzgFk0RcgUMuWg8nRdLbLytQJ21+m
	knhcvD3WGTHNkJ8KqkDJ1dgX2czrcvYpLqg4+XL8oR3rgE3Kl+xO/LCPtG9kJA==
Message-ID: <aade5fcc5bae0e2a04441388fd7f248704a33ae3.camel@mailbox.org>
Subject: Re: [PATCH v2] ata: pata_macio: Fix PCI region leak
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Jun 2025 16:01:43 +0200
In-Reply-To: <20250610135413.35930-2-phasta@kernel.org>
References: <20250610135413.35930-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 1hdic9gthff9ma5dm4sp1ikx8it6c7sy
X-MBO-RS-ID: 480e5cbc4daf07b7ee3

On Tue, 2025-06-10 at 15:54 +0200, Philipp Stanner wrote:
> pci_request_regions() became a managed devres functions if the PCI
> device was enabled with pcim_enable_device(), which is the case for
> pata_macio.
>=20
> The PCI subsystem recently removed this hybrid feature from
> pci_request_region(). When doing so, pata_macio was forgotten to be
> ported to use pcim_request_all_regions(). If that function is not
> used,
> pata_macio will fail on driver-reload because the PCI regions will
> remain blocked.
>=20
> Fix the region leak by replacing pci_request_regions() with its
> managed
> counterpart, pcim_request_all_regions().
>=20
> Fixes: 51f6aec99cb0 ("PCI: Remove hybrid devres nature from request
> functions")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Forgot Damien's Reviewed-by.

P.

> ---
> Changes in v2:
> =C2=A0 - Add Fixes: tag and rephrase commit message, since the merge
> window
> =C2=A0=C2=A0=C2=A0 closed already. (Niklas)
> ---
> =C2=A0drivers/ata/pata_macio.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index fbf5f07ea357..f7a933eefe05 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -1298,7 +1298,7 @@ static int pata_macio_pci_attach(struct pci_dev
> *pdev,
> =C2=A0	priv->dev =3D &pdev->dev;
> =C2=A0
> =C2=A0	/* Get MMIO regions */
> -	if (pci_request_regions(pdev, "pata-macio")) {
> +	if (pcim_request_all_regions(pdev, "pata-macio")) {
> =C2=A0		dev_err(&pdev->dev,
> =C2=A0			"Cannot obtain PCI resources\n");
> =C2=A0		return -EBUSY;

