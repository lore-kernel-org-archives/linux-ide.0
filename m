Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8B2F7479
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993395; cv=none; b=pGItxGU7/3isj3Zo9AfuPrF3tk8A5y1J/HWoDG1voFcUe7cG1kjOWjEcbFileHxWRTG8pziEMci9O511By7wQ9R3ST2PriAl6aOGFhDK3yFqUVCGfaTCgvlI/V+lruTcCv9O3b77x6tt0fIpzuOp8QHaBtqLdnEx7P8zrWUABeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993395; c=relaxed/simple;
	bh=tN0Gsf+5C0e2/TQABAIOfYX6cY1d+zHrhDYaUONT820=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+t7U5eXwLViHAa2xgSk8j9hJAF9PU+mj+b5vyStgw2j0Kwju/FjqxW+Z+wFQ/f3s8Ygcb71n5FzzTp5OzphCwvQEvoKR9xZZHqtBa2nax3hmabZXFhAjtKkSvppvnCt18nUitcTzkW9j2C7q3ls1L5C3582EO6w2Mk5imyJQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCvpkh2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCvpkh2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4340C4CEF1;
	Mon, 24 Nov 2025 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993394;
	bh=tN0Gsf+5C0e2/TQABAIOfYX6cY1d+zHrhDYaUONT820=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCvpkh2J2A/tIYaW0gNpAaPP2A0e1SeuGOr2xbRr7/G/AqvLwvDWpd5YMLCjdfB2X
	 Twt+xoG272NnpLyngGlTIuzJe5FrPjdR5qDqvZ8faurLS8FioqxILlyEAnF/npg3OW
	 WqeSCik0muhq0DVlzlzMTLegVEpOqSRWJxukP6fKYRH/91LSp1CsQ0KgThnQD7NgFq
	 8fDshJDCRgtQ3ALGT0n8lWRCCQ0u8b+zZKYJUMFp6++v79cjhbr5sYhOZXJkVM2bXf
	 ZFIeCoh+pV/SNlnvHmZmXrjIoHGSWh5XNSTawxU+rLPZAXXYBsPTAnCLiSzPDYhtCT
	 B2fEO6h30NBCg==
Date: Mon, 24 Nov 2025 15:09:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com
Subject: Re: [PATCH 2/3] ata: libata-core: Quirk DELLBOSS VD MV.R00-0
 max_sectors
Message-ID: <aSRnLyyopCslI4jT@ryzen>
References: <20251124134414.3057512-5-cassel@kernel.org>
 <20251124134414.3057512-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124134414.3057512-7-cassel@kernel.org>

On Mon, Nov 24, 2025 at 02:44:17PM +0100, Niklas Cassel wrote:
> DELLBOSS VD MV.R00-0 with FW rev MV.R00-0 times out when sending
> I/Os of size 4096 KiB.
> 
> Add a quirk so that the SATA controller is usable again.
> 
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Jack, it would be helpful if you could test this series.

We know that your hardware chokes on 8192 sectors
(one sector is always 512 bytes in Linux kernel code)
8192 * 512 = 4194304 bytes = 4096 KiB == 4 MiB.


When you write 4095 to max_sectors, we will set the limit to
8190 sectors.

My guess is that your hardware chokes when receiving an I/O
of anything larger than 8191 sectors.

If your hardware still chokes with this patch applied, then
we need to change the quirk to limit the I/Os to 8190 sectors
(which, thanks to your testing, we already know works).


Kind regards,
Niklas
