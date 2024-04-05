Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F61649DF
	for <linux-ide@vger.kernel.org>; Fri,  5 Apr 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322656; cv=none; b=aZAUzp+ydQz9synEM2ZNA9Dym9j9Mx4J/JTXSuKUB9FpjgkeLFfLeRVT95rkIg9uAJDrmaaULUBH6W2usH6r0xoUXnp0P+mRSKgfvtLwIN7ZdDUzN7Td1h3ABLWXfk8yAB6XwKlb/5pBNX8YpPgqzqEPWHe1WimKBSAm/Ej7kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322656; c=relaxed/simple;
	bh=T6t0TqfnNLCG7KHws+r38BU0FcKvJYp984jXdF83t3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBIB6ekUAlt6v/NdNz4v7mH+CyNgNdbzwelSyl8/I8EQzm3fjSN5iW6bEZl/4tWo+oMffbjorjdhaTO6EPYcXpMGdLpVOOFgulggw42rbEp/rhQ5I0kd3jSUnuaDbIXqrcrf202avFGb7nsRk31j780WwLHWeUiPbQr6cE+p10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toerd6lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toerd6lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CABC433C7;
	Fri,  5 Apr 2024 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322656;
	bh=T6t0TqfnNLCG7KHws+r38BU0FcKvJYp984jXdF83t3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Toerd6lG+82j9mPow2ih4VHVNkdOp+wZxdQdhXzLjlr8HSYDUZz7onH0k0Kjm64aq
	 5uJdX+J3qvo+oLM3pYrv0mXrWZfsHsGhnJbZfzSauco0YUDsyxs5dfAnjlfRy4YUes
	 4B+gFjEHnoqLHz9QG37jrwrNbx5KXUzP0eU7Tvs5VqJLb3cXmxbJi4/ABt26XchKrM
	 7ehtTinRB0fWsd4PHTW9BNNPISiceNkhgkDLLuehbVb/qbUUgHpBwaJMZDMr8Wuhhx
	 qeuA9ohBp2BSERRL8tGK+hddoqFCGkWRsIiMOOD8fXZozv0Jcy4d9qI18c0cyiToC4
	 7ULhz5XQCVypw==
Date: Fri, 5 Apr 2024 15:10:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Conrad Kostecki <conikost@gentoo.org>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Message-ID: <Zg_4W7dD_SwPseAB@ryzen>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405125143.1134539-1-dlemoal@kernel.org>

On Fri, Apr 05, 2024 at 09:51:43PM +0900, Damien Le Moal wrote:
> Commits 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> and 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> attempted to limit the ports of the ASM1166 and ASM1064 AHCI controllers
> to avoid long boot times caused by the fact that these adapters report
> a port map larger than the number of physical ports. The excess ports
> are "virtual" to hide port multiplier devices and probing these ports
> takes time. However, these commits caused a regression for users that do
> use PMP devices, as the ATA devices connected to the PMP cannot be
> scanned. These commits have thus been reverted by commit 6cd8adc3e18
> ("ahci: asm1064: asm1166: don't limit reported ports") to allow the
> discovery of devices connected through a port multiplier. But this
> revert re-introduced the long boot times for users that do not use a
> port multiplier setup.
> 
> This patch adds the mask_port_map ahci module parameter to allow users
> to manually specify port map masks for controllers. In the case of the
> ASMedia 1166 and 1064 controllers, users that do not have port
> multiplier devices can mask the excess virtual ports exposed by the
> controller to speedup port scanning, thus reducing boot time.
> 
> The mask_port_map parameter accepts 2 different formats:
>  - mask_port_map=<mask>
>    This applies the same mask to all AHCI controllers
>    present in the system. This format is convenient for small systems
>    that have only a single AHCI controller.
>  - mask_port_map=<pci_dev>=<mask>,<pci_dev>=mask,...
>    This applies the specified masks only to the PCI device listed. The
>    <pci_dev> field is a regular PCI device ID (domain:bus:dev.func).
>    This ID can be seen following "ahci" in the kernel messages. E.g.
>    for "ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)", the
>    <pci_dev> field is "0000:01:00.0".
> 
> When used, the kerenl messages indicate that a port map mask was forced.

Nit: s/kerenl/kernel/

> E.g.: without a mask:
> modrpobe ahci

Nit: s/modrpobe/modprobe/

> dmesg | grep ahci
> ...
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ahci 0000:00:17.0: (0000:00:17.0) 8/8 ports implemented (port mask 0xff)
> 
> With a mask:
> 
> modrpobe ahci mask_port_map=0000:00:17.0=0x1
> dmesg | grep ahci
> ...
> ahci 0000:00:17.0: masking port_map 0xff -> 0x1
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
> ahci 0000:00:17.0: (0000:00:17.0) 1/8 ports implemented (port mask 0x1)
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

With nits fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
