Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79A3EEACB;
	Wed,  2 Sep 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338449; cv=none; b=eowN4UE/0VVKZctGXJ1z/+bJCX2opEmUZXZ5HwARviR8tUOPzZnNS/3zbnp+3qU/720OzxW1z5R7TGCvuchtZitHCbpTkBcXipZBcA9BT5Bjf4xB6YIPtb6t5qofGnKvaRChnA5JXFlutMXlx7jLC/4Q2rqr8fwOYi/SyFAGMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338449; c=relaxed/simple;
	bh=HKbTcSuALr8eRF5pULuNwUJNBv9MGYOCxcA1ydK5gjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW/+I2su3qjJkMShguk+Y9HL6s5gNjklPnA50z7T6bsUaE7IPXoA8OCiKnCa2Le93XsG/HKAjAJl+O2X/3Mdih7blzCjnayJS6y8Xbj1OlaCSuuxdJynBaWC/LiqmcqCO7xUmGKR9uu8MugWh2CeL+8McELM6V3iDDOJbOlY//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPwnvR22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPwnvR22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6191F000E9;
	Wed,  2 Sep 2026 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338448;
	bh=Cp9TaPAA/xdfQAOjys//h3jDC/UjTKkI0uP0oBRcXyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QPwnvR22aU150PH/Ef5MG6UFEDVtpMKQj3ZzdhiuFf/o9Bs/GWyfxLMBxe07iASyv
	 IIbMcNKmWMINqKzYQhWX3mXmEiG7ma/trpAddiNodbbSLdA9sCQJM9fGeClgCCJ8F4
	 YR2HxKE72dv3F9makTNRxoT0yGB5LhjlgqLQ2GzLjBlbRGkbqJ4T2hKV/awlLwdp3/
	 TN8/vIvB7EjelUBAAGAJMvRKhtMR2fSES0p+Mm80nMHcxpTYR/h0AKnzj6hM3ymNX/
	 hJdQg/p00MXCkXEtnJqkGUcnDKpF1naXE6749kJjJJQJSmz8uQ3FYa9yLe4oMuHC2e
	 k5S+dY/UFXE4Q==
Date: Wed, 2 Sep 2026 10:40:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] ata: ahci: fail probe if BAR too small
 for claimed ports
Message-ID: <apfhDEu7u0kt4w4q@ryzen>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-166-sashal@kernel.org>
 <20260831144631.8C0E61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831144631.8C0E61F00A3D@smtp.kernel.org>

On Mon, Aug 31, 2026 at 02:46:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The BAR size validation incorrectly assumes the maximum port index is bounded by HOST_CAP.NP, but the driver actually accesses ports up to fls(HOST_PORTS_IMPL), allowing out-of-bounds MMIO accesses to bypass the check.
> - [High] The BAR size validation relies strictly on HOST_CAP.NP and rejects the device if the BAR is smaller than required for the maximum claimable ports, which can break working devices.
> --
> 
> commit 93586245aa8cac6edeb231c78f24de78d4e9a254
> Author: liyouhong <liyouhong@kylinos.cn>
> Subject: ata: ahci: fail probe if BAR too small for claimed ports
> 
> This patch adds validation in ahci_init_one() to check if the BAR size is
> sufficient for the number of ports claimed in HOST_CAP.NP. If the required
> size exceeds the actual BAR size, the probe fails with -ENODEV to prevent
> kernel panics from out-of-bounds MMIO access.
> 
> Link: https://lore.kernel.org/all/20260422080322.1006592-1-dayou5941@163.com/
> 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 7a7f88b3fa2b1..bbf6e83abd880 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1874,6 +1874,24 @@ static ssize_t remapped_nvme_show(struct device *dev,
> >  
> >  static DEVICE_ATTR_RO(remapped_nvme);
> >  
> > +static int ahci_validate_bar_size(struct pci_dev *pdev, int bar,
> > +				  struct ahci_host_priv *hpriv)
> > +{
> > +	u32 cap = readl(hpriv->mmio + HOST_CAP);
> > +	unsigned int max_ports = ahci_nr_ports(cap);
> > +	u32 last_port_end = 0x100 + (max_ports * 0x80);
> 
> [Severity: High]
> Does this validation actually prevent all out-of-bounds MMIO accesses?
> 
> The validation uses HOST_CAP.NP (via ahci_nr_ports) to determine the required
> BAR size, ignoring the actually implemented ports in HOST_PORTS_IMPL.
> 
> Looking at ahci_save_initial_config(), it only clears port_map if the total
> count of set bits (map_ports) exceeds CAP.NP:
> 
> drivers/ata/libahci.c:ahci_save_initial_config() {
> 	...
> 		if (map_ports > ahci_nr_ports(cap)) {
> 			dev_warn(dev,
> 				 "implemented port map (0x%lx) contains more ports than nr_ports (%u), using nr_ports\n",
> 				 port_map, ahci_nr_ports(cap));
> 			port_map = 0;
> 		}
> 	...
> }
> 
> If a controller reports CAP.NP = 0 (1 port) but sets bit 31 in HOST_PORTS_IMPL,
> map_ports is 1. Since 1 > 1 is false, port_map is not cleared.

1) A controller that reports CAP.NP, but does not have a BAR size to accomodate
   that amount of ports, would already have been rejected in ahci_init_one(),
   so ahci_save_initial_config() would never even get called.

2) Having bit 31 set in the PI register, would require CAP.NP to have a value
   of at least 31 (meaning 32 ports, since it is zeroes based).

   See the register description of the PI register:
   3.1.4 Offset 0Ch: PI – Ports Implemented
   This register indicates which ports are exposed by the HBA. It is loaded by
   the BIOS. It indicates which ports that the HBA supports are available for
   software to use. For example, on an HBA that supports 6 ports as indicated
   in CAP.NP, only ports 1 and 3 could be available, with ports 0, 2, 4, and 5
   being unavailable.
   Software must not read or write to registers within unavailable ports.
   The intent of this register is to allow system vendors to build platforms
   that support less than the full number of ports implemented on the HBA
   silicon.

   Thus, AFAICT, having a bit set in the PI register that is higher than CAP.NP,
   would be violating the spec.


> 
> The loop will then execute for index 31, accessing MMIO out of bounds:
> 
> drivers/ata/libahci.c:ahci_save_initial_config() {
> 	...
> 	for_each_set_bit(i, &port_map, AHCI_MAX_PORTS) {
> 		if (hpriv->saved_port_cap[i])
> 			continue;
> 
> 		port_mmio = __ahci_port_base(hpriv, i);
> 	...
> }
> 
> If the BAR size is 0x200, ahci_validate_bar_size() allows the probe to
> continue (since max_ports is 1, and 0x180 < 0x200), resulting in an OOB access
> and the exact panic this patch intended to prevent.
> 
> > +	resource_size_t bar_size = pci_resource_len(pdev, bar);
> > +
> > +	if (last_port_end > bar_size) {
> > +		dev_warn(&pdev->dev,
> > +			 "BAR%d too small for %u ports (last port ends at %#x, BAR %pa)\n",
> > +			 bar, max_ports, last_port_end, &bar_size);
> > +		return -ENODEV;
> 
> [Severity: High]
> Could this strict validation break working devices?
> 
> If a device's generic IP block hardcodes CAP.NP to 31 (claiming 32 ports,
> requiring a 0x1100 byte BAR), but the manufacturer only implemented 2 ports
> (reflected in HOST_PORTS_IMPL) and mapped a standard 4KB (0x1000 byte) BAR,
> the validation will fail (0x1100 > 0x1000).
> 
> Before this patch, the driver correctly relied on HOST_PORTS_IMPL to determine
> which ports to access and safely initialized within the 4KB BAR. This patch
> introduces a strict check that rejects the device if the BAR is smaller than
> required for the maximum claimable ports in CAP.NP.
> 
> Should this warn instead of failing the probe entirely, or base the check on
> the maximum port actually enabled in HOST_PORTS_IMPL?

Yes, a device's generic IP block hardcodes CAP.NP to some value (the number
of ports theoretically supported by the hardware), and then a manufacturer
can chose to only implement certain ports (using the PI register).

If the manufacturer did not have the ability to change CAP.NP, I doubt
that they will have the ability to change the size of the BAR, which should
be determined by the device's generic IP block, and should have a size that
can accomodate CAP.NP.

While the spec says:
"Software must not read or write to registers within unavailable ports."

Not having a BAR that is not enough to accomodate CAP.NP seems very wrong.

If we ever find such a controller, I would prefer to quirk that controller
to simply override (the obviously bogus) CAP.NP.


Kind regards,
Niklas
