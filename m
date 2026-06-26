Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7141379981
	for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478560; cv=none; b=UI51Eq5MBxgmEUKJUprXv7Dg/RfnN7xwU0fLRnp7ip6fHtCtaPMhDexYa/SwG77uHUUtEbd/6EtRLeXkIszEqSPeh8xbAtPem6D6s2hz5U+JMJi5BXHfjzei6depvB6w4bxkXMxOelizIXKW+wlT0/TAnCFiW8foT+uTHlj6zR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478560; c=relaxed/simple;
	bh=kkdmSEgbrV9Cri7xgWpwQiwUapq4oy5IuWfKxZoihxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjxe2hYZPdTiRurMKGjaC/tEFj38CSXg1Ee335dayl9tGEt7JlibfuH2raCxlmSsPKg97v8nAWzi2IdA/ctyCln2t+NQhgFoR9Dm4HunTpKPN4qEYa2eScO9W+Rnv9wkKzbUbcCB8nmTu9bNSevJpYe/p9aprvmViq0eGRw5P+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDKVCUn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDKVCUn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F31F00A3E
	for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478558;
	bh=kkdmSEgbrV9Cri7xgWpwQiwUapq4oy5IuWfKxZoihxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nDKVCUn0X4GEHkNC0o+7nDvH9y5G0eGxuSXnmgxo94ngZWNot1jzS6Evf1SKGbVJh
	 atNidFUI0EakDr/gnZclOd+w7vYTtBVmNvMdcQ/M3Zag09RsacmqCuvAZW0V1Yrni6
	 gY/d5306Nlv3MSezgGHwlMA44sL8uQwmTLwyXBbHizLhErtetaZTZPExzSv24pH7dS
	 b+KEeTgwMez+/ANVatpwfbFtbV6dIvbq96RTVvy43PQu8eZhLCJ7Xx9j3N1GEEvmO0
	 9Xm5OxnGu5j10aV4roiZn9JzBRrK2mQSYvX5nfrlO3k0AQuDs8LRiP1jNb1v9g52GR
	 mRg8DR8gm8zVw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ad58584037so698383e87.3
        for <linux-ide@vger.kernel.org>; Fri, 26 Jun 2026 05:55:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp3UN9Xrv5akSWUKdHgs2zTRNbhReFStdORGrfbZfoxoNWKDzWI30dKakYtMX8gnOUYJL/sM3uYXGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUkGuxGapy2MI1jCHAx8EsxJDpk+5Hovt4iYIeKbwm9f/q/4r
	R+a2mGLQmCYttYgO9lHY3RuCHE8mCILujYDagRkF75hbYC40yoVSKioVQ6ne7hvQ21yZMCh0Xth
	u0BJz2vaoLsBmxpeEmxOSQYtgMf9SZOg=
X-Received: by 2002:a05:6512:6301:b0:5aa:64cb:9589 with SMTP id
 2adb3069b0e04-5aea1f3f8c8mr2043000e87.4.1782478557391; Fri, 26 Jun 2026
 05:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626085848.40199-1-mhun512@gmail.com>
In-Reply-To: <20260626085848.40199-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 26 Jun 2026 14:55:44 +0200
X-Gmail-Original-Message-ID: <CAD++jL=uQ3pRiU3REBJs6gvB-VCY1=wqK1LBM8xx+KJO0cjs_Q@mail.gmail.com>
X-Gm-Features: AVVi8CejBNHUTU34lhlbx4J6D0kcvMJPGRzoqD36VHeEbpoGmia9m1n9PTX4J68
Message-ID: <CAD++jL=uQ3pRiU3REBJs6gvB-VCY1=wqK1LBM8xx+KJO0cjs_Q@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: unwind clocks on IDE pinctrl errors
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 11:00=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> =
wrote:

> gemini_sata_bridge_init() prepares and enables both SATA PCLKs, then
> disables them again while keeping the clocks prepared for later bridge
> start and stop operations. If gemini_setup_ide_pins() fails after that,
> gemini_sata_probe() returns directly and skips the existing
> out_unprep_clk unwind path.
>
> Route the IDE pinctrl failure through out_unprep_clk so the clocks
> prepared by gemini_sata_bridge_init() are unprepared before probe
> fails.
>
> Fixes: d872ced29d5f ("ata: sata_gemini: Introduce explicit IDE pin contro=
l")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Thanks!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
