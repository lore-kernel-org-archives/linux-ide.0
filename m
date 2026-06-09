Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D50404BCC;
	Tue,  9 Jun 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007376; cv=none; b=L2esFj/vu1eEPb5pXYrNHeRyzx8JC2oy9X6OYiGcdUufbgFtgHr6QMLmSlFNjTFXL+3+CtmEhlxIiM1KgpuT4Ddo4oSZrObVhJYTLVzX+A3+1NPtfuAGJkizPbk+WQiD29glWsIDROeagz6oL6iY7Q0NZhArkbSXYVayzEF3g00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007376; c=relaxed/simple;
	bh=Rl8SkcbLmO7zv9ynFeQabMuX06Ar+hVMMo2AsSyE/Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZU+/pLnkNTGbZRqTUlwFO17DOIbmWbHO1MUIZESYYQrTzw2QFr4+nnRQ/ceIy1pT6b0nggZneVpUNrQvPxBDDdtgcabhuMHwJHyE+BFxh8RmCvsLJ7NekMcZZoAivLsWO3jsOo/fceMQNFZE7TRqIwiqsWpzv/UUtT7LxpaymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsGtrKCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsGtrKCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19AD1F00893;
	Tue,  9 Jun 2026 12:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781007374;
	bh=LkDe/xNVmA8jEc1j9mX99eFtWfhlfnn6ShGmiI0F618=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WsGtrKCmBT7UQkinbT8dN/anRuN0AK1xc29D+d1PV8pA9wjQcR7NrOnTwHAx8ebGO
	 LJaMvyVpVBSIZ9L3DD/cJGKDlh1zrA72qD+lyhG8RBYRsHbaZWqOHI6o9M7axPaxNQ
	 DXNGIUtufZsB0GKsGo0V0N1V56Jgslle/K2wuBAGMdMQnpw34p4CJprKfr7WTRfj8B
	 LNJAInukzcrRQ5e4Xzmh9LFM7V8x8Xe3Es1ZutrEyXQ97+Wgl3Fs2wOrxlW0b0l8Dt
	 kz0BBREo0A9B5h//vxD98FZ/V+qa+HHEU/zYEIp80oER9g+BNRGNbMwolFp1rrcvh8
	 KXj4oa7g2VdRg==
Date: Tue, 9 Jun 2026 14:16:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, dlemoal@kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] possible deadlock in ata_bmdma_interrupt
Message-ID: <aigECzOctNIPbMeY@ryzen>
References: <CAHPqNmx0LUYXWW1n_Su0BEOGqF20qDHj3CNvXBLuR3E7LLBOBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmx0LUYXWW1n_Su0BEOGqF20qDHj3CNvXBLuR3E7LLBOBg@mail.gmail.com>

On Tue, Jun 09, 2026 at 07:39:30PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. possible
> deadlock in ata_bmdma_interrupt. Details are as follows.
> 
> Kernel commit: v7.0.6
> Kernel config: see attachment
> report: see attachment
> 
> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.
> 
> Best regards,
> Longxing Li
> 
> report:
> https://drive.google.com/file/d/1krb648PgTy0zRrwtf-cV7ahPwvaT9mv_/view?usp=drive_link

Hello Longxing Li,


Thank you for the report.

However, please send the report itself as plain text, to the mailing list.


Kind regards,
Niklas
