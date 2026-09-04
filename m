Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DB3D34B9
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526221; cv=none; b=q19ptCqiBKO0hlplSfwURuv+cMZiOwpS3VZv1woBUNFjfEUhBjVATORpHDYw9JSfCe4dh1hQ7GI8O0bUzrebVw44VYXVjQMrZjmi5gohKHUos09P12gXwy0rs1A7S7JfROctTWiEkFy5h/0GtkuMQ910zEGgCIoWxNiNZyiXfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526221; c=relaxed/simple;
	bh=CN4nMJj8I3o0NZAkDKQh3jbw0TWSUVPHo++2Aex0Ex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN8bwSvQcnVWkhtIret5nb1/QcMX6Xxu2pDE0V+4jyHpcmGirUP1c1O+fNLi7RoLWO2ohs4oaoH/6SKOUN+YFUKRmb5eKAJ6VYWsLPkw/foM1q8phWX4bYb1X+K1Vvfjp991AAv0GQ0K9qCd7G4wpPNoeTjP0IsYzc4URvweglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovdu8Uti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovdu8Uti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA841F00A3E;
	Fri,  4 Sep 2026 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526220;
	bh=QXGf0Azn8ZvkxDmDnTEWwypxEU9HGZctB+7x6J6C/aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ovdu8UtiRgjf893bTorl09Wtg8oTSH03eYSMp3LMbjAc7lD7T7HkK73J+y2Aqo/ry
	 NF/KpwN+64GrzlXZBnp9ZmVbPSyUX+aO7OxVOzTofgrKwhQQbUn5iyft1UhfDmac1P
	 Z7d4I1HYC8/nDmkmHST5rhyGOexsIW3eao9QVDiZWSMcAv4covsn+UXRrc/f9Bd5hZ
	 UlCEVL0F/cr2wtpEQA8KvjsBbcH/1rhgpJW6GeJ1utm5ixl3OCke95VnJo3VpocCce
	 nFBRMuzzIyAVC9mQ+3OnqD906cpMp86Tv8LSks5B2jAWCi4aCwXWCrWCc+GBVgJmtS
	 AfovFHYpQYBJQ==
Date: Fri, 4 Sep 2026 14:50:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
	"artmoty@gmail.com" <artmoty@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Mikael Etienne <mikael1022bzh@gmail.com>,
	Alvin Lim <alvinwylim@gmail.com>,
	Lennert Buytenhek <kernel@wantstofly.org>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <apq-h4SKix_zn3ni@ryzen>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen>
 <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com>
 <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apqn-bdMi4y4l1gE@ryzen>
 <07efa8b1-c5ef-4a61-8b0c-45f68d02d9f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07efa8b1-c5ef-4a61-8b0c-45f68d02d9f5@amd.com>

On Fri, Sep 04, 2026 at 07:38:06AM -0500, Mario Limonciello wrote:
> On 9/4/26 06:14, Niklas Cassel wrote:
> > 
> > 2) A fix for the AMD IOMMU driver to be merged, and backported to stable,
> > such that us writing a fix that drops the 32-bit only DMA quirk for JMicron
> > JMB582/585, which when backported to stable, will not cause users with an
> > AMD IOMMU to silently get their filesystem corrupted.
> > 
> > 
> 
> Right now what I'm thinking of doing is a quirk in arch/x86/pci/fixup.c to
> set the registers that could influence this issue.
> 
> An alternative may be some quirks to the AMD IOMMU driver to avoid using the
> upper 5 bits for the IOVA allocations (making it 59 bit).

No stress with regards to JMB582/585. We will keep the quirk as long as it
is needed to avoid the AMD IOMMU issue, but please CC me if you send out a
fix.

It is probably worse for those like Mikael Etienne, who is using an AMD 600
Series Chipset SATA Controller [1022:43f6], since for those SATA controllers,
we do not have a 32-bit only quirk that hides/workarounds the problem.


Kind regards,
Niklas
