Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A563597F;
	Mon,  6 Jan 2025 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141313; cv=none; b=tc00JXpd7qSJltJoSDG+D06iSv2Ig+oll9CBhkr/p7kG+QzEy9QC8x6id+D5sGgeihqO5BvAG1E9lcaR3Y/6EqmLOy4XVPzl9yGTmrzHhkn6HLf30LP7+3OacaagBUFi9fyC6ikgzBMoSf/s1dMUrLjSnk1BaF2crcDIdiIEa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141313; c=relaxed/simple;
	bh=eJd0j87GxJEGPqpx6KAvPu4hSFQVX6p54ubiUO+07fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p01kJQYbnbOsAe0254HJO27mqDcHdHKswkgpUPL4qtEDZgOFxKQKXqFkFAgH9XwInPLqW39HmjOaFnXYl+2B2kK/haqIVO/ZkSXDfK3Aa1FpJr4Uuo7KrhJTFU0TdguMDGplnpu/WK054hP+EGBOl46HGp56k4SjSOhreSzPxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM+byKPF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM+byKPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C90CC4CED2;
	Mon,  6 Jan 2025 05:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736141312;
	bh=eJd0j87GxJEGPqpx6KAvPu4hSFQVX6p54ubiUO+07fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uM+byKPFoWYO2dn+BEOENi5RzZurQ3uYYLyC4pzl9DKXMd7M2HZJKG2tIFmYlHwVa
	 P3DHMZTcrAaVqe5ZZB/PLCSed2qdoDqgHlOxmEZ3YINwM45qJ8nd4mgvkKr6zPK9+e
	 voyva+il4bh75IOffcRru8EJE1Eugflq2Px0DlGAl4RLSnpDU47Wyc6XEgYt7SgePB
	 fPvOTn57Z6gO3vlF18pVrQy8ONSBcR9NcU83heStRJJx/fVtMITxiGMDmw21FXimnx
	 wFcQcY043htODYRNfSxfIU7S4Na3lF32LAAHzG5XSRUb+mi3qdAQhdNtLBiEy/7JzX
	 3IuWKzOPyrfog==
Message-ID: <d17e611d-8590-4085-b995-0cf3ca071746@kernel.org>
Date: Mon, 6 Jan 2025 14:27:47 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
To: Josua Mayer <josua@solid-run.com>, Niklas Cassel <cassel@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/25 9:13 PM, Josua Mayer wrote:
> So far ahci_platform relied on number of child nodes in firmware to
> allocate arrays and expected port numbers to start from 0 without holes.
> This number of ports is then set in private structure for use when
> configuring phys and regulators.
> 
> Some platforms may not use every port of an ahci controller.
> E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
> to the following errors during boot:
> [    1.719476] ahci f2540000.sata: invalid port number 1
> [    1.724562] ahci f2540000.sata: No port enabled
> 
> Update all accessesors of ahci_host_priv phys and target_pwrs arrays to
> support holes. Access is gated by hpriv->mask_port_map which has a bit
> set for each enabled port.
> 
> Update ahci_platform_get_resources to ignore holes in the port numbers
> and enable ports defined in firmware by their reg property only.
> 
> When firmware does not define children it is assumed that there is
> exactly one port, using index 0.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied to for-6.14. Thanks !

-- 
Damien Le Moal
Western Digital Research
