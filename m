Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88F30FF1D;
	Thu, 28 May 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951465; cv=none; b=Eerkt1fxGw1TGRmZanlN9kRixJF0ooCUSc/EiCMdeP0PbOUFV037Zx+0gBq7m4/bnoTYKM4O7YyJtccXxCYDnRtR/wqhtrRLnl/brlE+tizRZcKAL21WM14Kye7qs1Is3qyUrDjqGGApgs5JHFQEnDxpbapd5uejJ74H1N3isgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951465; c=relaxed/simple;
	bh=A8C3UMIgHMxEX/9c+ehe/2ZefuBOI610ml9IrQ7cxyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yto/mYMfNxa5WX63OKLyyAYLYxMVWQGiBZX5DIeTQxGacgNIH/LFJImKT8e04WVpjXmBAwnXGhDuI290t5Cxe/Pr5GiQH+MuUnOT66MZfX1vGoqQnjFUL8EYAT+xURIbE/c5NH6ODygRWU7s1V77En8Q8HX9JFhWZvPIPIqCjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucw5o2MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucw5o2MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EA01F000E9;
	Thu, 28 May 2026 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779951464;
	bh=mcM91zgkiLLHFJCISSdRHIbYxsIV1FUrrFnYMwKcaaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ucw5o2MVD8DSAej/MUlmEXoCBonBjWMHEM/sLV7sOB2+IBri8VtD4TxSSnNG+q4VC
	 9NfAYjtenFUPVHsZWC8brPOy1h6+42X+apdCOtteFD70MPE/MtRBs8X+u4cblXc912
	 JiIJeEHqwADizgACLIGRQqMpQyJ6mnX8Du8vuIzQ/a8wjWl6KxoEV5RnwWN7purX3B
	 pMjdMNQ4wr74zvccVF5l8jxNrsnmdGUcJDIUlhOnLyl3MxCOz9TGKirnykSkvNKzAW
	 XPolz4SGjnigII52/aJrrHHqEGd0+tZIQpc6Hht61oH5VVUwVKWI5hjjuClFKzWYKT
	 aoyf8npDQpWYg==
Date: Thu, 28 May 2026 08:57:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Bart Van Assche <bvanassche@acm.org>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
Message-ID: <ahfnZEfc1zASNzZI@ryzen>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
 <20260527205711.BCA141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527205711.BCA141F000E9@smtp.kernel.org>

Hello Bart,

On Wed, May 27, 2026 at 08:57:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Low] Missing '&' operator in lock capability expression for `__acquires` and `__releases` annotations on `ata_eh_acquire` and `ata_eh_release`.

Is this review comment are valid?

> - [Low] The `ata_dummy_error_handler` function is missing the `__must_hold(&ap->host->eh_mutex)` annotation.

I don't see any downside of also just annotating ata_dummy_error_handler().


Kind regards,
Niklas
