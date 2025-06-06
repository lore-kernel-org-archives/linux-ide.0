Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B18C0E;
	Fri,  6 Jun 2025 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749172668; cv=none; b=Rsuz3kzLHvDau2It3xymDtcb/9lC2O8cXn99pXE8Dc2PP0rCgQ+YR4zm07JH2/QlkH0htlbWlkLqi0u5J3pgcbYpYRFw5Vd7iNJuDNTE3a2x+a4X3vpkheh4XNNzIcpv/9xyE1uRcW2P4emdoHfGzjVRaE171EKQtpXURA7gSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749172668; c=relaxed/simple;
	bh=IJnSJlEquy9vsdCcu1kOyeNtlynH+OnXTm+/vp//+yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Erho5ozNHD6LKhMnPPwaP+Cl5Z6Xf8Jeeyo+mm+Vi69cyt1DUYq3Yegyoqv1LVK9qzvuxB21ILZyWYznx/czAhDYCMRmDYMNZl5nO1LM25GkDbDdNrhRx3i8o8U1LbI8UF6z4fcl3Won9Bs9RmCvCKqJvpj/sRzB4PIdKIFeTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTTXL3uj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTTXL3uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ABFC4CEE7;
	Fri,  6 Jun 2025 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749172667;
	bh=IJnSJlEquy9vsdCcu1kOyeNtlynH+OnXTm+/vp//+yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTTXL3ujRja/OXt32PsutC4+4COOnaEHFM888nh5NYR55WCGbTmhwST9tFALHZOSj
	 RDsDhX5q48MR8/vGpcU/oGg7HEqMonLIfKosJFdDdS3zwfTU2baVjg5uGEln3650g6
	 WZAXydAY/8rzBSBgA8p1CdALx/Tsv2tDTxIyeVHxFUDfoRjxVtKjgBvGP0xgVdpd66
	 5bHZhbHp4PcamxUnZT2xsnd+SQALM0cYIH5S+aPM7S5bM5ufll2MWKqR3how5i9/Rh
	 D+87DBZz1mO1+rNgJOmX2it//OYJA58q+hqnSh4B8/QFqtS07VDlHqZVlZQqpLfC1I
	 dpESHU2hMUhPg==
Message-ID: <dbca1709-668f-470f-b1c0-d807f6ba8c9d@kernel.org>
Date: Fri, 6 Jun 2025 10:17:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: macio: Use non-hybrid PCI devres API
To: Philipp Stanner <phasta@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250604113423.138595-2-phasta@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250604113423.138595-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 20:34, Philipp Stanner wrote:
> macio enables its PCI device with pcim_enable_device(). This,
> implicitly, switches the function pci_request_regions() into managed
> mode, where it becomes a devres function.
> 
> The PCI subsystem wants to remove this hybrid nature from its
> interfaces. To do so, users of the aforementioned combination of
> functions must be ported to non-hybrid functions.
> 
> Replace the call to sometimes-managed pci_request_regions() with one to
> the always-managed pcim_request_all_regions().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
