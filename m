Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110948;
	b=Of+Ub11Ps9JEMEpEY2xEaT28VdQ3LQVDFrKfStkw1WUesiiVRdxB3COWNrrtGi5LIrtZ
	 m2INIdufOWpZ+jEl9Nq7kf4PWbe/AONK/ldAZsOEKjqoh924IuRF3KQo0+IW6chBlDswN
	 BkNbAtbqwJvHMDfLPFupcRTFGqNL9m6tSTNyleH7XTecIjRmQkax6qyeM6IKurAaiqeH1
	 f5l1LLtaX4F6tsRx+1iakD+idLkCvOVKBXOubVDty3m5hzLXUr5p3aSb2emK6mFIEGk6S
	 1YvI9pNO6Qhvhk7x0CrgtbLIiGjtLr3DXHfUCirPFxiX1TPfkRxy2xor2viOkvmp6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dxsnnFc3CUS202tnM5hKr+jjpbl7CJJtsDje1TeROK0=;
	b=qsHx9UQ0keMa7yguPo3z0I7BlvR0eEUDfMHpzsYLhxy8tfWVt8LPvfIHllVTqkXzWvq+
	 c1hNoQJD6MgTkpiiby0Itv+5yTQdghySd09JrVBPNByWOs2mHkQEA1u45QgrhKJ3ESLKt
	 OLP5ZCwgpRJRmG3/0IJaTsnfNwGcp5jWx4L9ve9UWRmDbW7gwymjQAu1uxxYFvgIR16xT
	 gkeBZh3PgpnKCdIcJooo14BK+bKhXVIFokw9zlK4KvSF+28nsgKSdTOF3l1a1BaAz6NM0
	 O/BJq9yz4fiYeKg0jDSb9yrWfYmHjGz9DvaZ9No/8OJ1+Q1IBEV4La/NZ/YHQzK0j9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khW4icCF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F1606A31B
	for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khW4icCF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943811F01825;
	Tue, 27 Oct 2026 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110947;
	bh=dxsnnFc3CUS202tnM5hKr+jjpbl7CJJtsDje1TeROK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khW4icCF+FANe9O7WvMXn5lVkMQPVYeQLROA4vdCA4WPDrIUqDDrCBR6ctM4bGLS+
	 8WrYChnIXCRlMg+HRJoe5e0XOIA4CChn9OUbNmmIUiRqGL3Ak6hiKsu8f3BERtjQQ+
	 d4hpOUsgiW0/ll5+4yhyi47ADVYgMGffLtjB9aGBUTMq1c6wB6DCSFCQdH5t0UaJ/Y
	 6OsDPfRq+bbuneFgKsPfOA9Sk4Y5CuoaUNJbBxSykfNz+e9/VU5b0kGUqOz6EwJBM6
	 khPqlCU49MnvYgKyXhcf4L3+rnPMqi26KfBlbhIbG2S+tVx69x4zhQaUIPE1+q99TH
	 IpY6jvPAARypg==
Message-ID: <sashiko-outbox-186720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] ATA: ahci: Add Intel PCH-S RAID device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Gardzinski" <romanx.gardzinski@linux.intel.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261027141240.7850-1-romanx.gardzinski@linux.intel.com>
References: <20261027141240.7850-1-romanx.gardzinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:22:27 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ata: ahci: Nova Lake PCH-S RAID entry uses legacy board_ahci_pcs_q=
uirk
--

commit 2589d3b85f965fdaa155298cf5da322c956d8de2
Author: Roman Gardzinski <romanx.gardzinski@linux.intel.com>

ATA: ahci: Add Intel PCH-S RAID device ID

This commit adds the Intel Nova Lake PCH-S RAID PCI device ID (0x6e66) to
ahci_pci_tbl in drivers/ata/ahci.c.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3c38ee3314ee9..f4b6235452dbd 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -274,6 +274,10 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  		/* Comet Lake PCH-H RAID */
>  		PCI_VDEVICE(INTEL, 0x06d6),
>  		.driver_data =3D board_ahci_pcs_quirk,
> +	}, {
> +		/* Nova Lake PCH-S RAID */
> +		PCI_VDEVICE(INTEL, 0x6e66),
> +		.driver_data =3D board_ahci_pcs_quirk,

[Severity: High]
Should this new Nova Lake PCH-S RAID entry in ahci_pci_tbl use board_ahci
instead of board_ahci_pcs_quirk?

In drivers/ata/ahci.c, enum board_ids notes that board_ahci_pcs_quirk is
only for legacy Intel platforms:

	/*
	 * board_ahci_pcs_quirk is for legacy Intel platforms.
	 * Modern Intel platforms should use board_ahci instead.
	 * (Some modern Intel platforms might have been added with
	 * board_ahci_pcs_quirk, however, we cannot change them to board_ahci
	 * without testing that the platform actually works without the quirk.)
	 */
	board_ahci_pcs_quirk,

Using board_ahci_pcs_quirk sets AHCI_HFLAG_INTEL_PCS_QUIRK in
ahci_port_info[]. When the controller is probed, resumed, or reset via:

  ahci_init_one() / ahci_pci_device_runtime_resume() / ahci_pci_device_resu=
me()
    -> ahci_pci_reset_controller()
      -> ahci_intel_pcs_quirk()

ahci_intel_pcs_quirk() reads and writes hpriv->port_map into the legacy
6-port PCS_6 PCI configuration register (offset 0x92):

	pci_read_config_word(pdev, PCS_6, &tmp16);
	if ((tmp16 & hpriv->port_map) !=3D hpriv->port_map) {
		tmp16 |=3D hpriv->port_map;
		pci_write_config_word(pdev, PCS_6, tmp16);
	}

On modern Intel platforms (and PCH-S controllers where the legacy 6-port
PCS_6 layout does not apply), applying this quirk has previously caused
regressions that broke SATA drive detection, as seen in commit 7edbb6059274
and commit 9e2f46cd8747. When the same Nova Lake controller is in AHCI mode,
it matches PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) and uses
board_ahci.

Also, the commit message states "No functional changes", even though adding=
 a
new PCI device ID enables driver binding for this hardware. Could the entry
be updated to use board_ahci and the commit message adjusted accordingly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027141240.7850=
-1-romanx.gardzinski@linux.intel.com?part=3D1
