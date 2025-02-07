Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194EC165F01
	for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918448; cv=none; b=LFgGcrPg0YHcBczNujxrqWheg+xtR6VldWKdtpMVDxaJHPVmKXiNK4EQpjL3zee4/Pdj5V2Hhex69u30bYxGGjrnz0qQAByVmfPrqb3k1aVFSQxQl2cmdIBIt2ijv7xCHDKINvKX0ReF+lZhYxeD+MoPLnPEBzFq7sKpvB+B/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918448; c=relaxed/simple;
	bh=DZD5/oHdFPC8uTULXmIlw9kYRgkpOXdFOPsgk02THRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmFwjZc4wFYTOE+Cs+GAc89z+ai3uHOS4kBkbVMlWjQxd03pwKTpvUlJqe4wBnaIiwmag1Y7QAv84SpCN06AH9Y3mrzNwD3oBCzMZtDrzXmUsOc7O4yUCh3jXtPLbIVr5vScL1YFdo77ZDpMRehgND7v8332UWWUg2C3dpfTW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Ao5GYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Ao5GYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92286C4CED1;
	Fri,  7 Feb 2025 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738918447;
	bh=DZD5/oHdFPC8uTULXmIlw9kYRgkpOXdFOPsgk02THRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9Ao5GYOnmyLKjFKNdTg5kG8/zE4YsukdxNmZmZvr8P/OxshbXjh96X/xzGazrIfr
	 e+LZZ6zRFW+iOsqW13Zqck1AuQGqaBQ3+SyP6aH3aZ43eBVYWjeGLxunjN5lc+lbno
	 h5UEIdBkeIohvr17yrUWrPezsQUUsZN1W7iNkP3h7E91aghMDS/0mWFLP1dbVh7SWQ
	 fGUxDTlhOS0+kcTVWchf2M4w+4RnxmDg3XdUQBNH6LbIcEMAhA1lMnJLlnzinOc7Cs
	 wNUJZCz9QXV1Bn8+m8oaY6ZFqj5Nc2rFjDGpUCAS2+qowQSQTby2+bshKokd+Sa73t
	 kEOL/qN+FSQRg==
Date: Fri, 7 Feb 2025 09:54:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Klaus Kudielka <klaus.kudielka@gmail.com>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH] ata: libahci_platform: Do not set mask_port_map when not
 needed
Message-ID: <Z6XKK44hE_215eoI@ryzen>
References: <20250207074810.1433154-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207074810.1433154-1-dlemoal@kernel.org>

On Fri, Feb 07, 2025 at 04:48:10PM +0900, Damien Le Moal wrote:
> Commit 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive
> port numbers") modified ahci_platform_get_resources() to allow
> identifying the ports of a controller that are defined as child nodes of
> the controller node in order to support non-consecutive port numbers (as
> defined by the platform device tree).
> 
> However, this commit also erroneously sets bits 0 of

s/bits/bit/


> hpriv->mask_port_map when the platform devices tree does not define port
> child nodes, to match the fact that the temporary default number of
> ports used in that case is 1. Doing so causes ahci_platform_init_host()
> to initialize and probe only the first port, even if the controller has
> multiple ports (that are not defined through the platform DT).
> 
> Fix this by removing setting bit 0 of hpriv->mask_port_map when the
> platform devices tree does not define port child nodes.

s/devices/device/


> 
> Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 8c87215dd3a2 ("ata: libahci_platform: support non-consecutive port numbers")
> Cc: stable@vger.kernel.org

Cc: stable is used then the fix should be backported.
The commit referenced in Fixes: is only in v6.14-rc1, so no need to backport,
and thus no need to Cc: stable.



Kind regards,
Niklas
