Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03129E109
	for <linux-ide@vger.kernel.org>; Fri,  4 Jul 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618258; cv=none; b=MNUmN+Wjj0RdtNn4i0hqQWdylQ8dpLaS77oS83kYrGUWIvEkIE5+k1RGYl1y9UdaZO3Mk8f0PcAiQdoWet+N8vlDjBKjeWtXQN4U/8ov5BZajBfR1ujyU+/0z8F/etDk2ZN8NmQshnwHbXwdiIMdEaPf2kxVGGfoZnTcOaWbMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618258; c=relaxed/simple;
	bh=uU+jnRk5eXO83I5ZZSaDFCC6b318Yt497JD8n6kaDoc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TIu2tiWhnHOxV2PAHIMpQhnBuRDYXGsvX7bOq5dYyd8I6WedWyi8SO4Ciwc+RIE1PyUiZ9PvRSL0wnxi7ZXmr4Cw4FNQK8kwv53K4TFmswnJq7r+7VofqCXF7tRjOLlwJWZbnJu52shk/AUCBkKcvVL9tUWk7oq6gnxAs7tP3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSqnAajg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSqnAajg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7874C4CEE3;
	Fri,  4 Jul 2025 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751618258;
	bh=uU+jnRk5eXO83I5ZZSaDFCC6b318Yt497JD8n6kaDoc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OSqnAajgWql34r1o8et+q3AkKz2Cy18ysUm0iafiCMinpplh+sdwAgN00/mL2tVMG
	 vyQKRR+XoQqbcJU9NTQVuxFZxSvmmvRK75ZMm6jqSBLbOSRVGpexV1fnOXAlxQYfQh
	 F0zHQB4Rqy4xRso0ugmR9PSTrQVcGSruklnRDuF5tDC1f8SwTDA6ey8npCqBn5ntwx
	 awxAJn3SOvDpj0AUFm+FsSj4SgpTjn34OsEfiJjW7bli9ok3BLQycyYWfBDjEyB0Ow
	 LRQ9/BszERn4uFLcrARCo1FJrJ/SUH2Eqr7JRoyKDuuPqGPY+5omadYsa3ykSVatmP
	 ctkM45R325cBQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250703103622.291272-1-dlemoal@kernel.org>
References: <20250703103622.291272-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2 0/4] Improve log directory handling and some
 cleanups
Message-Id: <175161825765.260885.17847459328339195957.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 10:37:37 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 03 Jul 2025 19:36:18 +0900, Damien Le Moal wrote:
> The first patch improves handling of a device general purpose log
> directory log page by avoiding repeated accesses to it using a cache.
> 
> The following 3 patches are simple cleanups that do not introduce
> functional changes.
> 
> Changes from v1:
>  - Improved error handling in patch 1
>  - Added review tag to patch 2
>  - Split former patch 3 into current patch 3 and 4
> 
> [...]

Applied to libata/linux.git (for-6.17), thanks!

[1/4] ata: libata-core: Cache the general purpose log directory
      https://git.kernel.org/libata/linux/c/6d4405b1
[2/4] ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
      https://git.kernel.org/libata/linux/c/6cbd9896
[3/4] ata: libata-eh: Rename and make ata_set_mode() static
      https://git.kernel.org/libata/linux/c/6ba4d05c
[4/4] ata: libata-core: Rename ata_do_set_mode()
      https://git.kernel.org/libata/linux/c/31921e87

Kind regards,
Niklas

