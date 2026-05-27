Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF73F39CC
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878935; cv=none; b=iagDeEkSRVKEYqqINh68Rvgf1MFTWOEClBIHtbyrCjHYTvtn7Ha+sZTdOKCn0RPDA6ZAeHR+7+hAcBQ9GPBHC4hrvmWau55vwiHBJw3yu9wlnDJEenePMUDgHlnWYCtR7lG2eoTvup/TaF2wpztbCZFo3ZsNXujW6Dqml6++nfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878935; c=relaxed/simple;
	bh=5ip1NEEYqF+MoNnG7p1XQCrLaIbMhXbETr28TUEFbb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skwMFLSmpMEpT7oCOgl+RSdccHUTIuL8fs2x+uVQsyG24+Tm7rpv+Y9dRcQZvZeqTmfFV6MSHn9WBkn+16NjdQmDK25/8eUYvy1/mhVqZdS8IH0cCVRDJzexiFQEmLA+vkN6OtDnmaJStwo3wGKsE3kRBFsAo278n8EI85G5xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3fDK7S8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3fDK7S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15AA1F000E9;
	Wed, 27 May 2026 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878932;
	bh=YIvWNtsPVeVeJqLzoWXe1uvysReXSydnoq0NeWUs0AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D3fDK7S8Gq8smrYeTN3cEcVEmp365ED0cVyRWoQkn+hgAhnEG85pPROIfX4dUwyZx
	 MCvc6XCM/V59b/nudPQA5oGjMN5+eg2ie81kLoAC1G846QTPgd5Kk7gyvi/UdHi7sW
	 SQnKjErsL3PSOdcfPcLi3pUGUNHEp0iWtI1CmXX/F0k+Hd/gW+oW/ZZH53vuGL2VPt
	 wz+xNFcSFuIbbeZXnmkStwreoosa19mpXe2p2GHwjz4i1JUM2WJ0lmH28VAj2Lc0X3
	 ZlPvT75qfN6z8sj+1/ZGg5yymF13eTFMu4TP+hah2/2z49taqlebnRQT26sKmpnY16
	 ayRqDJ7f32MpQ==
Date: Wed, 27 May 2026 12:48:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 8/9] ata: libata: Enable context analysis
Message-ID: <ahbMEF9zAvmXQeKE@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-9-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521173347.2079560-9-bvanassche@acm.org>

On Thu, May 21, 2026 at 10:33:36AM -0700, Bart Van Assche wrote:
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, annotating function
> pointers is a Clang 23 feature. As one can see here, a patch has been
> queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

(snip)

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 66ea590fad58..ddea4979e94b 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3877,6 +3877,9 @@ int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *reset_ops,
>  	ata_for_each_link(link, ap, EDGE) {
>  		struct ata_eh_context *ehc = &link->eh_context;
>  
> +		/* Tell the compiler that link->ap == ap. */
> +		__assume_ctx_lock(&link->ap->host->eh_mutex);

This is quite ugly.
Could we remove __assume_ctx_lock() if we supplied ap to eh_reset() ?

