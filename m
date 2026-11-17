Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909253;
	b=Nej6niD7iJl7y4ASQBqBSN6Hh7nqzVSPWuNhliZh2U25d17D+h8wMS1o4V+7ZOrusaIG
	 nEob6CbukdGQ0XQJVnWLJTKc27Obm+UEVaIQRa8wn0k1h3UNiiVO2NpcIYkIKsRzcNHTs
	 sUM1FIDomJ+Ee2C3MRloaYkCMaIpQTHym2tacx64gDmVM+dow8m61J35SkiuFbXTH62sM
	 21GlmVnR/qj9CZlTmj16uo/j4hNS/NVoDkAX0QLXaoPhw6xHyLVqzauox5t2rhOBQnJpd
	 KSIH8ZVhKRjtEzxUFV8kjbHl7UUxFSXnWtK+UtLBW0qkdjE4f+lJI0H4AbgLSZt2EqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zWYKkXK5XhvNSSaWyPmmBRMMzjYC1xB8O44tprDjoro=;
	b=wGCsQis56IcjtNE4o6PHdmF/e+z3TDYUngMP1ELqrQiR4cSmcK9/YGzj778UN+rYyfw9
	 YQ+uOLK7JJ3zlo0keZs1ZeYK6eb1zugOY1UyzCFNxoIFPMQnRYVW8WFRTpB79YiJDs/fB
	 V9FsxRIljzaahuNaTSgiixqUTqhorejljE0kFqKC7VVLCquYWAEjhKpFkYo3zR6YbYOxL
	 RHliHxg9FLaxJXw+KUr2BDm2D8Rplk4UeRWwe0Z8nQEH9TEbHfXhx9reGMGij6QRznbkH
	 SL4K67zxPfaCuWYzNZ4vkKrcSSLw1LfMF2dFC7trU+3qsMrXbXMFnnY3f+NUDbcfgGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+0X1ome;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AE606A32A
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2026 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+0X1ome
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070FB1F000C4;
	Tue, 17 Nov 2026 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909253;
	bh=zWYKkXK5XhvNSSaWyPmmBRMMzjYC1xB8O44tprDjoro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+0X1omeAnqfVrWu+F31jM5xW9Fhm6pMhrpO2ZdiA6Pc9DfK1Ewx/bSxuRRBX9K1H
	 chKyVjOaTvl+JMcJ1J4QO85Tvqq3bl25GEHpJT7kHRHCOo7bX6TXD5l7WYZLx58sHA
	 7Kiu/WTSh2xWm1L9EBpH8oIcMP+uqerhJ7nj4K3JFaxvkTNxR/41tDa+YfJh0YRvlQ
	 6SxzIdbYNz4PrmGuuQc8mPE7WA2lv0psp8Q4uTspqXd5Nni6gKVB8+Q/X4ucB+PBaO
	 GLFx25J9Xebnim2zphiaX7miE9MsCWvF6Bavhag3NVGE96VBXD0wLhMEM/FRM/YfLD
	 b79dzMoO+rwGA==
Message-ID: <sashiko-outbox-218548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: sata_dwc_460ex: Fix DMA channel leak in
 sata_dwc_port_start()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261117094903.1282096-1-haoxiang_li2024@163.com>
References: <20261117094903.1282096-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:54:12 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] ata: sata_dwc_460ex: use-after-free in sata_dwc_probe() [1]
--

commit 7cbed05368af81c2d62d6074918f0d6f1dc52c91
Author: Haoxiang Li <haoxiang_li2024@163.com>

ata: sata_dwc_460ex: Fix DMA channel leak in sata_dwc_port_start()

This commit releases the DMA channel in sata_dwc_port_start() when
phy_power_on() fails before freeing the port structure.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 0daa5850a7bd0..4ab378d2c26f7 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -852,7 +852,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
> =20
>  	err =3D phy_power_on(hsdev->phy);
>  	if (err)
> -		goto CLEANUP_ALLOC;
> +		goto CLEANUP_DMA;
> =20
>  	for (i =3D 0; i < SATA_DWC_QCMD_MAX; i++)
>  		hsdevp->cmd_issued[i] =3D SATA_DWC_CMD_ISSUED_NOT;
> @@ -879,6 +879,8 @@ static int sata_dwc_port_start(struct ata_port *ap)
>  	dev_dbg(ap->dev, "%s: done\n", __func__);
>  	return 0;
> =20
> +CLEANUP_DMA:
> +	dma_release_channel(hsdevp->chan);
>  CLEANUP_ALLOC:
>  	kfree(hsdevp);
>  CLEANUP:

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
sata_dwc_probe() after sata_dwc_dma_init_old() cause a use-after-free
[1] on the shared interrupt line?

drivers/ata/sata_dwc_460ex.c:sata_dwc_probe() {
	...
#ifdef CONFIG_SATA_DWC_OLD_DMA
	if (!of_property_present(dev->of_node, "dmas")) {
		err =3D sata_dwc_dma_init_old(ofdev, hsdev);
		if (err)
			return err;
	}
#endif

	hsdev->phy =3D devm_phy_optional_get(dev, "sata-phy");
	if (IS_ERR(hsdev->phy))
		return PTR_ERR(hsdev->phy);

	err =3D phy_init(hsdev->phy);
	if (err)
		goto error_out;
	...
error_out:
	phy_exit(hsdev->phy);
	return err;
}

sata_dwc_dma_init_old() registers a DMA engine and requests a shared
interrupt without devres, but the subsequent error paths in
sata_dwc_probe() return without calling sata_dwc_dma_exit_old().  When
probe fails, the driver core frees the devm-allocated device context while
the shared interrupt remains registered, so a later interrupt on that line
invokes the handler with freed memory.

[1] https://sashiko.dev/#/bug/linux-4f29918f-8b5f-48b5-ab4d-aa40ae6890e7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117094903.1282=
096-1-haoxiang_li2024@163.com?part=3D1
