Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A22139DD
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728816; cv=none; b=nTLtlLiz9ppTE8QrY6PXKqvSar3sAdmZphrv9BJxSSW/IOY2sVIWbBT19YWoSpfL4mGECUB33EeOaofL6ODquryPJI+wE/0qHxeeVfL8yj9B4dG6ahDV5n6oQE7NKLLnA0GVQX2urcwjB0B+KUIeEAGiHwRB7vywtIjwibQtGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728816; c=relaxed/simple;
	bh=MVHBEsfr+0h9+6RJJmyiQV3NH1LcjDPduPwvlb+F5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfEVvpPwAVCuSyIJBPeJr/+Ji1QHwkYBKN8Mz7FM7NXA4eJbkWSEJyCcmrD6hyw7InQ5L3NqJmiue+tSvhr0dOcSqweYwVyHFpP/bw8yeWrZMVRiIkXZ6s2+OwdRQk4fJ7qnha8dkvzuzjWL0y6jcoHRCJOo71mmRDOiJpjtUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfwZhC1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfwZhC1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08FAC3277B;
	Tue, 18 Jun 2024 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718728816;
	bh=MVHBEsfr+0h9+6RJJmyiQV3NH1LcjDPduPwvlb+F5NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfwZhC1EcNfsdK3+5xX3xiw1o1BtLu70LGi+82eZNdxV8KzOvnaP3Tx8xKdUcBH/w
	 jpoDWR76/YtjL9hbNU1EzS5KC4MKeb1Qe1i3/H2bW3PxkjdD+fE0qiU8X9XEQOJI9/
	 rpkOYB9GlQIKnQRJrH7Hkl+rjP8rFv9G6a2T/EW2rclgZ8n8f+ulYpYMRT26tKnOUh
	 LXPjidpmZiaEF8s+f7SJRytm/NGg37PvIlQQg9cNHq7tjaYz3/g0tdLTAWpDxXvApC
	 7b2Rs+HFqp2mRgrBRETBcn+DGLYZ6RoQtIBGkGRdtuCZ1hjiz1UtuMyYquMV0kuUqu
	 cADn1G7QkUMcA==
Date: Tue, 18 Jun 2024 18:40:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/5] ata: libata-core: Remove support for decreasing the
 number of ports
Message-ID: <ZnG4ak0RbWvZ3YaE@x1-carbon.lan>
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618153537.2687621-8-cassel@kernel.org>

On Tue, Jun 18, 2024 at 05:35:39PM +0200, Niklas Cassel wrote:
> -struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
> +struct ata_host *ata_host_alloc(struct device *dev, int n_ports)

I forgot to do the same rename of the parameter in the function
declaration in the header file, will fix in v2.


Kind regards,
Niklas
