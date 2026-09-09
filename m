Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320505476C6
	for <linux-ide@vger.kernel.org>; Wed,  9 Sep 2026 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953903; cv=none; b=anLzQq0ITMAWT8+B6vJ1Gl4vhfwAJlgxpvWJmEmFtUc+M9K2VOjaeAxhFm0VL9dlYqSKQK8l3C25xmYQiW7QGGU+pwCeJAs67F9upnQ4asbly77/1A4V5qLGCMUMHF53E1ZCfwD9rxu4XpQrr5+9le/TdT+UOc32q11KLXd23k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953903; c=relaxed/simple;
	bh=1FFhEFkRKy2XXKJOYR3fXEDAAJbm4WCmu8Ovx8YgC/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQW9I9nfluEdhaGIoHTpA1+Ez5AXPWHDEq0kq7TcT+qEg8/a9v/9sPa92KGmpqLNvjIl3zeciXvndxHT2Nxbqj9SbNvnqM4MFO8mUu4V+l9aopLxIEmk0mNnheRDmYAAAQJeRRMuJdYeoMCprKSJvMhg/Ak9/rYWQaqJPRFC6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9kmhmGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9kmhmGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72011F00A3A;
	Wed,  9 Sep 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953901;
	bh=JzOcYeFFHOzXLV7x3G0s06NzcriD2UNt06NlWz3DlMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9kmhmGx3Rx9oSbHb9Oc79jnoAdp/rlnhHF2qd9v+v7dg7FKm4vg6J/m2kjUOxsm9
	 wDplFsT91oy1oVcyZE0MlgXreQCqOSpFMGBvVsOg8FA0+IUsP6pSyQNgCsrAFfT1XJ
	 b14TvqNqk213RKnFO/fx0RPDkliX54+Rea+GvmrNwtjyxcXfY0tv54JwtpyM35/Q71
	 8S1mojBVbcwvbO3XInGhRBdbfbdU0Lk8AGBrhx0ECwk4vZcLHGq+4fsqO4YJNK4+ia
	 KW7zQO0JCPPRIv1epFPWGDB7hn690DrW6c1ZZQJ9H5PZU1OoaW83DKY7HjvkYHgNzd
	 oh0S+xlZYRDBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: sata_dwc_460ex: Don't enable interrupt if
 libATA core registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Borisov" <nik.borisov@suse.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260909112426.811456-1-nik.borisov@suse.com>
References: <20260909112426.811456-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:38:21 +0000
Message-Id: <20260909113821.A72011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Inverted teardown sequence for the PHY on probe error path, callin=
g phy_power_off() after phy_exit().

Pre-existing issues:
- [Critical] Missing cleanup of DMA resources on probe error paths leads to=
 Use-After-Free of DW DMA controller structures.
--

commit fb665db1a3c329dd76a0b668e1948fec56aec15e
Author: Nikolay Borisov <nik.borisov@suse.com>

ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fai=
ls

Recent 4bbc16a353a9 commit changed the timing when interrupts are enabled.
However it didn't account for the libATA registration step. Resolve the
issue by failing the entire registration process in case of failure to
register with libATA.

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891af..db39843c5f0fc 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1185,8 +1185,10 @@ static int sata_dwc_probe(struct platform_device *=
ofdev)
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
>  	err =3D ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to activate host");
> +		goto error_out;

[Severity: High]
If ata_host_activate() fails, does this new failure path invert the PHY
teardown sequence?

When ata_host_activate() fails, it has already called ata_host_start(),
which powers on the PHY and registers a devres cleanup action for
ata_host_release(). Jumping to the error_out block executes a manual
phy_exit():

error_out:
	phy_exit(hsdev->phy);
	return err;

When devres later handles the cleanup, it cascades to sata_dwc_port_stop()
and executes phy_power_off(hsdev->phy) on the already-exited PHY. Could
this sequence violate the PHY API and potentially cause system lockups or
synchronous external aborts?

[Severity: Critical]
This is a pre-existing issue, but does this error path expose a missing
cleanup of legacy DMA resources?

When sata_dwc_probe() fails and jumps to error_out, the error handling
block skips calling sata_dwc_dma_exit_old(). Because
sata_dwc_dma_init_old() uses non-devm functions like request_irq() and
dma_async_device_register(), these globally registered resources remain
active and hold pointers to the freed devm-allocated structures.

If the shared IRQ fires or the DMA subsystem accesses the controller after
sata_dwc_probe() fails, could this lead to a use-after-free?

> +	}
> =20
>  	/* Enable SATA Interrupts */
>  	sata_dwc_enable_interrupts(hsdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909112426.8114=
56-1-nik.borisov@suse.com?part=3D1
