Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26286366806
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187593; cv=none; b=OXbky17WCH6WUl0vkrk/8gxVhfiGb7+UYqAx0phE/OpJ6DeIzZzEnnkZ9aakJCvTp74s7vKITHIC+/N9Hh6+taMgdx64mZThF9nE8U1P4OXw65coNC7Bn2O7jrzOL4qqoma8W2eqo9hb7lkDVLDRGaATdLxFryKF30tyzc+SGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187593; c=relaxed/simple;
	bh=4kr85yNhWTs++cbbn3s9pkwa4u0ZXD2D2Ybs+yzzvY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dlXlkfd527wJvayVCgc1/j5U9uBnOveIvYx8I7iHK2ugCv1/MtqXLMNhkzYvdwjZKyTTpPswKO4grgs24RweaeCRDyDGRLeUGq8FEqFEIkrDRtNCjrX2Nk4oZA7bDAcZWr3R7LJtBDhrqjmeIOW67z3zE+c9OFA9kzyRyMeqpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjhDLwFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjhDLwFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E61F00A3D;
	Mon, 31 Aug 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187591;
	bh=ptyIYjKiP7gIZ+hxD0mE3795FoGnn0s6uS2HtzdA5sU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjhDLwFBbbzNspk3oFGZUAN0KWafXOAK/gvZZYjrEm/4rLpOzb1ahcBiwXo18mM0g
	 paF+kgt4yNuOzsMHQ5VBJ2NUyynjHM9NPnNM1VSP0F1i13jfXfJ8PjuD3YgaAR2OLv
	 /KqwldPICTeQ0OMUrdMBchBi6hI4jepP+ye7Bs0Nfhy4JGCVCxJkCh3jfQ0EV1lZkJ
	 7LUhfeICwax41sLlIYKniXxxEYd/sh033f/tIrAORStF8DbjdtAvo3DJwrbLgrrxrH
	 eKL4Kdjn5AbsxOY3ytvGAmCBjEBw32F7o4G7Lu70TVELNgjJ2p8ghW0Fs6maPmuTDs
	 IED+UlRh3OgWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] ata: ahci: fail probe if BAR too
 small for claimed ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260831133314.4125787-166-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-166-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:46:31 +0000
Message-Id: <20260831144631.8C0E61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The BAR size validation incorrectly assumes the maximum port index=
 is bounded by HOST_CAP.NP, but the driver actually accesses ports up to fl=
s(HOST_PORTS_IMPL), allowing out-of-bounds MMIO accesses to bypass the chec=
k.
- [High] The BAR size validation relies strictly on HOST_CAP.NP and rejects=
 the device if the BAR is smaller than required for the maximum claimable p=
orts, which can break working devices.
--

commit 93586245aa8cac6edeb231c78f24de78d4e9a254
Author: liyouhong <liyouhong@kylinos.cn>
Subject: ata: ahci: fail probe if BAR too small for claimed ports

This patch adds validation in ahci_init_one() to check if the BAR size is
sufficient for the number of ports claimed in HOST_CAP.NP. If the required
size exceeds the actual BAR size, the probe fails with -ENODEV to prevent
kernel panics from out-of-bounds MMIO access.

Link: https://lore.kernel.org/all/20260422080322.1006592-1-dayou5941@163.co=
m/

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 7a7f88b3fa2b1..bbf6e83abd880 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1874,6 +1874,24 @@ static ssize_t remapped_nvme_show(struct device *d=
ev,
> =20
>  static DEVICE_ATTR_RO(remapped_nvme);
> =20
> +static int ahci_validate_bar_size(struct pci_dev *pdev, int bar,
> +				  struct ahci_host_priv *hpriv)
> +{
> +	u32 cap =3D readl(hpriv->mmio + HOST_CAP);
> +	unsigned int max_ports =3D ahci_nr_ports(cap);
> +	u32 last_port_end =3D 0x100 + (max_ports * 0x80);

[Severity: High]
Does this validation actually prevent all out-of-bounds MMIO accesses?

The validation uses HOST_CAP.NP (via ahci_nr_ports) to determine the requir=
ed
BAR size, ignoring the actually implemented ports in HOST_PORTS_IMPL.

Looking at ahci_save_initial_config(), it only clears port_map if the total
count of set bits (map_ports) exceeds CAP.NP:

drivers/ata/libahci.c:ahci_save_initial_config() {
	...
		if (map_ports > ahci_nr_ports(cap)) {
			dev_warn(dev,
				 "implemented port map (0x%lx) contains more ports than nr_ports (%u), =
using nr_ports\n",
				 port_map, ahci_nr_ports(cap));
			port_map =3D 0;
		}
	...
}

If a controller reports CAP.NP =3D 0 (1 port) but sets bit 31 in HOST_PORTS=
_IMPL,
map_ports is 1. Since 1 > 1 is false, port_map is not cleared.

The loop will then execute for index 31, accessing MMIO out of bounds:

drivers/ata/libahci.c:ahci_save_initial_config() {
	...
	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
		if (hpriv->saved_port_cap[i])
			continue;

		port_mmio =3D __ahci_port_base(hpriv, i);
	...
}

If the BAR size is 0x200, ahci_validate_bar_size() allows the probe to
continue (since max_ports is 1, and 0x180 < 0x200), resulting in an OOB acc=
ess
and the exact panic this patch intended to prevent.

> +	resource_size_t bar_size =3D pci_resource_len(pdev, bar);
> +
> +	if (last_port_end > bar_size) {
> +		dev_warn(&pdev->dev,
> +			 "BAR%d too small for %u ports (last port ends at %#x, BAR %pa)\n",
> +			 bar, max_ports, last_port_end, &bar_size);
> +		return -ENODEV;

[Severity: High]
Could this strict validation break working devices?

If a device's generic IP block hardcodes CAP.NP to 31 (claiming 32 ports,
requiring a 0x1100 byte BAR), but the manufacturer only implemented 2 ports
(reflected in HOST_PORTS_IMPL) and mapped a standard 4KB (0x1000 byte) BAR,
the validation will fail (0x1100 > 0x1000).

Before this patch, the driver correctly relied on HOST_PORTS_IMPL to determ=
ine
which ports to access and safely initialized within the 4KB BAR. This patch
introduces a strict check that rejects the device if the BAR is smaller than
required for the maximum claimable ports in CAP.NP.

Should this warn instead of failing the probe entirely, or base the check on
the maximum port actually enabled in HOST_PORTS_IMPL?

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-166-sashal@kernel.org?part=3D1
