Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B51B4257
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618070; cv=none; b=Tf1ioTkmIJss5qXz9Y/dPVEFYRliFHTkvdk/v67xnKTJ7OMpPOio3wBM+l6L6kKxfzSxaR5e2L3GPh5INQuKNxCUM5pbCdb208H8fNNvC2tUXc3x2gjt1uohIFvNpmXiPRxCa0CLdTekLVMEsp85bSF6uOCG3BE6upCyvpj9tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618070; c=relaxed/simple;
	bh=zOfTrSfVO0NmACetR6+0WVaG3jH3tC/bZJbeYdSi28s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBaPuACuKPZNvQkTW4Vn02QIldLGOU424Swh90kurq2WQlv/BAKahJFguuwRmCEVfrSLIpBFT0mrttwx88Lb352GrPE47iFOM562ZmTqGIQNNWMSKJxJpM2fY3up+ZckY9KXwc/nWHYso7xaoRerpusyAgEAET6h8uC/WqQR0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 2AAE57F1F4; Sat, 05 Sep 2026 17:13:05 +0300 (EEST)
Date: Sat, 5 Sep 2026 17:13:05 +0300
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Mikael Etienne <mikael1022bzh@gmail.com>
Cc: cassel@kernel.org, mario.limonciello@amd.com,
	roland.waltersson@netinsight.net, artmoty@gmail.com,
	linux-ide@vger.kernel.org, david.laight.linux@gmail.com,
	alvinwylim@gmail.com
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <apwjcf0zeP3CKq_g@wantstofly.org>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen>
 <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com>
 <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apqn-bdMi4y4l1gE@ryzen>
 <07efa8b1-c5ef-4a61-8b0c-45f68d02d9f5@amd.com>
 <apq-h4SKix_zn3ni@ryzen>
 <178854093896.541085.18395405788748617410@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178854093896.541085.18395405788748617410@gmail.com>

On Fri, Sep 04, 2026 at 11:55:38PM +0700, Mikael Etienne wrote:

> The EFR field is probably the most direct discriminant. If Arthur,
> Alvin and Lennert posted the same line, the "different IOMMU versions"
> hypothesis could be tested immediately, with no extra hardware:

[...]

To echo what Niklas said, the DMA problem I was seeing a while ago with
the ASM106x was purely an issue with the ARM106x itself, that is, a 
device-internal IOVA address width restriction, and had nothing to do
with the IOMMU in my system.

I was seeing AMD IOMMU I/O page faults in my particular case, but only
because the system I originally encountered the issue in was an AMD-based
system where the ASM106x happened to be behind an (AMD) IOMMU which was
by default enabled in an isolating fashion, and the device was indeed
causing I/O page faults, due to an IOVA address with restriction in the
device itself, and the AMD IOMMU correctly signaled those I/O page faults,
and the AMD IOMMU was not at fault for the device causing those I/O page
faults, and I did subsequently reproduce the issue on an Intel-based
system, where the ASM106x was causing the exact same I/O page faults --
that is, after the Intel IOMMU was manually enabled, which it wasn't
(and maybe still isn't?) by default.

In other words, I think that the issue I was seeing with the ASM106x
should probably be left out of consideration in the context of the current
discussion, where it appears from a distance that the (AMD) IOMMU in the
reporter's system is somehow implicated in the corruption and misbehavior
they are seeing.
